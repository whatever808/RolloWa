package com.br.project.controller.attendance;


import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;


import org.springframework.security.core.annotation.AuthenticationPrincipal;

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

import com.br.project.controller.common.CommonController;
import com.br.project.dto.attendance.AttendanceDto;
import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.service.attendance.AttendanceService;
import com.br.project.service.member.MemberService;
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

	private final MemberService memberService;
	private final AttendanceService attendanceService;
	private final OrganizationService organizationService;
	private final PagingUtil pagingUtil;
	private final BCryptPasswordEncoder bcryptPwdEncoder;
	
	// 2.1 출결 상태 조회 -----------------------------------------------------------
	@GetMapping("/list.do")
	public ModelAndView attendanceList(@RequestParam(value = "page", defaultValue = "1") int currentPage,
			@RequestParam(value = "selectedDate", required = false) String selectedDate,
			ModelAndView mv) {
		
		// 오늘 날짜 가져와서 다음 형식으로 ("yyyy-MM-dd")
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		Calendar cal = Calendar.getInstance();
	    String currentDate = sdf.format(cal.getTime());
		
	    Map<String, Object> paramMap = new HashMap<>();
		int listCount = attendanceService.selectAttendanceListCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		paramMap.put("pi", pi);
		paramMap.put("selectedDate", currentDate);
		List<HashMap<String, Object>> list = attendanceService.selectAttendanceList(paramMap);

		// 출결 카운트
		List<AttendanceDto> attendanceCount = attendanceService.selectAttendanceCount(selectedDate);

		mv.addObject("pi", pi)
		  .addObject("listCount", listCount)
		  .addObject("list", list)
		  .addObject("attendanceCount", attendanceCount)
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
		
		/*
		log.debug("검색 selectedDate : {}", selectedDate);
		log.debug("검색 department : {}", department);
		log.debug("검색 team : {}", team);
		log.debug("검색 attendanceStatus : {}", attendanceStatus);
		log.debug("검색 name : {}", name);
		*/
		
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
	    paramMap.put("selectedDate", selectedDate.replaceAll("-", ""));
	    paramMap.put("department", department);
	    paramMap.put("team", team);
	    paramMap.put("attendanceStatus", attendanceStatus);
	    paramMap.put("name", name);
	    
		//log.debug("paramMap : {}", paramMap);
		
		int listCount = attendanceService.selectAttendanceListCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		paramMap.put("pi", pi);
		List<HashMap<String, Object>> list = attendanceService.selectAttendanceList(paramMap);
		
		// 출결 카운트
		List<AttendanceDto> attendanceCount = attendanceService.selectAttendanceCount(selectedDate);
		
		//log.debug("사용자가 선택한 날짜 : {}", selectedDate);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("listCount", listCount)
		  .addObject("attendanceCount", attendanceCount)
		  .setViewName("attendance/attendance_list");
		
		return mv;
	}
	
	// 2.2 급여 조회 페이지(기본 페이지 출력) --------------------------------------------------------------------------------------------
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
	
	// 2.2 급여 조회 페이지(검색 기능) --------------------------------------------------------------------------------------------
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
		
		//log.debug("사용자가 선택한 날짜 : {}", selectedDate);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("listCount", listCount)
		  .setViewName("attendance/account_list");
		
		return mv;
	}
	
	// 2.2 급여 상세 조회 페이지	---------------------------------------------------
	@RequestMapping("/accountDetail.do")
	public ModelAndView selectAuthLevel(@RequestParam("userNo") int userNo, ModelAndView mv) {
		//log.debug("사용자 번호 :  {}", userNo);
		
		MemberDto m = memberService.selectMemberInfo(userNo);
		
		mv.addObject("m", m)
		  .setViewName("attendance/account_detail");
		  
		  return mv;
	}
	// 2.2 급여 상세 페이지 수정하기
	@ResponseBody
	@RequestMapping("/accountDetailSave.do")
	public int updateSalary(@RequestParam ("userNo") int userNo,
			@RequestParam ("salary") int salary ,
			@RequestParam ("bank") String bank ,
			@RequestParam ("bankAccount") String bankAccount){
		/*
        log.debug("userNo: {}", userNo);
		log.debug("salary : {}", salary );
		log.debug("bank : {}", bank );
		log.debug("bankAccount : {}", bankAccount );
		*/
		
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("userNo", userNo);
		paramMap.put("salary", salary);
		paramMap.put("bank", bank);
		paramMap.put("bankAccount", bankAccount);
		
		int result = memberService.updateSalary(paramMap);

		return result;
    }
	
	// 2.3.1 구성원 상세 페이지 --------------------------------------------------------------------------------
	@GetMapping("/detailList.do")
	public ModelAndView selectMemberDetail(ModelAndView mv) {
		
		List<HashMap<String, Object>> list = memberService.selectMemberAll();
		log.debug("list출력 : {}", list);
		
		mv.addObject("list", list)
		  .setViewName("attendance/attendance_detailList");
		return mv;
	}
	// 2.3.2 구성원 조회 페이지 검색
	@GetMapping("/detailSearch.do")
	public ModelAndView search(
			@RequestParam(value = "department") String department,
			@RequestParam(value = "team") String team,
			@RequestParam(value = "position") String position,
			@RequestParam(value = "name") String name,
			ModelAndView mv) {
		
		log.debug("검색 department : {}", department);
		log.debug("검색 team : {}", team);
		log.debug("검색 position : {}", position);
		log.debug("검색 name : {}", name);
		
	    if(department.equals("전체 부서")) {
	    	department = "";
	    }
	    if(team.equals("전체 팀")) {
	    	team = "";
	    }
	    if(position.equals("전체 직급")) {
	    	position = "";
	    }

	    Map<String, Object> paramMap = new HashMap<>();
	    paramMap.put("department", department);
	    paramMap.put("team", team);
	    paramMap.put("position", position);
	    paramMap.put("name", name);
	    
		log.debug("paramMap : {}", paramMap);
		
		List<HashMap<String, Object>> list = memberService.selectMemberListSearch(paramMap);
		
		mv.addObject("list", list)
		  .setViewName("attendance/attendance_detailList");
		
		return mv;
	}
	
	// 2.3.3 구성원 조회 상세 페이지---------------------------------------------------
	@RequestMapping("/memberDetail.do")
	public ModelAndView selectMemberDetail(@RequestParam("userNo") int userNo, ModelAndView mv) {
		log.debug("사용자 번호 :  {}", userNo);
		
		MemberDto m = memberService.selectMemberInfo(userNo);
		
		mv.addObject("m", m)
		  .setViewName("attendance/attendance_memberDetail");
		  
		  return mv;
	}
	
	// 2.4 구성원 추가 ----------------------------------------------------
	@GetMapping("/signup.page")
	public String signupPage() {
		return "attendance/attendance_signup";
	}
	// 2.4.1 아이디 중복체크
	@ResponseBody
	@GetMapping("/idcheck.do")
	public String ajaxIdCheck(String checkId) {
		return attendanceService.selectUserIdCount(checkId) > 0 ? "NNNNN" : "YYYYY";
	}
	// 회원 가입하기
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
		return organizationService.selectDepartment();
	}
	// 2. 팀 조회
	@ResponseBody
	@GetMapping("/team.do")
	public List<GroupDto> selectTeam(@RequestParam("selectedDepartment") String selectedDepartment) {
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
	    return organizationService.selectPosition();
	}
	
	
	/* ======================================= "가림" 구역 ======================================= */
	/**
	 * 년도 & 월별 로그인 사용자의 근태현황 조회
	 */
	@RequestMapping(value="/myAttend.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> ajaxSelectMyAttend(HttpServletRequest request){
		
		HashMap<String, Object> params = CommonController.getParameterMap(request);
		
		Map<String, Object> responseData = new HashMap<>();
		Map<String, Object> memberAttend = attendanceService.selectMemberAttend(params);
		if(memberAttend != null && !memberAttend.isEmpty()) {
			responseData.put("result", "SUCCESS");
			responseData.put("attendInfo", memberAttend);
		}else {
			responseData.put("result", "FAIL");
		}
		
		return responseData;
	}
	
	/**
	 * 출근 등록 | 퇴근/조퇴 등록(수정)
	 */
	@RequestMapping(value={"/insert.ajax", "/update.ajax"})
	@ResponseBody
	public Map<String, Object> ajaxMemberAttendCheck(HttpServletRequest request) {
		
		HashMap<String, Object> params = CommonController.getParameterMap(request);
		// 예찬 연차 체크에 필요한 parameter 담음
		params.put("LoginMember", request.getSession().getAttribute("loginMember"));
		
		int result = request.getRequestURL().indexOf("insert") != -1 ? attendanceService.insertMemberAttend(params)
																	 : attendanceService.updateMemberAttend(params);
		
		Map<String, Object> responseData = new HashMap<>();
		if(result > 0) {
			responseData.put("result", "SUCCESS");
			responseData.put("attendTime", attendanceService.selectAttendTime(params));
		}else {
			responseData.put("result", "FAILED");
		}

		return responseData;
	}
	
	/* ======================================= "가림" 구역 ======================================= */

}
