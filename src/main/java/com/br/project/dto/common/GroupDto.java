package com.br.project.dto.common;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class GroupDto {
	private String groupCode;
	private String code;
	private String codeName;
	private String status;
	private String upperCode;
	private String dept;
	private String team;
	private String coworker;
	private int memberCount;
}
