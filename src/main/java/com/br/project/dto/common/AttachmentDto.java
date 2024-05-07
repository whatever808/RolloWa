package com.br.project.dto.common;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
@Builder
public class AttachmentDto {

	private String fileNo;
	private String originName;
	private Date enrollDate;
	private String modifyName;
	private String attachPath;
	private String status;
	private String refType;
	private String refNo;
	
}
