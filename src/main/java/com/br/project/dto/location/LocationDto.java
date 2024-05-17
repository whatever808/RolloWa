package com.br.project.dto.location;

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
public class LocationDto {

	private String locationNo;
	private String modifyEmp;
	private String registEmp;
	private String locationName;
	private Date registDate;
	private Date modifyDate;
	private String status;
	
}
