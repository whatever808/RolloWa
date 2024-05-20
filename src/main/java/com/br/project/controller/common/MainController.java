package com.br.project.controller.common;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.br.project.dto.calendar.CalendarDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.service.calendar.CalendarService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequiredArgsConstructor
public class MainController {
	private final CalendarService calService;
	// 메인페이지
	@RequestMapping("/")
	public String mainPage(@SessionAttribute(value="loginMember", required=false) MemberDto loginMember,
					HttpServletRequest request) {
		
		if(loginMember != null) {		
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
		map.put("team", member.getTeamCode());
		
		return calService.ajaxMainCalendar(map);
	}
}

