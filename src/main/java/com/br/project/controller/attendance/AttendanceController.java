package com.br.project.controller.attendance;

import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.dto.attendance.AttendanceDto;
import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.service.attendance.AttendanceService;
import com.br.project.service.organizaion.OrganizationService;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// 2. 출석 관련 컨트롤러

@RequestMapping("/attendance")
@Controller
@RequiredArgsConstructor
@Slf4j
public class AttendanceController {

	private final AttendanceService attendanceService;
	private final OrganizationService organizationService;
	private final PagingUtil pagingUtil;
	private final BCryptPasswordEncoder bcryptPwdEncoder;
	
	// 2.1 출결 상태 조회 -----------------------------------------------------------
	@GetMapping("/list.do")
	public ModelAndView attendanceList(@RequestParam(value = "page", defaultValue = "1") int currentPage
			,ModelAndView mv) {
		
		// 오늘 날짜를 가져오기
		Calendar cal = Calendar.getInstance();
		int currentYear = cal.get(Calendar.YEAR);
		int currentMonth = cal.get(Calendar.MONTH) + 1; // 월은 0부터 시작하므로 +1 해줍니다.
		int currentDay = cal.get(Calendar.DAY_OF_MONTH);

		// year와 month 설정 (오늘 날짜를 기준으로 설정)
		String year = String.valueOf(currentYear);
		String month = String.format("%02d", currentMonth);
		String day = String.format("%02d", currentDay);
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("year", year);
	    paramMap.put("month", month);
	    paramMap.put("day", day);
		
		int listCount = attendanceService.selectAttendanceListCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		paramMap.put("pi", pi);
		List<MemberDto> list = attendanceService.selectAttendanceList(paramMap);

		//List<AttendanceDto> attendanceCount = attendanceService.SelectAttendanceCount();

		mv.addObject("pi", pi)
		  .addObject("listCount", listCount)
		  .addObject("list", list)
		  //.addObject("attendanceCount", attendanceCount)
		  .setViewName("attendance/attendance_list");

		return mv;
	}
	
	// 2.2 출결 검색 ------------------------------------------------------
	@GetMapping("/search.do")
	public ModelAndView search(@RequestParam(value = "page", defaultValue = "1") int currentPage,
			@RequestParam(value = "selectedDate") String selectedDate,
			@RequestParam(value = "department") String department,
			@RequestParam(value = "team") String team,
			@RequestParam(value = "attendanceStatus") String attendanceStatus,
			@RequestParam(value = "name") String name,
			ModelAndView mv) {
		
		String year = null;
	    String month = null;
	    String day = null;
	    
	    if (selectedDate != null && !selectedDate.isEmpty()) {
	        String[] dateParts = selectedDate.split("-");
	        if (dateParts.length == 2) { // month 형식인 경우 (예: 2024-05)
	            year = dateParts[0];
	            month = dateParts[1];
	        } else if (dateParts.length == 3) { // date 형식인 경우 (예: 2024-05-21)
	            year = dateParts[0];
	            month = dateParts[1];
	            day = dateParts[2];
	        }
	    }

	    if(department.equals("전체 부서")) {
	    	department = "";
	    }
	    if(team.equals("전체 팀")) {
	    	team = "";
	    }
	    if(attendanceStatus.equals("전체 상태")) {
	    	attendanceStatus = "";
	    }

	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("year", year);
	    paramMap.put("month", month);
        paramMap.put("day", day);
	    paramMap.put("department", department);
	    paramMap.put("team", team);
	    paramMap.put("attendanceStatus", attendanceStatus);
	    paramMap.put("name", name);
	    
	    log.debug("검색 year : {}", year);
		log.debug("검색 month : {}", month);
		log.debug("검색 day : {}", day);
		log.debug("검색 department : {}", department);
		log.debug("검색 team : {}", team);
		log.debug("검색 attendanceStatus : {}", attendanceStatus);
		log.debug("검색 name : {}", name);
	    
		int listCount = attendanceService.selectAttendanceListCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		paramMap.put("pi", pi);
		List<MemberDto> list = attendanceService.selectAttendanceList(paramMap);
		
		log.debug("사용자가 선택한 날짜 : {}", selectedDate);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("listCount", listCount)
		  .setViewName("attendance/account_list");
		
		return mv;
	}
		
		
		
		
/*
		int listCount = attendanceService.selectAttendanceListCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		
		// 해당 selectSearchList에 날짜값(year,month) 넣어서 전달
		List<HashMap<String, String>> list = attendanceService.selectAttendanceList(pi, formattedDate);

		List<AttendanceDto> attendanceCount = attendanceService.SelectAttendanceCount();

		mv.addObject("pi", pi)
		  .addObject("listCount", listCount)
		  .addObject("list", list)
		  .addObject("attendanceCount", attendanceCount)
		  .setViewName("attendance/attendance_list");

		return mv;
	}
 */
	
	// 2.2 급여 조회(기본 페이지) --------------------------------------------------------------------------------------------
	@GetMapping("/accountList.do")
	public ModelAndView accountList(@RequestParam(value="page", defaultValue="1") int currentPage
			, ModelAndView mv) {

		// 오늘 날짜를 가져오기
		Calendar cal = Calendar.getInstance();
		int currentYear = cal.get(Calendar.YEAR);
		int currentMonth = cal.get(Calendar.MONTH) + 1; // 월은 0부터 시작하므로 +1 해줍니다.

		// year와 month 설정 (오늘 날짜를 기준으로 설정)
		String year = String.valueOf(currentYear);
		String month = String.format("%02d", currentMonth);
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("year", year);
	    paramMap.put("month", month);
		    
		int listCount = organizationService.selectOrganizationListCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		paramMap.put("pi", pi);
		List<MemberDto> list = organizationService.selectAccountList(paramMap);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("listCount", listCount)
		  .setViewName("attendance/account_list");
		
		return mv;
	}
	
	// 2.2 급여 조회(검색 페이지) --------------------------------------------------------------------------------------------
	@GetMapping("/accountSearch.do")
	public ModelAndView accountSearch(@RequestParam(value="page", defaultValue="1") int currentPage, 
			@RequestParam(value = "selectedDate") String selectedDate,
			@RequestParam(value = "department") String department,
			@RequestParam(value = "team") String team,
			@RequestParam(value = "name") String name,
			ModelAndView mv) {
		
		String year = null;
	    String month = null;

	    if (selectedDate != null && !selectedDate.isEmpty()) {
	        year = selectedDate.split("-")[0];
	        month = selectedDate.split("-")[1];
	    }
	    
	    if(department.equals("전체 부서")) {
	    	department = "";
	    }
	    if(team.equals("전체 팀")) {
	    	team = "";
	    }
	    
	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("year", year);
	    paramMap.put("month", month);
	    paramMap.put("department", department);
	    paramMap.put("team", team);
	    paramMap.put("name", name);
	    
	    
		//log.debug("검색 year : {}", year);
		//log.debug("검색 month : {}", month);
		//log.debug("검색 department : {}", department);
		//log.debug("검색 team : {}", team);
		//log.debug("검색 name : {}", name);
		
		
		int listCount = organizationService.selectOrganizationListCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		paramMap.put("pi", pi);
		List<MemberDto> list = organizationService.selectAccountList(paramMap);
		
		log.debug("사용자가 선택한 날짜 : {}", selectedDate);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("listCount", listCount)
		  .setViewName("attendance/account_list");
		
		return mv;
	}
	
	// 2.2 급여 상세 조회 페이지
	@GetMapping("/accountDetail.do")
	public String accountDetail(@RequestParam("userNo") int userNo, Model model) {
		
		List<MemberDto> list = organizationService.selectAccountDetail(userNo);
		
		model.addAttribute("list", list);
		
		return "attendance/account_detail";
	}
	
	
	
	
	
	// 2.4 구성원 추가  ------------ 비밀번호 ajax 수정필요 --------------------------------------------------------------------
	@GetMapping("/signup.page")
	public String signupPage() {
		return "attendance/attendance_signup";
	}

	@ResponseBody
	@GetMapping("/idcheck.do")
	public String ajaxIdCheck(String checkId) {
		return attendanceService.selectUserIdCount(checkId) > 0 ? "NNNNN" : "YYYYY";
	}

	@PostMapping("/signup.do")
	public String insertMembmer(MemberDto member, RedirectAttributes redirectAttributes) {
		log.debug("암호화 전 : {}", member);
		member.setUserPwd(bcryptPwdEncoder.encode(member.getUserPwd()));
		log.debug("암호화 후 : {}", member);
		
		int result = attendanceService.insertMember(member);
		
			redirectAttributes.addFlashAttribute("alertTitle", "회원가입 서비스");
			if (result > 0) {
				redirectAttributes.addFlashAttribute("alertMsg", "가입 성공");
			} else {
				redirectAttributes.addFlashAttribute("alertMsg", "가입 실패");
				redirectAttributes.addFlashAttribute("historyBackYN", "Y");
			}
			return "redirect:/";
	}
	
	
	
	// select box 컨트롤러 ------------------------------------------------------------------------------------
	// 1. 부서 조회
	@ResponseBody
	@GetMapping("/department.do")
	public List<GroupDto> selectDepartment() {
		log.debug("◆◇◆◇◆◇◆◇◆ 부서 조회 실행 ◆◇◆◇◆◇◆◇◆");

		return organizationService.selectDepartment();
	}
	// 2. 팀 조회
	@ResponseBody
	@GetMapping("/team.do")
	public List<GroupDto> selectTeam(@RequestParam("selectedDepartment") String selectedDepartment) {
		log.debug("◆◇◆◇◆◇◆◇◆ 팀 조회 실행 ◆◇◆◇◆◇◆◇◆");
		log.debug("selectedDepartment 값 : {}", selectedDepartment);
		
		// 초기값 설정
		List<GroupDto> result = null;
		
		if(selectedDepartment.equals("전체 부서")) {
			result = organizationService.selectTeamAll(selectedDepartment); 
		} else {
			result = organizationService.selectTeam(selectedDepartment); 
		}
		
		//log.debug("result출력 : {}", result);
		
	    return result;
	}
	// 3. 직급 조회
	@ResponseBody
	@GetMapping("/position.do")
	public List<GroupDto> selectPosition() {
		log.debug("직급 조회 실행");
	    return organizationService.selectPosition();
	}
	
	/* 삭제 예정
	// 4. 상태 조회
	@ResponseBody
	@GetMapping("/status.do")
	public List<GroupDto> selectStatus() {
		log.debug("상태 조회 실행");
	    return attendanceService.selectStatus();
	}
	*/
	
	/*
	@ResponseBody
	@GetMapping("/team.do")
	public Map<String, List<GroupDto>> selectTeam() {
		Map<String, List<GroupDto>> result = new HashMap<>();
		result.put("department", attendanceService.selectDepartment());
		result.put("team", attendanceService.selectTeam());
		result.put("position", attendanceService.selectPosition());
		
		log.debug("==================");
		List<GroupDto> departmentList = result.get("department");
		log.debug("부서 값 : {}", departmentList);
		log.debug("==================");
		List<GroupDto> teamList = result.get("team");
		log.debug("팀 값 : {}", teamList);
		log.debug("==================");
		return result;
	}
	*/
	
	/*
	 * @ResponseBody
	 * @GetMapping("/department.do") public String selectDepartment(Model model) {
	 * 
	 * /* 부서 조회 List<GroupDto> department = attendanceService.selectDepartment();
	 * model.addAttribute("department", department);
	 * 
	 * 팀 조회 List<GroupDto> team = attendanceService.selectTeam();
	 * model.addAttribute("team", team);
	 * 
	 * 직급 조회 List<GroupDto> position = attendanceService.selectPosition();
	 * model.addAttribute("position", position);
	 * 
	 * 보여줄 페이지 이름 return "attendance/signup"; }
	 */

}
