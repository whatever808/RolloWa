package com.br.project.controller.member;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.dto.member.MemberDto;
import com.br.project.service.member.MemberService;

import ch.qos.logback.core.util.FileUtil;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/member")
public class MemberController {
	private final MemberService memberService;
	private final FileUtil fileUtil;
	
	// 로그인
	@PostMapping("/login.do")
	public String MemberLogin(MemberDto member, HttpServletRequest request, RedirectAttributes redirectAttribute) {
		log.debug("id : {}, pwd : {}", member.getUserId(), member.getUserPwd());
		MemberDto loginMember = memberService.selectMember(member);
		HttpSession session = request.getSession();
		
		
		if(loginMember != null) {
			// 로그인 성공
			redirectAttribute.addFlashAttribute("alertMsg", "로그인 성공");
			session.setAttribute("loginMember", loginMember);
		} else {
			// 로그인 실패
			redirectAttribute.addFlashAttribute("alertMsg", "로그인 실패");
		}
		
		return "redirect:/";
	}
	
	@GetMapping("/logout.do")
	public String MemberLogOut(HttpServletRequest request) {
		HttpSession session = request.getSession(false);
		
		if(session != null) {
			session.invalidate();
		}
		
		return "redirect:/";
	}
		
	// 아이디 찾기
	@PostMapping(value="/forgetId.do", produces="application/text; charset=utf8")
	@ResponseBody
	public String ajaxSelectUserId(String userNo) {
		String userId = memberService.selectUserId(userNo);
		
		if(userId == null) {
			return "해당 사번의 아이디가 존재하지 않습니다.";
		} else {
			return "해당 사번의 아이디는 " + userId + "입니다.";
		}
	}
	
	// 비밀번호 찾기
	
	// 마이페이지 조회
	@GetMapping("/mypage.page")
	public String ToMyPage() {
		return "member/mypage";
	}
	
	// 마이페이지 프로필 이미지 수정
	@PostMapping("/modifyProfile.do")
	@ResponseBody
	public String ajaxUpdateProfile(MultipartFile multipartFile) {
		log.debug("{}", multipartFile);
		
		return "SUCCESS";
	}
}
