package com.br.project.service.calendar;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.calendar.CalendarDao;
import com.br.project.dto.calendar.CalendarDto;
import com.br.project.dto.calendar.CoworkerDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class CalendarService {
	private final CalendarDao calDao;

	/**
	 * @author dpcks
	 * @return
	 */
	public List<CalendarDto> ajaxSelectPCalendar(Object userNo) {
		Map<String, Object> map = new HashMap<>();
		if(userNo != null) {
			List<String> calNoList = calDao.selectCalNO(userNo);
			map.put("calNoList", calNoList);
			log.debug("calNoList == {}", calNoList);
		}
		
		return calDao.ajaxSelectPCalendar(map);
	}

	/**
	 * @author dpcks
	 * @param calendar
	 * @return
	 */
	public int insertCal(CalendarDto calendar) {
		int result = calDao.insertCal(calendar);
		int outcome = 1;
		List<CoworkerDto> coArr = calendar.getCoworker();
		
		if(!coArr.isEmpty()) {
			for(CoworkerDto c : coArr) {
				outcome *= calDao.insertCoworker(c.getUserNo());							
			}
		}
		
		return result * outcome;
	}

	/**
	 * @param calendar
	 * @return
	 */
	public int calUpdate(CalendarDto calendar) {
		int result = calDao.calUpdate(calendar);
		int outcome = calDao.coworkerDelete(calendar.getCalNO());
		int effect = 1;
		
		List<CoworkerDto> list = calendar.getCoworker();
		
		if(!list.isEmpty() && list != null) {
			for(CoworkerDto c : list) {
				effect *= calDao.reInserCoworker(calendar.getCalNO() , c.getUserNo());
			}
		}
		
		return result * outcome * effect;
	}

	/**
	 * @param teamCode
	 * @return
	 */
	public List<MemberDto> selectTeamPeer(String teamCode) {
		return calDao.selectTeamPeer(teamCode);
	}

	/**
	 * @return
	 */
	public List<CalendarDto> selectCompanyCalendar() {
		return calDao.selectCompanyCalendar();
	}

	/**
	 * @param calendar
	 * @return
	 */
	public int companyCalUpdate(CalendarDto calendar) {
		return calDao.insertCal(calendar);
	}

	/**
	 * @return
	 */
	public List<CalendarDto> selectListCalendar(Map<String, Object> map) {
		return calDao.selectListCalendar(map);
	}

	/**
	 * 전제 리스트 수 반환
	 * @return
	 */
	public int selectListCount(Map<String, Object> map) {
		return calDao.selectListCount(map);
	}

	/**
	 * @param values
	 * @return
	 */
	public int ajaxDeletedCal(String[] values) {
		return calDao.ajaxDeletedCal(values);
	}
}
