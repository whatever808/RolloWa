package com.br.project.controller.pay;




import java.io.File;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
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
import com.br.project.dto.pay.SignDto;
import com.br.project.service.pay.PayService;
import com.br.project.util.FileUtil;
import com.br.project.util.PagingUtil;
import com.google.common.collect.Maps;

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
	
	@RequestMapping(value="/approvalMain.page")
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
		log.debug("memberDpt : {}", member);
		List<PayDto> list = payService.paymainPage(pi);
		
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payService.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payService.successListCount(userName);
		// 로그인한 사용자의 전체수신갯수
		int ulistCount = payService.allUserCount(userName);
		// 미결재함
		
		int noApprovalSignCountToday = payService.noApprovalSignCountToday(userName);
		
		int noApprovalSignCount = payService.noApprovalSignCount(userName);
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
		String formatedNow = sdf.format(now);
		
			
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		model.addAttribute("noApprovalSignCount", String.valueOf(noApprovalSignCount));
		model.addAttribute("noApprovalSignCountToday", String.valueOf(noApprovalSignCountToday));
		model.addAttribute("userName", userName);
		model.addAttribute("userNo", userNo);
		model.addAttribute("today", formatedNow);
		
		return "pay/approvalMain";
	
			
		
		
	}
	
	//ajax용 전체결재함
	@ResponseBody
	@RequestMapping(value="/ajaxapprovalMain.do")
	public Map<String, Object> ajaxapprovalMain(@RequestParam(value="page", defaultValue="1") int currentPage, 
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
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("list", list);
		map.put("pi", pi);
		
		return map;
		
		
	}
	
	//결재메인페이지카테고리&검색---------------------
	@ResponseBody
	@GetMapping("/search.do")
	public Map<String, Object> searchList(@RequestParam Map<String, String> search
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
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		
		return map;
		
	}
	//----------------------------------------
	@ResponseBody
	@RequestMapping(value="/selectList.do")
	public Map<String, Object> selectList(HttpServletRequest request,
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
		
		Map<String, Object> map = new HashMap<>();
		map.put("pi", pi);
		map.put("list", list);
		
		return map;
		
	}
	
	// 메인결재 상세페이지목록클릭-----------------------
	@RequestMapping("/detail.do")
	public String detail(@RequestParam Map<String, Object> map, Model model
						, HttpSession session) {
		
		//회원정보조회용
		String approvalNo = (String)map.get("approvalNo");
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		log.debug("map : {}", map);
		if(map != null && !map.isEmpty() && map.get("documentType").equals("매출보고서")) {
			List<Map<String, Object>> list = payService.expendDetail(map);
			List<SignDto> sign = payService.ajaxSignSelect(map);
			List<Map<String, Object>> refList = payService.refList(approvalNo);
			model.addAttribute("list", list);
			model.addAttribute("userNo", userNo);
			model.addAttribute("userName", String.valueOf(userName));
			model.addAttribute("sign", sign);
			model.addAttribute("refList", refList);
			
			return "pay/expendDetail";
			
		}else if(map != null && !map.isEmpty() && map.get("documentType").equals("기안서")){
			map.put("refType", "PG");
			List<Map<String, Object>> list = payService.salesDetail(map);
			List<SignDto> sign = payService.ajaxSignSelect(map);
			List<Map<String, Object>> fileList = payService.fileDraftDetail(map);
			//에디터
			String content = payService.contentSelect(map);
			List<Map<String, Object>> refList = payService.refList(approvalNo);
			model.addAttribute("list", list);
			model.addAttribute("userNo", userNo);
			model.addAttribute("userName", userName);
			model.addAttribute("sign", sign);
			model.addAttribute("fileList", fileList);
			model.addAttribute("content", content);
			model.addAttribute("refList", refList);
			return "pay/salesDetail";
			
		}else if(map != null && !map.isEmpty() && map.get("documentType").equals("비품신청서")) {
			List<Map<String, Object>> list = payService.fixDetail(map);
			List<SignDto> sign = payService.ajaxSignSelect(map);
			List<Map<String, Object>> refList = payService.refList(approvalNo);
			
			model.addAttribute("list", list);
			model.addAttribute("userNo", userNo);
			model.addAttribute("userName", userName);
			model.addAttribute("refList", refList);
			model.addAttribute("sign", sign);
			return "pay/fixDetail";
			
		}else if(map != null && !map.isEmpty() && map.get("documentType").equals("휴직신청서")) {
			List<Map<String, Object>> list = payService.retireDetail(map);
			List<SignDto> sign = payService.ajaxSignSelect(map);
			List<Map<String, Object>> refList = payService.refList(approvalNo);
			model.addAttribute("list", list);
			model.addAttribute("userNo", userNo);
			model.addAttribute("userName", userName);
			model.addAttribute("sign", sign);
			model.addAttribute("refList", refList);
			return "pay/retireDetail";
			
		}else if(map != null && !map.isEmpty() && map.get("documentType").equals("지출결의서")) {
			List<Map<String, Object>> list = payService.draftDetail(map);
			map.put("refType", "PJ");
			List<Map<String, Object>> fileList = payService.fileDraftDetail(map);
			List<SignDto> sign = payService.ajaxSignSelect(map);
			List<Map<String, Object>> refList = payService.refList(approvalNo);
			model.addAttribute("list", list);
			model.addAttribute("fileList", fileList);
			model.addAttribute("userNo", userNo);
			model.addAttribute("userName", userName);
			model.addAttribute("sign", sign);
			model.addAttribute("refList", refList);
			return "pay/draftDetail";
		}
		
		return "";
		
		
		
	}
	
	//메인페이지 로그인한 유저의 전체결재 수신함--------------------------
	@ResponseBody
	@RequestMapping("/allUserlist.do")
	public Map<String, Object> allUserlist(@RequestParam (value="page", defaultValue="1") int currentPage
								,HttpSession session, Model model) {
		
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
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		
		return map;
		
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
		log.debug("teamNames : {}", teamNames);
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
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			model.addAttribute("teamNames", teamNames);
			return "pay/gWriterForm";
			
		}else if(writer.equals("m")) {
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			model.addAttribute("teamNames", teamNames);
			
			return "pay/mWriterForm";
			
		}else if(writer.equals("b")) {
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			model.addAttribute("teamNames", teamNames);
			
			return "pay/bWriterForm";
			
		}else if(writer.equals("j")) {
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			model.addAttribute("teamNames", teamNames);
			
			return "pay/jWriterForm";
			
		}else if(writer.equals("h")) {
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			model.addAttribute("teamNames", teamNames);
			
			return "pay/hWriterForm";
		}
		
		return "pay/bWriterForm";
		
		
		
	}
	
	//---------매출 보고서 ----------------------
	@PostMapping("/mReportInsert.do")
	public String mReportInsert(@RequestParam("item") List<String> items,
								@RequestParam("count") List<String> counts,
								@RequestParam("salesAmount") List<String> saleses,
								@RequestParam Map<String, Object> map, 
								RedirectAttributes redirectAttributes) {
		
		
		List<Map<String, Object>> list = new ArrayList<>();
		
		for(int i=0; i<items.size(); i++) {
			if(items.get(i) != null && !items.get(i).equals("")) {
				Map<String, Object> maps = new HashMap<>();
				maps.put("item", items.get(i));
				maps.put("count", counts.get(i));
				maps.put("salesAmount", saleses.get(i));
				list.add(maps);
			}
		}
		
		int result = payService.mReportInsert(map, list);
		
		redirectAttributes.addFlashAttribute("alertTitle", "게시글 등록 서비스");
		if(result == list.size()) {
			redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 등록 되었습니다.");
			redirectAttributes.addFlashAttribute("modalColor", "G");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록 실패");
		}
		
		
		return "redirect:/pay/myAllApproval.page";
	}
	
	@ResponseBody
	@RequestMapping("/ajaxReject.do")
	public List<SignDto> ajaxReject(@RequestParam Map<String, Object> map, HttpSession session) {
		
		int result = payService.ajaxUpdateReject(map);
		
		List<SignDto> list = new ArrayList<>();
		if(result == 1) {
			list = payService.ajaxSignSelect(map);
		}
		
	    String approvalSignNo = (String)map.get("approvalSignNo");
	    
	    if(approvalSignNo != null) {
	        SignDto signDto = new SignDto();
	        signDto.setApprovalSignNo(approvalSignNo);
	        list.add(signDto);
	    }
		
		
		return list;
		
	}
	
	@RequestMapping("/modify.do")
	public String modify(@RequestParam Map<String, Object> map, Model model
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
		//기안서
		map.put("refType", "PG");
		List<Map<String, Object>> listG = payService.salesDetail(map);
		
		//-------------------------------------
		
		//로그인한 유저의 팀이름, 부서, 팀명, 직급
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("userNo", userNo);
		List<MemberDeptDto> member = payService.selectloginUserDept(mapUserMember);
		
		//---------------------------
		
		List<Map<String, Object>> teamNames = payService.teamNameList();
		
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
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			model.addAttribute("teamNames", teamNames);
			//-------------------------------------
			model.addAttribute("list", listM);
			model.addAttribute("type", map.get("type"));
			
			return "pay/mModifyForm";
			
		}else if(map.get("report").equals("j")){
			map.put("refType", "PJ");
			List<Map<String, Object>> fileList = payService.fileDraftDetail(map);
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			model.addAttribute("teamNames", teamNames);
			//-------------------------------------
			model.addAttribute("list", listJ);
			model.addAttribute("fileList", fileList);
			model.addAttribute("type", map.get("type"));
			
			return "pay/jModifyForm";
			
		}else if(map.get("report").equals("h")){
			List<Map<String, Object>> fileList = payService.fileDraftDetail(map);
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			model.addAttribute("teamNames", teamNames);
			//-------------------------------------
			model.addAttribute("list", listH);
			model.addAttribute("type", map.get("type"));
			
			return "pay/hModifyForm";
			
		}else if(map.get("report").equals("b")){
			List<Map<String, Object>> fileList = payService.fileDraftDetail(map);
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			model.addAttribute("teamNames", teamNames);
			//-------------------------------------
			model.addAttribute("list", listB);
			model.addAttribute("type", map.get("type"));
			
			return "pay/bModifyForm";
		}else {
			//기안서
			//에디터
			String content = payService.contentSelect(map);
			
			model.addAttribute("member", member);
			model.addAttribute("userName", userName);
			model.addAttribute("userNo", userNo);
			model.addAttribute("teamNames", teamNames);
			model.addAttribute("content", content);			
			
			model.addAttribute("list", listG);
			model.addAttribute("type", map.get("type"));
			log.debug("gModifyFormList : {}", listG);
			
			return "pay/gModifyForm";
		}
		
		
		
	}
	
	//로그인한 사용자 전체수신결재함
	@ResponseBody
	@RequestMapping("/userSelectList.do")
	public Map<String, Object> userSelectList(@RequestParam (value="page", defaultValue="1") int currenPage
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
		
		Map<String, Object> maps = new HashMap<>();
		
		maps.put("pi", pi);
		maps.put("list", list);
		maps.put("conditions", map.get("conditions"));
		maps.put("status", map.get("status"));
		
		return maps;
	}
	
	//로그인한 사용자 전체수신결재함 - 검색
	@ResponseBody
	@GetMapping("/userSearch.do")
	public Map<String, Object> userSearch(@RequestParam Map<String, Object> map, @RequestParam (value="page", defaultValue="1") int currentPage
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
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("pi", pi);
		maps.put("list", list);
		maps.put("condition", map.get("condition"));
		maps.put("keyword", map.get("keyword"));
		
		return maps;
		
	}
	
	
	@PostMapping("/mReportUpdate.do")
	public String mReportUpdate(@RequestParam("item") List<String> items,
								@RequestParam("count") List<String> counts,
								@RequestParam("salesAmount") List<String> sales,
								@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes) { 
		
		log.debug("mReportUpdate : {}", map);
		log.debug("items : {}", items);
		log.debug("counts : {}", counts);
		log.debug("sales : {}", sales);
		List<Map<String, Object>> list = new ArrayList<>();
		
			for(int i=0; i<items.size(); i++) {
				if(items.get(i) != null && !items.get(i).equals("")) {
					Map<String, Object> maps = new HashMap<>();
					maps.put("expendNo", map.get("expendNo"));
					maps.put("item", items.get(i));
					maps.put("count", counts.get(i));
					maps.put("salesAmount", sales.get(i));
					list.add(maps);
				}
		}
		
		
		int result = payService.mReportUpdate(map, list);
		
		redirectAttributes.addFlashAttribute("alertTitle", "게시글 수정 서비스");
		if(result == list.size()) {
			redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 등록 되었습니다.");
			redirectAttributes.addFlashAttribute("modalColor", "G");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록 실패");
		}
		
		
		return "redirect:/pay/myAllApproval.page";
		
	}
	
	@PostMapping("/gReportUpdate.do")
	public String gReportUpdate(@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes
							  , List<MultipartFile> uploadFiles,  String[] delFileNo
							  , @RequestParam(value="referrer", defaultValue="null") List<String> referrerNo
							  , @RequestParam(value="referrerName", defaultValue="null") List<String> referrerName) { 
		
		String approvalNo = (String)map.get("approvalNo");
		
		List<Map<String, Object>> attachList = new ArrayList<>();
		
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> fileMap = fileUtil.fileUpload(uploadFile, "approval");
				Map<String, Object> file = new HashMap<>();
				file.put("filePath", fileMap.get("filePath"));
				file.put("filesystemName", fileMap.get("filesystemName"));
				file.put("originalName", fileMap.get("originalName"));
				file.put("RefType", "PG");
				file.put("salesNo", map.get("salesNo"));
				
				attachList.add(file);
			}
		}
		
		List<Map<String, Object>> referrerList = new ArrayList<>();
		if(referrerNo != null &&!referrerNo.equals("null")) {
			for(int i=0; i<referrerNo.size(); i++) {
				Map<String, Object> refMap = new HashMap<>();
				refMap.put("approvalNo", map.get("approvalNo"));
				refMap.put("writerNo", map.get("payWriterNo"));
				refMap.put("refNo", referrerNo.get(i));
				refMap.put("refName", referrerName.get(i));
				referrerList.add(refMap);
			}
		}
		
		int result = payService.gReportUpdate(map, attachList, delFileNo, referrerList, approvalNo);
		
		redirectAttributes.addFlashAttribute("alertTitle", "게시글 수정 서비스");
		if(result == 1 && uploadFiles.isEmpty() || result == attachList.size() && !uploadFiles.isEmpty()) {
			redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 등록 되었습니다.");
			redirectAttributes.addFlashAttribute("modalColor", "G");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록 실패");
		}
		
		
		
		return "redirect:/pay/myAllApproval.page";
		
	}
	
	
	
	@PostMapping("/gReportInsert.do")
	public String gReportInsert(@RequestParam Map<String, Object> map, List<MultipartFile> uploadFiles
								, RedirectAttributes redirectAttributes
								, @RequestParam(value="referrer", defaultValue="null") List<String> referrerNo
								, @RequestParam(value="referrerName", defaultValue="null") List<String> referrerName) {
		
		
		List<Map<String, Object>> attachList = new ArrayList<>();
		
		for(MultipartFile uploadFile : uploadFiles) {
			if(uploadFile != null && !uploadFile.isEmpty()) {
				Map<String, String> file = fileUtil.fileUpload(uploadFile, "approval"); 
				Map<String, Object> fileMap = new HashMap<>();
				fileMap.put("originalName", file.get("originalName"));
				fileMap.put("filesystemName", file.get("filesystemName"));
				fileMap.put("filePath", file.get("filePath"));
				fileMap.put("RefType", "PG");
				attachList.add(fileMap);
			}
		}
		log.debug("map : {}", map);
		
		map.put("fileStatus", "Y");			
		
		
		List<Map<String, Object>> referrerList = new ArrayList<>();
		if(!referrerNo.equals("null")) {
			for(int i=0; i<referrerNo.size(); i++) {
				Map<String, Object> refMap = new HashMap<>();
				refMap.put("writerNo", map.get("writerNo"));
				refMap.put("refNo", referrerNo.get(i));
				refMap.put("refName", referrerName.get(i));
				referrerList.add(refMap);
			}
		}
		
		int result = payService.gReportInsert(map, attachList, referrerList);
		
		
		redirectAttributes.addFlashAttribute("alertTitle", "게시글 등록 서비스");
		if(!attachList.isEmpty() && result == attachList.size()) {
			redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 등록 되었습니다.");
			redirectAttributes.addFlashAttribute("modalColor", "G");
		}else {
			for(Map<String, Object> at : attachList) {
				new File(at.get("filePath") + "/" + at.get("filesystemName")).delete();			
			}
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록 실패");
			
		}
		
		
		
		
		return "redirect:/pay/myAllApproval.page";
		
		
	}
	
	//로그인한 사용자의 승인완료된 수신함
	@ResponseBody
	@GetMapping("/approvedList.do")
	public Map<String, Object> ApprovedList(HttpSession session, @RequestParam (value="page", defaultValue="1") int currentPage
									, Model model){
		
		//회원정보조회용
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		//로그인한 사용자가 승인완료한 갯수
		int slistCount = payService.successListCount(userName);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(slistCount, currentPage, 5, 10);
		
		List<PayDto> list = payService.ApprovedList(pi, userName);
		
		//개시글총갯수
		int listCount = payService.selectListCount();
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payService.moreDateCount(userName);
		int ulistCount = payService.allUserCount(userName);
		
		Map<String, Object> map = new HashMap<>();
		map.put("pi", pi);
		map.put("list", list);
		
		return map;
		
	}
	
	
	@PostMapping("/bReportInsert.do")
	public String bReportInsert(@RequestParam("pName") List<String> pNames,
							    @RequestParam("size") List<String> sizes,
							    @RequestParam("amount") List<Integer> amounts,
							    @RequestParam("unitPrice") List<String> unitPrices,
							    @RequestParam("price") List<String> prices,
							    @RequestParam("etc") List<String> etcs,
							    @RequestParam Map<String, Object> map,
							    @RequestParam(value="referrer", defaultValue="null") List<String> referrerNo,
							    @RequestParam(value="referrerName", defaultValue="null") List<String> referrerName,
							    Model model,
							    RedirectAttributes redirectAttributes) {
		
		// 품목, 규격, 수량, 단가, 가격, 기타 
		List<Map<String, Object>> list = new ArrayList<>();
		
		for(int i=0; i<pNames.size(); i++) {
			if(pNames.get(i) != null && !pNames.get(i).equals("")) {
				Map<String, Object> maps = new HashMap<>();
				maps.put("pName", pNames.get(i));
				maps.put("size", sizes.get(i));
				maps.put("amount", amounts.get(i));
				maps.put("unitPrice", unitPrices.get(i));
				maps.put("price", prices.get(i));
				maps.put("etc", etcs.get(i));
				list.add(maps);
			}
		}
		log.debug("품목 : {}", list);
		
		List<Map<String, Object>> referrerList = new ArrayList<>();
		if(!referrerNo.equals("null")) {
			for(int i=0; i<referrerNo.size(); i++) {
				Map<String, Object> refMap = new HashMap<>();
				refMap.put("writerNo", map.get("writerNo"));
				refMap.put("refNo", referrerNo.get(i));
				refMap.put("refName", referrerName.get(i));
				referrerList.add(refMap);
			}
		}
		
		
		log.debug("referrerNo : {}", referrerNo);
		log.debug("referrerList : {}", referrerList);
		
		int result = payService.bReportInsert(map, list, referrerList);
		
		redirectAttributes.addFlashAttribute("alertTitle", "게시글 등록 서비스");
		if(result > 0) {
			redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 등록 되었습니다.");
			redirectAttributes.addFlashAttribute("modalColor", "G");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록 실패");
		}
		
		return "redirect:/pay/myAllApproval.page";
	}
	
	@PostMapping("/hReportInsert.do")
	public String hReportInsert(@RequestParam Map<String, Object> map
								, RedirectAttributes redirectAttributes){
		
		int result = payService.hReportInsert(map);
		
		redirectAttributes.addFlashAttribute("alertTitle", "게시글 등록 서비스");
		if(result == 2) {
			redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 등록 되었습니다.");
			redirectAttributes.addFlashAttribute("modalColor", "G");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록 실패");
		}
		
		return "redirect:/pay/myAllApproval.page";
	}
	
	
	@PostMapping("/jReportInsert.do")
	public String jReportInsert(@RequestParam("account") List<String> accounts,
								@RequestParam("usage") List<String> usages,
								@RequestParam("price") List<String> prices,
								@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes, 
								List<MultipartFile> uploadFiles) {
		
		
		// 품목들 담기
		List<Map<String, Object>> itemList = new ArrayList<>();
		for(int i=0; i<accounts.size(); i++) {
			if(accounts.get(i) != null && !accounts.get(i).equals("")) {
				Map<String, Object> maps = new HashMap<>();
				maps.put("account", accounts.get(i));
				maps.put("usage", usages.get(i));
				maps.put("price", prices.get(i));
				itemList.add(maps);
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
		
		redirectAttributes.addFlashAttribute("alertTitle", "게시글 등록 서비스");
		if(result > 0 && attachList.isEmpty() || result == attachList.size() && !attachList.isEmpty()) {
			redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 등록 되었습니다.");
			redirectAttributes.addFlashAttribute("modalColor", "G");
		}else {
			for(Map<String, Object> at : attachList) {
				new File( at.get("filePath") + "/" + at.get("filesystemName")).delete();
			}
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록 실패");
		}
		
		return "redirect:/pay/myAllApproval.page";
	
	}
	
	
	@PostMapping("/jReportUpdate.do")
	public String jReportUpdate(@RequestParam("account") List<String> accounts,
								@RequestParam("usage") List<String> usages,
								@RequestParam("price") List<String> prices,
								@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes, 
								List<MultipartFile> uploadFiles,  String[] delFileNo) {
		
		//파일이 전부삭제될경우 => delFileNo 삭제된 수 == 
		//삭제된파일이 null값일 경우
		String[] delFileNoArr = delFileNo != null ? delFileNo : null;
		
		int delFileNoLeng = 0;
		if(delFileNoArr != null) { // 삭제된파일이 null이 아니라면 길이 알아내기
			delFileNoLeng = delFileNoArr.length;			
		}
		
		//기존파일의배열길이(삭제되기전)
		String fileLength = (String)map.get("fileLength");
		int fileLeng = Integer.parseInt(fileLength);

		
		// 품목들 담기
		List<Map<String, Object>> itemList = new ArrayList<>();
		for(int i=0; i<accounts.size(); i++) {
			if(accounts.get(i) != null && !accounts.get(i).equals("")) {
				Map<String, Object> maps = new HashMap<>();
				maps.put("reportNo", map.get("reportNo"));
				maps.put("account", accounts.get(i));
				maps.put("usage", usages.get(i));
				maps.put("price", prices.get(i));
				itemList.add(maps);
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
		
		int result = payService.jReportUpdate(map, itemList, fileList, delFileNo);
		
		redirectAttributes.addFlashAttribute("alertTitle", "게시글 수정 서비스");
		if(result > 0 && fileList.isEmpty() || result == fileList.size() * itemList.size()  && !fileList.isEmpty()) {
			redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 등록 되었습니다.");
			redirectAttributes.addFlashAttribute("modalColor", "G");
		}else {
			for(Map<String, Object> at : fileList) {
				new File( at.get("filePath") + "/" + at.get("filesystemName")).delete();
			}
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록 실패");
		}
		

		return "redirect:/pay/myAllApproval.page";
		
		
	}
	
	@ResponseBody
	@RequestMapping("/delayDateList.do")
	public Map<String, Object> delayDateList(@RequestParam (value="page", defaultValue="1") int currentPage
												 , HttpSession session, Model model){
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		
		//일주일이상 처리가안된 목록갯수
		int mdCount = payService.moreDateCount(userName);
		PageInfoDto pi = pagingUtil.getPageInfoDto(mdCount, currentPage, 5, 10);
		
		List<PayDto> list = payService.delayDateList(userName, pi);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		
		return map;
		
	}
	
	@ResponseBody
	@RequestMapping("/delayDateSelectList.do")
	public Map<String, Object> delayDateSelectList(@RequestParam Map<String, Object> map, @RequestParam (value="page", defaultValue="1") int currentPage
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
		
		
		Map<String, Object> maps = new HashMap<>(); 
		maps.put("list", list);
		maps.put("pi", pi);
		maps.put("conditions", map.get("conditions"));
		maps.put("status", map.get("status"));
		
		return maps;
	}
	
	@ResponseBody
	@RequestMapping("/delayDateSearch.do")
	public Map<String, Object> delayDateSearch(@RequestParam Map<String, Object> map, @RequestParam (value="page", defaultValue="1") int currentPage
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
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("list", list);
		maps.put("pi", pi);
		maps.put("condition", map.get("condition"));
		maps.put("keyword", map.get("keyword"));
		
		return maps;
		
	}
	
	@PostMapping("/hReportUpdate.do")
	public String hReportUpdate(@RequestParam Map<String, Object> map, RedirectAttributes redirectAttributes) {
		
		int result = payService.hReportUpdate(map);
		
		redirectAttributes.addFlashAttribute("alertTitle", "게시글 수정 서비스");
		if(result == 2) {
			redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 등록 되었습니다.");
			redirectAttributes.addFlashAttribute("modalColor", "G");
		}else {
			redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록 실패");
		}
		
		return "redirect:/pay/myAllApproval.page";
	}
	
	@PostMapping("/bReportUpdate.do")
	public String bReportUpdate(@RequestParam("pName") List<String> pNames,
							    @RequestParam("size") List<String> sizes,
							    @RequestParam("amount") List<Integer> amounts,
							    @RequestParam("unitPrice") List<String> unitPrices,
							    @RequestParam("price") List<String> prices,
							    @RequestParam("etc") List<String> etcs,
							    @RequestParam Map<String, Object> map,
							    @RequestParam(value="referrer", defaultValue="null") List<String> referrerNo,
							    @RequestParam(value="referrerName", defaultValue="null") List<String> referrerName,
							    Model model,
							    RedirectAttributes redirectAttributes,
							    HttpSession session) {

			String approvalNo = (String)map.get("approvalNo");
			// 품목, 규격, 수량, 단가, 가격, 기타 
			List<Map<String, Object>> list = new ArrayList<>();
			
			for(int i=0; i<pNames.size(); i++) {
				if(pNames.get(i) != null && !pNames.get(i).equals("")) {
					Map<String, Object> maps = new HashMap<>();
					maps.put("reportNo", map.get("reportNo"));
					maps.put("pName", pNames.get(i));
					maps.put("size", sizes.get(i));
					maps.put("amount", amounts.get(i));
					maps.put("unitPrice", unitPrices.get(i));
					maps.put("price", prices.get(i));
					maps.put("etc", etcs.get(i));
					list.add(maps);
					
				}
			}
			
			List<Map<String, Object>> referrerList = new ArrayList<>();
			if(referrerNo != null &&!referrerNo.equals("null")) {
				for(int i=0; i<referrerNo.size(); i++) {
					Map<String, Object> refMap = new HashMap<>();
					refMap.put("approvalNo", map.get("approvalNo"));
					refMap.put("writerNo", map.get("payWriterNo"));
					refMap.put("refNo", referrerNo.get(i));
					refMap.put("refName", referrerName.get(i));
					referrerList.add(refMap);
				}
			}
			
			
			int result = payService.bReportUpdate(map, list, referrerList, approvalNo);
			
			
			redirectAttributes.addFlashAttribute("alertTitle", "게시글 수정 서비스");
			if(result > 0) {
				redirectAttributes.addFlashAttribute("alertMsg", "성공적으로 등록 되었습니다.");
				redirectAttributes.addFlashAttribute("modalColor", "G");
			}else {
				redirectAttributes.addFlashAttribute("alertMsg", "게시글 등록 실패");
			}
			
			
			return "redirect:/pay/myAllApproval.page";
		
	}
	
	// 승인 싸인 저장하기 ajax
	@ResponseBody
	@PostMapping(value="/ajaxSign.do")
	public Map<String, Object> ajaxSign(@RequestParam Map<String, Object> map) {
		
//		Map<String, Object> map = new HashMap<String, Object>();
//		map = CommonController.getParameterMap(request);

		log.debug("signMap : {}", map);
		int result =  payService.ajaxSignUpdate(map);
		
		List<SignDto> sign = new ArrayList<>();
		if(result > 0) {
			sign = payService.ajaxSignSelect(map);
		}
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("sign", sign);
		maps.put("approvalSignNo", map.get("approvalSignNo"));
		
		return maps;
		
	}
	
	
	// 결재승인자 선택 ajax
	@ResponseBody
	@GetMapping("/ajaxTeamSearch.do")
	public List<Map<String, Object>> ajaxSearch(String name){
		
		List<Map<String, Object>> list = payService.ajaxTeamSearch(name);
		
		return list;
		
	}
	
	//결재승인자 검색 ajax
	@ResponseBody
	@GetMapping("/ajaxSearchName.do")
	public List<Map<String, Object>> ajaxSearchName(String name){
		
		List<Map<String, Object>> list = payService.ajaxSearchName(name);
		
		return list;
	}
	
	
	// 승인 완료한 수신결재함
	@ResponseBody
	@RequestMapping("/approvalSearch.do")
	public Map<String, Object> approvalSearch(@RequestParam Map<String, Object> map, @RequestParam (value="page", defaultValue="1") int currentPage
							, Model model, HttpSession session) {
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		
		Map<String, Object> userMap = new HashMap<>();
		userMap.put("userName", userName);
		userMap.put("condition", map.get("condition"));
		userMap.put("keyword", map.get("keyword"));;
		
		//일주일이상 처리가안된 목록갯수
		int approvalSearchCount = payService.approvalSearchCount(userMap);
		PageInfoDto pi = pagingUtil.getPageInfoDto(approvalSearchCount, currentPage, 5, 10);
		
		List<PayDto> list = payService.approvalSearchList(userMap, pi);
		
		int mdCount = payService.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payService.successListCount(userName);
		// 로그인한 사용자의 전체수신갯수
		int ulistCount = payService.allUserCount(userName);
		//개시글총갯수
		int listCount = payService.selectListCount();
		
		Map<String, Object> mapes = new HashMap<>();
		
		mapes.put("list", list);
		mapes.put("pi", pi);
		mapes.put("condition", map.get("condition"));
		mapes.put("keyword", map.get("keyword"));;
		
		return mapes;
	}
	
	@ResponseBody
	@RequestMapping("/approvalSelectList.do")
	public Map<String, Object> approvalSelectList(HttpServletRequest request,@RequestParam (value="page", defaultValue="1") int currentPage
									, Model model, HttpSession session, @RequestParam Map<String, Object> map) {
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("userName", userName);
		maps.put("conditions", map.get("conditions"));
		maps.put("status", map.get("status"));;
		
		//일주일이상 처리가안된 목록갯수
		int approvalSelectCount = payService.approvalSelectCount(maps);
		PageInfoDto pi = pagingUtil.getPageInfoDto(approvalSelectCount, currentPage, 5, 10);
		
		log.debug("userMap : {}", maps);
		List<PayDto> list = payService.approvalSelectList(maps, pi);
		
		int mdCount = payService.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payService.successListCount(userName);
		// 로그인한 사용자의 전체수신갯수
		int ulistCount = payService.allUserCount(userName);
		//개시글총갯수
		int listCount = payService.selectListCount();
		
		Map<String, Object> mapes = new HashMap<>();
		
		mapes.put("list", list);
		mapes.put("pi", pi);
		mapes.put("conditions", map.get("conditions"));
		mapes.put("status", map.get("status"));
		
		return mapes;
		
	}
	
	@RequestMapping("/myAllApproval.page")
	public void myAllApproval(@RequestParam(value="page", defaultValue="1") int currentPage
							, HttpSession session, Model model) {
		
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("userNo", userNo);
		mapUserMember.put("statusType", "전체");
		
		int myAllApCount = payService.myAllApCount(mapUserMember);
		
		PageInfoDto pi =  pagingUtil.getPageInfoDto(myAllApCount, currentPage, 5, 10);

		List<Map<String, Object>> list = payService.myAllApproval(mapUserMember, pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("userName", userName);
		
	}
	
	@ResponseBody
	@GetMapping("/ajaxmyWaitApproval.page")
	public Map<String, Object> myWaitApproval(@RequestParam(value="page", defaultValue="1") int currentPage
							 , HttpSession session, Model model) {
		
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("userNo", userNo);
		mapUserMember.put("statusType", "D");
		
		int myAllApCount = payService.myAllApCount(mapUserMember);
		
		PageInfoDto pi =  pagingUtil.getPageInfoDto(myAllApCount, currentPage, 5, 10);

		List<Map<String, Object>> list = payService.myAllApproval(mapUserMember, pi);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		
		return map;
	}
	
	@ResponseBody
	@GetMapping("/ajaxMyReAllApproval.page")
	public Map<String, Object> ajaxmyReAllApproval(@RequestParam(value="page", defaultValue="1") int currentPage
			 						, HttpSession session, Model model, ModelAndView mv) {
		
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("userNo", userNo);
		mapUserMember.put("statusType", "All");
		
		int myAllApCount = payService.myAllApCount(mapUserMember);
		
		PageInfoDto pi =  pagingUtil.getPageInfoDto(myAllApCount, currentPage, 5, 10);

		List<Map<String, Object>> list = payService.myAllApproval(mapUserMember, pi);
			
		Map<String, Object> maps = new HashMap<>();
		maps.put("list", list);
		maps.put("pi", pi);
		
		return maps;
		
	}
	

	@ResponseBody
	@GetMapping("/ajaxMyRejectApproval.page")
	public Map<String, Object> ajaxMyRejectApproval(@RequestParam(value="page", defaultValue="1") int currentPage
											, HttpSession session, Model model) {
		
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("userNo", userNo);
		mapUserMember.put("statusType", "N");
		
		int myAllApCount = payService.myAllApCount(mapUserMember);
		
		PageInfoDto pi =  pagingUtil.getPageInfoDto(myAllApCount, currentPage, 5, 10);

		List<Map<String, Object>> list = payService.myAllApproval(mapUserMember, pi);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		
		return map;
	}
	
	@ResponseBody
	@GetMapping("/ajaxMyCompleteApproval.page")
	public Map<String, Object> ajaxMyCompletedApproval(@RequestParam(value="page", defaultValue="1") int currentPage
			 						, HttpSession session, Model model, ModelAndView mv) {
		
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("userNo", userNo);
		mapUserMember.put("statusType", "Y");
		
		int myAllApCount = payService.myAllApCount(mapUserMember);
		
		PageInfoDto pi =  pagingUtil.getPageInfoDto(myAllApCount, currentPage, 5, 10);

		List<Map<String, Object>> list = payService.myAllApproval(mapUserMember, pi);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		
		return map;
		
	}
	
	@ResponseBody
	@RequestMapping("/ajaxMyProgressesApproval.page")
	public Map<String, Object> ajaxMyProgressesApproval(@RequestParam(value="page", defaultValue="1") int currentPage
			 						, HttpSession session, Model model, ModelAndView mv) {
		
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("userNo", userNo);
		mapUserMember.put("statusType", "I");
		
		int myAllApCount = payService.myAllApCount(mapUserMember);
		
		PageInfoDto pi =  pagingUtil.getPageInfoDto(myAllApCount, currentPage, 5, 10);

		List<Map<String, Object>> list = payService.myAllApproval(mapUserMember, pi);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		
		return map;
		
	}
	
	
	@ResponseBody
	@RequestMapping("/ajaxMyApprovalSearch.do")
	public Map<String, Object> ajaxMyApprovalSearch(@RequestParam(value="page", defaultValue="1") int currentPage
			 						, HttpSession session, @RequestParam Map<String, Object> map) {
		
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		map.put("userName", userName);
		map.put("userNo", userNo);
		
		int mySearchApCount = payService.mySearchApCount(map);
		
		PageInfoDto pi =  pagingUtil.getPageInfoDto(mySearchApCount, currentPage, 5, 10);

		List<Map<String, Object>> list = payService.mySearchApList(map, pi);
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("list", list);
		maps.put("pi", pi);
		maps.put("statusType", map.get("statusType"));
		maps.put("option", map.get("option"));
		maps.put("keyword", map.get("keyword"));
		
		return maps;
		
	}
	
	
	@ResponseBody
	@GetMapping("/ajaxApprovaldelete.do")
	public String ajaxAppprovaldelete(String no) {
		
		log.debug("no : {}", no);
		
		int result = payService.ajaxAppprovaldelete(no);
		
		return result == 1 ? "SUCCESS" : "FAIL";
	}
	
	@ResponseBody
	@RequestMapping("/ajaxNoApprovalSign.do")
	public Map<String, Object> ajaxNoApprovalSign(@RequestParam (value="page", defaultValue="1") int currentPage, HttpSession session) {
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		
		int noApprovalSignCount = payService.noApprovalSignCount(userName);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(noApprovalSignCount, currentPage, 5, 10);
		
		List<PayDto> list = payService.noApprovalSign(userName, pi);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		return map;
		
	}
	
	@ResponseBody
	@RequestMapping("/ajaxNoApprovalSignSelectList.do")
	public Map<String, Object> ajaxNoApprovalSignSelectList(@RequestParam (value="page", defaultValue="1") int currentPage, HttpSession session
														 , @RequestParam Map<String, Object> map) {
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapes = new HashMap<>();
		mapes.put("userName", userName);
		mapes.put("conditions", map.get("conditions"));
		mapes.put("status", map.get("status"));
		
		int noApprovalSignSelectCount = payService.noApprovalSignSelectCount(mapes);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(noApprovalSignSelectCount, currentPage, 5, 10);
		
		List<PayDto> list = payService.noApprovalSignSelectList(mapes, pi);
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("list", list);
		maps.put("pi", pi);
		maps.put("conditions", map.get("conditions"));
		maps.put("status", map.get("status"));
		
		
		return maps;
		
	}
	
	@ResponseBody
	@RequestMapping("/ajaxNoApprovalSignSearchList.do")
	public Map<String, Object> ajaxNoApprovalSignSearchList(@RequestParam (value="page", defaultValue="1") int currentPage, HttpSession session
														 , @RequestParam Map<String, Object> map) {
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapes = new HashMap<>();
		mapes.put("userName", userName);
		mapes.put("condition", map.get("condition"));
		mapes.put("keyword", map.get("keyword"));
		
		int noApprovalSignSearchCount = payService.noApprovalSignSearchCount(mapes);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(noApprovalSignSearchCount, currentPage, 5, 10);
		
		List<PayDto> list = payService.noApprovalSignSearchList(mapes, pi);
		
		Map<String, Object> maps = new HashMap<>();
		maps.put("list", list);
		maps.put("pi", pi);
		maps.put("condition", map.get("condition"));
		maps.put("keyword", map.get("keyword"));
		
		return maps;
		
	}
	
	
	//승인자의 반려함
	@RequestMapping("/rejectApprovalList.page")
	public String rejectApprovalList(@RequestParam(value="page", defaultValue="1") int currentPage
							, HttpSession session, Model model) {
		
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("userNo", userNo);
		
		int myAllRejectApCount = payService.myRejectApCount(mapUserMember);
		
		PageInfoDto pi =  pagingUtil.getPageInfoDto(myAllRejectApCount, currentPage, 5, 10);

		List<Map<String, Object>> list = payService.myRejectApList(mapUserMember, pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("userName", userName);
		
		return "pay/rejectMyAp";
	}
	
	//승인자의 결재승인함
	@RequestMapping("/finishApprovalList.page")
	public String finishApprovalList(@RequestParam(value="page", defaultValue="1") int currentPage
							, HttpSession session, Model model) {
		
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("userNo", userNo);
		
		int myFinishApCount = payService.myFinishApCount(mapUserMember);
		
		PageInfoDto pi =  pagingUtil.getPageInfoDto(myFinishApCount, currentPage, 5, 10);

		List<Map<String, Object>> list = payService.myFinishApList(mapUserMember, pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("userName", userName);
		
		return "pay/finishMyAp";
	}
	
	// 승인자 차례의 미결재함
	@RequestMapping("/noApprovalList.page")
	public String noApprovalList(@RequestParam(value="page", defaultValue="1") int currentPage
							, HttpSession session, Model model) {
		
		Map<String, Object> map = new HashMap<>();
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		map.put("userName", userName);
		
		int noApprovalSignCountRe = payService.noApprovalSignCount(userName);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(noApprovalSignCountRe, currentPage, 5, 10);
		
		List<Map<String, Object>> list = payService.noApprovalSignRe(map, pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("userName", userName);
		
		
		return "pay/noMyAp";
	}
	
	//반려함 전체검색 조회
	@ResponseBody
	@GetMapping("/ajaxMyRejectSearchApproval.do")
	public Map<String, Object> ajaxMyRejectSearchApproval(@RequestParam (value="page", defaultValue="1") int currentPage, String keyword
											, HttpSession session) {
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("keyword", keyword);
		
		int myAllRejectApCount = payService.myRejectApCount(mapUserMember);
		
		PageInfoDto pi =  pagingUtil.getPageInfoDto(myAllRejectApCount, currentPage, 5, 10);

		List<Map<String, Object>> list = payService.myRejectApList(mapUserMember, pi);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		map.put("userName", userName);
		log.debug("list : {}", list);
		log.debug("pi : {}", pi);
		log.debug("userName : {}", userName);
		return map;
	}
	
	//승인자의 결재승인함 전체검색기능
	@ResponseBody
	@GetMapping("/ajaxMyFinishSearchApproval.do")
	public Map<String, Object> ajaxMyFinishSearchApproval(@RequestParam(value="page", defaultValue="1") int currentPage
							, HttpSession session, String keyword) {
		
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("keyword", keyword);
		
		int myAllRejectApCount = payService.myFinishApCount(mapUserMember);
		
		PageInfoDto pi =  pagingUtil.getPageInfoDto(myAllRejectApCount, currentPage, 5, 10);

		List<Map<String, Object>> list = payService.myFinishApList(mapUserMember, pi);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		map.put("userName", userName);
		log.debug("list : {}", list);
		log.debug("pi : {}", pi);
		log.debug("userName : {}", userName);
		
		return map;
	}
		
	// 승인자 차례의 미결재함 전체검색
	@ResponseBody
	@GetMapping("/ajaxMyNoSignSearchApproval.do")
	public Map<String, Object> ajaxMyNoSignSearchApproval(@RequestParam(value="page", defaultValue="1") int currentPage
														 , HttpSession session, String keyword) {
		
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userName", userName);
		mapUserMember.put("keyword", keyword);	
		
		int noApprovalSignCountRe = payService.noApprovalkeywordSignCount(mapUserMember);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(noApprovalSignCountRe, currentPage, 5, 10);
		
		List<Map<String, Object>> list = payService.noApprovalSignRe(mapUserMember, pi);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		map.put("userName", userName);
		log.debug("list : {}", list);
		log.debug("pi : {}", pi);
		log.debug("userName : {}", userName);
		
		return map;
	}
	//결재최종승인
	@ResponseBody
	@PostMapping("/ajaxApprovalprocessing.do")
	public int ajaxApprovalprocessing(@RequestParam Map<String, Object> map) {
		return payService.ajaxApprovalprocessing(map);
		
		
	}
	
	// 승인자 차례의 미결재함
	@RequestMapping("/noApprovalListMain.page")
	public String noApprovalListMain(@RequestParam(value="page", defaultValue="1") int currentPage
							, HttpSession session, Model model) {
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);
		
		int noApprovalSignCount = payService.noApprovalSignCount(userName);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(noApprovalSignCount, currentPage, 5, 10);
		
		List<PayDto> list = payService.noApprovalSign(userName, pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("userName", userName);
		
		//개시글총갯수
		int listCount = payService.selectListCount();
		
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payService.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payService.successListCount(userName);
		// 로그인한 사용자의 전체수신갯수
		int ulistCount = payService.allUserCount(userName);
		// 미결재함
		
		int noApprovalSignCountToday = payService.noApprovalSignCountToday(userName);
		Date now = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("MM-dd");
		String formatedNow = sdf.format(now);
		
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		model.addAttribute("noApprovalSignCount", String.valueOf(noApprovalSignCount));
		model.addAttribute("noApprovalSignCountToday", String.valueOf(noApprovalSignCountToday));
		model.addAttribute("userName", userName);
		model.addAttribute("userNo", userNo);
		model.addAttribute("today", formatedNow);
				
		
		
		return "pay/approvalMain";
	}
	

	@ResponseBody
	@RequestMapping("/ajaxFix.do")
	public String ajaxFix(@RequestParam Map<String, Object> map
						, @RequestParam(value="equipmentName") List<String> equipmentName) {

		log.debug("ajaxFixmap : {}", equipmentName);
		log.debug("ajaxFixmap : {}", equipmentName.get(0));
		
		log.debug("ajaxFixmap : {}", map);
		List<Map<String, Object>> list = new ArrayList<>();
		if(equipmentName != null && !equipmentName.isEmpty()) {
			for(int i=0; i<equipmentName.size(); i++) {
				Map<String, Object> maps = new HashMap<>();
				maps.put("equipmentName", equipmentName.get(i));
				maps.put("registEmp", map.get("registEmp"));
				list.add(maps);
			}
		}
		
		log.debug("ajaxFixList : {}", list);
		
		int result = payService.ajaxFix(list);
		
		return result == list.size() ? "SUCCESS" : "FAIL";
	}
	
	
	@ResponseBody
	@GetMapping("/laterSearchDept.do")
	public List<Map<String, Object>> laterSearchDept(String keyword) {
		
		return payService.laterSearchDept(keyword);
		
	}
	
	
	@RequestMapping("/myReferrer.page")
	public String myReferrer(@RequestParam(value="page", defaultValue="1") int currentPage, HttpSession session, Model model){
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		
		String userName = payService.loginUserMember(userNo);
		int myReferrerCount = payService.myReferrerCount(userNo);
		PageInfoDto pi = pagingUtil.getPageInfoDto(myReferrerCount, currentPage, 5, 10);
		List<Map<String, Object>> list = payService.myReferrerList(userNo, pi);
		
		model.addAttribute("list", list);
		model.addAttribute("pi",pi);
		model.addAttribute("userName",userName);
		
		return "pay/myReferrer";
		
	}
	
	
	// 승인자 차례의 미결재함 전체검색
	@ResponseBody
	@GetMapping("/ajaxMyReferrer.do")
	public Map<String, Object> ajaxMyReferrer(@RequestParam(value="page", defaultValue="1") int currentPage
											, HttpSession session, String keyword) {
		
		
		int userNo = (int)((MemberDto)session.getAttribute("loginMember")).getUserNo();
		String userName = payService.loginUserMember(userNo);	
		Map<String, Object> mapUserMember = new HashMap<>();
		mapUserMember.put("userNo", userNo);
		mapUserMember.put("keyword", keyword);	
		
		int ajaxMyReferrerCount = payService.ajaxMyReferrerCount(mapUserMember);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(ajaxMyReferrerCount, currentPage, 5, 10);
		
		List<Map<String, Object>> list = payService.ajaxMyReferrerList(mapUserMember, pi);
		
		Map<String, Object> map = new HashMap<>();
		map.put("list", list);
		map.put("pi", pi);
		map.put("userName", userName);
		log.debug("list : {}", list);
		log.debug("pi : {}", pi);
		log.debug("userName : {}", userName);
		
		return map;
	}
	
	


}
