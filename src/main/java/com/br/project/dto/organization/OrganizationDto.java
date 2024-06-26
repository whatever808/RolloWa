package com.br.project.dto.organization;

import java.util.List;

import com.br.project.dto.common.GroupDto;

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
public class OrganizationDto {

	private int userNo;
	private String userName;
	private String userId;
	private String userPwd;
	private String phone;
	private String address;
	private String bankAccount;
	private String bank;
	private String email;
	private String profileUrl;
	private int countFail;
	private String enrollDate;
	private int enrollUserNo;
	private String modifyDate;
	private int modifyUserNo;
	private String status;
	private int vacationCount;
	private int authLevel;
	private int salary;
	private int deptNo;
	private int teamNo;
	private int positionNo;
	private int alltime;
	private int totalSalary;
	private int payment;
	
	private String dept;
	private String team;
	private String posi;

	private List<GroupDto> groupList;
	
}
