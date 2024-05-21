package com.br.project.controller.chat;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.br.project.dto.chat.ChatMessageDto;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ChatController {

	private final SimpMessagingTemplate template; //특정 Broker로 메세지를 전달
	
	//json을 Map으로 변환
	public Map<String, String> jsonToMap(String json) throws Exception
	{
	    ObjectMapper objectMapper = new ObjectMapper();
	    TypeReference<Map<String, String>> typeReference = new TypeReference<Map<String,String>>() {};
	    
	    return objectMapper.readValue(json, typeReference);
	}
	
	@MessageMapping("/user")
	public void test(String msg) {
		log.debug("user 실행됨, msg : {}", msg);
		template.convertAndSend("/topic/a", "test String");
	}
	
	@MessageMapping(value = "/chat/enter/{roomNo}")
    public void enter(String json){
		log.debug("json : {}", json);
		try {
			Map<String, String> map = jsonToMap(json);
			template.convertAndSend("/topic/chat/room/" + map.get("roomNo"), map.get("name") + "님이 채팅방에 입장하셨습니다.");
		} catch (Exception e) {
			e.printStackTrace();
		}         
    }
	
	/*
    @MessageMapping(value = "/chat/message")
    public void message(ChatMessageDto message){
        template.convertAndSend("/topic/chat/room/" + message.getRoomId(), message);
    }*/
}
