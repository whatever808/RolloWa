package com.br.project.dao.member;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MemberDao {
	private final SqlSessionTemplate sqlSessionTemplate;
	
	public MemberDto selectMember(MemberDto member) {
		return sqlSessionTemplate.selectOne("memberMapper.selectMember", member);
	}

	public String selectUserId(String userNo) {
		return sqlSessionTemplate.selectOne("memberMapper.selectUserId", userNo);
	}
}
