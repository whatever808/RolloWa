package com.br.project.dto.notification;

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
public class NotificationSendDto {	
	private int nsendNo;
	private String notiURL;
	private String notiCheckDate;
	private String notiSendDate;
	private String status;
	private String receiveUserNo;
	private String sendUserNo;
}
