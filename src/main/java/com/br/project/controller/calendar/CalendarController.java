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

	/**
	 * 개인 일정 과 같은 팀원들의 정보를 불러오는 매서드
	 * @author dpcks
	 * @param mv 조회된 객체와 view단을 선택하는 객체
	 * @return 
	 */
	@GetMapping("/pCalendar.page")
	public ModelAndView importPCalendar(HttpSession session, ModelAndView mv) {
		
		MemberDto member = (MemberDto)session.getAttribute("loginUser");
		
//		String teamCode = member.getTeamCode();
		String teamCode = "A";
		
		List<MemberDto> teams = calService.selectTeamPeer(teamCode);
		
		for(int i =0; i<teams.size(); i++) {
			MemberDto m = teams.get(i);
			if(m.getUserNo() == 1051) {
				teams.add(0, teams.remove(i));
			}
		}
		//log.debug("teams {}", teams);
		
		List<GroupDto> group = dService.selectDepartmentList("CALD01");
		//log.debug("group {}", group);		
		
		mv.addObject("teams", teams)
		  .addObject("group", group)
		  .setViewName("calendar/pCalendar");
		return mv;
	}
	
	/**
	 * @param userNo
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="/selectCal.ajax", produces="application/json")
	public List<CalendarDto> ajaxSelectPCalendar(@RequestBody Map<String, Object> request) {
		//log.debug("userNo {}", request.get("userNO"));
		List<CalendarDto> list = calService.ajaxSelectPCalendar(request.get("userNO"));
		//log.debug("list = {}", list);
		return list;
	}

	/**
	 * 일정을 등록하기 위한 페이지를 이동 하는 매서드
	 * @author dpcks
	 */
	@GetMapping("/calEnroll.page")
	public ModelAndView moveEnroll(HttpSession session, ModelAndView mv) {
		
		MemberDto member = (MemberDto)session.getAttribute("loginUser");
		
//		String teamCode = member.getTeamCode();
		String teamCode = "A";
		
		List<MemberDto> teams = calService.selectTeamPeer(teamCode);
		
		for(int i =0; i<teams.size(); i++) {
			MemberDto m = teams.get(i);
			if(m.getUserNo() == 1051) {
				teams.add(0, teams.remove(i));
			}
		}
		
		List<GroupDto> group = dService.selectDepartmentList("CALD01");
		
		mv.addObject("teams", teams)
		.addObject("group", group)
		.setViewName("calendar/calEnroll");
		
		return mv;
	}
	
	/**
	 * 일정 등록 페이지에서 전달 받은 객체, 데이터를 형 변환을 해서
	 * db에 저장 시키고 그 결과를 반환하는 매서드
	 * @param calendar db로 부터 전달 받은 calendarDto 데이터
	 * @param date 사용자가 선탣한 시작, 끝 날짜
	 * @param time 사용자가 선탣한 시작, 끝 시간
	 * @param mv 성공 문구와 view단을 선택하기 위한 객체
	 * @return 
	 */
	@PostMapping("/calEnroll.do")
	public ModelAndView insertCal(CalendarDto calendar
							, String[] date, String[] time
							, HttpSession session
							, ModelAndView mv) {
		if(calendar.getCalSort() != "P") {
			calendar.setCalSort("D");			
		}
		calendar.setStartDate(date[0]+ " " + time[0]);
		calendar.setEndDate(date[1] + " " + time[1]);
		
		MemberDto member = (MemberDto)session.getAttribute("loginUser");
//		calendar.setEmp(String.valueOf(member.getUserNo()));
		calendar.setEmp("1051");
		
		//log.debug("data == {}", calendar);
		
		int result = calService.insertCal(calendar);
		
		if(result > 0 ) {
			mv.addObject("alertMsg", "성공적으로 등록 되었습니다.").setViewName("redirect:pCalendar.page");
		}else {
			mv.addObject("alertMsg", "다시 시도해 주세요.").setViewName("redirect:calEnroll.page");
		}
		return mv;
	}
	
	/**
	 * 수정을 필요를 하는 데이터를 받아와서 형변환(date + time) 후 db엣 저장
	 * @param calendar
	 * @param date
	 * @param time
	 * @return
	 */	
	@PostMapping("/calUpdate.do")
	public ModelAndView calUpdate(CalendarDto calendar,
									String[] date, String[] time
									, ModelAndView mv) {
		
		calendar.setStartDate(date[0]+ " " + time[0]);
		calendar.setEndDate(date[1] + " " + time[1]);
		//MemberDto member = (MemberDto)session.getAttribute("loginUser");
		//calendar.setCalNO(String.valueOf(member.getUserNo()));
		calendar.setEmp("1051");
		log.debug("calendar {}", calendar);
		
		int result = calService.calUpdate(calendar);
		
		if(result > 0 ) {
			mv.addObject("alertMsg", "성공적으로 등록 되었습니다.").setViewName("redirect:pCalendar.page");
		}else {
			mv.addObject("alertMsg", "다시 시도해 주세요.").setViewName("redirect:pCalendar.page");
		}
		return mv;
	}

	/**
	 * @param mv
	 * @return
	 */
	@GetMapping("/companyCalendar.page")
	public ModelAndView selectCompanyCalendar(ModelAndView mv) {
		
		List<GroupDto> group = dService.selectDepartmentList("CALD02");	
		List<CalendarDto> list = calService.selectCompanyCalendar();
		
		mv.addObject("list", list)
			.addObject("group", group)
			.setViewName("calendar/cCalendar");
		
		return mv;
	}
	
	/**
	 * @param session
	 * @param mv
	 * @return
	 */
	@GetMapping("/companyCalEnroll.page")
	public ModelAndView moveCompanyEnroll(HttpSession session, ModelAndView mv) {
		
		List<GroupDto> group = dService.selectDepartmentList("CALD02");
		
		mv.addObject("group", group)
		.setViewName("calendar/companyCalEnroll");
		
		return mv;
	}

	/**
	 * @param calendar
	 * @param date
	 * @param time
	 * @param mv
	 * @return
	 */
	@PostMapping("/companyCalUpdate.do")
	public ModelAndView companyCalUpdate(CalendarDto calendar,
										String[] date, String[] time
										, ModelAndView mv) {
		
		calendar.setStartDate(date[0]+ " " + time[0]);
		calendar.setEndDate(date[1] + " " + time[1]);
		//MemberDto member = (MemberDto)session.getAttribute("loginUser");
		//calendar.setCalNO(String.valueOf(member.getUserNo()));
		calendar.setEmp("1050");
		calendar.setCalSort("C");
		log.debug("calendar {}", calendar);
		
		int result = calService.companyCalUpdate(calendar);
		
		if(result > 0 ) {
			mv.addObject("alertMsg", "성공적으로 등록 되었습니다.").setViewName("redirect:companyCalendar.page");
		}else {
			mv.addObject("alertMsg", "다시 시도해 주세요.").setViewName("redirect:companyCalEnroll.page");
		}
		return mv;
	}

	/**
	 * 
	 */
	@GetMapping("/companyControllor.page")
	public void companyControllor() {}
	
	/**
	 * @param page
	 * @param dataStart
	 * @param dataEnd
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="/companyControllor.ajax",  produces="application/json")
	public Map<String, Object> ajaxcompanyControllor(@RequestParam(defaultValue = "1") int page
													,String dataStart, String dataEnd) {
		
		//log.debug("page {}", page);
		//log.debug("dataStart {}", dataStart);
		//log.debug("dataEnd {}", dataEnd);
		
		Map<String, Object> map = new HashMap<>();
		map.put("dataStart", dataStart);
		map.put("dataEnd", dataEnd);
		
		int listCount = calService.selectListCount(map);
		PageInfoDto paging = new PagingUtil().getPageInfoDto(listCount, page, 5, 5);
		map.put("paging", paging);
		
		List<CalendarDto> list = calService.selectListCalendar(map);
		
		map.remove("dataStart");
		map.remove("dataEnd");

		map.put("list", list);	
		
		return map;
	}
	
	/**
	 * @param check
	 */
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
//	@PostMapping(value="/deletedCheck.do", produces = "application/json; charset=utf8")
//	public void ajaxDeleredCal(@RequestBody String[] check) {
//		 log.debug("String   { }", Arrays.toString(check));
//		 log.debug("String   { }", check);
//	}
	
	@ResponseBody
	@PostMapping(value="/deletedCheck.do", produces = "application/json; charset=utf8")
	public int ajaxDeletedCal(HttpServletRequest request) {
		 String[] values = request.getParameterValues("check");
		 //log.debug("values: {}", Arrays.toString(values));
		 return calService.ajaxDeletedCal(values);
	}
	

}
