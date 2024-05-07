package com.br.project.service.calendar;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.calendar.CalendarDao;
import com.br.project.dto.calendar.CalendarDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CalendarService {
	private final CalendarDao CalDao;

	public List<CalendarDto> selectPCalendar() {
		return CalDao.selectPCalendar();
	}
}
