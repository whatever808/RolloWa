package com.br.project.dto.pay;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@AllArgsConstructor
@NoArgsConstructor
@ToString
@Getter
@Setter
@Builder
public class BusinessDto {
	
	private int businessNo;
	private String title;
	private String reDepartment;
	private String content;
	private String businessDt;
	private String etcContent;
	private String status;

}
