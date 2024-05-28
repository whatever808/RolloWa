package com.br.project.dao.attendance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.attendance.AttendanceDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Repository
@Slf4j
public class AttendanceDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	// 출결 조회 dao
	public int selectAttendanceListCount() {
		return sqlSessionTemplate.selectOne("attendanceMapper.selectAttendanceListCount");
	}
	public List<HashMap<String, Object>> selectAttendanceList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("attendanceMapper.selectAttendanceList", paramMap);
	}
	
	/*
	public List<AttendanceDto> SelectAttendanceCount() {
		return sqlSessionTemplate.selectList("attendanceMapper.SelectAttendanceCount");
	}
	*/

	// 아이디 중복체크
	public int selectUserIdCount(String checkId) {
		return sqlSessionTemplate.selectOne("attendanceMapper.selectUserIdCount", checkId);
	}

	// 회원가입
	public int insertMember(MemberDto member) {
		return sqlSessionTemplate.insert("attendanceMapper.insertMember", member);
	}
	public List<AttendanceDto> selectAttendanceCount(String selectedDate) {
		return sqlSessionTemplate.selectList("attendanceMapper.selectAttendanceCount", selectedDate);
	}
	
	/* ======================================= "가림" 구역 ======================================= */
	/**
	 * 당일 휴가인 사원 리스트조회
	 */
	public List<Map<String, Object>> selectVacationMemberList(){
		return sqlSessionTemplate.selectList("attendanceMapper.selectVacationMemberList");
	}
	
	/**
	 * 당일 휴가 or 결근 사원 근태등록
	 */
	public int insertVacationOrDayOffMemberAttend(Map<String, Object> params) {
		return sqlSessionTemplate.insert("attendanceMapper.insertVacationOrDayOffMemberAttend", params);
	}
	
	/**
	 * 당일 결근한 사원 리스트조회
	 */
	public List<Map<String, Object>> selectDayOffMemberList(){
		return sqlSessionTemplate.selectList("attendanceMapper.selectDayOffMemberList");
	}
	
	/**
	 * 당일 출근후 퇴근/조퇴 미처리 사용자 퇴근처리
	 */
	public int updateMemberWorkOffTime() {
		return sqlSessionTemplate.update("attendanceMapper.updateMemberWorkOffTime");
	}
	
	/**
	 * 사용자가 요청한 년도 & 월의 사용자 근태현황 조회
	 */
	public Map<String, Object> selectMemberAttend(HashMap<String, Object> params){
		return sqlSessionTemplate.selectOne("attendanceMapper.selectMemberAttend", params);
	}
	
	/**
	 * 출근 등록
	 */
	public int insertMemberAttend(HashMap<String, Object> params) {
		return sqlSessionTemplate.insert("attendanceMapper.insertMemberAttend", params);
	}
	
	/**
	 * 퇴근/조퇴 등록(수정)
	 */
	public int updateMemberAttend(HashMap<String, Object> params) {
		return sqlSessionTemplate.update("attendanceMapper.updateMemberAttend", params);
	}
	
	/**
	 * 출근/퇴근/조퇴 시간조회
	 */
	public Map<String, Object> selectAttendTime(HashMap<String, Object> params){
		return sqlSessionTemplate.selectOne("attendanceMapper.selectAttendTime", params);
	}
	
	
	/* ======================================= "가림" 구역 ======================================= */

	

	// 출결 상태 조회
	/* 삭제 예정
	public List<GroupDto> selectStatus() {
		return sqlSessionTemplate.selectList("attendanceMapper.selectStatus");
	}
	 */
	
}
