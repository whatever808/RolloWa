package com.br.project.handler;

import java.util.ArrayList;
import java.util.List;

import org.springframework.web.socket.BinaryMessage;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.PongMessage;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

public class ChatEchoHandler extends TextWebSocketHandler{

	private List<WebSocketSession> sessionList = new ArrayList();
	
	// 채팅용 웹소켓 연결 시
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {
		// 소켓 리스트에 추가
		sessionList.add(session);
		
		// 채팅방 리스트 조회
	}
	
	// 채팅 메시지 도착 시
	@Override
	public void handleMessage(WebSocketSession session, WebSocketMessage<?> message) throws Exception {
		if (message instanceof TextMessage) {
			handleTextMessage(session, (TextMessage) message);
		}
		else if (message instanceof BinaryMessage) {
			handleBinaryMessage(session, (BinaryMessage) message);
		}
		else if (message instanceof PongMessage) {
			handlePongMessage(session, (PongMessage) message);
		}
		else {
			throw new IllegalStateException("Unexpected WebSocket message type: " + message);
		}
	}
	
	// 연결 종료
	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
	}
	
}
