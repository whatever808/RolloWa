package com.br.project.controller.attendance;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
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

	// 2.1 출결 상태 조회
	@GetMapping("/list.do")
	public ModelAndView list(@RequestParam(value = "page", defaultValue = "1") int currentPage,
			@RequestParam(value = "nowDate", required = false) String nowDate, ModelAndView mv) {

		if (nowDate == null || nowDate.isEmpty()) {
			// 오늘 날짜를 얻어옵니다.
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy년 MM월 dd일 (E)", Locale.KOREA);
			nowDate = sdf.format(new Date());
		}

		int listCount = attendanceService.selectAttendanceListCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		List<HashMap<String, String>> list = attendanceService.selectAttendanceList(pi);

		List<AttendanceDto> attendanceCount = attendanceService.SelectAttendanceCount();

		// log.debug("pageInfo : {}", pi);
		// log.debug("list : {}", list);
		// log.debug("attendanceCount : {}", attendanceCount);

		mv.addObject("pi", pi).addObject("listCount", listCount).addObject("list", list)
				.addObject("attendanceCount", attendanceCount).addObject("nowDate", nowDate)
				.setViewName("attendance/list");

		return mv;
	}

	// 2.4 구성원 추가
	@GetMapping("/signup.page")
	public String signupPage() {
		return "attendance/signup";
	}

	@ResponseBody
	@GetMapping("/idcheck.do")
	public String ajaxIdCheck(String checkId) {
		return attendanceService.selectUserIdCount(checkId) > 0 ? "NNNNN" : "YYYYY";
	}

	@PostMapping("/signup.do")
	public String signup(MemberDto member, RedirectAttributes redirectAttributes) {
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

	/* 1. 부서 조회 */
	@ResponseBody
	@GetMapping("/department.do")
	public List<GroupDto> selectDepartment() {
		log.debug("부서 조회 실행");
	    return organizationService.selectDepartment();
	}
	/* 2. 팀 조회 */
	@ResponseBody
	@GetMapping("/team.do")
	public List<GroupDto> selectTeam(@RequestParam("selectedDepartment") String selectedDepartment) {
		log.debug("팀 조회 실행");
		log.debug("selectedDepartment 값 : {}", selectedDepartment);
		List<GroupDto> result = organizationService.selectTeam(selectedDepartment); 
		log.debug("result출력 : {}", result);
		
	    return result;
	}
	/* 3. 직급 조회 */
	@ResponseBody
	@GetMapping("/position.do")
	public List<GroupDto> selectPosition() {
		log.debug("직급 조회 실행");
	    return organizationService.selectPosition();
	}
	
	
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
