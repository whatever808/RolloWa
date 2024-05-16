package com.br.project.dto.attendance;

import java.util.Date;
import java.util.List;

import com.br.project.dto.common.GroupDto;
import com.br.project.dto.member.MemberDto;

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
public class AttendanceDto {

	private int userNo;
	private String userName;
	private String userId;
	private String userPwd;
	private String phone;
	private String address;
	private String accountNo;
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
	
	private String dept;
	private String team;
	private String posi;

	private List<GroupDto> groupList;
	
	private int attendanceNo; // 근무번호 : 시퀀스
	//private int userNo; // 사번
	private Date clockIn; // 시작시간
	private Date clockOut; // 종료시간
	private String requestDetail; // 상태 : 출근|결근|퇴근|조퇴|휴가
	
	
}
