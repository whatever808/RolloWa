package com.br.project.dto.calendar;


import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
@Builder
public class CalendarDto {
	private String calNO;
	private String calSort;
	private String calTitle;
	private String calcontent;
	private String statrDate;
	private String endDate;
	private String place;
	private String color;
	private String status;
	private String groupCode;
	
}
