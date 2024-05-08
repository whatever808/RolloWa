package com.br.project.controller.organization;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import lombok.extern.slf4j.Slf4j;

// 1.1 조직도

@RequestMapping("/orginfo")
@Controller
@Slf4j
public class OrganizationInfoController {

	@GetMapping("/orgchart.page")
	public String orgchart() {
		return "organization/organizationChart";
	}
	
	@GetMapping("/empSearch.page")
	public String empSearch() {
		return "organization/empSearch";
	}

}
