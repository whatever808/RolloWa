package com.br.project.dao.board;

import java.util.HashMap;
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
	 * @param filter : [카테고리], [부서코드], [검색조건], [검색키워드], [공지사항 상태값]
	 * @return : 총 공지사항 갯수조회 (STATUS = "Y")
	 */
	public int selectTotalBoardCount(HashMap<String, Object> filter) {
		return sqlSessionTemplate.selectOne("boardMapper.selectTotalBoardCount", filter);
	}
	
	/**
	 * @param filter   : [카테고리], [부서코드], [검색조건], [검색키워드], [공지사항/첨부파일 상태값]
	 * @param pageInfo : 페이징바 객체
	 * @return : 공지사항 목록조회(페이지별)
	 */
	public List<BoardDto> selectBoardList(PageInfoDto pageInfo, HashMap<String, Object> filter){
		RowBounds rowBounds = new RowBounds(pageInfo.getListLimit() * (pageInfo.getCurrentPage() - 1)
										   ,pageInfo.getListLimit());
		return sqlSessionTemplate.selectList("boardMapper.selectBoardList", filter, rowBounds);
	}
	
	/**
	 * @param filter : [부서코드], [카테고리], [검색조건], [검색키워드], [공지사항 상태값] ([글번호])
	 * @return : 공지사항 목록조회(전체)
	 */
	public List<BoardDto> selectBoardList(HashMap<String, Object> filter){
		return sqlSessionTemplate.selectList("boardMapper.selectBoardList", filter);
	}
	
	/**
	 * @param boardNo : 공지사항 번호
	 * @return : 공지사항 조회수 증가시킨 총 행수
	 */
	public int updateReadCount(String boardNo) {
		return sqlSessionTemplate.update("boardMapper.updateReadCount", boardNo);
	}
	
	/**
	 * @param params : [글번호], [부서코드], ([카테고리], [검색조건], [검색키워드])
	 * @return : 공지사항 상세정보가 담긴 공지사항 객체
	 */
	public BoardDto selectBoard(HashMap<String, Object> params) {
		return sqlSessionTemplate.selectOne("boardMapper.selectBoard", params);
	}
	
	/**
	 * @return : 공지사항 등록성공시, 등록된 공지사항 번호
	 */
	public int selectPostedBoardNo() {
		return sqlSessionTemplate.selectOne("boardMapper.selectPostedBoardNo");
	}
	
	/**
	 * @param board : 등록할 공지사항 정보가 담긴 공지사항 객체
	 * @return : 공지사항 등록 갯수
	 */
	public int insertBoard(HashMap<String, Object> params) {
		return sqlSessionTemplate.insert("boardMapper.insertBoard", params);
	}
	
	/**
	 * @param board : 수정할 공지사항 정보가 담긴 공지사항 객체
	 * @return : 공지사항 수정 갯수
	 */
	public int updateBoard(HashMap<String, Object> params) {
		return sqlSessionTemplate.update("boardMapper.updateBoard", params);
	}
	
	/**
	 * @param params : {"no" : {수정/삭제할 공지사항번호}, "status" : {변경할 상태값('T'|'N')}}
	 * @method : 공지사항 임시저장으로 변경 or 공지사항 삭제요청시 실행
	 * @return :
	 * 	  ㄴ case 01) 공지사항 임시저장으로 변경요청 : 상태값이 변경된 공지사항 갯수
	 * 	  ㄴ case 02) 공지사항 삭제요청         : 삭제된(상태값이 변경된) 공지사항 갯수
	 */
	public int updateBoardStatus(HashMap<String, Object> params) {
		return sqlSessionTemplate.update("boardMapper.updateBoardStatus", params);
	}
	
	
	
}
