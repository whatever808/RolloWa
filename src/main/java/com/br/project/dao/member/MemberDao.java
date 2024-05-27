package com.br.project.dao.member;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.common.AttachmentDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class MemberDao {
	private final SqlSessionTemplate sqlSessionTemplate;
	
	public MemberDto memberLogin(MemberDto member) {
		return sqlSessionTemplate.selectOne("memberMapper.memberLogin", member);
	}
	
	public MemberDto selectMember(MemberDto member) {
		return sqlSessionTemplate.selectOne("memberMapper.selectMember", member);
	}

	public String selectUserId(String userNo) {
		return sqlSessionTemplate.selectOne("memberMapper.selectUserId", userNo);
	}
	
	public String selectUserName(String userNo) {
		return sqlSessionTemplate.selectOne("memberMapper.selectUserName", userNo);
	}

	public int updateProfile(MemberDto member) {
		return sqlSessionTemplate.update("memberMapper.updateProfile", member);
	}

	public int insertAttachment(AttachmentDto att) {
		return sqlSessionTemplate.insert("attachmentMapper.insertAttachment", att);
	}

	public int updateMember(Map<String, String> memberInfo) {
		return sqlSessionTemplate.update("memberMapper.updateMember", memberInfo);
	}

	public int updateUserPwd(MemberDto member) {
		return sqlSessionTemplate.update("memberMapper.updateUserPwd", member);
	}
	
	// 전체 사원 조회
	public List<MemberDto> selectAllMember() {
		return sqlSessionTemplate.selectList("memberMapper.selectAllMember");
	}

	// 채팅방 참여인원 조회
	public List<MemberDto> selectParticipants(Map<String, Object> map) {
		return sqlSessionTemplate.selectList("memberMapper.selectParticipants", map);
	}
	
	// 팀원 조회
	public List<MemberDto> selectTeamMember(Map<String, String> map) {
		return sqlSessionTemplate.selectList("memberMapper.selectTeamMember", map);
	}
	/* ======================================= "가림" 구역 ======================================= */
	/**
	 * 메인페이지용 회원 정보 조회
	 */
	public Map<String, Object> selectMemberForMainPage(MemberDto member){
		return sqlSessionTemplate.selectOne("memberMapper.selectMemberForMainPage", member);
	}

	/* ======================================= "가림" 구역 ======================================= */
}
