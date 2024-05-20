package com.br.project.service.attendance;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.attendance.AttendanceDao;
import com.br.project.dto.attendance.AttendanceDto;
import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AttendanceService {

	private final AttendanceDao attendanceDao;

	public int selectAttendanceListCount() {
		return attendanceDao.selectAttendanceListCount();
	}

	public List<HashMap<String, String>> selectAttendanceList(PageInfoDto pi) {
		return attendanceDao.selectAttendanceList(pi);
	}

	public List<AttendanceDto> SelectAttendanceCount() {
		return attendanceDao.SelectAttendanceCount();
	}

	
	public int selectUserIdCount(String checkId) {
		return attendanceDao.selectUserIdCount(checkId);
	}

	public int insertMember(MemberDto member) {
		return attendanceDao.insertMember(member);
	}

	// 출결 상태 조회
	public List<GroupDto> selectStatus() {
		return attendanceDao.selectStatus();
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
	
	/* ======================================= "가림" 구역 ======================================= */

	
}
