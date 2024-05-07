package com.br.project.service.member;

import org.springframework.stereotype.Service;

import com.br.project.dao.member.MemberDao;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {
	private final MemberDao memberDao;
	
	// 회원 로그인
	public MemberDto selectMember(MemberDto member) {
		return memberDao.selectMember(member);
	}

	// 회원 아이디 찾기
	public String selectUserId(String userNo) {
		return memberDao.selectUserId(userNo);
	}
}
