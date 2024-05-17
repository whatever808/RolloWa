package com.br.project.controller.reservation;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.br.project.dto.common.GroupDto;
import com.br.project.service.reservation.ReservationService;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("/reservation")
@Controller
@RequiredArgsConstructor
@Slf4j
public class ReservationController {

	private final ReservationService reservationService;
	private final PagingUtil pagingUtil;
	
	// 3.1 예약 관리
	@GetMapping("/list.do")
	public String orgChart(Model model) {
		return "reservation/list";
	}	
	
}
