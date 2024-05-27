package com.br.project.controller.sales;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.br.project.service.sales.SalesService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="sales")
@RequiredArgsConstructor
@Slf4j
public class SalesController {

	private SalesService salesService;
	
	/**
	 * 이용권 매출관리 페이지요청
	 */
	@RequestMapping("/ticket.do")
	public String showSalesManagePage() {
		return "/sales/ticket_sales";
	}
	
}
