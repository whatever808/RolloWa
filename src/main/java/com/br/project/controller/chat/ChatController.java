package com.br.project.controller.chat;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.br.project.dto.chat.ChatMessageDto;
import com.br.project.service.chat.ChatService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ChatController {

	private final SimpMessagingTemplate template; //특정 Broker로 메세지를 전달
	private final ChatService chatService;
	
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
		
	// 채팅방 입장
	@MessageMapping(value = "/chat/enter/{roomNo}")
    public void enter(String json){
		try {
			Map<String, String> map = jsonToMap(json);
			map.put("msgContent", map.get("name") + "님이 채팅방에 입장하셨습니다.");
			int result = insertChatMsg(map);
			
			if (result > 0) {
				template.convertAndSend("/topic/chat/room/" + map.get("roomNo"), map.get("msgContent"));
			} else {
				log.debug("채팅 메세지 저장 중 오류 발생");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}         
    }
	
	// 채팅방 메세지 전송 및 기록
    @MessageMapping(value = "/chat/message/{roomNo}")
    public void message(String json){
		try {
			Map<String, String> map = jsonToMap(json);
			int result = insertChatMsg(map);
			
			if (result > 0) {
				template.convertAndSend("/topic/chat/room/" + map.get("roomNo"), json);
			} else {
				log.debug("채팅 메세지 저장 중 오류 발생");
			}
			
		} catch (Exception e) { 
			e.printStackTrace();
		}   
    }
    
    // 채팅 메세지 데이터베이스에 저장
    public int insertChatMsg(Map<String, String> map) {
    	ChatMessageDto chatMsg = ChatMessageDto.builder()
				.msgContent(map.get("msgContent"))
				.chatRoomNo(Integer.parseInt(map.get("roomNo")))
				.userNo(Integer.parseInt(map.get("userNo")))
				.build();

    	return chatService.insertChatMsg(chatMsg);
    }
}

