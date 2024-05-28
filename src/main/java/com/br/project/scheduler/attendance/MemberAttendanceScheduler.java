package com.br.project.scheduler.attendance;

import java.util.List;
import java.util.Map;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import com.br.project.service.attendance.AttendanceService;
import com.br.project.service.pay.VacationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Component
@RequiredArgsConstructor
public class MemberAttendanceScheduler {

	private final AttendanceService attendanceService;
	private final VacationService vacationService;
	
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
	 * 평일 매일 밤 11시 59분 59초에 당일 결근사원 근태등록
	 */
	@Scheduled(cron = "59 59 23 * * MON-FRI")
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
	
	/**
	 * 1월과 6월에 각 회사 인원들의 근무일수을 갱신하는 스케줄러
	 * @author dpcks
	 */
	@Scheduled(cron = "00 00 01 1 1,6 *")
	public void updateVacation() {
		int result = vacationService.updateYearLabor();
		if(result > 0 ) {
			log.debug(result +"행만큼 갱신이 완료 되었습니다.");
		}else {
			log.debug("갱신에 실패 했습니다.");
		}
		
	}
	
	
}
