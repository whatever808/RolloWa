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

}
