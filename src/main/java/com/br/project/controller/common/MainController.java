package com.br.project.controller.common;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.dto.member.MemberDto;

@Controller
public class MainController {
	// 메인페이지
	@RequestMapping("/")
	public String mainPage(@SessionAttribute(value="loginMember", required=false) MemberDto loginMember, 
					RedirectAttributes redirectAttribute, Model model) {
		
		if(redirectAttribute.getAttribute("alertMsg") != null) {
			model.addAttribute("alertMsg", redirectAttribute.getAttribute("alertMsg"));
		}
		
		if(loginMember != null) {
			return "mainpage/mainpage";
		}
		
		return "main";
	}
}

