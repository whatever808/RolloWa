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
	public List<CalendarDto> selectPCalendar(Map<String, Object> map) {
		return calDao.selectPCalendar(map);
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
	 * @param userNo
	 * @return
	 */
	public List<CalendarDto> selectOneMemberCal(String userNo) {
		
		List<String> calNoList = calDao.selectCalNO(userNo);
//		log.debug("calNoList == {}", calNoList);
		
		Map<String, Object> map = new HashMap<>();
		map.put("calNoList", calNoList);

		return  calDao.selectPCalendar(map);
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
	public int selectListCount() {
		return calDao.selectListCount();
	}
}
