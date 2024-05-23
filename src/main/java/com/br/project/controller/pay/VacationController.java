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
import org.springframework.web.multipart.MultipartFile;

import com.br.project.dto.common.AttachmentDto;
import com.br.project.dto.common.GroupDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.dto.pay.VacationDto;
import com.br.project.service.common.department.DepartmentService;
import com.br.project.service.pay.VacationService;
import com.br.project.util.FileUtil;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/vacation")
@RequiredArgsConstructor
public class VacationController {
	private final VacationService vactService;
	private final DepartmentService departService;
	private final FileUtil fileUtil;
	
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
	 * @author dpcks
	 * @param vacation
	 * @param files
	 * @param session
	 * @return
	 */
	@ResponseBody
	@PostMapping(value="/insertVact.do", produces="text/html; charset=utf-8")
	public int insertVacation(VacationDto vacation , List<MultipartFile> files, HttpSession session) {
//		int emp = ((MemberDto)session.getAttribute("loginMember")).getUserNo();
		int emp = 1050;
		vacation.setMember(MemberDto.builder().userNo(emp).build());
		
		HashMap<String, Object> fileInfo = new HashMap<>();
		fileInfo.put("category", "vacation_" + vacation.getGroup().getCode());
		fileInfo.put("refType", "VACT");
		fileInfo.put("refNo", null);
		fileInfo.put("status", "Y");
		
		Map<String, Object> map = new HashMap<>();
		map.put("vacation", vacation);
		
		if(files != null && !files.isEmpty()) {			
			List<AttachmentDto> uploadFile = fileUtil.getAttachmentList(files, fileInfo);
			map.put("uploadFile", uploadFile);
		}
		return vactService.insertVacation(map);
	}
	
	@ResponseBody
	@PostMapping(value="/request.ajax")
	public List<VacationDto> selectRequest(HttpSession session){
		//int userNo = ((MemberDto)session.getAttribute("loginMember")).getUserNo();
		int userNo = 1050;
		
		return vactService.selectRequest(userNo);
	}
	
	/*수정*/
	
	@GetMapping("/complete.page")
	public void moveComplete(Model model) {
		Map<String, String> map = new HashMap<>();
		map.put("code", "VACT01");
		List<GroupDto> vactList = departService.selectDepartmentList(map);
		model.addAttribute("vactList", vactList);
	}
	
}
