package com.br.project.controller.pay;




import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.controller.common.CommonController;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.dto.pay.MemberDeptDto;
import com.br.project.dto.pay.PayDto;
import com.br.project.service.pay.PayService;
import com.br.project.util.FileUtil;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/pay")
@RequiredArgsConstructor
@Controller
public class PayController {
	
	private final PayService payService;
	private final PagingUtil pagingUtil;
	private final FileUtil fileUtil;
	
	
	//결재메인페이지
	
	@RequestMapping(value="/paymain.page")
	public String paymainPage(@RequestParam(value="page", defaultValue="1") int currentPage, 
							   Model model, HttpSession session, RedirectAttributes redirectAttributes) {
		//개시글총갯수
		int listCount = payService.selectListCount();
		
		
		//페이지인포객체 생성
		PageInfoDto pi =  pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		//회원정보조회용
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("userNo", userNo);
		List<MemberDeptDto> member = payService.selectloginUserDept(mapUserMember);
		
		List<PayDto> list = payService.paymainPage(pi);
		
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payService.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payService.successListCount(userName);
		// 로그인한 사용자의 전체수신갯수
		int ulistCount = payService.allUserCount(userName);
		
		
		log.debug("member : {} ", member);
		log.debug("member.get(0) : {}", member.get(0));
		log.debug("member.get(0) : {}", member.get(0).getPositionName());
		if(member.get(0).getPositionName().equals("차장") || 
		   member.get(0).getPositionName().equals("부장") ||
		   member.get(0).getPositionName().equals("과장")) {
			
			model.addAttribute("list", list);
			model.addAttribute("pi", pi);
			model.addAttribute("listCount", String.valueOf(listCount));		
			model.addAttribute("mdCount", String.valueOf(mdCount));
			model.addAttribute("slistCount", String.valueOf(slistCount));
			model.addAttribute("ulistCount", String.valueOf(ulistCount));
			model.addAttribute("userName", userName);	
			model.addAttribute("paymain", "paymain");
			
			return "pay/paymain";
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "관리자직급만 이용할 수 있는 메뉴입니다.");
			return "redirect:/";
		}
		
	}
	
	//결재메인페이지카테고리&검색---------------------
	@GetMapping("/search.do")
	public ModelAndView searchList(@RequestParam Map<String, String> search
								 , @RequestParam(value="page", defaultValue="1") int currentPage
								 , ModelAndView mv, HttpSession session) {
		
		//회원정보조회용
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		//개시글총갯수
		int listCount = payService.selectListCount();
		
		//검색한갯수조회
		int searchlistCount = payService.searchListCount(search);
		//페이지
		PageInfoDto pi = pagingUtil.getPageInfoDto(searchlistCount, currentPage, 5, 10);
		//리스트
		List<PayDto> list = payService.searchList(pi, search);
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payService.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payService.successListCount(userName);
		// 로그인한 사용자의 전체수신갯수
		int ulistCount = payService.allUserCount(userName);

		
		mv.addObject("list", list)
		  .addObject("pi", pi)
		  .addObject("search", search)
		  .addObject("searchlistCount", searchlistCount)
		  .addObject("listCount", String.valueOf(listCount))		  
		  .addObject("mdCount", String.valueOf(mdCount))
		  .addObject("slistCount", String.valueOf(slistCount))
		  .addObject("ulistCount", String.valueOf(ulistCount))
		  .addObject("userName", userName)
		  .setViewName("pay/paymain");
		
		
		return mv;
		
	}
	//----------------------------------------
	
	@RequestMapping(value="/selectList.do")
	public String selectList(HttpServletRequest request,
			 @RequestParam (value="page", defaultValue="1") int currentPage
						, Model model, HttpSession session) {
		
		//회원정보조회용
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params = CommonController.getParameterMap(request);
		log.debug(request.toString());
		//(카테고리별)페이지갯수
		int clistCount = payService.slistCount(params);
	
		//페이지
		PageInfoDto pi =  pagingUtil.getPageInfoDto(clistCount, currentPage, 5, 10);
		//리스트
		List<PayDto> list = payService.categoryList(params, pi);
		
		//개시글총갯수
		int listCount = payService.selectListCount();
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payService.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payService.successListCount(userName);
		// 로그인한 사용자의 전체수신갯수
		int ulistCount = payService.allUserCount(userName);

		
		model.addAttribute("clistCount", clistCount);
		model.addAttribute("params", params);
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		model.addAttribute("userName", userName);
		
		return "pay/paymain";
		
	}
	
	// 메인결재 상세페이지목록클릭-----------------------
	@RequestMapping("/detail.do")
	public String detail(@RequestParam Map<String, Object> map, Model model
						, HttpSession session) {
		
		//회원정보조회용
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		log.debug("map : {}", map);
		if(map != null && !map.isEmpty() && map.get("documentType").equals("매출보고서")) {
			List<Map<String, Object>> list = payService.expendDetail(map);
			model.addAttribute("list", list);
			model.addAttribute("userNo", userNo);
			model.addAttribute("userName", String.valueOf(userName));
			return "pay/expendDetail";
		}else if(map != null && !map.isEmpty() && map.get("documentType").equals("기안서")){
			map.put("refType", "PG");
			List<Map<String, Object>> list = payService.salesDetail(map);
			model.addAttribute("list", list);
			model.addAttribute("userNo", userNo);
			model.addAttribute("userName", userName);
			return "pay/salesDetail";
		}else if(map != null && !map.isEmpty() && map.get("documentType").equals("비품신청서")) {
			List<Map<String, Object>> list = payService.fixDetail(map);
			model.addAttribute("list", list);
			model.addAttribute("userNo", userNo);
			model.addAttribute("userName", userName);
			return "pay/fixDetail";
		}else if(map != null && !map.isEmpty() && map.get("documentType").equals("휴직신청서")) {
			List<Map<String, Object>> list = payService.retireDetail(map);
			model.addAttribute("list", list);
			model.addAttribute("userNo", userNo);
			model.addAttribute("userName", userName);
			return "pay/retireDetail";
		}else if(map != null && !map.isEmpty() && map.get("documentType").equals("지출결의서")) {
			List<Map<String, Object>> list = payService.draftDetail(map);
			map.put("refType", "PJ");
			List<Map<String, Object>> fileList = payService.fileDraftDetail(map);
			model.addAttribute("list", list);
			model.addAttribute("fileList", fileList);
			model.addAttribute("userNo", userNo);
			model.addAttribute("userName", userName);
			return "pay/draftDetail";
		}
		
		return "";
		
		/*
		}else if(documentType.equals("지출결의서")){
			PayDto payDto = payServiceImpl.jdetail(pDto);
			model.addAttribute("payDto", payDto);
			return "pay/jdetail";
		}else if(documentType.equals("기안서")){
			PayDto payDto = payServiceImpl.gdetail(pDto);
			model.addAttribute("payDto", payDto);
			return "pay/gdetail";
		}else if(documentType.equals("휴가신청서")){
			PayDto payDto = payServiceImpl.vdetail(pDto);
			model.addAttribute("payDto", payDto);
			return "pay/vdetail";
		}else if(documentType.equals("휴직신청서")){
			PayDto payDto = payServiceImpl.hdetail(pDto);
			model.addAttribute("payDto", payDto);
			return "pay/hdetail";
		}else{ //출장보고서
			PayDto payDto = payServiceImpl.cdetail(pDto);
			model.addAttribute("payDto", payDto);
			return "pay/cdetail";
		}
		*/
		
	}
	
	//메인페이지 로그인한 유저의 전체결재 수신함--------------------------
	@GetMapping("/allUserlist.do")
	public String allUserlist(@RequestParam (value="page", defaultValue="1") int currentPage
								,HttpSession session, Model model) {
		
		
		// userName
		//회원정보조회용
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		
		log.debug("userName : {}", userName);
		
		//로그인한 유저 승인자결재함목록갯수
		int ulistCount = payService.allUserCount(userName);
		log.debug("ulistCount : {}", ulistCount);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(ulistCount, currentPage, 5, 10);
		
		//로그인한 유저 승인자결재함목록리스트
		List<PayDto> list = payService.allUserList(userName, pi);
		
		//개시글총갯수
		int listCount = payService.selectListCount();
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payService.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payService.successListCount(userName);
		
		log.debug("list : {}", list);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		model.addAttribute("userName", userName);
		model.addAttribute("userAllList", "userAllList");
		
		return "pay/paymain";
		
	}
	//-------------------------------------------------------
	
	
	//글작성페이지폼-------------------------------------------
	@RequestMapping("/writerForm.page")
	public String mWriterForm(Model model, HttpSession session, String writer) {
		
		//로그인한 유저의 팀이름 + 부서 + 직급
		//회원정보조회용
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("userNo", userNo);
		List<MemberDeptDto> member = payService.selectloginUserDept(mapUserMember);
		
		
		List<MemberDeptDto> teamList = payService.selectDepartment();
		List<Map<String, Object>> maDeptList = new ArrayList<>();
		List<Map<String, Object>> operatDeptList = new ArrayList<>();
		List<Map<String, Object>> marketDeptList = new ArrayList<>();
		List<Map<String, Object>> fbDeptList = new ArrayList<>();
		List<Map<String, Object>> hrDeptList = new ArrayList<>();
		List<Map<String, Object>> serviceDeptList = new ArrayList<>();
		
		
		
		//팀명
		List<Map<String, Object>> teamNames = payService.teamNameList();
		
		// 총무부의 이름, 팀이름, 직급(부장,과장,차장)
		
		for(int i=0; i<teamList.size(); i++) {
			Map<String, Object> managementDept = new HashMap<>();;
			if(teamList.get(i).getDeptName().equals("총무부")) {
				managementDept.put("userNo", teamList.get(i).getUserNo());
				managementDept.put("userName", teamList.get(i).getUserName());
				managementDept.put("teamName", teamList.get(i).getTeamName());
				managementDept.put("positionName", teamList.get(i).getPositionName());
				managementDept.put("deptName", teamList.get(i).getDeptName());
				maDeptList.add(managementDept);
			}
		}
		
		// 운영부의 이름, 팀이름, 직급(부장,과장,차장)
		
		
		for(int i=0; i<teamList.size(); i++) {
			if(teamList.get(i).getDeptName().equals("운영부")) {
				Map<String, Object> operationsDept = new HashMap<>();
				operationsDept.put("userNo", teamList.get(i).getUserNo());
				operationsDept.put("userName", teamList.get(i).getUserName());
				operationsDept.put("teamName", teamList.get(i).getTeamName());
				operationsDept.put("positionName", teamList.get(i).getPositionName());
				operationsDept.put("deptName", teamList.get(i).getDeptName());
				operatDeptList.add(operationsDept);
				
			}
		}
		
		// 마케팅부의 이름, 팀이름, 직급(부장,과장,차장)
		
		
		for(int i=0; i<teamList.size(); i++) {
			if(teamList.get(i).getDeptName().equals("마케팅부")) {
				Map<String, Object> marketingDept = new HashMap<>();
				marketingDept.put("userNo", teamList.get(i).getUserNo());
				marketingDept.put("userName", teamList.get(i).getUserName());
				marketingDept.put("teamName", teamList.get(i).getTeamName());
				marketingDept.put("positionName", teamList.get(i).getPositionName());
				marketingDept.put("deptName", teamList.get(i).getDeptName());
				marketDeptList.add(marketingDept);
			}
		}
		
		// fb(호텔 운영부)의 이름, 팀이름, 직급(부장,과장,차장)
		for(int i=0; i<teamList.size(); i++) {
			if(teamList.get(i).getDeptName().equals("FB")) {
				Map<String, Object> fbDept = new HashMap<>();
				fbDept.put("userNo", teamList.get(i).getUserNo());
				fbDept.put("userName", teamList.get(i).getUserName());
				fbDept.put("teamName", teamList.get(i).getTeamName());
				fbDept.put("positionName", teamList.get(i).getPositionName());
				fbDept.put("deptName", teamList.get(i).getDeptName());
				fbDeptList.add(fbDept);
			}
		}
		
		
		// 인사부의 이름, 팀이름, 직급(부장,과장,차장)
		for(int i=0; i<teamList.size(); i++) {
			if(teamList.get(i).getDeptName().equals("인사부")) {
				Map<String, Object> hrDept = new HashMap<>();
				hrDept.put("userNo", teamList.get(i).getUserNo());
				hrDept.put("userName", teamList.get(i).getUserName());
				hrDept.put("teamName", teamList.get(i).getTeamName());
				hrDept.put("positionName", teamList.get(i).getPositionName());
				hrDept.put("deptName", teamList.get(i).getDeptName());
				hrDeptList.add(hrDept);
			}
		}
		
		// 서비스부의 이름, 팀이름, 직급(부장,과장,차장)
		for(int i=0; i<teamList.size(); i++) {
			if(teamList.get(i).getDeptName().equals("서비스부")) {
				Map<String, Object> serviceDept = new HashMap<>();
				serviceDept.put("userNo", teamList.get(i).getUserNo());
				serviceDept.put("userName", teamList.get(i).getUserName());
				serviceDept.put("teamName", teamList.get(i).getTeamName());
				serviceDept.put("positionName", teamList.get(i).getPositionName());
				serviceDept.put("deptName", teamList.get(i).getDeptName());
				serviceDeptList.add(serviceDept);
			}
		}
		
		if(writer.equals("g")) {
			model.addAttribute("maDeptList", maDeptList);
			model.addAttribute("operatDeptList", operatDeptList);
			model.addAttribute("marketDeptList", marketDeptList);
			model.addAttribute("fbDeptList", fbDeptList);
			model.addAttribute("hrDeptList", hrDeptList);
			model.addAttribute("serviceDeptList", serviceDeptList);
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			return "pay/gWriterForm";
			
		}else if(writer.equals("m")) {
			model.addAttribute("maDeptList", maDeptList);
			model.addAttribute("operatDeptList", operatDeptList);
			model.addAttribute("marketDeptList", marketDeptList);
			model.addAttribute("fbDeptList", fbDeptList);
			model.addAttribute("hrDeptList", hrDeptList);
			model.addAttribute("serviceDeptList", serviceDeptList);
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			model.addAttribute("teamNames", teamNames);
			
			return "pay/mWriterForm";
			
		}else if(writer.equals("b")) {
			model.addAttribute("maDeptList", maDeptList);
			model.addAttribute("operatDeptList", operatDeptList);
			model.addAttribute("marketDeptList", marketDeptList);
			model.addAttribute("fbDeptList", fbDeptList);
			model.addAttribute("hrDeptList", hrDeptList);
			model.addAttribute("serviceDeptList", serviceDeptList);
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			
			return "pay/bWriterForm";
			
		}else if(writer.equals("j")) {
			model.addAttribute("maDeptList", maDeptList);
			model.addAttribute("operatDeptList", operatDeptList);
			model.addAttribute("marketDeptList", marketDeptList);
			model.addAttribute("fbDeptList", fbDeptList);
			model.addAttribute("hrDeptList", hrDeptList);
			model.addAttribute("serviceDeptList", serviceDeptList);
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			
			return "pay/jWriterForm";
			
		}else if(writer.equals("h")) {
			model.addAttribute("maDeptList", maDeptList);
			model.addAttribute("operatDeptList", operatDeptList);
			model.addAttribute("marketDeptList", marketDeptList);
			model.addAttribute("fbDeptList", fbDeptList);
			model.addAttribute("hrDeptList", hrDeptList);
			model.addAttribute("serviceDeptList", serviceDeptList);
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			
			return "pay/hWriterForm";
		}
		
		return "pay/bWriterForm";
		
		
		
	}
	//----------------------------------------------------
	
	//---------매출 보고서 ----------------------
	@PostMapping("/mReportInsert.do")
	public String mReportInsert(@RequestParam Map<String, Object> map
							  , HttpSession session, RedirectAttributes redirectAttributes) {
		//map =>최초/중간/최종 승인자의 이름, 매출구분, 담당자, 총매출 금액이 담겨있음
		log.debug("{}", map.get("items"));
		
		// 품목, 수량, 매출금액이 담긴 리스트
		List<Map<String, Object>> list = new ArrayList<>();
		
		String[] itemsArr = ((String)map.get("items")).split(",");
		String[] countArr = ((String)map.get("counts")).split(",");
		String[] salesArr = ((String)map.get("salesAmounts")).split(",");
		
		for(int i=0; i<itemsArr.length; i++) {
			Map<String, Object> maps = new HashMap<>();
			maps.put("items", itemsArr[i]);
			maps.put("counts", countArr[i]);
			maps.put("salesAmounts", salesArr[i]);
			list.add(maps);
		}
		log.debug("list : {}", list);
		int writerNo = ((MemberDto)session.getAttribute("loginMember")).getUserNo();
		map.put("writerNo", writerNo);
		
		int result = payService.mReportInsert(map, list);
		
		
		if(result == list.size()) {
			redirectAttributes.addFlashAttribute("alertTitle", "게시글등록");
			redirectAttributes.addFlashAttribute("alertMsg", "등록이 성공적으로 완료되었습니다.");
		}
		
		
		return "redirect:/pay/paymain.page";
	}
	
	@RequestMapping("/reject.do")
	public String reject(@RequestParam Map<String, Object> map, HttpSession session) {
		
		int result = payService.updateReject(map);
		
		if(result == 1) {
			session.setAttribute("alertMsg", "성공적으로 제출이 완료되었습니다.");
		}
		
		return "pay/paymain"; 
		
	}
	
	
	@RequestMapping("/modify.do")
	public String mModify(@RequestParam Map<String, Object> map, Model model
						  , HttpSession session) {
		
		//기존에 작성된 데이터값들
		//매출
		List<Map<String, Object>> listM = payService.expendModify(map);
		//지출
		List<Map<String, Object>> listJ = payService.draftModify(map);
		//휴직
		List<Map<String, Object>> listH = payService.retireModify(map);
		//비품
		List<Map<String, Object>> listB = payService.fixDetail(map);
		//-------------------------------------
		
		//로그인한 유저의 팀이름, 부서, 팀명, 직급
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("userNo", userNo);
		List<MemberDeptDto> member = payService.selectloginUserDept(mapUserMember);
		//---------------------------
		
		
		//-----전체 팀이름, 부서, 팀명, 직급 (부장,차장,과장)--------
		List<MemberDeptDto> teamList = payService.selectDepartment(); 
		
		// 위에 데이터값을 가지고 부서로 따로 나눔
		List<Map<String, Object>> maDeptList = new ArrayList<>();
		List<Map<String, Object>> operatDeptList = new ArrayList<>();
		List<Map<String, Object>> marketDeptList = new ArrayList<>();
		List<Map<String, Object>> fbDeptList = new ArrayList<>();
		List<Map<String, Object>> hrDeptList = new ArrayList<>();
		List<Map<String, Object>> serviceDeptList = new ArrayList<>();
		
		
		
		// 총무부의 이름, 팀이름, 직급(부장,과장,차장)
		
		for(int i=0; i<teamList.size(); i++) {
			Map<String, Object> managementDept = new HashMap<>();;
			if(teamList.get(i).getDeptName().equals("총무부")) {
				managementDept.put("userNo", teamList.get(i).getUserNo());
				managementDept.put("userName", teamList.get(i).getUserName());
				managementDept.put("teamName", teamList.get(i).getTeamName());
				managementDept.put("positionName", teamList.get(i).getPositionName());
				managementDept.put("deptName", teamList.get(i).getDeptName());
				maDeptList.add(managementDept);
			}
		}
		
		// 운영부의 이름, 팀이름, 직급(부장,과장,차장)
		
		
		for(int i=0; i<teamList.size(); i++) {
			if(teamList.get(i).getDeptName().equals("운영부")) {
				Map<String, Object> operationsDept = new HashMap<>();
				operationsDept.put("userNo", teamList.get(i).getUserNo());
				operationsDept.put("userName", teamList.get(i).getUserName());
				operationsDept.put("teamName", teamList.get(i).getTeamName());
				operationsDept.put("positionName", teamList.get(i).getPositionName());
				operationsDept.put("deptName", teamList.get(i).getDeptName());
				operatDeptList.add(operationsDept);
				
			}
		}
		
		// 마케팅부의 이름, 팀이름, 직급(부장,과장,차장)
		
		
		for(int i=0; i<teamList.size(); i++) {
			if(teamList.get(i).getDeptName().equals("마케팅부")) {
				Map<String, Object> marketingDept = new HashMap<>();
				marketingDept.put("userNo", teamList.get(i).getUserNo());
				marketingDept.put("userName", teamList.get(i).getUserName());
				marketingDept.put("teamName", teamList.get(i).getTeamName());
				marketingDept.put("positionName", teamList.get(i).getPositionName());
				marketingDept.put("deptName", teamList.get(i).getDeptName());
				marketDeptList.add(marketingDept);
			}
		}
		
		// fb(호텔 운영부)의 이름, 팀이름, 직급(부장,과장,차장)
		for(int i=0; i<teamList.size(); i++) {
			if(teamList.get(i).getDeptName().equals("FB")) {
				Map<String, Object> fbDept = new HashMap<>();
				fbDept.put("userNo", teamList.get(i).getUserNo());
				fbDept.put("userName", teamList.get(i).getUserName());
				fbDept.put("teamName", teamList.get(i).getTeamName());
				fbDept.put("positionName", teamList.get(i).getPositionName());
				fbDept.put("deptName", teamList.get(i).getDeptName());
				fbDeptList.add(fbDept);
			}
		}
		
		
		// 인사부의 이름, 팀이름, 직급(부장,과장,차장)
		for(int i=0; i<teamList.size(); i++) {
			if(teamList.get(i).getDeptName().equals("인사부")) {
				Map<String, Object> hrDept = new HashMap<>();
				hrDept.put("userNo", teamList.get(i).getUserNo());
				hrDept.put("userName", teamList.get(i).getUserName());
				hrDept.put("teamName", teamList.get(i).getTeamName());
				hrDept.put("positionName", teamList.get(i).getPositionName());
				hrDept.put("deptName", teamList.get(i).getDeptName());
				hrDeptList.add(hrDept);
			}
		}
		
		// 서비스부의 이름, 팀이름, 직급(부장,과장,차장)
		for(int i=0; i<teamList.size(); i++) {
			if(teamList.get(i).getDeptName().equals("서비스부")) {
				Map<String, Object> serviceDept = new HashMap<>();
				serviceDept.put("userNo", teamList.get(i).getUserNo());
				serviceDept.put("userName", teamList.get(i).getUserName());
				serviceDept.put("teamName", teamList.get(i).getTeamName());
				serviceDept.put("positionName", teamList.get(i).getPositionName());
				serviceDept.put("deptName", teamList.get(i).getDeptName());
				serviceDeptList.add(serviceDept);
			}
		}
		
		
		
		if(map.get("report").equals("m")) {
			model.addAttribute("maDeptList", maDeptList);
			model.addAttribute("operatDeptList", operatDeptList);
			model.addAttribute("marketDeptList", marketDeptList);
			model.addAttribute("fbDeptList", fbDeptList);
			model.addAttribute("hrDeptList", hrDeptList);
			model.addAttribute("serviceDeptList", serviceDeptList);
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			//-------------------------------------
			model.addAttribute("list", listM);
			
			return "pay/mWriterForm";
			
		}else if(map.get("report").equals("j")){
			map.put("refType", "PJ");
			List<Map<String, Object>> fileList = payService.fileDraftDetail(map);
			model.addAttribute("maDeptList", maDeptList);
			model.addAttribute("operatDeptList", operatDeptList);
			model.addAttribute("marketDeptList", marketDeptList);
			model.addAttribute("fbDeptList", fbDeptList);
			model.addAttribute("hrDeptList", hrDeptList);
			model.addAttribute("serviceDeptList", serviceDeptList);
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			//-------------------------------------
			model.addAttribute("list", listJ);
			model.addAttribute("fileList", fileList);
			
			return "pay/jModifyForm";
		}else if(map.get("report").equals("h")){
			map.put("refType", "PJ");
			List<Map<String, Object>> fileList = payService.fileDraftDetail(map);
			model.addAttribute("maDeptList", maDeptList);
			model.addAttribute("operatDeptList", operatDeptList);
			model.addAttribute("marketDeptList", marketDeptList);
			model.addAttribute("fbDeptList", fbDeptList);
			model.addAttribute("hrDeptList", hrDeptList);
			model.addAttribute("serviceDeptList", serviceDeptList);
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			//-------------------------------------
			model.addAttribute("list", listH);
			
			return "pay/hModifyForm";
		}else if(map.get("report").equals("b")){
			map.put("refType", "PJ");
			List<Map<String, Object>> fileList = payService.fileDraftDetail(map);
			model.addAttribute("maDeptList", maDeptList);
			model.addAttribute("operatDeptList", operatDeptList);
			model.addAttribute("marketDeptList", marketDeptList);
			model.addAttribute("fbDeptList", fbDeptList);
			model.addAttribute("hrDeptList", hrDeptList);
			model.addAttribute("serviceDeptList", serviceDeptList);
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			//-------------------------------------
			model.addAttribute("list", listB);
			
			return "pay/bModifyForm";
		}
		
		
		
		return "pay/mWriterForm";
		
	}
	
	//로그인한 사용자 전체수신결재함
	@RequestMapping("/userSelectList.do")
	public String userSelectList(@RequestParam (value="page", defaultValue="1") int currenPage
								, Model model, @RequestParam Map<String, Object> map
								, HttpSession session) {
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		
		map.put("userName", userName);
		int userSelectListCount = payService.userSelectListCount(map);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(userSelectListCount, currenPage, 5, 10);
		
		List<PayDto> list = payService.userSelectList(map, pi);
		
		
		//개시글총갯수
		int listCount = payService.selectListCount();
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payService.moreDateCount(userName);
		int ulistCount = payService.allUserCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payService.successListCount(userName);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		model.addAttribute("map", map);
		model.addAttribute("userName", userName);
		model.addAttribute("userAllListSelect", "userAllListSelect");
		
		
		
		return "pay/paymain";
	}
	//로그인한 사용자 전체수신결재함 - 검색
	@GetMapping("/userSearch.do")
	public String userSearch(@RequestParam Map<String, Object> map, @RequestParam (value="page", defaultValue="1") int currentPage
							, Model model, HttpSession session) {
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		map.put("userName", userName);
		
		//총갯수
		int userSearchCount = payService.userSearchCount(map);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(userSearchCount, currentPage, 5, 10);
		
		List<PayDto> list = payService.userSearchList(map, pi);
		
		//개시글총갯수
		int listCount = payService.selectListCount();
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payService.moreDateCount(userName);
		int ulistCount = payService.allUserCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payService.successListCount(userName);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		model.addAttribute("map", map);
		model.addAttribute("userName", userName);
		model.addAttribute("userSearchList", "userSearchList");
		
		return "pay/paymain";
		
		
	}
	
	
	@PostMapping("/mReportUpdate.do")
	public String mReportUpdate(@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes) {
		
		List<Map<String, Object>> list = new ArrayList<>();
		map.put("totalSales", map.get("totalSales").toString().replace(",", ""));
		
		
		
		String expendNo = (String) map.get("expendNo");
		log.debug("map : {}", map);
		
		for(int i=0; i<map.size(); i++) {
			if(map.get("item" + i ) != null && !map.get("item" + i).toString().equals("")) {
				Map<String, Object> nameMap = new HashMap<>();
				nameMap.put("expendNo", expendNo);
				nameMap.put("item", map.get("item" + i));
				nameMap.put("count", map.get("count" + i));
				nameMap.put("salesAmount", map.get("sales" + i));
				list.add(nameMap);
			}
		}
		
		if(map.get("items") != null && !map.get("items").toString().equals("")) {
			
			String[] items = ((String)map.get("items")).split(",");
			String[] counts = ((String)map.get("counts")).split(",");
			String[] sales = ((String)map.get("salesAmounts")).split(",");
			
			for(int i=0; i<items.length; i++) {
				Map<String, Object> splitMap = new HashMap<>();
				splitMap.put("expendNo", expendNo);
				splitMap.put("item", items[i]);
				splitMap.put("count", counts[i]);
				splitMap.put("salesAmount", sales[i]);
				list.add(splitMap);
			}
		}
		
		for(int i = 0; i < list.size(); i++) {
			log.debug("list : {}", list.get(i));
		}
		
		int newlist = payService.mReportUpdate(map, list);
		
		if(newlist == list.size()) {
			redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 수정되었습니다.");
		}
	
		
		
		return "redirect:/pay/paymain.page";
		
	}
	
	
	
	@PostMapping("/gReportInsert.do")
	public String gReportInsert(@RequestParam Map<String, Object> map, List<MultipartFile> uploadFiles
								, RedirectAttributes redirectAttributes) {
		
		
		List<Map<String, Object>> attachList = new ArrayList<>();
		
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> fileMap = fileUtil.fileUpload(uploadFile, "approval");
				Map<String, Object> file = new HashMap<>();
				file.put("filePath", fileMap.get("filePath"));
				file.put("filesystemName", fileMap.get("filesystemName"));
				file.put("originalName", fileMap.get("originalName"));
				file.put("RefType", "PG");
				attachList.add(file);
			}
		}
		log.debug("map : {}", map);
		
		if(attachList != null && !attachList.isEmpty()) {
			map.put("fileStatus", "Y");			
		}else {
			map.put("fileStatus", "N");
		}
		
		int result = payService.gReportInsert(map, attachList);
		
		redirectAttributes.addFlashAttribute("alertTitle", "결재 등록 서비스");
		if(attachList.isEmpty() && result == 1 || !attachList.isEmpty() && result == attachList.size()) {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록에 성공하였습니다.");
		}else {
			for(Map<String, Object> at : attachList) {
				new File(at.get("filePath") + "/" + at.get("filesystemName")).delete();			
			}
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("historyBackYN", "Y");
		}
		
		
		return "redirect:/pay/paymain.page";
		
		
	}
	
	//로그인한 사용자의 승인완료된 수신함
	@GetMapping("/approvedList.do")
	public String ApprovedList(HttpSession session, @RequestParam (value="page", defaultValue="1") int currntPage
									, Model model){
		
		//회원정보조회용
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		//로그인한 사용자가 승인완료한 갯수
		int slistCount = payService.successListCount(userName);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(slistCount, slistCount, 5, 10);
		
		List<PayDto> list = payService.ApprovedList(pi, userName);
		
		//개시글총갯수
		int listCount = payService.selectListCount();
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payService.moreDateCount(userName);
		int ulistCount = payService.allUserCount(userName);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		model.addAttribute("userName", userName);
		model.addAttribute("userSuccessList", "userSuccessList");
		
		return "pay/paymain";
		
	}
	
	
	@PostMapping("/bReportInsert.do")
	public String bReportInsert(@RequestParam Map<String, Object> map, Model model
							  , RedirectAttributes redirectAttributes) {
		
		// 품목, 규격, 수량, 단가, 가격, 기타 
		List<Map<String, Object>> list = new ArrayList<>();
		for(int i=0; i<map.size(); i++) {
			if(map.get("pName" + i) != null && !map.get("pName" + i).toString().equals("")) {
				Map<String, Object> mapName = new HashMap<>();
				mapName.put("pName", map.get("pName" + i));
				mapName.put("size", map.get("size" + i));
				mapName.put("amount", map.get("amount" + i));
				mapName.put("unitPrice", map.get("unitprice" + i));
				mapName.put("price", map.get("price" + i));
				mapName.put("etc", map.get("etc" + i));
				list.add(mapName);
			}
			
		}
		
		int result = payService.bReportInsert(map, list);
		redirectAttributes.addFlashAttribute("alertTitle", "비품신청서");
		if(result == list.size()) {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록에 성공하였습니다.");
		}
		
		return "redirect:/pay/paymain.page";
	}
	
	@PostMapping("/hReportInsert.do")
	public String hReportInsert(@RequestParam Map<String, Object> map
								, RedirectAttributes redirectAttributes){
		
		int result = payService.hReportInsert(map);
		
		redirectAttributes.addFlashAttribute("alertTitle", "휴가신청서");
		if(result == 2) {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록에 성공하였습니다.");
		}
		
		return "redirect:/pay/paymain.page";
	}
	
	@PostMapping("/jReportInsert.do")
	public String jReportInsert(@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes
								, List<MultipartFile> uploadFiles) {
		
		
		// 품목들 담기
		List<Map<String, Object>> itemList = new ArrayList<>();
		for(int i=0; i<map.size(); i++) {
			if(map.get("account" + i) != null && !map.get("account" + i).toString().equals("")) {
				Map<String, Object> itemMap = new HashMap<>();
				itemMap.put("account", map.get("account" + i));
				itemMap.put("usage", map.get("usage" + i));
				itemMap.put("price", map.get("price" + i));
				itemList.add(itemMap);
			}
		}
		
		//파일 담기
		List<Map<String, Object>> attachList = new ArrayList<>();
		
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> file = fileUtil.fileUpload(uploadFile, "approval"); 
				Map<String, Object> fileMap = new HashMap<>();
				fileMap.put("originalName", file.get("originalName"));
				fileMap.put("filesystemName", file.get("filesystemName"));
				fileMap.put("filePath", file.get("filePath"));
				fileMap.put("RefType", "PJ");
				attachList.add(fileMap);
			}
		}
		
		if(attachList != null && !attachList.isEmpty()) {
			map.put("fileStatus", "Y");			
		}else {
			map.put("fileStatus", "N");
		}
		
		int result = payService.jReportInsert(map, itemList, attachList);
		log.debug("result : {}", result);
		log.debug("itemSize : {}", itemList.size());
		log.debug("attachSize : {}", attachList.size());
		
				
		redirectAttributes.addFlashAttribute("alertTitle", "지출결의서");
		if(result == itemList.size() && attachList.isEmpty() || result == attachList.size() * itemList.size() && !attachList.isEmpty()) {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글등록에 성공하였습니다.");
			
		}else {
			
			//게시글등록에 실패시 저장된 파일은 저장공간만 낭비되므로 삭제
			for(Map<String, Object> at : attachList) {
				new File( at.get("filePath") + "/" + at.get("filesystemName")).delete();
			}
			
			redirectAttributes.addFlashAttribute("alertMsg", "게시글등록에 실패하였습니다.");
			redirectAttributes.addFlashAttribute("historyBackYN", "Y");
		}
		
		
		return "redirect:/pay/paymain.page";
	}
	
	
	//............
	@PostMapping("/jReportUpdate.do")
	public String jReportUpdate(@RequestParam Map<String, Object> map, List<MultipartFile> uploadFiles
							  , RedirectAttributes redirectAttributes, String[] delFileNo) {
		
		//삭제된파일이 null값일 경우
		String[] delFileNoArr = (delFileNo != null) ? delFileNo : null;
		
		int delFileNoLeng = 0;
		if(delFileNoArr != null) { // 삭제된파일이 null이 아니라면 길이 알아내기
			delFileNoLeng = delFileNoArr.length;			
		}
		
		//기존파일의배열길이(삭제되기전)
		String fileLength = (String)map.get("fileLength");
		int fileLeng = Integer.parseInt(fileLength);

		String reportNo = (String)map.get("reportNo");
		
		log.debug(reportNo);
		
		//품목들
		List<Map<String, Object>> list = new ArrayList<>();
		for(int i=0; i<map.size(); i++) {
			if(map.get("account" + i) != null && !map.get("account" + i).toString().equals("")) {
				Map<String, Object> itemMap = new HashMap<>();			
				itemMap.put("reportNo", reportNo);
				itemMap.put("account", map.get("account" + i));
				itemMap.put("usage", map.get("account" + i));
				itemMap.put("price", map.get("price" + i));
				list.add(itemMap);
			}
		}
		
		//추가한 파일들
		List<Map<String, Object>> fileList = new ArrayList<>();
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> fileMap = fileUtil.fileUpload(uploadFile, "approval");
				Map<String, Object> file = new HashMap<>();
				file.put("filePath", fileMap.get("filePath"));
				file.put("filesystemName", fileMap.get("filesystemName"));
				file.put("originalName", fileMap.get("originalName"));
				file.put("RefType", "PJ");
				file.put("draftNo", map.get("draftNo"));
				fileList.add(file);
			}
		}
		
		if(fileLeng == delFileNoLeng && fileList.isEmpty()) {
			map.put("fileStatus", "N");
		}else {
			map.put("fileStatus", "Y");
		}
		
		int result = payService.jReportUpdate(map, list, fileList, delFileNo == null ? null : delFileNo);

		//log.debug("fileLength : {}", map.get("fileLength"));
		
		return "redirect:/pay/paymain.page";
		
		
	}
	
	@RequestMapping("/delayDateList.do")
	public String delayDateList(@RequestParam (value="page", defaultValue="1") int currentPage
												 , HttpSession session, Model model){
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		
		//일주일이상 처리가안된 목록갯수
		int mdCount = payService.moreDateCount(userName);
		PageInfoDto pi = pagingUtil.getPageInfoDto(mdCount, currentPage, 5, 10);
		
		List<PayDto> list = payService.delayDateList(userName, pi);
		
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payService.successListCount(userName);
		// 로그인한 사용자의 전체수신갯수
		int ulistCount = payService.allUserCount(userName);
		//개시글총갯수
		int listCount = payService.selectListCount();
		
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		model.addAttribute("userName", userName);	
		model.addAttribute("delayDate", "delayDate");
		
		return "pay/paymain";
		
	}
	
	
	@RequestMapping("/delayDateSelectList.do")
	public String delayDateSelectList(@RequestParam Map<String, Object> map, @RequestParam (value="page", defaultValue="1") int currentPage
							, Model model, HttpSession session) {
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		
		Map<String, Object> userMap = new HashMap<>();
		userMap.put("userName", userName);
		userMap.put("conditions", map.get("conditions"));
		userMap.put("status", map.get("status"));
		
		//일주일이상 처리가안된 목록갯수
		int moreDateSelectCount = payService.moreDateSelectCount(userMap);
		PageInfoDto pi = pagingUtil.getPageInfoDto(moreDateSelectCount, currentPage, 5, 10);
		
		List<PayDto> list = payService.delayDateSelectList(userMap, pi);
		
		int mdCount = payService.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payService.successListCount(userName);
		// 로그인한 사용자의 전체수신갯수
		int ulistCount = payService.allUserCount(userName);
		//개시글총갯수
		int listCount = payService.selectListCount();
		
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		model.addAttribute("userName", userName);
		model.addAttribute("map", map);
		model.addAttribute("delayDateSelect", "delayDateSelect");
		
		return "pay/paymain";
	}
	
	@RequestMapping("/delayDateSearch.do")
	public String delayDateSearch(@RequestParam Map<String, Object> map, @RequestParam (value="page", defaultValue="1") int currentPage
							, Model model, HttpSession session) {
		
		
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		
		Map<String, Object> userMap = new HashMap<>();
		userMap.put("userName", userName);
		userMap.put("condition", map.get("condition"));
		userMap.put("keyword", map.get("keyword"));;
		
		//일주일이상 처리가안된 목록갯수
		int moreDateSearchCount = payService.moreDateSearchCount(userMap);
		PageInfoDto pi = pagingUtil.getPageInfoDto(moreDateSearchCount, currentPage, 5, 10);
		
		List<PayDto> list = payService.delayDateSearchList(userMap, pi);
		
		int mdCount = payService.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payService.successListCount(userName);
		// 로그인한 사용자의 전체수신갯수
		int ulistCount = payService.allUserCount(userName);
		//개시글총갯수
		int listCount = payService.selectListCount();
		
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		model.addAttribute("userName", userName);
		model.addAttribute("map", map);
		model.addAttribute("delayDateSearch", "delayDateSearch");
		
		return "pay/paymain";
		
	}
	
	@PostMapping("/hReportUpdate.do")
	public String hReportUpdate(@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes) {
		
		int result = payService.hReportUpdate(map);
		
		redirectAttributes.addFlashAttribute("alertTitle", "휴직신청서");
		if(result == 2) {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 수정이 완료되었습니다.");
		}
		
		return "redirect:/pay/paymain.page";
	}
	
	@PostMapping("/bReportUpdate.do")
	public String bReportUpdate(@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes) {
		
		List<Map<String, Object>> itemList = new ArrayList<>();
		String reportNo = (String)map.get("reportNo");
		String reportType = (String)map.get("reportType");
		for(int i=0; i<map.size(); i++) {
			if(map.get("pName" + i) != null && !map.get("pName" + i).equals("")) {
				Map<String, Object> itemMap = new HashMap<>();
				itemMap.put("reportNo", reportNo);
				itemMap.put("reportType", reportType);
				itemMap.put("pName", map.get("pName" + i));
				itemMap.put("size", map.get("size" + i));
				itemMap.put("amount", map.get("amount" + i));
				itemMap.put("unitprice", map.get("unitprice" + i));
				itemMap.put("price", map.get("price" + i));
				itemMap.put("etc", map.get("etc" + i));
				itemList.add(itemMap);
			}
		}
		log.debug("itemList : {}", itemList);
		int result = payService.bReportUpdate(map, itemList);
		
		redirectAttributes.addFlashAttribute("alertTitle", "비품신청서");
		if(result == itemList.size()) {
			redirectAttributes.addFlashAttribute("alertMsg", "결재 수정이 완료되었습니다.");
		}
		
		return "redirect:/pay/paymain.page";
		
	}
	
	@ResponseBody
	@PostMapping("/ajaxSign.do")
	public int ajaxSign(@RequestParam Map<String, Object> map) {
		
		return payService.ajaxSign(map);
		
	}

	
	


}
