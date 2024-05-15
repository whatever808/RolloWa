package com.br.project.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.PongMessage;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.br.project.dto.member.MemberDto;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AlramEchoHandler extends TextWebSocketHandler {
	
	private List<WebSocketSession> sessionList = new ArrayList();
	
	//json을 Map으로 변환
	public Map<String, String> jsonToMap(String json) throws Exception
	{
	    ObjectMapper objectMapper = new ObjectMapper();
	    TypeReference<Map<String, String>> typeReference = new TypeReference<Map<String,String>>() {};
	    
	    return objectMapper.readValue(json, typeReference);
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 로그인한 회원 => 모두 소켓에 연결
		// 공지사항 등록 시 알림 발생 => 부서 회원에게만 공지사항 전송
		log.debug("session : {}", session.getAttributes().get("loginMember"));
		
		for(WebSocketSession client : sessionList) {
			if(client != session) {
				// 로그인한 회원을 소켓에 저장
				sessionList.add(session);
			}
		}
		
		
	}
	
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		log.debug("websocket으로 전달된 메세지 내용 : {}", message.getPayload());
		log.debug("message 객체 : {}", message);		

		Map<String, String> map = jsonToMap(message.getPayload().toString());
		log.debug("map : {}, page : {}, teamcode : {}", map, map.get("page"), map.get("teamCode"));
		
		// 알림 보낸 회원 조회
		MemberDto currentMember = (MemberDto)session.getAttributes().get("loginMember");
		// message에 팀코드를 포함해서 전송되면 해당 팀코드를 갖는 사원에게만 알림 전송
		for(WebSocketSession webSession : sessionList) {
			MemberDto member = (MemberDto)webSession.getAttributes().get("loginMember");
			
			// 알림 보낸 회원을 제외한 회원에게 알림 보냄
			if(!member.getUserId().equals(currentMember.getUserId())) {
				
			}
			
			log.debug("팀원 아이디 : {}, 팀코드 : {}", member.getUserId(), member.getTeamCode());
			if(member.getTeamCode().equals(message.getPayload())) {
				webSession.sendMessage(new TextMessage("공지사항이 등록되었습니다."));		
			}
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
	}
	
}
