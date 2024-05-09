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
					, RedirectAttributes redirectAttribute
					, String alertMsg
					, String alertTitle) {
		
		// alertMsg랑 alertTitle이 url에 노출되는데 이걸 어떻게 해야할지!
		if(alertMsg != null) {
			log.debug("로그인 메세지 실행됨");
			redirectAttribute.addFlashAttribute("alertTitle", alertTitle);
			redirectAttribute.addFlashAttribute("alertMsg",alertMsg);
		}
		
		if(loginMember != null) {
			return "mainpage/mainpage";
		}
		
		return "main";
	}
}

