package com.br.project.service.attendance;

import java.util.HashMap;
import java.util.List;

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

	
	
	
}
