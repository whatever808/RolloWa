package com.br.project.handler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.br.project.dto.member.MemberDto;
import com.br.project.service.member.MemberService;

public class LoginLogoutEcoHandler extends TextWebSocketHandler{
	
	@Autowired
	MemberService memberService;
	List<WebSocketSession> webSocketSessionList = new ArrayList<>();
	
	/**
	 * 로그인 했을 경우
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		webSocketSessionList.add(session);
		
		MemberDto loginMember = (MemberDto)(session.getAttributes().get("loginMember"));
		Map<String, Object> memberData = memberService.selectMemberForMainPage(loginMember);
		
		String msg = "login|"
				   + memberData.get("userNo").toString() + "|"
				   + memberData.get("profileURL").toString() + "|"
				   + memberData.get("userName").toString() + " / "
				   + memberData.get("positionName").toString() + " / "
				   + memberData.get("teamName").toString();
		
		for(WebSocketSession client : webSocketSessionList) {
			client.sendMessage(new TextMessage(msg));
		}
		
	}
	
	/**
	 * 로그아웃 했을 경우
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		webSocketSessionList.remove(session);
		
		String msg = "logout | " + ((MemberDto)(session.getAttributes().get("loginMember"))).getUserNo();
		
	}
	

}
