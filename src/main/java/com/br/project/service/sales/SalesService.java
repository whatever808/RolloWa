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
	 * 티켓별 매출현황 조회
	 */
	public List<Map<String, Object>> selectTicketSalesByTicketType(HashMap<String, Object> params){
		return salesDao.selectTicketSalesByTicketType(params);
	}
	
	/**
	 * 결제수단별 매출비율 조회
	 */
	public List<Map<String, Object>> selectTicketSalesPercentByPaymentMethod(HashMap<String, Object> params){
		return salesDao.selectTicketSalesPercentByPaymentMethod(params);
	}
}
