package com.br.project.controller.sales;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import static com.br.project.controller.common.CommonController.*;
import com.br.project.service.sales.SalesService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="sales")
@RequiredArgsConstructor
@Slf4j
public class SalesController {

	private final SalesService salesService;
	
	/**
	 * 이용권 매출관리 페이지요청
	 */
	@RequestMapping("/ticket.do")
	public String showSalesManagePage() {
		return "/sales/ticket_sales";
	}
	
	/**
	 * 년/월/일 총매출액, 평균매출액, 최고매출액, 최저매출액 조회 (테이블)
	 */
	@RequestMapping(value="/ticket/table.ajax", produces="application/json; charset=utf-8")
	@ResponseBody
	public List<Map<String, Object>> selectTicketSalesByTicketType(HttpServletRequest request){
		return salesService.selectTicketSalesForTable(getParameterMap(request));
	}
	
	/**
	 * 월/일 이용권별 총매출액, 평균매출액 조회 (차트)
	 */
	@RequestMapping(value="/ticket/chart.ajax", produces="application/json; charset=utf-8")
	@ResponseBody
	public List<Map<String, Object>> ajaxSelectTicketSalesForChart(HttpServletRequest request){
		return salesService.selectTicketSalesForChart(getParameterMap(request));
	}

	
	/**
	 * 결제수단별 매출비율 데이터조회
	 */
	@RequestMapping(value="/ticket/paymethod.ajax", produces="application/json; charset=utf-8")
	@ResponseBody
	public List<Map<String, Object>> selectTicketSalesPercentByPaymentMethod(HttpServletRequest request){
		return salesService.selectTicketSalesPercentByPaymentMethod(getParameterMap(request));
	}
	
}
