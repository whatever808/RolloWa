package com.br.project.dto.pay;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class SignDto {
	
	private int approvalNo;
	private String firstSign;
	private String middleSign;
	private String finalSign;
	private String firstApDt;
	private String middleApDt;
	private String finalApDt;
	private String approvalSignNo;
	
}
