package com.br.project.scheduler.attendance;

import java.util.List;
import java.util.Map;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.br.project.service.attendance.AttendanceService;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class MemberAttendanceScheduler {

	private final AttendanceService attendanceService;
	
	/**
	 * 평일 매일 자정 12시에 당일 휴가인 사원 근태등록
	 */
	@Scheduled(cron = "0 0 0 * * MON-FRI")
	public void insertVacationMemberAttend() {
		// 휴가사원 리스트
		List<Map<String, Object>> vacationMemberList = attendanceService.selectVacationMemberList();
		
		// 휴가사원 근태등록
		if(vacationMemberList != null && !vacationMemberList.isEmpty()) {
			for(Map<String, Object> params : vacationMemberList) {
				params.put("requestDetail", "휴가");
				attendanceService.insertVacationOrDayOffMemberAttend(params);
			}
		}
		
	}
	
	/**
	 * 평일 매일 밤 11시 55분 00초에 당일 결근사원 근태등록
	 */
	@Scheduled(cron = "00 55 23 * * MON-FRI")
	public void insertDayOffMemberAttend() {
		// 결근사원 리스트
		List<Map<String, Object>> dayOffMemberList = attendanceService.selectDayOffMemberList();
		
		// 결근사원 근태등록
		if(dayOffMemberList != null && !dayOffMemberList.isEmpty()) {
			for(Map<String, Object> params : dayOffMemberList) {
				params.put("requestDetail", "결근");
				attendanceService.insertVacationOrDayOffMemberAttend(params);
			}
		}
		
		// 당일 조퇴/퇴근 미처리 사용자 퇴근처리
		attendanceService.updateMemberWorkOffTime();
		
	}
	
}
