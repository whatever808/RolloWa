package com.br.project.dto.pay;

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
public class MemberDeptDto {
	// 부서 - 팀에 속한 직원 Dto
	private String userNo; // 사원 번호
    private String userName; // 사원이름
    private String teamCode; // 팀코드
    private String positionCode; // 코드
    private String teamName; // 부서에 속한 팀이름
    private String positionName; // 과장, 부장, 차장
    private String deptName; // 부서
    
}
