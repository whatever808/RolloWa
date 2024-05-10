package com.br.project.dto.notification;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class NotificationDto {
	private int notiNo;
	private String notiContent;
	private String enrollDate;
	private String modifyDate;
	private String status;
	private int enrollUserNo;
	private int modifyUserNo;
}
