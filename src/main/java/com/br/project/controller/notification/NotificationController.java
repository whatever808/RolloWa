package com.br.project.controller.notification;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.dto.notification.NotificationDto;
import com.br.project.service.notification.NotificationService;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequestMapping("notification")
@Controller
@RequiredArgsConstructor
@Slf4j
public class NotificationController {
	private final NotificationService nService;
	private final PagingUtil pagingUtil;
	
	// 알림 조회
	@GetMapping("list.page")
	public String selectNotification(@RequestParam(value="page", defaultValue="1") int currentPage
				, Model model) {
		int notiListCount = nService.selectNotiListCount();
		PageInfoDto pageInfo = pagingUtil.getPageInfoDto(notiListCount, currentPage, 5, 8);
		List<NotificationDto> notiList = nService.selectNoti(pageInfo);
		log.debug("pageInfo : {}", pageInfo);
		log.debug("notiList : {}", notiList);
		model.addAttribute("pageInfo", pageInfo);
		model.addAttribute("notiList", notiList);
		
		return "common/notification";
	}
	
	// 알림 생성
	@PostMapping("/insert.do")
	public String insertNotification(String content, HttpSession session
					, RedirectAttributes redirectAttributes) {
		MemberDto loginMember = (MemberDto)session.getAttribute("loginMember");
		NotificationDto notification = NotificationDto.builder()
											.enrollUserNo(loginMember.getUserNo())
											.notiContent(content)
											.build();
		int result = nService.insertNoti(notification);
		
		redirectAttributes.addFlashAttribute("alertTitle", "알림 등록 서비스");
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "알림을 성공적으로 등록했습니다.");
		} else {
			redirectAttributes.addFlashAttribute("alertMsg", "알림 내용이 길어 알림 등록에 실패했습니다.");
		}
		
		return "redirect:/notification/list.page";
	}
	
	// 알림 삭제
	@PostMapping("delete.do")
	public String deleteNotification(String notiNo
				, RedirectAttributes redirectAttributes) {
		int result = nService.deleteNoti(notiNo);
		
		redirectAttributes.addFlashAttribute("alertTitle", "알림 삭제 서비스");
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "알림을 성공적으로 삭제했습니다.");
		} else {
			redirectAttributes.addFlashAttribute("alertMsg", "알림 삭제에 실패했습니다.");
		}
		
		return "redirect:/notification/list.page";
	}
}
