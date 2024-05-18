package com.br.project.service.board;

import java.util.HashMap;
import java.util.List;

import org.springframework.stereotype.Service;

import com.br.project.dao.board.BoardDao;
import com.br.project.dao.common.attachment.AttachmentDao;
import com.br.project.dto.board.BoardDto;
import com.br.project.dto.common.AttachmentDto;
import com.br.project.dto.common.PageInfoDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
public class BoardService {

	private final BoardDao boardDao;
	private final AttachmentDao attachmentDao;
	
	/**
	 * @param filter : [카테고리], [부서코드], [검색조건], [검색키워드], [공지사항 상태값]
	 * @return : 총 공지사항 갯수(STATUS = 'Y')
	 */
	public int selectTotalBoardCount(HashMap<String, Object> filter) {
		return boardDao.selectTotalBoardCount(filter);
	}
	
	/**
	 * @param filter   : [카테고리], [부서코드], [검색조건], [검색키워드], [공지사항/첨부파일 상태값]
	 * @param pageInfo : 페이징바 객체
	 * @return : 공지사항 목록(페이지별)
	 */
	public List<BoardDto> selectBoardList(PageInfoDto pageInfo, HashMap<String, Object> filter){
		return boardDao.selectBoardList(pageInfo, filter);
	}
	
	/**
	 * @param filter : [부서코드], [카테고리], [검색조건], [검색키워드], [공지사항/첨부파일 상태값], ([글번호])
	 * @return : 공지사항 목록(전체)
	 */
	public List<BoardDto> selectBoardList(HashMap<String, Object> filter){
		return boardDao.selectBoardList(filter);
	}
	
	/**
	 * @param boardNo : 공지사항 번호
	 * @return : 공지사항 조회수 증가시킨 총 행수
	 */
	public int updateReadCount(String boardNo) {
		return boardDao.updateReadCount(boardNo);
	}
	
	/**
	 * @param params : [글번호], [부서코드], [공지사항/첨부파일 상태값], ([카테고리], [검색조건], [검색키워드])
	 * @return : 공지사항 상세정보가 담긴 공지사항 객체
	 */
	public BoardDto selectBoard(HashMap<String, Object> params) {
		return boardDao.selectBoard(params);
	}
	
	/**
	 * @return : 공지사항 등록 성공시, 등록된 공지사항 번호
	 */
	public int selectPostedBoardNo() {
		return boardDao.selectPostedBoardNo();
	}
	
	/**
	 * @param board : 등록할 공지사항 정보
	 * @method : 공지사항 등록 결과 (0 | 1)
	 */
	public int insertBoard(HashMap<String, Object> params){
		// 1) 게시글 등록
		int result = boardDao.insertBoard(params);
		
		// 2) 첨부파일이 있을경우, 첨부파일 등록
		List<AttachmentDto> attachmentList = (List<AttachmentDto>)params.get("attachmentList");
		if(result > 0) {
			if(attachmentList != null && !attachmentList.isEmpty()) {
				for(AttachmentDto attachment : attachmentList) {
					result = attachmentDao.insertBoardAttachment(attachment);
				}
			}
		}
		
		return result;
	}
	
	/**
	 * @param params : 수정할 공지사항 정보, 등록할 첨부파일 정보, 삭제할 파일번호 배열
	 * @method : 공지사항 수정 결과 (0 | 1)
	 */
	public int updateBoard(HashMap<String, Object> params) {
		String[] delFileNoArr = (String[])params.get("delFileNoArr");
		List<AttachmentDto> uploadFileList = (List<AttachmentDto>)params.get("uploadFileList");
		
		// 공지사항 수정
		int result = boardDao.updateBoard(params);
		
		// 공지사항 수정 성공시
		if(result > 0) {
			// 삭제할 첨부파일이 있을경우, 첨부파일 삭제(상태변경)
			if(delFileNoArr != null) { 
				for(String delFileNo : delFileNoArr) {
					result = attachmentDao.deleteBoardAttachment(delFileNo);
				}
			}
			
			// 등록할 첨부파일이 있을경우, 첨부파일 등록
			if(uploadFileList != null && !uploadFileList.isEmpty()) {
				for(AttachmentDto attachment : uploadFileList) {
					result = attachmentDao.insertBoardAttachment(attachment);
				}
			}
		}
		
		return result;
	}
	
	/**
	 * @param params : {"no" : {공지사항번호/첨부파일 참조번호}, 
	 *                  "fyn" : {첨부파일 유무('Y'|'N'}, 
	 *                  "refType" : {BD}, 
	 *                  "status" : {수정할 상태값('T'|'N')}}
	 * @method : 공지사항 
	 * @return :
	 * 	  ㄴ case 01) 공지사항 임시저장으로 변경요청 : 상태값이 변경된 공지사항 갯수 (0 | 1)
	 * 	  ㄴ case 02) 공지사항 삭제요청           : 삭제된(상태값이 변경된) 공지사항 갯수 (0 | 1)
	 */
	public int updateBoardStatus(HashMap<String, Object> params) {
		// 공지사항 상태값 수정
		int result = boardDao.updateBoardStatus(params);
		
		String attachmentYN = (String)params.get("fyn");
		// 해당 공지사항 첨부파일이 있을경우, 첨부파일 상태값 수정
		if(result > 0 && (attachmentYN !=null && attachmentYN.equals("Y"))) {
			result = attachmentDao.updateBoardAttachmentStatus(params);
		}
		
		return result;
	}
	
	
	
	
}
















