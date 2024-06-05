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

import lombok.extern.slf4j.Slf4j;
@Slf4j
public class LoginLogoutEcoHandler extends TextWebSocketHandler{
	
	@Autowired
	MemberService memberService;
	List<WebSocketSession> webSocketSessionList = new ArrayList<>();
	
	/**
	 * 로그인 했을 경우
	 */
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 로그인 사용자들의 사원번호 리스트
		List<Integer> loginUserNoList = new ArrayList<>();
		for(WebSocketSession webSocketSession : webSocketSessionList) {
			MemberDto sessionMember = (MemberDto)webSocketSession.getAttributes().get("loginMember");
			loginUserNoList.add(sessionMember.getUserNo());
		}
		
		// 세션 리스트에 추가
		if(loginUserNoList.isEmpty()) {
			webSocketSessionList.add(session);
		}else {
			MemberDto loginMember = (MemberDto)session.getAttributes().get("loginMember");
			int flag = loginUserNoList.indexOf(loginMember.getUserNo());
			if(flag == -1) {
				webSocketSessionList.add(session);
			}
		}
		
		// 로그인 사용자들의 정보를 담은 문자열(메세지)
		String memberList = "login|";
		for(WebSocketSession webSocketSession : webSocketSessionList) {
			MemberDto sessionMember = (MemberDto)webSocketSession.getAttributes().get("loginMember");
			
			Map<String, Object> memberData = memberService.selectMemberForMainPage(sessionMember);
			
			memberList += (memberList.indexOf("&") == -1 ? "" : ",")
						+ memberData.get("userNo").toString() + "&"
					    + memberData.get("profileURL").toString() + "&"
					    + memberData.get("userName").toString() + " / "
					    + memberData.get("positionName").toString() + " / "
					    + memberData.get("teamName").toString();
		}
		
		for(WebSocketSession client : webSocketSessionList) {
			client.sendMessage(new TextMessage(memberList));
		}
		
	}
	
	/**
	 * 로그아웃 했을 경우
	 */
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		webSocketSessionList.remove(session);
		
		String logoutMember = "logout|" + ((MemberDto)(session.getAttributes().get("loginMember"))).getUserNo();
		
		for(WebSocketSession client : webSocketSessionList) {
			client.sendMessage(new TextMessage(logoutMember));
		}
	}
	

}
