package com.br.project.dto.organization;

import java.util.Date;

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

	private String groupNo; // 부서 : DEPT01
	private String groupCode; // 팀 : A
	private String codeName; // 팀명 : 경리부
	private Date registDate; // 생성일 : sysdate 
	private Date ModifyDate; // 수정일 : sysdate
	private String sysdate; // 상태
	private int registEmp; // 생성자
	private int modifyEmp; // 수정자
	private String upperCode; // 상위코드 : 이 부서의 상위 부서
	
}
