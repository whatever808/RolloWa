package com.br.project.service.sales;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.sales.SalesDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SalesService {

	private final SalesDao salesDao;
	
	
	/**
	 * 년/월/일 총매출액, 평균매출액, 최고매출액, 최저매출액 조회 (테이블)
	 */
	public List<Map<String, Object>> selectTicketSalesForTable(HashMap<String, Object> params){
		return salesDao.selectTicketSalesForTable(params);
	}
	
	/**
	 * 월/일 이용권별 총매출액, 평균매출액 조회 (차트)
	 */
	public List<Map<String, Object>> selectTicketSalesForChart(HashMap<String, Object> params){
		return salesDao.selectTicketSalesForChart(params);
	}
	
	/**
	 * 결제수단별 매출비율 조회
	 */
	public List<Map<String, Object>> selectTicketSalesPercentByPaymentMethod(HashMap<String, Object> params){
		return salesDao.selectTicketSalesPercentByPaymentMethod(params);
	}
}
