package com.br.project.controller.payment;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

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
	

}
