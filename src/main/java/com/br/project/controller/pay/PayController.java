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
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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
			
		List<PayDto> list = payServiceImpl.paymainPage(pi);
		
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payServiceImpl.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payServiceImpl.successListCount(userName);
		// 로그인한 사용자의 전체수신갯수
		int ulistCount = payServiceImpl.allUserCount(userName);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		model.addAttribute("paymain", "paymain");
		
		
		
		return "pay/paymain";
	}
	
	//결재메인페이지카테고리&검색---------------------
	@GetMapping("/search.do")
	public ModelAndView searchList(@RequestParam Map<String, String> search
								 , @RequestParam(value="page", defaultValue="1") int currentPage
								 , ModelAndView mv, HttpSession session) {
		
		String userName = ((MemberDto)session.getAttribute("loginMember")).getUserName();
		//개시글총갯수
		int listCount = payServiceImpl.selectListCount();
		
		//검색한갯수조회
		int searchlistCount = payServiceImpl.searchListCount(search);
		//페이지
		PageInfoDto pi = pagingUtil.getPageInfoDto(searchlistCount, currentPage, 5, 10);
		//리스트
		List<PayDto> list = payServiceImpl.searchList(pi, search);
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payServiceImpl.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payServiceImpl.successListCount(userName);
		// 로그인한 사용자의 전체수신갯수
		int ulistCount = payServiceImpl.allUserCount(userName);

		
		mv.addObject("list", list)
		  .addObject("pi", pi)
		  .addObject("search", search)
		  .addObject("searchlistCount", searchlistCount)
		  .addObject("listCount", String.valueOf(listCount))		  
		  .addObject("mdCount", String.valueOf(mdCount))
		  .addObject("slistCount", String.valueOf(slistCount))
		  .addObject("ulistCount", String.valueOf(ulistCount))
		  .setViewName("pay/paymain");
		
		
		return mv;
		
	}
	//----------------------------------------
	
	@RequestMapping(value="/selectList.do")
	public String selectList(HttpServletRequest request,
			 @RequestParam (value="page", defaultValue="1") int currentPage
						, Model model, HttpSession session) {
		
		String userName = ((MemberDto)session.getAttribute("loginMember")).getUserName();
		
		Map<String, Object> params = new HashMap<String, Object>();
		
		params = CommonController.getParameterMap(request);
		log.debug(request.toString());
		//(카테고리별)페이지갯수
		int clistCount = payServiceImpl.slistCount(params);
	
		//페이지
		PageInfoDto pi =  pagingUtil.getPageInfoDto(clistCount, currentPage, 5, 10);
		//리스트
		List<PayDto> list = payServiceImpl.categoryList(params, pi);
		
		//개시글총갯수
		int listCount = payServiceImpl.selectListCount();
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payServiceImpl.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payServiceImpl.successListCount(userName);
		// 로그인한 사용자의 전체수신갯수
		int ulistCount = payServiceImpl.allUserCount(userName);

		
		model.addAttribute("clistCount", clistCount);
		model.addAttribute("params", params);
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		
		
		return "pay/paymain";
		
	}
	
	// 메인결재 상세페이지목록클릭-----------------------
	@RequestMapping("/detail.do")
	public String detail(@RequestParam Map<String, Object> map, Model model
						, HttpSession session) {
		
		
		String userName = ((MemberDto)session.getAttribute("loginMember")).getUserName();
		int userNo = ((MemberDto)session.getAttribute("loginMember")).getUserNo();
		if(map.get("documentType").equals("매출보고서")) {
			List<Map<String, Object>> list = payServiceImpl.expendDetail(map);
			model.addAttribute("list", list);
			model.addAttribute("userNo", userNo);
			model.addAttribute("userName", userName);
			log.debug("list : {}", list);
			return "pay/expendDetail";
		}
		
		return "pay/expendDetail";
		
		/*else if(documentType.equals("비품신청서")){
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
		*/
		
	}
	
	//메인페이지 로그인한 유저의 전체결재 수신함--------------------------
	@GetMapping("/allUserlist.do")
	public String allUserlist(@RequestParam (value="page", defaultValue="1") int currentPage
								,HttpSession session, Model model) {
		
		
		// userName
		String userName  = ((MemberDto)session.getAttribute("loginMember")).getUserName();
		
		log.debug("userName : {}", userName);
		
		//로그인한 유저 승인자결재함목록갯수
		int ulistCount = payServiceImpl.allUserCount(userName);
		log.debug("ulistCount : {}", ulistCount);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(ulistCount, currentPage, 5, 10);
		
		//로그인한 유저 승인자결재함목록리스트
		List<PayDto> list = payServiceImpl.allUserList(userName, pi);
		
		//개시글총갯수
		int listCount = payServiceImpl.selectListCount();
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payServiceImpl.moreDateCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payServiceImpl.successListCount(userName);
		
		log.debug("list : {}", list);
		
		model.addAttribute("list", list);
		model.addAttribute("pi", pi);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		model.addAttribute("userAllList", "userAllList");
		
		return "pay/paymain";
		
	}
	//-------------------------------------------------------
	
	
	//글작성페이지폼-------------------------------------------
	@RequestMapping("/mWriterForm.do")
	public String mWriterForm(Model model, HttpSession session) {
		
		//로그인한 유저의 팀이름 + 부서 + 직급
		MemberDto loginMember = (MemberDto)session.getAttribute("loginMember");
		List<MemberDeptDto> member = payServiceImpl.selectloginUserDept(loginMember);
			
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
			if(list.get(i).getDeptName().equals("FB")) {
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
			if(list.get(i).getDeptName().equals("인사부")) {
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
			if(list.get(i).getDeptName().equals("서비스부")) {
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
		model.addAttribute("member", member);
		
		log.debug("maDeptList : {}", maDeptList);
		
		return "pay/mWriterForm";
		
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
		
		int result = payServiceImpl.mReportInsert(map, list);
		
		
		if(result == list.size()) {
			redirectAttributes.addFlashAttribute("alertTitle", "게시글등록");
			redirectAttributes.addFlashAttribute("alertMsg", "등록이 성공적으로 완료되었습니다.");
		}
		
		
		return "redirect:/pay/paymain.page";
	}
	
	@RequestMapping("/reject.do")
	public String reject(@RequestParam Map<String, Object> map, HttpSession session) {
		
		int result = payServiceImpl.updateReject(map);
		
		if(result == 1) {
			session.setAttribute("alertMsg", "성공적으로 제출이 완료되었습니다.");
		}
		
		return "pay/paymain"; 
		
	}
	
	
	@RequestMapping("/mModify.do")
	public String mModify(@RequestParam Map<String, Object> map, Model model
						  , HttpSession session) {
		
		List<Map<String, Object>> list = payServiceImpl.expendModify(map);
		
		//-------------------------------------
		//로그인한 유저의 팀이름, 부서, 팀명, 직급
		MemberDto loginMember = (MemberDto)session.getAttribute("loginMember");
		List<MemberDeptDto> member = payServiceImpl.selectloginUserDept(loginMember);
			
		List<MemberDeptDto> list2 = payServiceImpl.selectDepartment();
		List<Map<String, Object>> maDeptList = new ArrayList<>();
		List<Map<String, Object>> operatDeptList = new ArrayList<>();
		List<Map<String, Object>> marketDeptList = new ArrayList<>();
		List<Map<String, Object>> fbDeptList = new ArrayList<>();
		List<Map<String, Object>> hrDeptList = new ArrayList<>();
		List<Map<String, Object>> serviceDeptList = new ArrayList<>();
		
		
		
		// 총무부의 이름, 팀이름, 직급(부장,과장,차장)
		
		for(int i=0; i<list.size(); i++) {
			Map<String, Object> managementDept = new HashMap<>();;
			if(list2.get(i).getDeptName().equals("총무부")) {
				managementDept.put("userNo", list2.get(i).getUserNo());
				managementDept.put("userName", list2.get(i).getUserName());
				managementDept.put("teamName", list2.get(i).getTeamName());
				managementDept.put("positionName", list2.get(i).getPositionName());
				managementDept.put("deptName", list2.get(i).getDeptName());
				maDeptList.add(managementDept);
			}
		}
		
		// 운영부의 이름, 팀이름, 직급(부장,과장,차장)
		
		
		for(int i=0; i<list.size(); i++) {
			if(list2.get(i).getDeptName().equals("운영부")) {
				Map<String, Object> operationsDept = new HashMap<>();
				operationsDept.put("userNo", list2.get(i).getUserNo());
				operationsDept.put("userName", list2.get(i).getUserName());
				operationsDept.put("teamName", list2.get(i).getTeamName());
				operationsDept.put("positionName", list2.get(i).getPositionName());
				operationsDept.put("deptName", list2.get(i).getDeptName());
				operatDeptList.add(operationsDept);
				
			}
		}
		
		// 마케팅부의 이름, 팀이름, 직급(부장,과장,차장)
		
		
		for(int i=0; i<list.size(); i++) {
			if(list2.get(i).getDeptName().equals("마케팅부")) {
				Map<String, Object> marketingDept = new HashMap<>();
				marketingDept.put("userNo", list2.get(i).getUserNo());
				marketingDept.put("userName", list2.get(i).getUserName());
				marketingDept.put("teamName", list2.get(i).getTeamName());
				marketingDept.put("positionName", list2.get(i).getPositionName());
				marketingDept.put("deptName", list2.get(i).getDeptName());
				marketDeptList.add(marketingDept);
			}
		}
		
		// fb(호텔 운영부)의 이름, 팀이름, 직급(부장,과장,차장)
		for(int i=0; i<list.size(); i++) {
			if(list2.get(i).getDeptName().equals("FB")) {
				Map<String, Object> fbDept = new HashMap<>();
				fbDept.put("userNo", list2.get(i).getUserNo());
				fbDept.put("userName", list2.get(i).getUserName());
				fbDept.put("teamName", list2.get(i).getTeamName());
				fbDept.put("positionName", list2.get(i).getPositionName());
				fbDept.put("deptName", list2.get(i).getDeptName());
				fbDeptList.add(fbDept);
			}
		}
		
		
		// 인사부의 이름, 팀이름, 직급(부장,과장,차장)
		for(int i=0; i<list.size(); i++) {
			if(list2.get(i).getDeptName().equals("인사부")) {
				Map<String, Object> hrDept = new HashMap<>();
				hrDept.put("userNo", list2.get(i).getUserNo());
				hrDept.put("userName", list2.get(i).getUserName());
				hrDept.put("teamName", list2.get(i).getTeamName());
				hrDept.put("positionName", list2.get(i).getPositionName());
				hrDept.put("deptName", list2.get(i).getDeptName());
				hrDeptList.add(hrDept);
			}
		}
		
		// 서비스부의 이름, 팀이름, 직급(부장,과장,차장)
		for(int i=0; i<list.size(); i++) {
			if(list2.get(i).getDeptName().equals("서비스부")) {
				Map<String, Object> serviceDept = new HashMap<>();
				serviceDept.put("userNo", list2.get(i).getUserNo());
				serviceDept.put("userName", list2.get(i).getUserName());
				serviceDept.put("teamName", list2.get(i).getTeamName());
				serviceDept.put("positionName", list2.get(i).getPositionName());
				serviceDept.put("deptName", list2.get(i).getDeptName());
				serviceDeptList.add(serviceDept);
			}
		}
		
		model.addAttribute("maDeptList", maDeptList);
		model.addAttribute("operatDeptList", operatDeptList);
		model.addAttribute("marketDeptList", marketDeptList);
		model.addAttribute("fbDeptList", fbDeptList);
		model.addAttribute("hrDeptList", hrDeptList);
		model.addAttribute("serviceDeptList", serviceDeptList);
		model.addAttribute("member", member);
		//-------------------------------------
		model.addAttribute("list", list);
		
		return "pay/mWriterForm";
		
	}
	
	//로그인한 사용자 전체수신결재함
	@RequestMapping("/userSelectList.do")
	public String userSelectList(@RequestParam (value="page", defaultValue="1") int currenPage
								, Model model, @RequestParam Map<String, Object> map
								, HttpSession session) {
		String userName = (String)((MemberDto)session.getAttribute("loginMember")).getUserName();
		
		map.put("userName", userName);
		int userSelectListCount = payServiceImpl.userSelectListCount(map);
		
		PageInfoDto pi = pagingUtil.getPageInfoDto(userSelectListCount, currenPage, 5, 10);
		
		List<PayDto> list = payServiceImpl.userSelectList(map, pi);
		
		
		//개시글총갯수
		int listCount = payServiceImpl.selectListCount();
		//로그인한 사용자의 일주일이상승인완료가 안된 게시글총갯수
		int mdCount = payServiceImpl.moreDateCount(userName);
		int ulistCount = payServiceImpl.allUserCount(userName);
		//로그인한 사용자의 결재한 내역 게시글 총갯수
		int slistCount = payServiceImpl.successListCount(userName);
		
		model.addAttribute("pi", pi);
		model.addAttribute("list", list);
		model.addAttribute("listCount", String.valueOf(listCount));		
		model.addAttribute("mdCount", String.valueOf(mdCount));
		model.addAttribute("slistCount", String.valueOf(slistCount));
		model.addAttribute("ulistCount", String.valueOf(ulistCount));
		model.addAttribute("map", map);
		model.addAttribute("userAllListSelect", "userAllListSelect");
		
		
		
		return "pay/paymain";
	}
	
	
	
	

	
	
	

}
