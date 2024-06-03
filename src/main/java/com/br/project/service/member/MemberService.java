package com.br.project.service.member;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.member.MemberDao;
import com.br.project.dto.common.AttachmentDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {
	private final MemberDao memberDao;
	
	// 회원 로그인
	public MemberDto memberLogin(MemberDto member) {
		return memberDao.memberLogin(member);
	}
	
	// 회원 정보 조회
	public MemberDto selectMember(MemberDto member) {
		return memberDao.selectMember(member);
	}

	// 회원 아이디 찾기
	public String selectUserId(String userNo) {
		return memberDao.selectUserId(userNo);
	}
	
	// 회원 이름 찾기
	public String selectUserName(String userNo) {
		return memberDao.selectUserName(userNo);
	}
	
	// 회원 프로필 이미지 변경
	public int updateProfile(MemberDto member, AttachmentDto att) {
		int result1 = memberDao.updateProfile(member);
		int result2 = memberDao.insertAttachment(att);
		
		return result1 * result2;
	}
	
	// 회원정보 수정
	public int updateMember(Map<String, String> memberInfo) {
		return memberDao.updateMember(memberInfo);
	}
	
	// 회원 비밀번호 변경
	public int updateUserPwd(MemberDto member) {
		return memberDao.updateUserPwd(member);
	}

	// 전체 회원 조회
	public List<MemberDto> selectAllMember() {
		return memberDao.selectAllMember();
	}
	
	// 팀원 조회
	public List<String> selectTeamMember(Map<String, Object> map) {
		return memberDao.selectTeamMember(map);
	}
	
	// 이름으로 사원 검색
	public List<MemberDto> searchMember(Map<String, String> map) {
		return memberDao.searchMember(map);
	}
	
	/* ======================================= "가림" 구역 ======================================= */
	/**
	 * 메인페이지용 회원 정보 조회
	 */
	public Map<String, Object> selectMemberForMainPage(MemberDto member){
		return memberDao.selectMemberForMainPage(member);
	}

	/* ======================================= "가림" 구역 ======================================= */
	
	// ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆ 호관 start ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆
	// 사이드바(구성원 관리) 관리자만 표시 하기
	public Map<String, Object> selectAuthLevel(int userNo) {
		return memberDao.selectAuthLevel(userNo);
	}
	// 사용자 정보 조회하기
	public MemberDto selectMemberInfo(int userNo) {
		return memberDao.selectMemberInfo(userNo);
	}
	// 사용자 급여 정보 수정하기
	public int updateSalary(Map<String, Object> paramMap) {
		return memberDao.updateSalary(paramMap);
	}
	// 사용자 전체 리스트 조회
	public List<HashMap<String, Object>> selectMemberAll() {
		return memberDao.selectMemberAll();
	}
	// 사용자 전체 리스트 검색 조회
	public List<HashMap<String, Object>> selectMemberListSearch(Map<String, Object> paramMap) {
		return memberDao.selectMemberListSearch(paramMap);
	}

	// 사용자 탈퇴
	public int deleteMemberAttendance(Map<String, Object> paramMap) {
		return memberDao.deleteMemberAttendance(paramMap);
	}
	// 사용자 정보 수정
	public int updateMemberAttendance(Map<String, Object> paramMap) {
		return memberDao.updateMemberAttendance(paramMap);
	}

	// ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆ 호관 end ◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆◆
	
	/* ======================================= "예찬" 구역 ======================================= */
	
	public MemberDto selectAnuual(int userNo) {
		return memberDao.selectAnuual(userNo);
	}
	
	/* ======================================= "예찬" 구역 ======================================= */
}
