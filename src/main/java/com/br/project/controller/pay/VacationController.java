package com.br.project.controller.pay;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.br.project.service.pay.VacationService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/vacation")
@RequiredArgsConstructor
public class VacationController {
	private final VacationService vacaService;
	
	/**
	 * 휴가 조회 및 신청을 할 수 있는 페이지
	 * @author 에찬
	 * @return 휴가 카테고리 와 휴가 현황을 반환 
	 */
	@GetMapping("/vacation.page")
	public void selectVacation() {
		
	}
	
}
