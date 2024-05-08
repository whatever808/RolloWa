package com.br.project.controller.member;

import java.util.HashMap;
import java.util.Map;

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
	// 휴대폰 인증번호 발송
    @PostMapping("/send-one")
    public SingleMessageSentResponse sendOne() {
        Message message = new Message();
        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
        message.setFrom("발신번호 입력");
        message.setTo("수신번호 입력");
        message.setText("한글 45자, 영자 90자 이하 입력되면 자동으로 SMS타입의 메시지가 추가됩니다.");

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
}
