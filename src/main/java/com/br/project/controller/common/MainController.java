package com.br.project.controller.common;

import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.br.project.dto.member.MemberDto;
import com.br.project.service.attendance.AttendanceService;
import com.br.project.service.calendar.CalendarService;
import com.br.project.service.member.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {
	
	private final CalendarService calService;
	private final MemberService memberService;
	private final AttendanceService attendanceService;
	
	// 메인페이지
	@RequestMapping("/")
	public String mainPage(@SessionAttribute(value="loginMember", required=false) MemberDto loginMember,
					HttpServletRequest request) {
		
		if(loginMember != null) {	
			/* --------------------------------------- "가림" --------------------------------------- */
			HashMap<String, Object> params = new HashMap<>();
			params.put("year", (LocalDate.now()).getYear());
			params.put("month", (LocalDate.now()).getMonthValue());
			params.put("userNo", loginMember.getUserNo());
			
			request.setAttribute("loginMember", memberService.selectMemberForMainPage(loginMember));
			request.setAttribute("loginMemberAttend", attendanceService.selectMemberAttend(params));
			request.setAttribute("loginMemberTodayAttend", attendanceService.selectAttendTime(params));
			/* --------------------------------------- "가림" --------------------------------------- */
			return "mainpage/mainpage";
		}
		
		return "main";
	}
	
	/**
	 * 회사 일정 과 부서 일정을 조회해서 전달하는 매서드
	 * @author dpcks
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="/mainCalendar.ajax", produces="application/json; charset=utf8")
	public Map<String, Object> ajaxMainCalendar(HttpSession session){
		MemberDto member = (MemberDto)session.getAttribute("loginMember");
		HashMap<String, Object> map = new HashMap<>();
		map.put("teamCode", member.getTeamCode());
		
		return calService.ajaxMainCalendar(map);
	}
}

