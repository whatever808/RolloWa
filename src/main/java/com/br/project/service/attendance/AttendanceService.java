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

	/*
	public List<HashMap<String, String>> selectAttendanceList(PageInfoDto pi, String nowDate) {
		return attendanceDao.selectAttendanceList(pi,nowDate);
	}
	*/

	// 출결 조회
	public int selectAttendanceListCount() {
		return attendanceDao.selectAttendanceListCount();
	}
	public List<MemberDto> selectAttendanceList(Map<String, Object> paramMap) {
		return attendanceDao.selectAttendanceList(paramMap);
	}
	
	/*
	public List<AttendanceDto> SelectAttendanceCount() {
		return attendanceDao.SelectAttendanceCount();
	}
	*/
	
	public int selectUserIdCount(String checkId) {
		return attendanceDao.selectUserIdCount(checkId);
	}

	public int insertMember(MemberDto member) {
		return attendanceDao.insertMember(member);
	}

	

	

	
}
