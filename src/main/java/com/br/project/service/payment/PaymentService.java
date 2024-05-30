package com.br.project.service.payment;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.payment.PaymentDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentService {
	
	private final PaymentDao paymentDao;
	
	public Map<String, Object> userInformation(int userNo){
		return paymentDao.userInformation(userNo);
	}
}
