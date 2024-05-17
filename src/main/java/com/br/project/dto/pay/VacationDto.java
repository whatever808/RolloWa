package com.br.project.dto.pay;

import com.br.project.dto.common.GroupDto;
import com.br.project.dto.member.MemberDto;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@NoArgsConstructor
@AllArgsConstructor
@ToString
@Builder
public class VacationDto {
	private String vacaNO;
	private String vacaStart;
	private String vacaEnd;
	private String vacaComment;
	private String vacaApporvalDate;
	private String vacaColor;
	private String vacaRetractC;
	private String vacationRRetractC;
	private String vacationApprorvalStatus;
	private String vacationGroupCode;
	private GroupDto group;
	private MemberDto member;
}
