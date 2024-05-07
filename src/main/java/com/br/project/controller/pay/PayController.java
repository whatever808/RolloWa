package com.br.project.controller.pay;




import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.br.project.dto.common.PageInfoDto;
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
		
		//로그인한 유저의 이름값 꺼내기
		//MemberDto loginUser = (MemeberDto)session.getAttribute("loginUser");
		//String userName = loginUser.getUserName();
		//userName 전달 = > 해야됨
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
	
	
	//메인결재 보고서 카테고리----------------------
	@GetMapping(value="/selects.do")
	public String selectList(String conditions, @RequestParam (value="page", defaultValue="1") int currentPage
						, Model model) {
		
		//(카테고리별)페이지갯수
		int clistCount = payServiceImpl.slistCount(conditions);
		
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
	//---------------------------------------------
	
	// 메인결재 상세페이지목록클릭-----------------------
	@RequestMapping("/detail.do")
	public String detail(PayDto pDto, Model model) {
		
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
	
	
	@GetMapping("/tomWriter.do")
	public void tomWriter() {
		
	}
	

	
	
	

}
