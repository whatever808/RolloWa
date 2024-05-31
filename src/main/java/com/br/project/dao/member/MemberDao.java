package com.br.project.dao.member;

import java.util.HashMap;
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
	public List<String> selectTeamMember(Map<String, Object> map) {
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
	
	// ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆ 호관 start ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆
	// 사이드바(구성원 관리) 관리자만 표시 하기
	public Map<String, Object> selectAuthLevel(int userNo) {
		return sqlSessionTemplate.selectOne("memberMapper.selectAuthLevel", userNo);
	}
	// 사용자 정보 전체 조회하기
	public MemberDto selectMemberInfo(int userNo) {
		return sqlSessionTemplate.selectOne("memberMapper.selectMemberInfo", userNo);
	}
	// 사용자 급여정보 수정하기
	public int updateSalary(Map<String, Object> paramMap) {
		return sqlSessionTemplate.update("memberMapper.updateSalary", paramMap);
	}
	// 사용자 전체 리스트 조회
	public List<HashMap<String, Object>> selectMemberAll() {
		return sqlSessionTemplate.selectList("memberMapper.selectMemberAll");
	}
	// 사용자 전체 리스트 검색 조회
	public List<HashMap<String, Object>> selectMemberListSearch(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("memberMapper.selectMemberListSearch", paramMap);
	}
	// 사용자 탈퇴
	public int deleteMemberAttendance(Map<String, Object> paramMap) {
		return sqlSessionTemplate.update("memberMapper.deleteMemberAttendance", paramMap);
	}
	// 사용자 정보 수정
	public int updateMemberAttendance(Map<String, Object> paramMap) {
		return sqlSessionTemplate.update("memberMapper.updateMemberAttendance", paramMap);
	}
	// ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆ 호관 end ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆
	/* ======================================= "예찬" 구역 ======================================= */
	/**
	 * 회원의 연차 정보를 불러오는 dao
	 * @param userNo {회원 고유 번호}
	 * @return 연차 정보를 담고 있는 Dto객체
	 */
	public MemberDto selectAnuual(int userNo) {
		return sqlSessionTemplate.selectOne("memberMapper.selectAnuual", userNo);
	}
	/* ======================================= "예찬" 구역 ======================================= */
	
}
