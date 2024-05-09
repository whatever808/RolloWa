package com.br.project.controller.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.dto.common.AttachmentDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.service.member.MemberService;
import com.br.project.util.FileUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.nurigo.sdk.NurigoApp;
import net.nurigo.sdk.message.model.Message;
import net.nurigo.sdk.message.request.SingleMessageSendingRequest;
import net.nurigo.sdk.message.response.SingleMessageSentResponse;
import net.nurigo.sdk.message.service.DefaultMessageService;

@Controller
@RequiredArgsConstructor
@Slf4j
@RequestMapping("/member")
public class MemberController {
	private final MemberService memberService;
	private final FileUtil fileUtil;
	DefaultMessageService messageService = NurigoApp.INSTANCE.initialize("NCSVIKI2KIZ8BWZP", "FRCLTDLTRNZ8AYQ3ABSZCF4JOBNBFIGK", "https://api.coolsms.co.kr");
		
	// 로그인
	@PostMapping("/login.do")
	public String MemberLogin(MemberDto member, HttpServletRequest request, Model model) {
		MemberDto loginMember = memberService.selectMember(member);
		HttpSession session = request.getSession();
		
		model.addAttribute("alertTitle", "로그인 서비스");
		if(loginMember != null) {
			// 로그인 성공
			session.setAttribute("loginMember", loginMember);
		} else {
			// 로그인 실패
			log.debug("로그인 실패 실행됨");
			model.addAttribute("alertMsg", "로그인 실패");
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
	// 휴대폰 인증번호 발송
    @PostMapping(value="/sendMsg.do", produces="aplication/json; charset=utf-8")
    @ResponseBody
    public SingleMessageSentResponse ajaxSendOne(String phone) {
        Message message = new Message();
        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
        message.setFrom("송신 전화번호");
        message.setTo(phone);
        String rand = RandomStringUtils.randomNumeric(6);
        log.debug(rand);
        
        message.setText("[CoolSMS] 인증번호를 확인하고 입력해주세요 : " + rand);

        SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
        System.out.println(response);

        return response;
    }
    
	// 마이페이지 조회
	@GetMapping("/mypage.page")
	public String ToMyPage() {
		return "member/mypage";
	}

	// 마이페이지 프로필 이미지 수정
	@PostMapping("/modifyProfile.do")
	@ResponseBody
	public String ajaxUpdateProfile(MultipartFile uploadFile, HttpSession session) {
		log.debug("{}", uploadFile);
		MemberDto member = new MemberDto();
		// 로그인한 회원 정보 확인
		if(session.getAttribute("loginMember") != null) {
			member = (MemberDto)session.getAttribute("loginMember");
		} else {
			return "FAIL";
		}

		Map<String, String> file = new HashMap<>(); 
	
		if(uploadFile != null && !uploadFile.isEmpty()) {
			file = fileUtil.fileUpload(uploadFile, "member");
		}
		AttachmentDto att = AttachmentDto.builder()
								.originName(file.get("originalName"))
								.attachPath(file.get("filePath"))
								.modifyName(file.get("filesystemName"))
								.refType("M")
								.refNo(String.valueOf(member.getUserNo()))
								.build();
		member.setProfileURL(att.getAttachPath() + "/" + att.getModifyName());
		
		int result = memberService.updateProfile(member, att);
		
		if (result > 0) {
			return "SUCCESS";
		} else {
			return "FAIL";
		}
	}
	
	// 마이페이지 수정
	@PostMapping("/updateInfo.do")
	public String updateInfo(@RequestParam Map<String, String> memberInfo, HttpSession session
				, RedirectAttributes redirectAttributes) {
		log.debug("{}", memberInfo);
		
		// 로그인한 멤버 번호 추출
		MemberDto loginMember = (MemberDto)session.getAttribute("loginMember");
		memberInfo.put("userNo", String.valueOf(loginMember.getUserNo()));
		
		// 주소 합치기
		StringBuilder totalAddress = new StringBuilder();
		totalAddress.append("(").append(memberInfo.get("postNumber"))
					.append(") ")
					.append(memberInfo.get("address")).append(" ")
					.append(memberInfo.get("detailAddress"));
		memberInfo.put("totalAddress", totalAddress.toString());
		
		// db update
		int result = memberService.updateMember(memberInfo);
		// 회원정보 다시 조회
		loginMember = memberService.selectMember(loginMember);
		
		redirectAttributes.addAttribute("alertTitle", "회원정보 수정");
		if (result > 0) {
			session.setAttribute("loginMember", loginMember);
			redirectAttributes.addAttribute("alertMsg", "회원정보 수정 성공");
		} else {
			redirectAttributes.addAttribute("alertMsg", "회원정보 수정 실패");
		}
		
		return "redirect:/member/mypage.page/{alertTitle}/{alertMsg}";
	}
}
