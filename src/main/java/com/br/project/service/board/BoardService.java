package com.br.project.service.board;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.board.BoardDao;
import com.br.project.dto.board.BoardDto;
import com.br.project.dto.common.PageInfoDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class BoardService {

	private final BoardDao boardDao;
	
	/**
	 * @return : 총게시글 갯수조회(STATUS = "Y")
	 */
	public int selectTotalBoardCount(Map<String, String> filter) {
		return boardDao.selectTotalBoardCount(filter);
	}
	
	/**
	 * @return : 게시글 목록조회
	 */
	public List<BoardDto> selectBoardList(PageInfoDto pageInfo, Map<String, String> filter){
		return boardDao.selectBoardList(pageInfo, filter);
	}
	
}
