package com.br.project.scheduler.attendance;

import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class MemberAttendanceScheduler {

	@Scheduled(cron = "0 0 0 * * MON-FRI")
	public void insertVacationMemberAttend() {
		/*
		 * select COUNT(VACATION_NO)
			  from vacation
			where APPORVAL_STATUS = 'Y'
			  and status = 'Y'
			  and sysdate between vacation_strat and vacation_end
			  and  regist_emp = 1052
		 */
	}
	
	// 퇴근시간 이후까지 출근 미체크시, 결근처리 or 자정에 모두 결근처리
	
	/*
	 * select count(*)
 from attendance
where user_no = 10
   and clock_in < extract(year from sysdate)
   and clock_in is null
	 * 
	 */
	
}
