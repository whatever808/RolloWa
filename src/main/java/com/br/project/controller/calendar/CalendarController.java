package com.br.project.controller.calendar;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	 * 개인 ?��?�� ?��?�� 매서?��
	 * @author dpcks
	 */
	@RequestMapping("/pCalendar.page")
	public void selectPCalendar() {}
	
	/**
	 * @author dpcks
	 * @return ?��?�� qja?��값을 ?���? 못정?��
	 */
	@ResponseBody
	@PostMapping(value="/selectCal.do", produces="application/json")
	public List<CalendarDto> selectCal(String start, String end) {
//		log.debug("start {}", start);
		log.debug("end {}", end);
		Map<String, String> map = new HashMap<>();
		map.put("start", start.replace("T", " "));
		map.put("end", end.replace("T", " "));
		
		return calService.selectPCalendar(map);
	}
	
}
