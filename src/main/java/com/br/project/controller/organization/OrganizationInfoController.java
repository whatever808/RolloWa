package com.br.project.controller.organization;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

// 1. 조직안내

@RequestMapping("/orginfo")
@Controller
@Slf4j
public class OrganizationInfoController {

	// 1.1 조직도
	@GetMapping("/orgchart.page")
	public String orgchart() {
		return "organization/organizationChart";
	}
	
	// 1.2 직원검색
	@GetMapping("/empSearch.page")
	public String empSearch() {
		return "organization/empSearch";
	}
	
	// 1.3 조직관리(관리자 전용)

}
