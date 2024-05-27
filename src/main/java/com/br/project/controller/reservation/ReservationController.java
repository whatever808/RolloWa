package com.br.project.controller.reservation;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.br.project.dto.common.PageInfoDto;
import com.br.project.service.reservation.ReservationService;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


// 3. 예약 관련 controller

@RequestMapping("/reservation")
@Controller
@RequiredArgsConstructor
@Slf4j
public class ReservationController {

	private final ReservationService reservationService;
	private final PagingUtil pagingUtil;
	
	// 3.1 예약 관리
	@GetMapping("/list.do")
	public ModelAndView reservationList(@RequestParam(value = "page", defaultValue = "1") int currentPage,
			@RequestParam(value = "selectedDate", required = false) String selectedDate,
			ModelAndView mv) {
		
		// 오늘 날짜 가져와서 다음 형식으로 ("yyyy-MM-dd")
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		Calendar cal = Calendar.getInstance();
		String currentDate = sdf.format(cal.getTime());
		
		Map<String, Object> paramMap = new HashMap<>();
		int listCount = reservationService.selectEquipmentListCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		paramMap.put("pi", pi);
		paramMap.put("selectedDate", currentDate);
		List<HashMap<String, Object>> list = reservationService.selectEquipmentList(paramMap);
		
		// 예약 리스트 가져오기
		List<HashMap<String, Object>> reservationList = reservationService.selectReservationState(paramMap);
		log.debug("예약 리스트 : {}", reservationList);
		
		mv.addObject("pi", pi)
		  .addObject("listCount", listCount)
		  .addObject("list", list)
		  .addObject("reservationList", reservationList)
		  .setViewName("reservation/reservation_list");
		
		return mv;
	}
	
	// 3.1 예약 관리
	@GetMapping("/search.do")
	public ModelAndView reservationListSearch(@RequestParam(value = "page", defaultValue = "1") int currentPage,
			@RequestParam(value = "selectedDate") String selectedDate,
			ModelAndView mv) {
		
		Map<String, Object> paramMap = new HashMap<>();
		int listCount = reservationService.selectEquipmentListCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		paramMap.put("pi", pi);
		List<HashMap<String, Object>> list = reservationService.selectEquipmentList(paramMap);
		
		log.debug("검색 selectedDate : {}", selectedDate);
		paramMap.put("selectedDate", selectedDate);
		
		// 예약 리스트 가져오기
		List<HashMap<String, Object>> reservationList = reservationService.selectReservationState(paramMap);
		log.debug("예약 리스트 : {}", reservationList);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("listCount", listCount)
		  .addObject("reservationList", reservationList)
		  .setViewName("reservation/reservation_list");
		
		return mv;
	}
	
	// 비품 예약 하기
	
	@ResponseBody
	@RequestMapping("/reserve.do")
	public Map<String, Object> insertReservation(@RequestParam ("userNo") int userNo,
			@RequestParam ("equipmentName") String equipmentName,
			@RequestParam ("reserveDate") String reserveDate,
			@RequestParam ("startTime") String startTime,
			@RequestParam ("endTime") String endTime,
			@RequestParam ("content") String content){
	
		/*
        log.debug("userNo: {}", userNo);
		log.debug("selectedEquipmentName : {}", equipmentName );
		log.debug("reserveDate : {}", reserveDate );
		log.debug("startTime : {}", startTime );
		log.debug("endTime : {}", endTime );
		log.debug("content : {}", content );
		*/
		
		// 1. 먼저 예약 가능한지 시간 체크하기
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("userNo", userNo);
		paramMap.put("equipmentName", equipmentName);
		paramMap.put("reserveDate", reserveDate);
		paramMap.put("startTime", startTime);
		paramMap.put("endTime", endTime);
		paramMap.put("content", content);
		
		
		int timeCheck = reservationService.selectTimeCheck(paramMap);
		if (timeCheck > 0) {
			paramMap.put("success", false);
	    } else {
	    	int result = reservationService.insertReservation(paramMap);
	    }
		
		
		return paramMap;
        //return "/reservation/list.do";
    }

	
	
	// 3.2 내 예약 조회
	@GetMapping("/my.page")
	public String reservationMy() {
		return "reservation/reservation_my";
	}
	
	
	// 3.3 비품 관리
	@GetMapping("/manager.page")
	public String reservationManager() {
		return "reservation/reservation_manager";
	}
	
}
