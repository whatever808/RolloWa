package com.br.project.handler;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.br.project.dto.member.MemberDto;
import com.br.project.service.notification.NotificationService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class AlramEchoHandler extends TextWebSocketHandler {
	
	private List<WebSocketSession> sessionList = new ArrayList();
	@Autowired
	private NotificationService notificationService;
	
	//json을 Map으로 변환
	public Map<String, String> jsonToMap(String json) throws Exception
	{
	    ObjectMapper objectMapper = new ObjectMapper();
	    TypeReference<Map<String, String>> typeReference = new TypeReference<Map<String,String>>() {};
	    
	    return objectMapper.readValue(json, typeReference);
	}
	
	//Map을 json으로 변환
	public String mapToJson(Map<String, String> map) {
		ObjectMapper objectMapper = new ObjectMapper();
		String json = null;
		try {
			json = objectMapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return json;
	}
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 로그인한 회원 => 모두 소켓에 연결
		// 공지사항 등록 시 알림 발생 => 부서 회원에게만 공지사항 전송

		//log.debug("session : {}", session.getAttributes().get("loginMember"));
		sessionList.add(session);
		//log.debug("sessionList : {}", sessionList);

	}
	
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		//log.debug("websocket으로 전달된 메세지 내용 : {}", message.getPayload());
		//log.debug("message 객체 : {}", message);		

		Map<String, String> map = jsonToMap(message.getPayload().toString());		
		// 알림 보낸 회원 조회
		MemberDto currentMember = (MemberDto)session.getAttributes().get("loginMember");
		
		// 공지사항 팀번호
		String teamCode = map.get("teamCode");
		// 공지사항 글번호
		int boardNo = notificationService.selectLatestBno(teamCode);
		
		// message에 팀코드를 포함해서 전송되면 해당 팀코드를 갖는 사원에게만 알림 전송
		for(WebSocketSession webSession : sessionList) {
			// 로그인한 모든 회원
			MemberDto member = (MemberDto)webSession.getAttributes().get("loginMember");
			
			// 알림 보낸 회원을 제외한 회원에게 알림 보냄
			if(!member.getUserId().equals(currentMember.getUserId())) {
				if(member.getTeamCode().equals(teamCode)) {
					Map<String, String> textMap = new HashMap<>();
					textMap.put("teamCode", teamCode);
					textMap.put("boardNo", String.valueOf(boardNo));
					textMap.put("message", "부서 공지사항이 등록 되었습니다.");
					
					webSession.sendMessage(new TextMessage(mapToJson(textMap)));
					//log.debug("mapToJson : {}", mapToJson(textMap));
				}
			}
		}
	}
	
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
		sessionList.remove(session);
	}
	
}
