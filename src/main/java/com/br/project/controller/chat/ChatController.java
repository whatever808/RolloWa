package com.br.project.controller.chat;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.stereotype.Controller;

@Controller
public class ChatController {

	@MessageMapping("/test")
	@SendTo("/subscribe/hello")
	public String greeting() {
		
		return "안녕하세요";
	}
	
}
