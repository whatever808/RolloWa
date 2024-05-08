package com.br.project.controller.calendar;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.br.project.dto.calendar.CalendarDto;
import com.br.project.service.calendar.CalendarService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
@RequestMapping("/calendar")
@RequiredArgsConstructor
public class CalendarController {
	private final CalendarService calService;
	
	/**
	 * 개인 및 부서 일정 조회 매서드
	 * @author dpcks
	 */
	@GetMapping("/pCalendar.page")
	public ModelAndView selectPCalendar(ModelAndView mv) {
		List<CalendarDto> list = calService.selectPCalendar();
		for(int i= 0; i< list.size(); i++) {
		}
		mv.addObject("list", list).setViewName("calendar/pCalendar");
		return mv;
	}
	
	@GetMapping("/calEnroll.page")
	public void moveEnroll() {}
	
	@PostMapping("/calEnroll.do")
	public void insertCal(CalendarDto calendar, String[] date, String[] time) {
		log.debug("data == {}", calendar);
		calendar.setStartDate(date[0]+ " " + time[0]);
		calendar.setEndDate(date[1] + " " + time[1]);
		
//		calService.insertCal(calendar);
	}
	
	
	
	
	
}
