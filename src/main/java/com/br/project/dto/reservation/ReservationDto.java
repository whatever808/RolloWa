package com.br.project.dto.reservation;

import java.util.Date;
import java.util.List;

import com.br.project.dto.common.GroupDto;
import com.br.project.dto.organization.OrganizationDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
@Builder
public class ReservationDto {
	
	private int equipmentNo;
	private String equipmentName;
	private Date registDate;
	private Date registEmp;
	private Date ModifyDate ;
	private String equipmentAbilability;
	private String status;
	
	private List<GroupDto> groupList;

}
