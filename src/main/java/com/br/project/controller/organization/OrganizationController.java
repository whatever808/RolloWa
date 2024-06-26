package com.br.project.controller.organization;

import java.util.HashMap;
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
public class OrganizationController {

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
	
	
	
	// 조직관리(관리자 전용)
	@GetMapping("/manager.do")
	public String manager(Model model) {
		List<GroupDto> dept = organizationService.selectOrganizationChart();
		model.addAttribute("dept", dept);
		
		return "organization/organization_manager";
	}
	
	// 3. 조직 관리 -------------------------------------------------------------
	
	// 부서 추가
	@PostMapping("/insertDepartment.do")
    @ResponseBody
    public int insertDepartment(@RequestBody Map<String, Object> payload) {
		String deptName = (String) payload.get("dept");
        Object userNoObj = payload.get("userNo");
        String userNo;

        if (userNoObj instanceof Integer) {
            userNo = String.valueOf(userNoObj);
        } else {
            userNo = (String) userNoObj;
        }
        
		Map<String, Object> paramMap = new HashMap<>();
		paramMap.put("userNo", userNo);
		paramMap.put("deptName", deptName);
        
        int result = organizationService.insertDepartment(paramMap);
        if (result > 0) {
            log.debug("부서 추가 성공");
        } else {
            log.debug("부서 추가 실패");
        }
        return result;
    }
	
	// 팀 추가
	@PostMapping("/insertTeam.do")
    @ResponseBody
    public int insertTeam(@RequestBody Map<String, String> payload) {
		String deptCode = (String) payload.get("deptCode");
        String teamName = (String) payload.get("teamName");
        Object userNoObj = payload.get("userNo");
        String userNo;
        
        log.debug("deptCode값 : {}", deptCode);
        log.debug("teamName값 : {}", teamName);
        
        if (userNoObj instanceof Integer) {
            userNo = String.valueOf(userNoObj);
        } else {
            userNo = (String) userNoObj;
        }

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userNo", userNo);
        paramMap.put("deptCode", deptCode);
        paramMap.put("teamName", teamName);

        int result = organizationService.insertTeam(paramMap);
        if (result > 0) {
            log.debug("팀 추가 성공");
        } else {
            log.debug("팀 추가 실패");
        }
        return result;
	}
	
	// 팀 삭제
    @PostMapping("/deleteTeam.do")
    @ResponseBody
    public boolean deleteTeam(@RequestBody Map<String, Object> payload) {
        String deptCode = (String) payload.get("deptCode");
        String teamName = (String) payload.get("teamName");
        Object userNoObj = payload.get("userNo");
        String userNo = null;

        if (userNoObj instanceof Integer) {
            userNo = String.valueOf(userNoObj);
        } else {
            userNo = (String) userNoObj;
        }

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("userNo", userNo);
        paramMap.put("deptCode", deptCode);
        paramMap.put("teamName", teamName);

        int result = organizationService.deleteTeam(paramMap);
        return result > 0;
    }
    
    // 부서 삭제
    @PostMapping("/deleteDepartment.do")
    @ResponseBody
    public int deleteDepartment(@RequestBody Map<String, Object> params) {
        String deptCode = (String) params.get("deptCode");
        int userNo = (int) params.get("userNo");
    	
    	log.debug("deptCode 값 : {}", deptCode);
    	
    	Map<String, Object> paramMap = new HashMap<>();
    	paramMap.put("deptCode", deptCode);
    	paramMap.put("userNo", userNo);
    	
    	int result = organizationService.deleteDepartment(paramMap);
    	 
    	if(result > 0) {
    		log.debug("부서 삭제 성공");
    	} else {
    		log.debug("부서 삭제 실패");
    	}
    	return result;
    }
    // 부서명 수정
    @PostMapping("/updateDepartmentName.do")
    @ResponseBody
    public int updateDepartmentName(@RequestBody Map<String, Object> params) {
    	String deptCode = (String) params.get("deptCode");
    	String newName = (String) params.get("newName");
    	int userNo = (int) params.get("userNo");
    	
    	log.debug("deptCode 값 : {}", deptCode);
    	log.debug("newName 값 : {}", newName);
    	
    	Map<String, Object> paramMap = new HashMap<>();
    	paramMap.put("deptCode", deptCode);
    	paramMap.put("newName", newName);
    	paramMap.put("userNo", userNo);
    	
    	int result = organizationService.updateDepartmentName(paramMap);
    	
    	if(result > 0) {
    		log.debug("부서명 수정 성공");
    	} else {
    		log.debug("부서명 수정 실패");
    	}
    	return result;
    }
    
    // 팀명 수정
    @PostMapping("/updateTeamName.do")
    @ResponseBody
    public int updateTeamName(@RequestBody Map<String, Object> params) {
    	String teamCode = (String) params.get("teamCode");
    	String newName = (String) params.get("newName");
    	int userNo = (int) params.get("userNo");
    	
    	log.debug("teamCode 값 : {}", teamCode);
    	log.debug("newName 값 : {}", newName);
    	
    	Map<String, Object> paramMap = new HashMap<>();
    	paramMap.put("teamCode", teamCode);
    	paramMap.put("newName", newName);
    	paramMap.put("userNo", userNo);
    	
    	int result = organizationService.updateTeamName(paramMap);
    	if(result > 0) {
    		log.debug("부서명 수정 성공");
    	} else {
    		log.debug("부서명 수정 실패");
    	}
    	return result;
    }
	
    // 팀 사용자 인원수 카운트
    @GetMapping("/countMembers.do")
    @ResponseBody
    public List<Map<String, Object>> countMembers() {
        return organizationService.countMember();
    }
    
    // 부서명 중복 체크
    @PostMapping("/countDepartmentByName.do")
    @ResponseBody
    public int countDepartmentByName(@RequestBody Map<String, String> payload) {
        String deptName = payload.get("deptName");

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("deptName", deptName);
        int resultDepartmentCount = organizationService.countDepartmentByName(paramMap);

        return resultDepartmentCount;
    }

    // 팀명 중복 체크 다른부서이면 팀명 동일해도 상관없음
    @PostMapping("/countTeamByNameAndDept.do")
    @ResponseBody
    public int countTeamByNameAndDept(@RequestBody Map<String, String> payload) {
        String deptCode = payload.get("deptCode");
        String teamName = payload.get("teamName");

        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("deptCode", deptCode);
        paramMap.put("teamName", teamName);
        int resultDepartmentCount = organizationService.countTeamByNameAndDept(paramMap);
        return resultDepartmentCount;
    }
    
	
}
