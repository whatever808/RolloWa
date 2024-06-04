package com.br.project.dto.calendar;

import java.util.List;

import com.br.project.dto.member.MemberDto;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Setter
@Getter
@AllArgsConstructor
@NoArgsConstructor
@ToString
public class calDepartDto {
	private String department;
	private List<MemberDto> member;
}
