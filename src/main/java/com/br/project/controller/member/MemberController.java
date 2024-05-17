package com.br.project.controller.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.RandomStringUtils;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
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
import com.br.project.dto.common.GroupDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.service.common.department.DepartmentService;
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
	private final DepartmentService departmentService;
	private final FileUtil fileUtil;
	private final BCryptPasswordEncoder bcryptPasswordEncoder;
	DefaultMessageService messageService = NurigoApp.INSTANCE.initialize("NCSVIKI2KIZ8BWZP", "FRCLTDLTRNZ8AYQ3ABSZCF4JOBNBFIGK", "https://api.coolsms.co.kr");
		
	// 로그인
	@PostMapping("/login.do")
	public String MemberLogin(MemberDto member, HttpServletRequest request,
				RedirectAttributes redirectAttributes) {
		MemberDto loginMember = memberService.memberLogin(member);
		HttpSession session = request.getSession();
		redirectAttributes.addFlashAttribute("alertTitle", "로그인 서비스");
		
		if(bcryptPasswordEncoder.matches(member.getUserPwd(), loginMember.getUserPwd())) {
			// 로그인 성공
			session.setAttribute("loginMember", loginMember);
		} else {
			// 로그인 실패
			log.debug("로그인 실패 실행됨");
			redirectAttributes.addFlashAttribute("alertMsg", "로그인 실패");
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
    public String ajaxSendOne(String phone) {
        Message message = new Message();
        // 발신번호 및 수신번호는 반드시 01012345678 형태로 입력되어야 합니다.
        message.setFrom("01047547864");
        message.setTo(phone);
        String rand = RandomStringUtils.randomNumeric(6);
        log.debug(rand);
        
        message.setText("[CoolSMS] 인증번호를 확인하고 입력해주세요 : " + rand);

        //SingleMessageSentResponse response = this.messageService.sendOne(new SingleMessageSendingRequest(message));
        //log.debug("{}", response);
        
        return rand;
    }
    
    // 임시 비밀번호 생성
    @PostMapping("forgetPwd.do")
    @ResponseBody
    public Map<String, String> ajaxUpdateUserPwd(String userId) {	
    	char[] charSet = new char[] {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
    				'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z',
    				'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 
    				'!', '@', '#', '$', '%', '^', '&' };
    
    	String newPwd =  "pass1234"; //RandomStringUtils.random(10, charSet);
    	log.debug("{}", newPwd);
    	MemberDto member = MemberDto.builder()
    								.userId(userId)
    								.userPwd(bcryptPasswordEncoder.encode(newPwd))
    								.build();
    	
    	int result = memberService.updateUserPwd(member);
    	Map<String, String> map = new HashMap<>();
    	
    	if (result > 0) {
    		map.put("msg", "SUCCESS");
    		map.put("newPwd", newPwd);
    	} else {
    		map.put("msg", "FAIL");
    	}
    	
    	return map;
    }
    
	// 마이페이지 조회
	@GetMapping("/mypage.page")
	public String ToMyPage(Model model, HttpSession session) {
		MemberDto loginMember = (MemberDto)session.getAttribute("loginMember");
		loginMember = memberService.selectMember(loginMember);
		
		model.addAttribute("memberInfo", loginMember);
		
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
		MemberDto loginMember = null;
		if ((MemberDto)session.getAttribute("loginMember") != null) {
			loginMember = (MemberDto)session.getAttribute("loginMember");	
		} else {
			redirectAttributes.addFlashAttribute("alertMsg", "로그인 오류");
			return "redirect:/";
		}
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
		
		redirectAttributes.addFlashAttribute("alertTitle", "회원정보 수정");
		if (result > 0) {
			session.setAttribute("loginMember", loginMember);
			redirectAttributes.addFlashAttribute("alertMsg", "회원정보 수정 성공");
		} else {
			redirectAttributes.addFlashAttribute("alertMsg", "회원정보 수정 실패");
		}
		
		return "redirect:/member/mypage.page";
	}
	// 비밀번호 수정
	@PostMapping("modifyPwd.do")
	public String updateUserPwd(@RequestParam Map<String, String> map
				, HttpSession session
				, RedirectAttributes redirectAttributes) {
		MemberDto loginMember = (MemberDto)session.getAttribute("loginMember");
		int result = 0;
		
		redirectAttributes.addFlashAttribute("alertTitle", "비밀번호 변경 서비스");
		if (bcryptPasswordEncoder.matches(map.get("userPwd"), loginMember.getUserPwd())) {
			loginMember.setUserPwd(bcryptPasswordEncoder.encode(map.get("updatePwd")));
			result = memberService.updateUserPwd(loginMember);
			
			if (result > 0) {
				session.invalidate();
				redirectAttributes.addFlashAttribute("alertMsg", "비밀번호 변경 성공. 다시 로그인 해주세요.");
				return "redirect:/";
			}	
		}
		redirectAttributes.addFlashAttribute("alertMsg", "비밀번호 변경 실패. 현재 비밀번호를 다시 확인해주세요.");
		return "redirect:/member/mypage.page";
	}
	
	// 채팅 - 전체 부서 조회
	@GetMapping("/select.do")
	@ResponseBody
	public Map<String, List> selectDept() {
		Map<String, List> groupMap = new HashMap<>();
		Map<String, String> codeMap = new HashMap<>();
		
		// 부서 조회
		codeMap.put("code", "DEPT01");
		groupMap.put("deptList", departmentService.selectDepartmentList(codeMap));
		
		// 팀 조회
		codeMap.put("code", "TEAM01");
		groupMap.put("teamList", departmentService.selectDepartmentList(codeMap));
		
		// 사원 조회
		groupMap.put("memberList", memberService.selectAllMember());
		
		return groupMap;
	}
	
	// 채팅 - 부서의 팀 조회
	@GetMapping("/selectTeam.do")
	@ResponseBody
	public List<GroupDto> selectTeam(String upperCode) {
		Map<String, String> codeMap = new HashMap<>();
		codeMap.put("code", "TEAM01");
		codeMap.put("upperCode", upperCode);
		return departmentService.selectDepartmentList(codeMap);
	}
	
	// 채팅 - 전체 사원 조회
	@GetMapping("/selectMember.do")
	@ResponseBody
	public List<MemberDto> selectMember(String teamCode) {
		return memberService.selectAllMember();
	}
	
	// 채팅 - 전체 부서&팀&사원 조회
	@GetMapping("/selectMember.do")

	/* ======================================= "가림" 구역 ======================================= */
	@RequestMapping("/memInfo.do")
	@ResponseBody
	public MemberDto selectMemInfo(HttpSession session){
		return memberService.selectMember((MemberDto)(session.getAttribute("loginMember")));
	}
	/* ======================================= "가림" 구역 ======================================= */
	



}
