package com.br.project.controller.organization;

import java.util.List;
import java.util.Map;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.service.organizaion.OrganizationService;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// 1. 조직안내

@RequestMapping("/organization")
@Controller
@RequiredArgsConstructor
@Slf4j
public class OrganizationInfoController {

	private final OrganizationService organizationService;
	private final PagingUtil pagingUtil;
	
	// 1.1 조직도 컨트롤러
	@GetMapping("/chart.page")
	public String orgChart(Model model) {
		List<GroupDto> dept = organizationService.selectOrganizationChart();
		model.addAttribute("dept", dept);
		return "organization/organization_chart";
	}	
	
	// 1.2 직원 조회 컨트롤러
	@GetMapping("/list.do")
	public ModelAndView list(@RequestParam(value="page", defaultValue="1") int currentPage
					, ModelAndView mv) {
		
		int listCount = organizationService.selectOrganizationListCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		List<MemberDto> list = organizationService.selectOrganizationList(pi);
		//log.debug("pageInfo : {}", pi);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("listCount", listCount)
		  .setViewName("organization/organization_list");
		
		return mv;
	}
	
	// 1.2 직원 조회 검색 컨트롤러
	@GetMapping("/search.do")
	public ModelAndView search(@RequestParam(value="page", defaultValue="1") int currentPage,
					   @RequestParam Map<String, String> search,
					   ModelAndView mv) {
		
		String department =search.get("department"); 
		String team = search.get("team");
		
		if(department.equals("전체 부서")) {
			search.put("department", "");
		}
		if(team.equals("전체 팀")) {
			search.put("team", "");
		}
		
		//log.debug("◆◇◆◇◆◇◆◇◆ 직원 검색 ◆◇◆◇◆◇◆◇◆");
		//log.debug(" search: {}", search);
		
		int listCount = organizationService.selectSearchListCount(search);
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		List<MemberDto> list = organizationService.selectSearchList(search, pi);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("listCount", listCount)
		  .addObject("search", search)
		  .addObject("department", department)
		  .addObject("team", team)
		  .setViewName("organization/organization_list");
		
		return mv;
	}
	
	//select box 컨트롤러
	// 1. 부서 조회
	@ResponseBody
	@GetMapping("/department.do")
	public List<GroupDto> selectDepartment() {
		//log.debug("◆◇◆◇◆◇◆◇◆ 부서 조회 실행 ◆◇◆◇◆◇◆◇◆");

		return organizationService.selectDepartment();
	}
	// 2. 팀 조회 
	@ResponseBody
	@GetMapping("/team.do")
	public List<GroupDto> selectTeam(@RequestParam("selectedDepartment") String selectedDepartment) {
		//log.debug("◆◇◆◇◆◇◆◇◆ 팀 조회 실행 ◆◇◆◇◆◇◆◇◆");
		
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
		//log.debug("직급 조회 실행");
	    return organizationService.selectPosition();
	}
	
	
	
	// 1.3 조직관리(관리자 전용)
	@GetMapping("/manager.do")
	public String manager(Model model) {
		List<GroupDto> dept = organizationService.selectOrganizationChart();
		model.addAttribute("dept", dept);
		
		return "organization/organization_manager";
	}
	
	@ResponseBody
	@PostMapping("/addDepartment.do")
	public List<Map<String, Object>> addDepartment(@RequestBody List<Map<String, Object>> departmentData) {
	    // departmentData를 받아서 처리하고, 필요에 따라 출력
	    
		/*
		for (Map<String, Object> department : departmentData) {
	        log.debug("부서명: {}", department.get("departmentName"));
	        List<String> teams = (List<String>) department.get("teams");
	        log.debug("소속 팀: {}", teams);
	    }
	    */
		
		// 직원이 속한 팀 또는 부서가 있는지 확인
		for (Map<String, Object> department : departmentData) {
	        String departmentName = (String) department.get("departmentName");
	        if (organizationService.hasEmployeesInDepartment(departmentName)) {
	            throw new RuntimeException("부서에 속한 직원이 있습니다. 삭제할 수 없습니다.");
	        }
	        List<String> teams = (List<String>) department.get("teams");
	        for (String teamName : teams) {
	            if (organizationService.hasEmployeesInTeam(teamName)) {
	                throw new RuntimeException("팀에 속한 직원이 있습니다. 삭제할 수 없습니다.");
	            }
	        }
	    }
		
        return departmentData;
		
	    // 받은 데이터를 그대로 반환하여 클라이언트로 전송
	    //return departmentData;
	}

	
}
