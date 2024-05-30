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
public class FixturesDto {
	
	private int fixNo;
	private String title;
	private String totalSum;
	private String productName;
	private int productSize;
	private int quantity;
	private String unitPrice;
	private String price;
	private String note;
	

}
