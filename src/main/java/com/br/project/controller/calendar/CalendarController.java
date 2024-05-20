package com.br.project.controller.calendar;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.br.project.dto.calendar.CalendarDto;
import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.service.calendar.CalendarService;
import com.br.project.service.common.department.DepartmentService;
import com.br.project.service.pay.VacationService;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/calendar")
@RequiredArgsConstructor
public class CalendarController {
	private final CalendarService calService;
	private final DepartmentService dService;
	private final VacationService vService;

	/**
	 * 일정 캘린더를 이동 하면서 부서 내부에 팀원 과 부서 카테고리를 조회해서 가져오는 매서드
	 * @param session 로그인한 직원의 부서 코드를 받아오기 위한 매개변수
	 * @param mv 	  조회된 데이터를 전달하고 view을 선택하는 배개변수	
	 * @return
	 */
	@GetMapping("/pCalendar.page")
	public ModelAndView importPCalendar(HttpSession session, ModelAndView mv) {
		
		MemberDto member = (MemberDto)session.getAttribute("loginMember");
		String teamCode = member.getTeamCode();
		List<MemberDto> teams = calService.selectTeamPeer(teamCode);
		Map<String, String> map = new HashMap<>();
		map.put("code", "CALD01");
		List<GroupDto> group = dService.selectDepartmentList(map);	
		
		for(int i =0; i<teams.size(); i++) {
			MemberDto m = teams.get(i);
			if(m.getUserNo() == member.getUserNo()) {
				teams.add(0, teams.remove(i));
			}
		}
		
		mv.addObject("teams", teams)
		  .addObject("group", group)
		  .setViewName("calendar/pCalendar");
		return mv;
	}
	

	/**
	 * ajax을 이용해서 userNO값[null: 전체, userNo: 특정 사원]을 받아와서 조회하는 매서드
	 * @param request 전달 받은 data null값을 받기 위해 json으로 받아옴
	 * @return userNo값에 따라 조회되는 일정 List
	 */
	@ResponseBody
	@PostMapping(value="/selectCal.ajax", produces="application/json")
	public Map<String, Object> ajaxSelectPCalendar(@RequestBody Map<String, Object> request,
												 HttpSession session) {
		MemberDto member = (MemberDto)session.getAttribute("loginMember");
		request.put("teamCode", member.getTeamCode());

		Map<String, Object> map = new HashMap<>();
		
		map.put("list", calService.ajaxSelectPCalendar(request));
		map.put("vacaList", vService.ajaxSelectVacation(request));
		
		if(request.get("calNoList") instanceof List) {
			if(((List<?>)request.get("calNoList")).isEmpty()) {
				map.put("noSearch", "Y");
			}
		}
		
		return map;
	}


	/**
	 * 일정 등록 페이지로 이동하면서 team과 카테고리(group)를 조회해 오는 매서드
	 * for 문 => front단에서 본인이 가장 먼저 나오도록 정렬 시킴
	 * @param session 로그안 유저의 부서를 가져오기 위한 매서드
	 * @param mv team, group, view을 전달 및 선택하는 객체
	 * @return
	 */
	@GetMapping("/calEnroll.page")
	public ModelAndView moveEnroll(HttpSession session, ModelAndView mv) {
		
		MemberDto member = (MemberDto)session.getAttribute("loginMember");
		String teamCode = member.getTeamCode();
		
		List<MemberDto> teams = calService.selectTeamPeer(teamCode);
		Map<String, String> map = new HashMap<>();
		map.put("code", "CALD01");
		List<GroupDto> group = dService.selectDepartmentList(map);	
		
		for(int i =0; i<teams.size(); i++) {
			MemberDto m = teams.get(i);
			if(m.getUserNo() == member.getUserNo()) {
				teams.add(0, teams.remove(i));
			}
		}
		
		mv.addObject("teams", teams)
		.addObject("group", group)
		.setViewName("calendar/calEnroll");
		
		return mv;
	}
	
	/**
	 * 일정 등록 페이지에서 전달 받은 객체, 데이터를 형 변환을 해서 db에 저장 시키고 그 결과를 반환하는 매서드
	 * @param calendar 	db로 부터 전달 받은 calendarDto 데이터
	 * @param date 		사용자가 선탣한 시작, 끝 날짜
	 * @param time 		사용자가 선탣한 시작, 끝 시간
	 * @param mv 		알림 문구와 view단을 선택하기 위한 객체
	 * @return 
	 */
	@PostMapping("/calEnroll.do")
	public ModelAndView insertCal(CalendarDto calendar
							, String[] date, String[] time
							, HttpSession session
							, ModelAndView mv) {

		calendar.setCalSort("D");			
		calendar.setStartDate(date[0]+ " " + time[0]);
		calendar.setEndDate(date[1] + " " + time[1]);
		
		MemberDto member = (MemberDto)session.getAttribute("loginMember");
		calendar.setEmp(String.valueOf(member.getUserNo()));
		
		int result = calService.insertCal(calendar);
		
		if(result > 0 ) {
			mv.addObject("alertMsg", "성공적으로 등록 되었습니다.")
			  .addObject("modalColor", "G")
			  .setViewName("redirect:pCalendar.page");
		}else {
			mv.addObject("alertMsg", "다시 시도해 주세요.")
			  .addObject("modalColor", "R")
			  .setViewName("redirect:calEnroll.page");
		}
		return mv;
	}
	
	/**
	 * 수정을 필요를 하는 데이터를 받아와서 형변환(date + time) 후 db에 저장
	 * @param calendar  수정된 data를 받아오는 받아오는 Dto 객체
	 * @param date 		날짜에 해당하는 값
	 * @param time		시간에 해당하는 값
	 * @param mv		알림 문구와 view단을 선택하는 객체
	 * @return
	 */	
	@ResponseBody
	@PostMapping("/calUpdate.do")
	public int calUpdate(CalendarDto calendar
						, HttpSession session
						, String[] date, String[] time
						, ModelAndView mv) {
		
		calendar.setStartDate(date[0]+ " " + time[0]);
		calendar.setEndDate(date[1] + " " + time[1]);
		MemberDto member = (MemberDto)session.getAttribute("loginMember");
		calendar.setEmp(String.valueOf(member.getUserNo()));
		
		return calService.calUpdate(calendar);
	}

	/**
	 * 회사일정에 관한 카테고리를 조회해서 이동해주는 매서드
	 * @param mv
	 * @return
	 */
	@GetMapping("/companyCalendar.page")
	public ModelAndView selectCompanyCalendar(ModelAndView mv) {
		Map<String, String> map = new HashMap<>();
		map.put("code", "CALD02");
		List<GroupDto> group = dService.selectDepartmentList(map);	
		
		mv.addObject("group", group)
		  .setViewName("calendar/cCalendar");
		
		return mv;
	}
	
	/**
	 * 회사 일정을 등록 하기 위한 매서드
	 * @param calendar 	입력한 정보
	 * @param session 	현재 회원의 정보을 받기 위한 session 객체
	 * @param date		입력된 날짜
	 * @param time		입력된 시간
	 * @param mv		알림 문구를 보내기 위한 객체
	 * @return
	 */
	@PostMapping("/insertCompanyCal.do")
	public ModelAndView insertCompany(CalendarDto calendar
									  , HttpSession session
									  , String[] date, String[] time
									  , ModelAndView mv) {
		calendar.setCalSort("C");			
		calendar.setStartDate(date[0]+ " " + time[0]);
		calendar.setEndDate(date[1] + " " + time[1]);
		
		MemberDto member = (MemberDto)session.getAttribute("loginMember");
		calendar.setEmp(String.valueOf(member.getUserNo()));
		
		int result = calService.insertCompany(calendar);
		
		if(result > 0 ) {
			mv.addObject("alertMsg", "성공적으로 등록 되었습니다.")
			  .addObject("modalColor", "G")
			  .setViewName("redirect:companyCalendar.page");
		}else {
			mv.addObject("alertMsg", "다시 시도해 주세요.")
			  .addObject("modalColor", "G")
			  .setViewName("redirect:companyCalEnroll.page");
		}
		
		return mv;
	}
	
	/**
	 * ajax을 통해 회사 일정을 조회해 오는 매서드
	 */
	@ResponseBody
	@PostMapping(value="/companyCal.ajax", produces="application/json; charset=UTF-8")
	public List<CalendarDto> ajaxCompanyCalendar() {
		return calService.ajaxCompanyCalendar();
	}
	
	/**
	 * 회사 일정 등록 페이지로 이동 및 카테고리를 조회해서 가져오는 매서드
	 * @param mv
	 * @return
	 */
	@GetMapping("/companyCalEnroll.page")
	public ModelAndView moveCompanyEnroll(ModelAndView mv) {
		Map<String, String> map = new HashMap<>();
		map.put("code", "CALD02");
		List<GroupDto> group = dService.selectDepartmentList(map);	
		
		mv.addObject("group", group)
		.setViewName("calendar/companyCalEnroll");
		
		return mv;
	}

	/**
	 * 회사 일정을 갱신하기 위한 매서드
	 * @param calendar 	해당 일정의 calendarDto값을 받아옴
	 * @param date		유저가 입력한 data값
	 * @param time		유저가 입력한 time값
	 * @param mv		
	 * @return
	 */
	@ResponseBody
	@PostMapping("/companyCalUpdate.do")
	public int companyCalUpdate(CalendarDto calendar, HttpSession session
								, String[] date, String[] time, ModelAndView mv) {
		
		calendar.setStartDate(date[0]+ " " + time[0]);
		calendar.setEndDate(date[1] + " " + time[1]);
		MemberDto member = (MemberDto)session.getAttribute("loginMember");
		calendar.setEmp(String.valueOf(member.getUserNo()));
		calendar.setCalSort("C");
		
		return calService.companyCalUpdate(calendar);
	}

	/**
	 * 회사 일정을 List로 보여주는 위한 페이지로 이동하는 매서드
	 */
	@GetMapping("/calendarList.page")
	public String calendarList() {
		return "calendar/calendarList";
	}
	

	/**
	 * ajax을 통해서 필요한 부분만 일정을 불러 들이는 매서드
	 * @param page			현재 페이지값을 전달받은 매개변수
	 * @param dataStart		검색을 위한 시작 날짜
	 * @param dataEnd		검색을 위한 끝 날짜
	 * @return map			paging처리를 위한 객체와 page에 맞는 List 객체 반환
	 */
	@ResponseBody
	@PostMapping(value="/calendarControllor.ajax", produces="application/json")
	public Map<String, Object> ajaxCompanyControllor(@RequestParam(defaultValue = "1") int page
													,String dataStart, String dataEnd, String calSort) {
		
		Map<String, Object> map = new HashMap<>();
		map.put("dataStart", dataStart);
		map.put("dataEnd", dataEnd);
		map.put("calSort", calSort);
		
		int listCount = calService.selectListCount(map);
		PageInfoDto paging = new PagingUtil().getPageInfoDto(listCount, page, 5, 5);
		map.put("paging", paging);
		
		List<CalendarDto> list = calService.selectListCalendar(map);
		
		map.remove("dataStart");
		map.remove("dataEnd");
		map.remove("calSort");

		map.put("list", list);	
		
		return map;
	}
	
	/*
	 * 1) view단에 .serialize()을 사용 할떄 
	 * 공통된 name(check)에서 값을 추출 할때는 HttpServletRequest을 이용해서 
	 * 배열로 값을 받아 올 수 있다.
	 * String[] checkValues = request.getParameterValues("check");
	 * log.debug("check values: {}", Arrays.toString(checkValues));
	 * 
	 * 2) 
	 * JSON.stringify(value, replacer, space)
	 * 	- value :   JSON 문자열로 변환할 값이다.(배열, 객체, 숫자, 문자)
	 * 	- replacer: 함수 또는 배열이 될 수 있다. 
	 * 				함수일떄 한번 걸치고 해당하는 값만을 반환
	 * 				배열일때 값과 일치하는 값만 문자열화 한다.
	 * 	- space :   해당하는 공백(숫자) 이나 구분자(",")를 넣어서 문자열화 한다.
	 * 	주의 : value 값들을 객체든, 배열이든 모두 String 타입으로 변환 되어 생성된다.
	 * 	
	 * 	- .get() : 선택된 요소를 배열로 가져옴 == 제이쿼리 객체를 배열로 가져올 수 있음
	 *	- .map(Array, function(value, key[index]){
	 *			return value +1;
	 *		})
	 * 	
	 * 
	 * Resolved [org.springframework.http.converter.HttpMessageNotReadableException: JSON parse error: Cannot deserialize value of type `[Ljava.lang.String;` from Object value (token `JsonToken.START_OBJECT`); 
	 * nested exception is com.fasterxml.jackson.databind.exc.MismatchedInputException: Cannot deserialize value of type `[Ljava.lang.String; ` from Object value (token `JsonToken.START_OBJECT`)<EOL> at [Source: (org.springframework.util.StreamUtils$NonClosingInputStream); line: 1, column: 1]]
	 */
//	@ResponseBody
//	@PostMapping(value="/deletedCheck.do", produces = "application/json")
//	public void ajaxDeleredCal(@RequestBody Map<String, String> map) {
//		//Object str = request.get("check");
//		log.debug("request  { }", map);
////		 log.debug("check  { }", str);
//	}
	
	/**
	 * 체크된 일정 번호를 받아와서 상태를 'N'으로 변경하는 매서드 
	 * @param request	체크된 값들을 배열로 받기위한 필요 매개변수
	 * @return 			삭게된 행수를 반환
	 */
	@ResponseBody
	@PostMapping(value="/deletedCheck.do", produces = "application/json; charset=utf8")
	public int ajaxDeletedCal(HttpServletRequest request) {
		 String[] values = request.getParameterValues("check");
		 return calService.ajaxDeletedCal(values);
	}

}
