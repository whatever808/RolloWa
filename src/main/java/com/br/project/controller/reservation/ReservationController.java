package com.br.project.controller.reservation;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.br.project.dto.common.PageInfoDto;
import com.br.project.service.reservation.ReservationService;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import oracle.jdbc.clio.annotations.Debug;


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
	@GetMapping("/my.do")
	public ModelAndView reservationList(@RequestParam(value = "userNo", defaultValue = "1") int userNo,
			ModelAndView mv) {
		
		//log.debug("값을 가져왔는지 : {}", userNo);

		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("userNo", userNo);
		
		//int listCount = reservationService.selectEquipmentListCount();
		//PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		//paramMap.put("pi", pi);
		
		// 내 예약 리스트 가져오기
		List<HashMap<String, Object>> reservationList = reservationService.selectMyReservation(paramMap);
		log.debug("예약 리스트 : {}", reservationList);
		
		mv.addObject("reservationList", reservationList)
		  .setViewName("reservation/reservation_my");
		
		return mv;
	}

	// 3.3 내 예약 취소
	@PostMapping("/cancel.do")
	@ResponseBody
	public String cancelReservations(@RequestBody Map<String, Object> request) {
	    List<Integer> reservationNo = (List<Integer>) request.get("reservationNo");

	    log.debug("reservationNo값 : {}", reservationNo);
	    
	    Map<String, Object> params = new HashMap<>();
	    params.put("reservationNo", reservationNo);
	    
	    int result = reservationService.updateReservation(params);
	    if(result > 0) {
	        log.debug("업데이트 성공");
	        return "SUCCESS";
	    } else {
	        log.debug("업데이트 실패");
	        return "FAIL";
	    }
	}
	
	// 3.4 비품 관리
	@GetMapping("/equipment.do")
	public ModelAndView reservationEquipment(@RequestParam(value = "page", defaultValue = "1") int currentPage,
			ModelAndView mv) {
		
		Map<String, Object> paramMap = new HashMap<>();
		// 비품 정보 가져오기
		int listCount = reservationService.selectEquipmentListCount();
		List<HashMap<String, Object>> list = reservationService.selectEquipmentList(paramMap);
		
		mv.addObject("list", list)
		  .addObject("listCount", listCount)
		  .setViewName("reservation/reservation_equipment");
		
		return mv;
	}
	
	// 비품 추가
    @PostMapping("/equipment")
    @ResponseBody
    public Map<String, Object> insertEquipment(@RequestBody Map<String, Object> equipmentData) {
        String equipmentName = (String) equipmentData.get("equipmentName");
        Map<String, Object> response = new HashMap<>();
        int success = reservationService.insertEquipment(equipmentName);
        response.put("success", success);
        return response;
    }

    // 비품 삭제
    @DeleteMapping("/equipment")
    @ResponseBody
    public Map<String, Object> deleteEquipment(@RequestBody Map<String, Object> equipmentData) {
        List<Integer> ids = (List<Integer>) equipmentData.get("ids");
        Map<String, Object> response = new HashMap<>();
        int success = reservationService.deleteEquipment(ids);
        response.put("success", success);
        return response;
    }

    // 비품 업데이트
    @PutMapping("/equipment")
    @ResponseBody
    public Map<String, Object> updateEquipment(@RequestBody List<Map<String, Object>> equipmentList) {
        Map<String, Object> response = new HashMap<>();
        int success = reservationService.updateEquipment(equipmentList);
        response.put("success", success);
        return response;
    }
	
	
}
