package com.br.project.service.calendar;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.calendar.CalendarDao;
import com.br.project.dto.calendar.CalendarDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CalendarService {
	private final CalendarDao calDao;

	/**
	 * @author dpcks
	 * @return
	 */
	public List<CalendarDto> selectPCalendar() {
		return calDao.selectPCalendar();
	}

	/**
	 * @author dpcks
	 * @param calendar
	 * @return
	 */
	public int insertCal(CalendarDto calendar) {
		int result = calDao.insertCal(calendar);
		int outcome = 1;
		String[] coArr = calendar.getCoworker();
		
		if(coArr != null) {
			for(String w : coArr) {
				outcome *= calDao.insertCoworker(w);							
			}
		}
		
		return result * outcome;
	}

	public int calUpdate(CalendarDto calendar) {
		int result = calDao.calUpdate(calendar);
		return result;
	}

	public List<MemberDto> selectTeamPeer(String teamCode) {
		return calDao.selectTeamPeer(teamCode);
	}
}
