package com.br.project.controller.facility;

import static com.br.project.controller.common.CommonController.getParameterMap;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.service.facility.AttractionService;
import com.br.project.service.location.LocationService;
import com.br.project.util.FileUtil;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="/attraction")
@RequiredArgsConstructor
@Slf4j
public class AttractionController {

	private final AttractionService attractionService;
	private final LocationService locationService;
	private final PagingUtil pagingUtil;
	private final FileUtil fileUtil;
	
	/**
	 * @method : 어트랙션 목록조회
	 */
	@RequestMapping({"/list.do", "/manage.do"})
	public String selectAttractionList(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		
		StringBuffer requestURL = request.getRequestURL();
		
		try {
			PageInfoDto pageInfo = pagingUtil.getPageInfoDto(attractionService.selectTotalAttractionCount(getParameterMap(request))
														    ,Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"))
														    ,5, 10);
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("attractionList", attractionService.selectAttractionList(getParameterMap(request), pageInfo));
			request.setAttribute("locationList", locationService.selectLocationList());
			if(requestURL.indexOf("manage") != -1) {
				return "facility/attraction/attraction_manage";
			}else {				
				return "facility/attraction/attraction_list";
			}
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("alertTitle", requestURL.indexOf("manage") != -1 ? "어트랙션 관리서비스" : "어트랙션 조회서비스");
			redirectAttributes.addFlashAttribute("alertMsg", requestURL.indexOf("manage") != -1 ? "어트랙션 관리페이지 요청에 실패했습니다." : "어트랙션 목록조회에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	/**
	 * @method : 어트랙션 목록조회 (AJAX)
	 */
	@RequestMapping(value="/list.ajax", produces="application/json; charset=utf-8")
	@ResponseBody
	public HashMap<String, Object> ajaxSelectAttractionList(HttpServletRequest request){
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			PageInfoDto pageInfo = pagingUtil.getPageInfoDto(attractionService.selectTotalAttractionCount(getParameterMap(request))
														    ,Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"))
														    ,5, 10);
			resultMap.put("pageInfo", pageInfo);
			resultMap.put("attractionList", attractionService.selectAttractionList(getParameterMap(request), pageInfo));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	/**
	 * @method : 어트랙션 등록페이지
	 */
	@RequestMapping("/regist.page")
	public String showRegistPage(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		try {
			request.setAttribute("locationList", locationService.selectLocationList());
			return "facility/attraction/regist";
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("alertTitle", "어트랙션 등록서비스");
			redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 등록요청에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	/**
	 * @method : 어트랙션 등록
	 */
	@RequestMapping("/regist.do")
	public String insertAttraction(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		try {
			HashMap<String, Object> params = getParameterMap(request);
			MemberDto loginMember = (MemberDto)request.getSession().getAttribute("loginMember");
			params.put("registEmp", loginMember.getUserNo());
			params.put("modifyEmp", loginMember.getUserNo());
			params.put("manageEmp", loginMember.getUserNo());
			
			if(attractionService.insertAttraction(params) > 0) {
				redirectAttributes.addFlashAttribute("alertMsg", "어트랙션이 등록되었습니다.");
				return "redirect:/attraction/list.do";
			}else {
				redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 등록에 실패했습니다.");
				return "redirect:" + request.getHeader("Referer");
			}
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 등록에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}finally {
			redirectAttributes.addFlashAttribute("alertTitle", "어트랙션 등록서비스");
		}
	}
	
	/**
	 * @method : 어트랙션 정보수정 페이지
	 */
	@RequestMapping("/modify.page")
	public String showModifyPage(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		try {
			request.setAttribute("locationList", locationService.selectLocationList());
			request.setAttribute("attraction", attractionService.selectAttraction(getParameterMap(request)));
			return "facility/attraction/attraction_modify";
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("alertTitle", "어트랙션 수정서비스");
			redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 수정요청에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	/**
	 * @method : 어트랙션 정보수정
	 */
	@RequestMapping("/modify.do")
	public String modifyAttraction(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		try {
			HashMap<String, Object> params = getParameterMap(request);
			MemberDto loginMember = (MemberDto)request.getSession().getAttribute("loginMember");
			params.put("modifyEmp", loginMember.getUserNo());
			
			if(attractionService.updateAttraction(params) > 0) {
				redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 정보가 수정되었습니다.");
				return "redirect:/attraction/manage.do";
			}else {
				redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 정보수정에 실패했습니다.");
				return "redirect:" + request.getHeader("Referer");
			}
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 수정요청에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}finally {
			redirectAttributes.addFlashAttribute("alertTitle", "어트랙션 수정서비스");
			
		}
	}
	
	/**
	 * @method : 어트랙션 상세조회
	 */
	@RequestMapping("/detail.do")
	public String selectAttraction(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		try {
			HashMap<String, String> attraction = attractionService.selectAttraction(getParameterMap(request));
			if(attraction != null) {
				request.setAttribute("attraction", attraction);				
				return "facility/attraction/attraction_detail";
			}else {
				redirectAttributes.addFlashAttribute("alertTitle", "어트랙션 조회서비스");
				redirectAttributes.addFlashAttribute("alertMsg", "존재하지 않는 어트랙션입니다.");
				return "redirect:" + request.getHeader("Referer");
			}
		}catch(Exception e){
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("alertTitle", "어트랙션 조회서비스");
			redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 상세조회에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	
}
