package com.br.project.controller.organization;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
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
import com.br.project.dto.organization.OrganizationDto;
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

		return organizationService.selectDepartment();
	}
	// 2. 팀 조회 
	@ResponseBody
	@GetMapping("/team.do")
	public List<GroupDto> selectTeam(@RequestParam("selectedDepartment") String selectedDepartment) {
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
	
	// 3. 조직 관리 -------------------------------------------------------------
	
	// 부서 추가
	@PostMapping("/addDepartment.do")
    @ResponseBody
    public ResponseEntity<String> addDepartment(@RequestBody OrganizationDto organizationDto) {
        organizationService.addDepartment(organizationDto);
        return ResponseEntity.ok("Department added successfully");
    }
	
	// 팀 추가
	@PostMapping("/addTeam.do")
    @ResponseBody
    public ResponseEntity<String> addTeam(@RequestBody OrganizationDto organizationDto) {
        organizationService.addTeam(organizationDto);
        return ResponseEntity.ok("Team added successfully");
    }
	
	// 부서 삭제
	@PostMapping("/deleteDepartment.do")
    @ResponseBody
    public ResponseEntity<String> deleteDepartment(@RequestParam String departmentCode) {
        boolean isDeleted = organizationService.deleteDepartment(departmentCode);
        if (isDeleted) {
            return ResponseEntity.ok("Department deleted successfully");
        } else {
            return ResponseEntity.status(HttpStatus.CONFLICT).body("Cannot delete department with active members");
        }
    }
	
	// 팀 삭제
	@PostMapping("/deleteTeam.do")
    @ResponseBody
    public ResponseEntity<String> deleteTeam(@RequestParam String teamCode) {
        try {
            boolean isDeleted = organizationService.deleteTeam(teamCode);
            if (!isDeleted) {
                throw new IllegalStateException("Cannot delete team with active members");
            }
            return ResponseEntity.ok("Team deleted successfully");
        } catch (IllegalStateException e) {
            return ResponseEntity.status(HttpStatus.CONFLICT).body(e.getMessage());
        }
    }
	
	
	
	
	
	
}
