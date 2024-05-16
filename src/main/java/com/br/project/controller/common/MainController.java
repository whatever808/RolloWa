package com.br.project.controller.common;

import java.util.HashMap;

import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.br.project.dto.member.MemberDto;

import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class MainController {
	// 메인페이지
	@RequestMapping("/")
	public String mainPage(@SessionAttribute(value="loginMember", required=false) MemberDto loginMember,
					HttpServletRequest request) {
		
		if(loginMember != null) {		
			return "mainpage/mainpage";
		}
		
		return "main";
	}
}

