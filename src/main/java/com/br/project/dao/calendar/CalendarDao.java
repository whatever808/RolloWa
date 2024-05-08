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

	public List<CalendarDto> selectPCalendar() {
		return sqlSession.selectList("calMapper.selectPCalendar");
	}

	public int insertCal(CalendarDto calendar) {
		return sqlSession.insert("calMapper.insertCal", calendar);
	}

	public int insertCoworker(String woker) {
		return sqlSession.insert("calMapper.inserCoworker", woker);
	}
	
	
}
