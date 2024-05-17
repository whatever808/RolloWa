package com.br.project.dto.facility;

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
public class AttractionDto {

	private String attractionNo;
	private String location;	// location_no
	private String manageEmp;
	private String registEmp;
	private String modifyEmp;
	private String attractionName;
	private String attractionIntro;
	private String customerLimit;
	private String ageLimit;
	private String ageLimitRange;
	private String heightLimit;
	private String heightLimitRange;
	private Date registDate;
	private Date modifyDate;
	private String status;
	private String operation;
}
