package com.br.project.service.payment;

import java.util.HashMap;
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

	/**
	 * 토스페이 관련 서비스
	 * @author dpcks
	 */
	public int ajaxTossSimplePay(HashMap<String,Object> params) {
		int result = paymentDao.ajaxTossSimplePay(params);
		int outcome = paymentDao.ajaxTossSimplePayDetail(params);
		return result * outcome;
	}

	public Map<String, Object> selectValiation() {
		return paymentDao.selectValiation();
	}
	
	
	
	//이문희 일반 Ticket_order
	public int insertAjaxkakaoPayCommon(Map<String, Object> map) {
		int result1 = paymentDao.insertAjaxkakaoPayCommon(map);
		int result2 = paymentDao.insertKakaoPayDetailCommon(map);
		return result1 + result2;
	}
	
	//이문희 정기 Ticket_order
	public int insertAjaxkakaoPayRoutine(Map<String, Object> map) {
		int result1 = paymentDao.insertAjaxkakaoPayRoutine(map);
		int result2 = paymentDao.insertKakaoPayDetailrRoutine(map);
		return result1 + result2;
	}
	

	
	
}
