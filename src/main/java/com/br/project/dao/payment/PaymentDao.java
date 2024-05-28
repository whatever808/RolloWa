package com.br.project.dao.payment;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class PaymentDao {
	
	private final SqlSessionTemplate sqlSessionTemplate;
	
	public List<Map<String, Object>> userInformation(int userNo){
		return sqlSessionTemplate.selectList("paymentMapper.userInformation", userNo);
	}

}
