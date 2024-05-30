package com.br.project.dao.sales;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class SalesDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * 티켓별 매출현황 조회
	 */
	public List<Map<String, Object>> selectTicketSalesByTicketType(HashMap<String, Object> params){
		return sqlSessionTemplate.selectList("salesMapper.selectTicketSalesByTicketType", params);
	}
	
	/**
	 * 결제수단별 매출비율 조회
	 */
	public List<Map<String, Object>> selectTicketSalesPercentByPaymentMethod(HashMap<String, Object> params){
		return sqlSessionTemplate.selectList("salesMapper.selectTicketSalesPercentByPaymentMethod", params);
	}
}
