package com.br.project.service.member;

import org.springframework.stereotype.Service;

import com.br.project.dao.member.MemberDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {
	private final MemberDao memberDao;
}
