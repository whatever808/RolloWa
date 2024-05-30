package com.br.project.service.attendance;

import java.time.Clock;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Service;

import com.br.project.dao.attendance.AttendanceDao;
import com.br.project.dao.pay.VacationDao;
import com.br.project.dto.attendance.AttendanceDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AttendanceService {

	private final AttendanceDao attendanceDao;
	private final VacationDao vacationDao;

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
	 * 당일 출근후 퇴근/조퇴 미처리 사용자 퇴근처리
	 */
	public int updateMemberWorkOffTime() {
		return attendanceDao.updateMemberWorkOffTime();
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
	
	@Bean
    public static LocalDate getNowDate() {
        return LocalDate.now(Clock.systemDefaultZone());
    }
	
	/**
	 * 퇴근/조퇴 등록(수정)
	 */
	public int updateMemberAttend(HashMap<String, Object> params) {
		
		/*======================== 예찬 ===========================*/
		int result = checkAnuual(((MemberDto)params.get("loginMember")));
		/*======================== 예찬 ===========================*/

		
		return attendanceDao.updateMemberAttend(params) * result;
	}
	
	/**
	 * 출근/퇴근/조퇴 시간조회
	 */
	public Map<String, Object> selectAttendTime(HashMap<String, Object> params){
		return attendanceDao.selectAttendTime(params);
	}
	/* ======================================= "가림" 구역 ======================================= */
	
	/* ======================================= "예찬" 구역 ======================================= */
	
	/**
	 * 사원의 근무일 수에 따라 1년 및 30일이 될때 마다 연차를 갱신 해 주는 매서드
	 * 1년 차 이상 += 15일 + 근무일수
	 * 1년차 미만  += 1일
	 * {VacationCount : 새롭게 더해줄 연차 정보}
	 * @param member 객체에 필요한 정보
	 * @return update 성공여부
	 */
	public int checkAnuual(MemberDto member) {
		
		LocalDate currentDate = getNowDate();

		int result = 1;
		int year = Integer.parseInt(member.getVaYearLabor());
		//1년차 이상
		if(year > 0) {
			LocalDate givenDate = LocalDate.of(currentDate.getYear() - 1
	   											, currentDate.getMonthValue()
	   											, Integer.parseInt(member.getVaGivenDate()));
			// 1년이 지날때 마다
			if(givenDate.plusYears(1).isEqual(currentDate)) {
				//연차 15 + 근수연수 member.getVaYearLabor()
				member.setVacationCount(year + 15);
				result = vacationDao.updateAnuul(member);
			}
			
		// 1년차 미만
		}else {
			LocalDate givenDate = LocalDate.of(currentDate.getYear()
					   							, currentDate.getMonthValue() - 1
					   							, Integer.parseInt(member.getVaGivenDate()));
			// 30일이 지날때마다
			if(givenDate.plusDays(30).isEqual(currentDate)) {
				//연차 +1
				member.setVacationCount(1);
				result = vacationDao.updateAnuul(member);				
			}
		}
		return result;
	}
	/* ======================================= "에찬" 구역 ======================================= */
	
}
