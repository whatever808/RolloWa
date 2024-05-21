package com.br.project.controller.pay;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.br.project.dto.common.GroupDto;
import com.br.project.dto.pay.VacationDto;
import com.br.project.service.common.department.DepartmentService;
import com.br.project.service.pay.VacationService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/vacation")
@RequiredArgsConstructor
public class VacationController {
	private final VacationService vactService;
	private final DepartmentService departService;
	
	/**
	 * 휴가 조회 및 신청을 할 수 있는 페이지
	 * @author 에찬
	 * @return 휴가 카테고리 와 휴가 현황을 반환 
	 */
	@GetMapping("/vacation.page")
	public void moveVacation(Model model) {
		Map<String, String> map = new HashMap<>();
		map.put("code", "VACT01");
		List<GroupDto> vactList = departService.selectDepartmentList(map);
		model.addAttribute("vactList", vactList);
	}
	
	/**
	 * 
	 */
	@ResponseBody
	@PostMapping("/insertVact.do")
	public void insertVacation(VacationDto vacation, HttpSession session) {
//		int emp = ((MemberDto)session.getAttribute("loginMember")).getUserNo();
		int emp = 1050;
		
		
		
	}
	
}
