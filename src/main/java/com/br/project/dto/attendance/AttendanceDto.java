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

	private int attendanceNo; // 근무번호 : 시퀀스
	private int userNo; // 사번 : member 테이블
	private Date clockIn; // 근무시작 시간
	private Date clockOut; // 근무종료 시간
	private String requestDetail; // 상태 (출근|결근|퇴근|조회|휴가)
	
	private String dept;
	private String team;
	private String posi;
	private Date todayIn;
	private Date todayOut;

	private List<GroupDto> groupList;
	private List<MemberDto> memberList;
	
	private String profileURL;
	private String userName;
	
	private String a;
	private String b;
	private String c;
	private String d;
	private String e;

}
