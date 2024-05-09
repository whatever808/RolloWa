package com.br.project.controller.pay;




import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.br.project.controller.common.CommonController;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.dto.pay.MemberDeptDto;
import com.br.project.dto.pay.PayDto;
import com.br.project.service.pay.PayServiceImpl;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RequestMapping("/pay")
@RequiredArgsConstructor
@Controller
public class PayController {
	
	private final PayServiceImpl payServiceImpl;
	private final PagingUtil pagingUtil;
	
	//결재메인페이지
	
	@RequestMapping(value="/paymain.page")
	public String paymainPage(@RequestParam(value="page", defaultValue="1") int currentPage, 
							   Model model, HttpSession session) {
		//개시글총갯수
		int listCount = payServiceImpl.selectListCount();
		
		//페이지인포객체 생성
		PageInfoDto pi =  pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		
		String userName = (String)((MemberDto)session.getAttribute("loginMember")).getUserName();
		//로그인한 유저의 전체수신결재함(총갯수)
		int userPayCount = payServiceImpl.userPayCount(userName);
				
		List<PayDto> list = payServiceImpl.paymainPage(pi);
		
		//일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payServiceImpl.moreDateCount();
		//결재내역 게시글 총갯수
		int slistCount = payServiceImpl.successListCount();
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		
		
		
		return "pay/paymain";
	}
	
	//결재메인페이지카테고리&검색---------------------
	@GetMapping("/search.do")
	public ModelAndView searchList(@RequestParam Map<String, String> search
								 , @RequestParam(value="page", defaultValue="1") int currentPage
								 , ModelAndView mv) {
		
		
		//갯수조회
		int listCount = payServiceImpl.searchListCount(search);
		//페이지
		PageInfoDto pi = pagingUtil.getPageInfoDto(listCount, currentPage, 5, 10);
		//리스트
		List<PayDto> list = payServiceImpl.searchList(pi, search);
		//일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payServiceImpl.moreDateCount();
		//결재내역 게시글 총갯수
		int slistCount = payServiceImpl.successListCount();
		
		
		mv.addObject("list", list)
		  .addObject("pi", pi)
		  .addObject("search", search)
		  .addObject("listCount", listCount)
		  .addObject("mdCount", String.valueOf(mdCount))
		  .addObject("slistCount", String.valueOf(slistCount))
		  .setViewName("pay/paymain");
		
		
		return mv;
		
	}
	//----------------------------------------
	
	@RequestMapping(value="/selectList.do")
	public String selectList(HttpServletRequest request,
			 @RequestParam (value="page", defaultValue="1") int currentPage
						, Model model) {
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params = CommonController.getParameterMap(request);
		log.debug(request.toString());
		//(카테고리별)페이지갯수
		int clistCount = payServiceImpl.slistCount(params);
		
		//일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payServiceImpl.moreDateCount();
		
		//결재내역 게시글 총갯수
		int slistCount = payServiceImpl.successListCount();
		
		//페이지
		PageInfoDto pi =  pagingUtil.getPageInfoDto(clistCount, currentPage, 5, 10);
		
		//리스트
		List<PayDto> list = payServiceImpl.categoryList(params, pi);
		
		model.addAttribute("clistCount", clistCount);
		model.addAttribute("params", params);
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		
		
		return "pay/paymain";
		
	}
	
	/*
	//메인결재 보고서 카테고리----------------------
	@GetMapping(value="/selects.do")
	public String selectList(String conditions, @RequestParam (value="page", defaultValue="1") int currentPage
						, Model model) {
		
		//(카테고리별)페이지갯수
		int clistCount = 1;//payServiceImpl.slistCount(conditions);
		
		//일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payServiceImpl.moreDateCount();
		
		//결재내역 게시글 총갯수
		int slistCount = payServiceImpl.successListCount();
		
		//페이지
		PageInfoDto pi =  pagingUtil.getPageInfoDto(clistCount, currentPage, 5, 10);
		
		//리스트
		List<PayDto> list = payServiceImpl.categoryList(conditions, pi);
		
		model.addAttribute("clistCount", clistCount);
		model.addAttribute("slistCount", slistCount);
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("conditions", conditions);
		
		return "pay/paymain";
		
	}
	*/
	//---------------------------------------------
	
	/*
	//메인결재 보고서 카테고리----------------------
		@GetMapping(value="/status.do")
		public String statusList(String status, @RequestParam (value="page", defaultValue="1") int currentPage
							, Model model) {
			
			//(카테고리별)페이지갯수
			int clistCount = 1;//payServiceImpl.slistCount(status);
			
			//일주일이상승인완료가 안된 게시글총갯수
			int mdCount = payServiceImpl.moreDateCount();
			
			//결재내역 게시글 총갯수
			int slistCount = payServiceImpl.successListCount();
			
			//페이지
			PageInfoDto pi =  pagingUtil.getPageInfoDto(clistCount, currentPage, 5, 10);
			
			//리스트
			List<PayDto> list = payServiceImpl.statusList(status, pi);
			
			model.addAttribute("clistCount", clistCount);
			model.addAttribute("slistCount", slistCount);
			model.addAttribute("mdCount", String.valueOf(mdCount));
			model.addAttribute("slistCount", String.valueOf(slistCount));
			model.addAttribute("pi", pi);
			model.addAttribute("list", list);
			model.addAttribute("status", status);
			
			return "pay/paymain";
			
		}
		//---------------------------------------------
		*/
	
	
	// 메인결재 상세페이지목록클릭-----------------------
	@RequestMapping("/detail.do")
	public String detail(PayDto pDto, Model model) {
		log.debug("documentType : {}", pDto.getDocumentType() );
		log.debug("dto : {}", pDto );
		String documentType = pDto.getDocumentType();
		if(documentType.equals("매출보고서")) {
			PayDto payDto = payServiceImpl.mdetail(pDto);
			model.addAttribute("payDto", payDto);
			return "pay/mdetail";
		}else if(documentType.equals("비품신청서")){
			PayDto payDto = payServiceImpl.bdetail(pDto);
			model.addAttribute("payDto", payDto);
			return "pay/bdetail";
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
		
	}
	
	//메인페이지 로그인한 유저의 전체결재 수신함--------------------------
	@GetMapping("/allUserlist.do")
	public String allUserlist(@RequestParam (value="page", defaultValue="1") int currentPage
								,HttpSession session, Model model) {
		
		//session 멤버객체
		MemberDto loginMember = (MemberDto)session.getAttribute("loginMember");
		// 로그인한 userName
		String userName = loginMember.getUserName();
		log.debug("userName : {}", userName);
		
		//로그인한 유저의 승인자결재목록갯수
		int ulistCount = payServiceImpl.allUserCount(userName);
		
		//페이지
		PageInfoDto pi = pagingUtil.getPageInfoDto(ulistCount, ulistCount, 5, 10);
		
		//로그인한 유저의 승인자결재목록리스트
		List<PayDto> list = payServiceImpl.allUserList(userName, pi);
		
		//일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payServiceImpl.moreDateCount();
		
		//결재내역 게시글 총갯수
		int slistCount = payServiceImpl.successListCount();
		
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("ulistCount", ulistCount);
		model.addAttribute("mdCount", mdCount);
		model.addAttribute("slistCount", slistCount);
		
		return "pay/paymain";
		
	}
	//-------------------------------------------------------
	
	
	//글작성페이지폼-------------------------------------------
	@RequestMapping("/mWriterForm.do")
	public String mWriterForm(Model model) {
		
		List<MemberDeptDto> list = payServiceImpl.selectDepartment();
		List<Map<String, Object>> maDeptList = new ArrayList<>();
		List<Map<String, Object>> operatDeptList = new ArrayList<>();
		List<Map<String, Object>> marketDeptList = new ArrayList<>();
		List<Map<String, Object>> fbDeptList = new ArrayList<>();
		List<Map<String, Object>> hrDeptList = new ArrayList<>();
		List<Map<String, Object>> serviceDeptList = new ArrayList<>();
		
		// 총무부의 이름, 팀이름, 직급(부장,과장,차장)
		
		for(int i=0; i<list.size(); i++) {
			Map<String, Object> managementDept = new HashMap<>();;
			if(list.get(i).getDeptName().equals("총무부")) {
				managementDept.put("userNo", list.get(i).getUserNo());
				managementDept.put("userName", list.get(i).getUserName());
				managementDept.put("teamName", list.get(i).getTeamName());
				managementDept.put("positionName", list.get(i).getPositionName());
				managementDept.put("deptName", list.get(i).getDeptName());
				maDeptList.add(managementDept);
			}
		}
		
		// 운영부의 이름, 팀이름, 직급(부장,과장,차장)
		
		
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).getDeptName().equals("운영부")) {
				Map<String, Object> operationsDept = new HashMap<>();
				operationsDept.put("userNo", list.get(i).getUserNo());
				operationsDept.put("userName", list.get(i).getUserName());
				operationsDept.put("teamName", list.get(i).getTeamName());
				operationsDept.put("positionName", list.get(i).getPositionName());
				operationsDept.put("deptName", list.get(i).getDeptName());
				operatDeptList.add(operationsDept);
				
			}
		}
		
		// 마케팅부의 이름, 팀이름, 직급(부장,과장,차장)
		
		
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).getDeptName().equals("마케팅부")) {
				Map<String, Object> marketingDept = new HashMap<>();
				marketingDept.put("userNo", list.get(i).getUserNo());
				marketingDept.put("userName", list.get(i).getUserName());
				marketingDept.put("teamName", list.get(i).getTeamName());
				marketingDept.put("positionName", list.get(i).getPositionName());
				marketingDept.put("deptName", list.get(i).getDeptName());
				marketDeptList.add(marketingDept);
			}
		}
		
		// fb(호텔 운영부)의 이름, 팀이름, 직급(부장,과장,차장)
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).getDeptName().equals("마케팅부")) {
				Map<String, Object> fbDept = new HashMap<>();
				fbDept.put("userNo", list.get(i).getUserNo());
				fbDept.put("userName", list.get(i).getUserName());
				fbDept.put("teamName", list.get(i).getTeamName());
				fbDept.put("positionName", list.get(i).getPositionName());
				fbDept.put("deptName", list.get(i).getDeptName());
				fbDeptList.add(fbDept);
			}
		}
		
		
		// 인사부의 이름, 팀이름, 직급(부장,과장,차장)
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).getDeptName().equals("FB")) {
				Map<String, Object> hrDept = new HashMap<>();
				hrDept.put("userNo", list.get(i).getUserNo());
				hrDept.put("userName", list.get(i).getUserName());
				hrDept.put("teamName", list.get(i).getTeamName());
				hrDept.put("positionName", list.get(i).getPositionName());
				hrDept.put("deptName", list.get(i).getDeptName());
				hrDeptList.add(hrDept);
			}
		}
		
		// 서비스부의 이름, 팀이름, 직급(부장,과장,차장)
		for(int i=0; i<list.size(); i++) {
			if(list.get(i).getDeptName().equals("FB")) {
				Map<String, Object> serviceDept = new HashMap<>();
				serviceDept.put("userNo", list.get(i).getUserNo());
				serviceDept.put("userName", list.get(i).getUserName());
				serviceDept.put("teamName", list.get(i).getTeamName());
				serviceDept.put("positionName", list.get(i).getPositionName());
				serviceDept.put("deptName", list.get(i).getDeptName());
				serviceDeptList.add(serviceDept);
			}
		}
		
		
		model.addAttribute("maDeptList", maDeptList);
		model.addAttribute("operatDeptList", operatDeptList);
		model.addAttribute("marketDeptList", marketDeptList);
		model.addAttribute("fbDeptList", fbDeptList);
		model.addAttribute("hrDeptList", hrDeptList);
		model.addAttribute("serviceDeptList", serviceDeptList);
		
		log.debug("maDeptList : {}", maDeptList);
		
		return "pay/mWriterForm";
		
	}
	//----------------------------------------------------
	
	
	
	
	
	
	
	
	
	

	
	
	

}
