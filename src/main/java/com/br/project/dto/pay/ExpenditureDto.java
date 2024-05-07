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
public class ExpenditureDto {
	
	private int salesNo;
	private String salesDivision;
	private String manager;
	private String totalSales;
	private String item;
	private int quantity;
	private String salesAmount;
}
