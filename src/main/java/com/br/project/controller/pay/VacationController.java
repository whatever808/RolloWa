package com.br.project.controller.pay;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.br.project.dto.common.AttachmentDto;
import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.dto.pay.VacationDto;
import com.br.project.service.common.department.DepartmentService;
import com.br.project.service.pay.VacationService;
import com.br.project.util.FileUtil;
import com.br.project.util.PagingUtil;

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
		int emp = ((MemberDto)session.getAttribute("loginMember")).getUserNo();
		vacation.setMember(MemberDto.builder().userNo(emp).build());
		
		HashMap<String, Object> fileInfo = new HashMap<>();
		fileInfo.put("category", "vacation_" + vacation.getGroup().getCode());
		fileInfo.put("refType", "VACT");
		fileInfo.put("refNo", null);
		fileInfo.put("status", "Y");
		
		Map<String, Object> map = new HashMap<>();
		map.put("vacation", vacation);
		List<AttachmentDto> uploadFile = new ArrayList<>();
		if(files != null && !files.isEmpty()) {			
			uploadFile = fileUtil.getAttachmentList(files, fileInfo);
			map.put("uploadFile", uploadFile);
		}
		
		int result = vactService.insertVacation(map);
		
		if(result<=0) {
			if(files != null && !files.isEmpty()) {
				for(AttachmentDto att : uploadFile) {
					new File(att.getAttachPath(), att.getModifyName()).delete();				
				}
			}
		}
		
		return result;
	}
	
	@ResponseBody
	@PostMapping(value="/request.ajax")
	public List<VacationDto> selectRequest(HttpSession session){
		int userNo = ((MemberDto)session.getAttribute("loginMember")).getUserNo();
		
		return vactService.selectRequest(userNo);
	}
	
	@ResponseBody
	@PostMapping(value="/requestUpdate.ajax")
	public int requestUpdate(VacationDto vacation, List<MultipartFile> files ,HttpSession session) {
		int userNo = ((MemberDto)session.getAttribute("loginMember")).getUserNo();
		vacation.setMember(MemberDto.builder().userNo(userNo).build());
		
		HashMap<String, Object> fileInfo = new HashMap<>();
		fileInfo.put("category", "vacation_" + vacation.getVacaGroupCode());
		fileInfo.put("refType", "VACT");
		fileInfo.put("refNo", vacation.getVacaNO());
		fileInfo.put("status", "Y");
		
		Map<String, Object> map = new HashMap<>();
		map.put("vacation", vacation);
		List<AttachmentDto> uploadFile = new ArrayList<>();
		
		if(files != null && !files.isEmpty()) {			
			uploadFile = fileUtil.getAttachmentList(files, fileInfo);
			map.put("uploadFile", uploadFile);
			
			String[] arr ={vacation.getVacaNO()};
			fileInfo.put("delBoardNoArr", arr);			
			List<AttachmentDto> list =  vactService.selectOriginAtt(fileInfo);
			
			if(uploadFile != null && !uploadFile.isEmpty()) {
				for(AttachmentDto att : list) {
					new File(att.getAttachPath(), att.getModifyName()).delete();				
					vactService.deleteRequest(att.getFileNo());
				}
			}
			
		}
		
		int result = vactService.requestUpdate(map);
		
		if(result <= 0) {
			
			if(uploadFile != null) {
				for(AttachmentDto att : uploadFile) {
					new File(att.getAttachPath(), att.getModifyName()).delete();				
				}
			}
		}
		return result;
	} 
	
	@PostMapping("/deleteRequest.ajax")
	@ResponseBody
	public int deleteRequest(String vacaNO) {
		int result = vactService.deleteRcequest(vacaNO);
		
		HashMap<String, Object> fileInfo = new HashMap<>();
		fileInfo.put("refType", "VACT");
		fileInfo.put("refNo", vacaNO);	
		String[] arr ={vacaNO};
		fileInfo.put("delBoardNoArr", arr);			
		List<AttachmentDto> list =  vactService.selectOriginAtt(fileInfo);
		
		if(list != null && !list.isEmpty()) {
			for(AttachmentDto att : list) {
				new File(att.getAttachPath(), att.getModifyName()).delete();				
				vactService.deleteRequest(att.getFileNo());
			}
		}
		
		return result;
	}
	
	@GetMapping("/complete.page")
	public void moveComplete(Model model) {
		Map<String, String> map = new HashMap<>();
		map.put("code", "VACT01");
		List<GroupDto> vactList = departService.selectDepartmentList(map);
		model.addAttribute("vactList", vactList);
	}
	
	@ResponseBody
	@PostMapping(value="/searchOld.ajax")
	public Map<String, Object> searchOld(@RequestParam(defaultValue = "1") int page
										, HttpSession session
										, VacationDto vacation){
		int userNo = ((MemberDto)session.getAttribute("loginMember")).getUserNo();
		vacation.setMember(MemberDto.builder().userNo(userNo).build());
		Map<String, Object> map = new HashMap<>();
		int listCount = vactService.selectVacarionCount(vacation.getMember().getUserNo());
		PageInfoDto paging = new PagingUtil().getPageInfoDto(listCount, page, 5, 5);
		List<VacationDto> list = vactService.searchOld(vacation);
		map.put("list", list);
		map.put("paging", paging);
		return map;
	}
	
	/**
	 * @param vacaNO
	 * @return
	 */
	@ResponseBody
	@PostMapping("/RRequest.ajax")
	public int RRequest(VacationDto vacation) {
		int result = vactService.RRequest(vacation);
		HashMap<String, Object> fileInfo = new HashMap<>();
		fileInfo.put("refType", "VACT");
		fileInfo.put("refNo", vacation.getVacaNO());	
		String[] arr ={vacation.getVacaNO()};
		fileInfo.put("delBoardNoArr", arr);			
		List<AttachmentDto> list =  vactService.selectOriginAtt(fileInfo);
		
		if(list != null && !list.isEmpty()) {
			for(AttachmentDto att : list) {
				new File(att.getAttachPath(), att.getModifyName()).delete();				
				vactService.deleteRequest(att.getFileNo());
			}
		}
		return result;
	}
}
