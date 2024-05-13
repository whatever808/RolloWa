package com.br.project.service.attendance;

import java.util.List;

import org.springframework.stereotype.Service;

import com.br.project.dao.attendance.AttendanceDao;
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

	public List<MemberDto> selectAttendanceList(PageInfoDto pi) {
		return attendanceDao.selectAttendanceList(pi);
	}
	
	
	
	
}
