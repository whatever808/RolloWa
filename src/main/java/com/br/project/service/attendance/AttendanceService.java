package com.br.project.service.attendance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.attendance.AttendanceDao;
import com.br.project.dto.attendance.AttendanceDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AttendanceService {

	private final AttendanceDao attendanceDao;

	// 출결 조회
	public int selectAttendanceListCount() {
		return attendanceDao.selectAttendanceListCount();
	}
	public List<HashMap<String, Object>> selectAttendanceList(Map<String, Object> paramMap) {
		return attendanceDao.selectAttendanceList(paramMap);
	}
	
	public int selectUserIdCount(String checkId) {
		return attendanceDao.selectUserIdCount(checkId);
	}

	public int insertMember(MemberDto member) {
		return attendanceDao.insertMember(member);
	}
	public List<AttendanceDto> selectAttendanceCount(String selectedDate) {
		return attendanceDao.selectAttendanceCount(selectedDate);
	}
	
	/* ======================================= "가림" 구역 ======================================= */
	/**
	 * 해당날짜 휴가인 사원 리스트조회
	 */
	public List<Map<String, Object>> selectVacationMemberList(){
		return attendanceDao.selectVacationMemberList();
	}
	
	/**
	 * 해당날짜 휴가인 사원 근태관리 테이블에 휴가등록
	 */
	public int insertVacationOrDayOffMemberAttend(Map<String, Object> params) {
		return attendanceDao.insertVacationOrDayOffMemberAttend(params);
	}
	
	/**
	 * 당일 결근한 사원 리스트조회
	 */
	public List<Map<String, Object>> selectDayOffMemberList(){
		return attendanceDao.selectDayOffMemberList();
	}
	
	/**
	 * 사용자가 요청한 년 & 월의 사용자 근태현황 조회
	 */
	public Map<String, Object> selectMemberAttend(HashMap<String, Object> params){
		return attendanceDao.selectMemberAttend(params);
	}
	
	/**
	 * 출근 등록
	 */
	public int insertMemberAttend(HashMap<String, Object> params) {
		return attendanceDao.insertMemberAttend(params);
	}
	
	/**
	 * 퇴근/조퇴 등록(수정)
	 */
	public int updateMemberAttend(HashMap<String, Object> params) {
		
		/*======================== 예찬 ===========================*/
	
		
		/*======================== 예찬 ===========================*/
		
		return attendanceDao.updateMemberAttend(params);
	}
	
	/**
	 * 출근/퇴근/조퇴 시간조회
	 */
	public Map<String, Object> selectAttendTime(HashMap<String, Object> params){
		return attendanceDao.selectAttendTime(params);
	}
	/* ======================================= "가림" 구역 ======================================= */

	

	

	
}
