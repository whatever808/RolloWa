package com.br.project.controller.organization;

import java.util.List;


import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.service.organizaion.OrganizationService;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

// 1. 조직안내

@RequestMapping("/orginfo")
@Controller
@RequiredArgsConstructor
@Slf4j
public class OrganizationInfoController {

	private final OrganizationService organizationService;
	private final PagingUtil pagingUtil;
	
	// 1.1 조직도
	@GetMapping("/orgChart.page")
	public String orgchart() {
		return "organization/orgChart";
	}
	
	// 1.2 직원검색
	@GetMapping("/empSearch.do")
	public ModelAndView list(@RequestParam(value="page", defaultValue="1")
					int currentPage, ModelAndView mv) {
		
		int listCount = organizationService.selectOrganizationListCount();
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 10, 10);
		List<MemberDto> list = organizationService.selectOrganizationList(pi);
		
		mv.addObject("pi", pi)
		  .addObject("list", list)
		  .addObject("listCount", listCount)
		  .setViewName("organization/empSearch");
		
		return mv;
	}
	
	// 1.2 부서조회
	@GetMapping("/dept")
    public List<GroupDto> getDept(){
        return organizationService.getDept();
    }

	
	// 1.3 조직관리(관리자 전용)
	@GetMapping("/orgManager.page")
	public String deptManager() {
		return "organization/orgManager";
	}

}
