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
	 * @method : 총게시글 갯수조회(STATUS = 'Y')
	 * @return : 총게시글수
	 */
	public int selectTotalBoardCount(Map<String, String> filter) {
		return boardDao.selectTotalBoardCount(filter);
	}
	
	/**
	 * @method : 게시글 목록조회
	 * @return : 게시글 리스트
	 */
	public List<BoardDto> selectBoardList(PageInfoDto pageInfo, Map<String, String> filter){
		return boardDao.selectBoardList(pageInfo, filter);
	}
	
	/**
	 * @method : 게시글 등록
	 * @return : {{게시글 등록행수}, [{등록실패 첨부파일},...]}
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
