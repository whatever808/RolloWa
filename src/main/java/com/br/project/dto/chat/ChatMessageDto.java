package com.br.project.dto.chat;

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
public class ChatMessageDto {
	private int msgNo;
	private String msgContent;
	private String sendDate;
	private String status;
	private int userNo;
	private int chatRoomNo;
	
	private String userName;
	private String profileURL;
}
