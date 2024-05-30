package com.br.project.controller.payment;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;



@Slf4j
@RequestMapping("/payment")
//@RequiredArgsConstructor
@Controller
public class PaymentController {
	
	
	@RequestMapping("/payment.page")
	public void payment() {
	}
	
	@PostMapping("/tossSimplePay.ajax")
	public void ajaxTossSimplePay(HttpServletRequest request) {
		
	}
	

}
