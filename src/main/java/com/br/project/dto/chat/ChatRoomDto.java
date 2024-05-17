package com.br.project.dto.chat;

import java.util.HashSet;
import java.util.Set;
import java.util.UUID;

import org.springframework.web.socket.WebSocketSession;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class ChatRoomDto {
	private int chatRoomNo;
	private String chatRoomName;
	private String enrollDate;
	private String modifyDate;
	private String status;
	private int enrollUserNo;
	private int modifyUserNo;
}
