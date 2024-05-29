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
	 * 년/월/일 총매출액, 평균매출액, 최고매출액, 최저매출액 조회 (테이블)
	 */
	public List<Map<String, Object>> selectTicketSalesForTable(HashMap<String, Object> params){
		return sqlSessionTemplate.selectList("salesMapper.selectTicketSalesForTable", params);
	}
	
	/**
	 * 월/일 이용권별 총매출액, 평균매출액 조회 (차트)
	 */
	public List<Map<String, Object>> selectTicketSalesForChart(HashMap<String, Object> params){
		return sqlSessionTemplate.selectList("salesMapper.selectTicketSalesForChart", params);
	}
	
	/**
	 * 결제수단별 매출비율 조회
	 */
	public List<Map<String, Object>> selectTicketSalesPercentByPaymentMethod(HashMap<String, Object> params){
		return sqlSessionTemplate.selectList("salesMapper.selectTicketSalesPercentByPaymentMethod", params);
	}
}
