package com.br.project.dao.calendar;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.calendar.CalendarDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CalendarDao {
	private final SqlSessionTemplate sqlSession;

	public List<CalendarDto> ajaxSelectPCalendar(Map<String, Object> request) {
		return sqlSession.selectList("calMapper.ajaxSelectPCalendar", request);
	}

	public int insertCal(CalendarDto calendar) {
		return sqlSession.insert("calMapper.insertCal", calendar);
	}

	public int insertCoworker(String userNo) {
		return sqlSession.insert("calMapper.inserCoworker", userNo);
	}

	public int calUpdate(CalendarDto calendar) {
		return sqlSession.update("calMapper.calUpdate", calendar);
	}

	public List<MemberDto> selectTeamPeer(String teamCode) {
		return sqlSession.selectList("memberMapper.selectTeamPeer", teamCode);
	}

	public int coworkerDelete(String calNO) {
		return sqlSession.delete("calMapper.coworkerDelete", calNO);
	}

	public int reInserCoworker(String calNO, String userNo) {
		Map<String, String> map = new HashMap<>();
		map.put("userNo", userNo);
		map.put("calNO", calNO);
		return sqlSession.insert("calMapper.reInserCoworker", map);
	}

	public List<String> selectCalNO(Object userNo) {
		return sqlSession.selectList("calMapper.selectCalNO", userNo);
	}

	public List<CalendarDto> ajaxCompanyCalendar() {
		return sqlSession.selectList("calMapper.ajaxCompanyCalendar");
	}

	public List<CalendarDto> selectListCalendar(Map<String, Object> map) {
		PageInfoDto page = (PageInfoDto)map.get("paging");
		RowBounds row = new RowBounds(page.getListLimit()* (page.getCurrentPage()-1)
									, page.getListLimit());
		
		return sqlSession.selectList("calMapper.selectListCalendar",map,row);
	}

	public int selectListCount(Map<String, Object> map) {
		return sqlSession.selectOne("calMapper.selectListCount", map);
	}

	public int ajaxDeletedCal(String[] values) {
		return sqlSession.update("calMapper.ajaxDeletedCal", values);
	}

	public int companyCalUpdate(CalendarDto calendar) {
		return sqlSession.update("calMapper.companyCalUpdate", calendar);
	}

	public List<CalendarDto> ajaxMainCalendar() {
		return sqlSession.selectList("calMapper.ajaxMainCalendar");
	}

	public int insertCompany(CalendarDto calendar) {
		return sqlSession.insert("calMapper.insertCal", calendar);
	}
	
	/* ======================================= "가림" 구역 ======================================= */
	/**
	 * 로그인한 사용자의 오늘일정 조회
	 */
	public List<Map<String, Object>> selectTodaySchedule(Map<String, Object> params){
		return sqlSession.selectList("calMapper.selectTodaySchedule", params);
	}
	
	
	/* ======================================= "가림" 구역 ======================================= */
	
}
