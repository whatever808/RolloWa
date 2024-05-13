package com.br.project.service.board;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.board.BoardDao;
import com.br.project.dto.board.BoardDto;
import com.br.project.dto.common.AttachmentDto;
import com.br.project.dto.common.PageInfoDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardService {

	private final BoardDao boardDao;
	private final BoardAttachmentService attachmentService; 
	
	/**
	 * @param filter : [카테고리], [부서코드], [검색조건], [검색키워드]
	 * @return : 총 공지사항 갯수(STATUS = 'Y')
	 */
	public int selectTotalBoardCount(Map<String, String> filter) {
		return boardDao.selectTotalBoardCount(filter);
	}
	
	/**
	 * @param filter   : [카테고리], [부서코드], [검색조건], [검색키워드]
	 * @param pageInfo : 페이징바 객체
	 * @return : 공지사항 목록(페이지별)
	 */
	public List<BoardDto> selectBoardList(PageInfoDto pageInfo, Map<String, String> filter){
		return boardDao.selectBoardList(pageInfo, filter);
	}
	
	/**
	 * @param filter : [부서코드], [카테고리], [검색조건], [검색키워드], ([글번호])
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
	 * @param params : [글번호], [부서코드], ([카테고리], [검색조건], [검색키워드])
	 * @return : 공지사항 상세정보가 담긴 공지사항 객체
	 */
	public BoardDto selectBoard(HashMap<String, Object> params) {
		return boardDao.selectBoard(params);
	}
	
	/**
	 * @param board : 등록할 공지사항 정보가 담긴 공지사항 객체
	 * @method : 공지사항 등록
	 * @return : 등록된 공지사항 행 수, 등록실패한 첨부파일 객체 리스트
	 */
	public Map<String, Object> insertBoard(BoardDto board){
		Map<String, Object> result = new HashMap<>();
		
		// 1) 게시글 등록
		int boardResult = boardDao.insertBoard(board);
		result.put("boardResult", boardResult);
		
		// 2) 첨부파일이 있을경우, 첨부파일 등록
		List<AttachmentDto> attachmentList = board.getAttachmentList();
		if(boardResult > 0) {
			if(attachmentList != null && !attachmentList.isEmpty()) {
				result.put("failedFiles", attachmentService.insertAttachment(attachmentList));
			}
		}
		
		return result;
	}
	
}
