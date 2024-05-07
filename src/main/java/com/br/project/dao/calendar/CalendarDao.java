package com.br.project.dao.calendar;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.calendar.CalendarDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class CalendarDao {
	private final SqlSessionTemplate sqlSession;

	public List<CalendarDto> selectPCalendar(Map<String, String> map) {
		return sqlSession.selectList("calMapper.selectPCalendar", map);
	}
	
	
}
