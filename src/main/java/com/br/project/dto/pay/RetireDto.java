package com.br.project.dto.pay;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@AllArgsConstructor
@NoArgsConstructor
@Builder
@ToString
@Getter
@Setter
public class RetireDto {
	
	private int retireNo;
	private String title;
	private String startPeriod;
	private String lastPeriod;
	private String content;
	private String status;

}
