package com.br.project.controller.common;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.dto.member.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MainController {
	// 메인페이지
	@RequestMapping("/")
	public String mainPage(@SessionAttribute(value="loginMember", required=false) MemberDto loginMember 
					, Model model
					, String alertMsg
					, String alertTitle) {

		log.debug("alertMsg : {}", alertMsg);
		
		if(alertMsg != null) {
			log.debug("로그인 메세지 실행됨");
			model.addAttribute("alertTitle", alertTitle);
			model.addAttribute("alertMsg",alertMsg);
		}
		
		if(loginMember != null) {
			return "mainpage/mainpage";
		}
		
		return "main/{alertTitle}&{alertMsg}";
	}
}

