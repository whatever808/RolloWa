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
import com.br.project.service.member.MemberService;
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
	private final MemberService memberService;

	/**
	 * 휴가 조회 및 신청을 할 수 있는 페이지
	 * 
	 * @author 에찬
	 * @return 휴가 카테고리 와 휴가 현황을 반환
	 */
	@GetMapping("/vacation.page")
	public void moveVacation(Model model, HttpSession session) {
		Map<String, String> map = new HashMap<>();
		map.put("code", "VACT01");
		List<GroupDto> vactList = departService.selectDepartmentList(map);

		MemberDto member = memberService.selectAnuual(((MemberDto) session.getAttribute("loginMember")).getUserNo());

		model.addAttribute("vactList", vactList);
		model.addAttribute("member", member);
	}

	/**
	 * @author dpcks
	 * @param vacation
	 * @param files
	 * @param session
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/insertVact.do")
	public int insertVacation(VacationDto vacation, List<MultipartFile> files, HttpSession session) {
		int emp = ((MemberDto) session.getAttribute("loginMember")).getUserNo();
		vacation.setMember(MemberDto.builder().userNo(emp).build());
		
		String upper = vactService.selectUpperMember(emp);
		vacation.setSignMember(upper);

		HashMap<String, Object> fileInfo = new HashMap<>();
		fileInfo.put("category", "vacation_" + vacation.getGroup().getCode());
		fileInfo.put("refType", "VACT");
		fileInfo.put("refNo", null);
		fileInfo.put("status", "Y");

		Map<String, Object> map = new HashMap<>();
		map.put("vacation", vacation);
		List<AttachmentDto> uploadFile = new ArrayList<>();
		if (files != null && !files.isEmpty()) {
			uploadFile = fileUtil.getAttachmentList(files, fileInfo);
			map.put("uploadFile", uploadFile);
		}

		int result = vactService.insertVacation(map);

		if (result <= 0) {
			if (files != null && !files.isEmpty()) {
				for (AttachmentDto att : uploadFile) {
					new File(att.getAttachPath(), att.getModifyName()).delete();
				}
			}
		}
		return result;
	}

	@ResponseBody
	@PostMapping(value = "/request.ajax")
	public List<VacationDto> selectRequest(HttpSession session) {
		int userNo = ((MemberDto) session.getAttribute("loginMember")).getUserNo();
		List<VacationDto> list = vactService.selectRequest(userNo);
		return vactService.selectRequest(userNo);
	}

	@ResponseBody
	@PostMapping(value = "/requestUpdate.ajax")
	public int requestUpdate(VacationDto vacation, List<MultipartFile> files, HttpSession session) {
		int userNo = ((MemberDto) session.getAttribute("loginMember")).getUserNo();
		vacation.setMember(MemberDto.builder().userNo(userNo).build());

		HashMap<String, Object> fileInfo = new HashMap<>();
		fileInfo.put("category", "vacation_" + vacation.getVacaGroupCode());
		fileInfo.put("refType", "VACT");
		fileInfo.put("refNo", vacation.getVacaNO());
		fileInfo.put("status", "Y");

		Map<String, Object> map = new HashMap<>();
		map.put("vacation", vacation);
		List<AttachmentDto> uploadFile = new ArrayList<>();

		if (files != null && !files.isEmpty()) {
			uploadFile = fileUtil.getAttachmentList(files, fileInfo);
			map.put("uploadFile", uploadFile);

			String[] arr = { vacation.getVacaNO() };
			fileInfo.put("delBoardNoArr", arr);
			List<AttachmentDto> list = vactService.selectOriginAtt(fileInfo);

			if (uploadFile != null && !uploadFile.isEmpty()) {
				for (AttachmentDto att : list) {
					new File(att.getAttachPath(), att.getModifyName()).delete();
					vactService.deleteRequest(att.getFileNo());
				}
			}

		}

		int result = vactService.requestUpdate(map);

		if (result <= 0) {

			if (uploadFile != null) {
				for (AttachmentDto att : uploadFile) {
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
		String[] arr = { vacaNO };
		fileInfo.put("delBoardNoArr", arr);
		List<AttachmentDto> list = vactService.selectOriginAtt(fileInfo);

		if (list != null && !list.isEmpty()) {
			for (AttachmentDto att : list) {
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
	@PostMapping(value = "/searchOld.ajax")
	public Map<String, Object> searchOld(@RequestParam(defaultValue = "1") int page, HttpSession session,
			VacationDto vacation) {
		int userNo = ((MemberDto) session.getAttribute("loginMember")).getUserNo();
		vacation.setMember(MemberDto.builder().userNo(userNo).build());
		Map<String, Object> map = new HashMap<>();
		int listCount = vactService.selectVacarionCount(vacation);
		PageInfoDto paging = new PagingUtil().getPageInfoDto(listCount, page, 5, 5);

		map.put("vacation", vacation);
		map.put("paging", paging);
		List<VacationDto> list = vactService.searchOld(map);

		map.put("list", list);
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
		String[] arr = { vacation.getVacaNO() };
		fileInfo.put("delBoardNoArr", arr);
		List<AttachmentDto> list = vactService.selectOriginAtt(fileInfo);

		if (list != null && !list.isEmpty()) {
			for (AttachmentDto att : list) {
				new File(att.getAttachPath(), att.getModifyName()).delete();
				vactService.deleteRequest(att.getFileNo());
			}
		}
		return result;
	}

	/**
	 * 현재 관리자에게 결재를 요청한 게시글을 페이징처리 후 조회
	 * 
	 * @param page
	 * @param session
	 * @param vacation
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/vacationRequest.ajax")
	public Map<String, Object> reQuest(@RequestParam(defaultValue = "1") int page, HttpSession session,
			VacationDto vacation) {
		int userNo = ((MemberDto) session.getAttribute("loginMember")).getUserNo();
		vacation.setMember(MemberDto.builder().userNo(userNo).build());
		Map<String, Object> map = new HashMap<>();
		int listCount = vactService.selectRefuseRequest(vacation);
		PageInfoDto paging = new PagingUtil().getPageInfoDto(listCount, page, 5, 5);

		map.put("vacation", vacation);
		map.put("paging", paging);
		List<VacationDto> list = vactService.searchreQuest(map);

		map.put("list", list);
		return map;
	}

	/**
	 * 휴가 신청및 철회 신청이 거절 될 경우
	 * 
	 * @param vacation
	 * @return
	 */
	@ResponseBody
	@PostMapping(value = "/singRefuse.ajax")
	public int singRefuse(VacationDto vacation) {
		int result = vactService.singRefuse(vacation);
		return result;
	}

	/**
	 * 휴가 신청및 철회 신청이 승인 될 경우
	 * 
	 * @param vacation
	 * @return
	 */
	@ResponseBody
	@PostMapping(value ="/singConfirm.ajax")
	public int singConfirm(VacationDto vacation, String status) {
		int result = vactService.singConfirm(vacation);
		int outcome = 0;
		if (result > 0) {
			if(status.equals("false")) {
				//false
				outcome = vactService.requestRefuse(vacation);
				outcome *= vactService.vacationExpire(vacation);
			}else {
				//true
				outcome = vactService.requestConfine(vacation);
			}
		}
		return result * outcome;
	}

}
