package com.br.project.dto.pay;

import java.sql.Date;
import java.util.List;

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
public class DraftDto {
	
	private int draftNo;
	private String title;
	private String sum;
	private String vat;
	private String totalSum;
	private String status;
	private String account;
	private String content;
	private int amount;

}
