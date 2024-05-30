package com.br.project.controller.payment;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.br.project.dto.member.MemberDto;
import com.br.project.service.payment.PaymentService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@RequestMapping("/payment")
@RequiredArgsConstructor
@Controller
public class PaymentController {
	
	private final PaymentService paymentService;
	
	@RequestMapping("/payment.page")
	public void payment(HttpSession session, Model model) {
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		
		Map<String, Object> member = paymentService.userInformation(userNo);
			
		model.addAttribute("member", member);
		
	}
	
	/**
	 * 토스페이 간편 결제 매서드
	 * @author dpcks
	 * @param request
	 */
	@ResponseBody
	@PostMapping("/tossSimplePay.ajax")
	public int ajaxTossSimplePay(@RequestBody HashMap<String,Object> param) {
		
		// 결제 상태 1:결제대기, 2:결제취소, 3:결제성공
		if(param.get("status").equals("paid")) {
			param.replace("status", 2);
		}else if(param.get("status").equals("failed")) {
			param.replace("status", 3);
		}else if(param.get("status").equals("ready")) {
			param.replace("status", 1);
		}
		
		// 결제수단이 계좌이체일 경우 CS
		if(param.get("pay_method").equals("trans")) {
			param.replace("pay_method", "CS");
		}else if(param.get("pay_method").equals("card ")){
			param.replace("pay_method", "CD");
		}
		
		if(!param.get("paid_amount").equals("")) {
			param.put("onePrice", Integer.parseInt((String)param.get("paid_amount"))
								/Integer.parseInt((String)param.get("paid_amount")));
		}
		
		return paymentService.ajaxTossSimplePay(param);		
	}
	

}
