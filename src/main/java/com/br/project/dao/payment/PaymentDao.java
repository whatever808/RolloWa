package com.br.project.dao.payment;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PaymentDao {
	
	private final SqlSessionTemplate sqlSessionTemplate;
	
	public Map<String, Object> userInformation(int userNo){
		return sqlSessionTemplate.selectOne("paymentMapper.userInformation", userNo);
	}

	public int ajaxTossSimplePay(HashMap<String, Object> params) {
		return sqlSessionTemplate.insert("paymentMapper.ajaxTossSimplePay", params);
	}
	public int ajaxTossSimplePayDetail(HashMap<String, Object> params) {
		return sqlSessionTemplate.insert("paymentMapper.ajaxTossSimplePayDetail", params);
	}

	public Map<String, Object> selectValiation() {
		return sqlSessionTemplate.selectOne("paymentMapper.selectValiation");
	}
	
	
	//이문희 일반 Ticket_order
	public int insertAjaxkakaoPayCommon(Map<String, Object> map) {
		return sqlSessionTemplate.insert("paymentMapper.insertAjaxkakaoPayCommon", map);
	}
	
	//이문희 일반 Ticket_dorder_dtail
	public int insertKakaoPayDetailCommon(Map<String, Object> map) {
		return sqlSessionTemplate.insert("paymentMapper.insertKakaoPayDetailCommon", map);
	}
	
	//이문희 정기 Ticket_order
	public int insertAjaxkakaoPayRoutine(Map<String, Object> map) {
		return sqlSessionTemplate.insert("paymentMapper.insertAjaxkakaoPayRoutine", map);
	}
	
	//이문희 정기 Ticket_dorder_dtail
	public int insertKakaoPayDetailrRoutine(Map<String, Object> map) {
		return sqlSessionTemplate.insert("paymentMapper.insertKakaoPayDetailrRoutine", map);
	}
	
	
		

}
