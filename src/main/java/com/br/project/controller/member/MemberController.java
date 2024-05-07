package com.br.project.controller.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.br.project.dto.member.MemberDto;
import com.br.project.service.member.MemberService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/member")
public class MemberController {
	private final MemberService memberService;
	
	@PostMapping("/login.do")
	public String MemberLogin(MemberDto member, HttpServletRequest request) {

		System.out.println("userId : " + member.getUserId() + ", userPwd :" + member.getUserPwd());
		
		int result = 0;
		
		HttpSession session = request.getSession();
		
		return "common/sidebar";
	}
	
	@PostMapping("/logout.do")
	public String MemberLogOut(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		if(session != null) {
			session.invalidate();
		}
		
		return "redirect:/";
	}
}
