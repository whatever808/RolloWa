package com.br.project.dao.board;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.board.BoardDto;
import com.br.project.dto.common.PageInfoDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class BoardDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @return : 총게시글 갯수조회 (STATUS = "Y")
	 */
	public int selectTotalBoardCount(Map<String, String> request) {
		return sqlSessionTemplate.selectOne("boardMapper.selectTotalBoardCount", request);
	}
	
	/**
	 * @return : 게시글 목록조회
	 */
	public List<BoardDto> selectBoardList(PageInfoDto pageInfo, Map<String, String> request){
		RowBounds rowBounds = new RowBounds(pageInfo.getListLimit() * (pageInfo.getCurrentPage() - 1)
										   ,pageInfo.getListLimit());
		return sqlSessionTemplate.selectList("boardMapper.selectBoardList", request, rowBounds);
	}
	
	
	/**
	 * @return : 게시글 등록 행수
	 */
	public int insertBoard(BoardDto board) {
		return sqlSessionTemplate.insert("boardMapper.insertBoard", board);
	}

	
	
	
}
