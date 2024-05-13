package com.br.project.controller.fcm;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.SessionAttribute;

import com.br.project.dto.member.MemberDto;
import com.br.project.service.notification.NotificationService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class FCMController {
	private final NotificationService notificationService;
	
	@PostMapping("/register")
	public ResponseEntity register(@RequestBody String token
					, @SessionAttribute(value="loginMember", required=false) MemberDto loginMember) {
		notificationService.register(loginMember.getUserId(), token);
		return ResponseEntity.ok().build();
	}
}
