package com.br.project.controller.payment;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
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
	
	
	//이문희 카카오페이
	@ResponseBody
	@PostMapping("/ajaxkakaoPayment.do")
	public String ajaxkakaoPay(@RequestParam Map<String, Object> map){
		log.debug("ajaxkakaoPayment : {}", map);
		
		String newOrderPayment = (String) map.get("orderPayment"); 
		
	    Map<String, Object> maps1 = new HashMap<>();
	    int	result1 = 0;
	    // 일반 이용권
	    if (map.get("ticketType1") != null || !((String)map.get("ticketType1")).equals("")) {
		    
	        if (newOrderPayment != null && newOrderPayment.length() > 0) {
	            String newOrderPayment1 = newOrderPayment.substring(0, newOrderPayment.length() - 1);
	            maps1.put("orderPayment", newOrderPayment1.replace(",", ""));
	        }
	        maps1.put("ticketType", "N"); 
	        maps1.put("ticketPrice", map.get("ticketPrice1"));
	        maps1.put("tickSerialNo", "SERIAL" + ((int) (Math.random() * 100000)) + new Date().getTime() + "1");
	        maps1.put("ticketCtn", map.get("ticketCtn1"));
	        maps1.put("customerId", map.get("customerId"));	        
	        maps1.put("startDate", map.get("startDate1"));
	        maps1.put("endDate", map.get("endDate1"));
	        maps1.put("discount", map.get("discount"));

	        result1 = paymentService.insertAjaxkakaoPayCommon(maps1);
	    }
	    
	    
	    Map<String, Object> maps2 = new HashMap<>();
	    int	result2 = 0;
	    // 정기 이용권
	    if (map.get("ticketType2") != null || !((String)map.get("ticketType2")).equals("")) {
	    	
	    	
	        if (newOrderPayment != null && newOrderPayment.length() > 0) {
	            String newOrderPayment1 = newOrderPayment.substring(0, newOrderPayment.length() - 1);
	            maps2.put("orderPayment", newOrderPayment1.replace(",", ""));
	        }
	        maps2.put("ticketType", "S");
	        maps2.put("ticketPrice", map.get("ticketPrice2"));
	        maps2.put("tickSerialNo", "SERIAL" + ((int) (Math.random() * 100000)) + new Date().getTime() + "2");
	        maps2.put("ticketCtn", map.get("ticketCtn2"));
	        maps2.put("customerId", map.get("customerId"));	
	        maps2.put("startDate", map.get("startDate2"));
	        maps2.put("endDate", map.get("endDate2"));
	        maps2.put("discount", map.get("discount"));
	        
	       result2 = paymentService.insertAjaxkakaoPayRoutine(maps2);
	    }
	    
	    log.debug("maps1 : {}", maps1);
		log.debug("maps2 : {}", maps2);
		
		
		
		
		return "SUCCUSS";
	}
	

}
