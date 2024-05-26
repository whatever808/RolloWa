package com.br.project.controller.facility.attraction;

import static com.br.project.controller.common.CommonController.getParameterMap;

import java.io.File;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.service.facility.attraction.AttractionService;
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
	@RequestMapping({"/list.do", "manage/list.do"})
	public String selectAttractionList(HttpServletRequest request, RedirectAttributes redirectAttributes, @RequestParam(value="locations[]", required=false) List<String> locations) {
		
		StringBuffer requestURL = request.getRequestURL();
		
		HashMap<String, Object> params = getParameterMap(request);
		if(locations != null && !locations.isEmpty()) {
			params.put("locations", locations);			
		}
		
		try {
			PageInfoDto pageInfo = pagingUtil.getPageInfoDto(attractionService.selectTotalAttractionCount(params)
														    ,Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"))
														    ,5, requestURL.indexOf("manage") != -1 ? 10 : 5);
			request.setAttribute("pageInfo", pageInfo);
			request.setAttribute("attractionList", attractionService.selectAttractionList(params, pageInfo));
			request.setAttribute("locationList", locationService.selectLocationList());
			if(requestURL.indexOf("manage") != -1) {
				return "facility/attraction/attraction_manage";
			}else {				
				return "facility/attraction/attraction_list";
			}
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("modalColor", "R");
			redirectAttributes.addFlashAttribute("alertTitle", requestURL.indexOf("manage") != -1 ? "어트랙션 관리서비스" : "어트랙션 조회서비스");
			redirectAttributes.addFlashAttribute("alertMsg", requestURL.indexOf("manage") != -1 ? "어트랙션 관리페이지 요청에 실패했습니다." : "어트랙션 목록조회에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	/**
	 * @method : 어트랙션 목록조회 (AJAX)
	 */
	@RequestMapping(value={"/list.ajax", "manage/list.ajax"}, produces="application/json; charset=utf-8")
	@ResponseBody
	public HashMap<String, Object> ajaxSelectAttractionList(HttpServletRequest request, @RequestParam(value="locations[]", required=false) List<String> locations){
		
		StringBuffer requestURL = request.getRequestURL();
		
		HashMap<String, Object> params = getParameterMap(request);
		if(locations != null && !locations.isEmpty()) {
			params.put("locations", locations);			
		}
		
		HashMap<String, Object> resultMap = new HashMap<>();
		try {
			PageInfoDto pageInfo = pagingUtil.getPageInfoDto(attractionService.selectTotalAttractionCount(params)
														    ,Integer.parseInt(request.getParameter("page") == null ? "1" : request.getParameter("page"))
														    ,5, requestURL.indexOf("manage") != -1 ? 10 : 5);
			resultMap.put("pageInfo", pageInfo);
			resultMap.put("attractionList", attractionService.selectAttractionList(params, pageInfo));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return resultMap;
	}
	
	/**
	 * @method : 어트랙션 상세조회
	 */
	@RequestMapping(value="/detail.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public HashMap<String, Object> selectAttraction(HttpServletRequest request) {
		return attractionService.selectAttraction(getParameterMap(request));
	}
	
	/**
	 * @method : 어트랙션 등록페이지
	 */
	@RequestMapping("/regist.page")
	public String showRegistPage(HttpServletRequest request, RedirectAttributes redirectAttributes) {
		try {
			request.setAttribute("locationList", locationService.selectLocationList());
			return "facility/attraction/attraction_regist";
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("modalColor", "R");
			redirectAttributes.addFlashAttribute("alertTitle", "어트랙션 등록서비스");
			redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 등록요청에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	/**
	 * @method : 어트랙션 등록
	 */
	@RequestMapping("/regist.do")
	public String insertAttraction(MultipartHttpServletRequest request, RedirectAttributes redirectAttributes) {
		try {
			HashMap<String, Object> params = getParameterMap(request);
			MemberDto loginMember = (MemberDto)request.getSession().getAttribute("loginMember");
			params.put("registEmp", loginMember.getUserNo());
			params.put("modifyEmp", loginMember.getUserNo());
			params.put("manageEmp", loginMember.getUserNo());
			params.put("thumbnailURL", fileUtil.getFileUrl(request.getFile("thumbnail"), "attraction"));
			
			if(attractionService.insertAttraction(params) > 0) {
				redirectAttributes.addFlashAttribute("modalColor", "G");
				redirectAttributes.addFlashAttribute("alertMsg", "어트랙션이 등록되었습니다.");
				return "redirect:/attraction/list.do";
			}else {
				redirectAttributes.addFlashAttribute("modalColor", "R");
				redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 등록에 실패했습니다.");
				return "redirect:" + request.getHeader("Referer");
			}
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("modalColor", "R");
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
			redirectAttributes.addFlashAttribute("modalColor", "R");
			redirectAttributes.addFlashAttribute("alertTitle", "어트랙션 수정서비스");
			redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 수정요청에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	/**
	 * @method : 어트랙션 정보수정
	 */
	@RequestMapping("/modify.do")
	public String modifyAttraction(MultipartHttpServletRequest request, RedirectAttributes redirectAttributes) {
		try {
			// 기존 업로드 대표이미지 삭제
			int idx = request.getParameter("oldThumbnailURL").lastIndexOf("/");
			String oldThumbnailFileName = request.getParameter("oldThumbnailURL").substring(idx + 1);
			String oldThumbnailFilePath = request.getParameter("oldThumbnailURL").substring(0 ,idx);
			new File(oldThumbnailFilePath, oldThumbnailFileName).delete();
			
			HashMap<String, Object> params = getParameterMap(request);
			MemberDto loginMember = (MemberDto)request.getSession().getAttribute("loginMember");
			params.put("modifyEmp", loginMember.getUserNo());
			params.put("thumbnailURL", fileUtil.getFileUrl(request.getFile("thumbnail"), "attraction"));
			
			if(attractionService.updateAttraction(params) > 0) {
				redirectAttributes.addFlashAttribute("modalColor", "G");
				redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 정보가 수정되었습니다.");
				return "redirect:/attraction/manage/list/do";
			}else {
				redirectAttributes.addFlashAttribute("modalColor", "R");
				redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 정보수정에 실패했습니다.");
				return "redirect:" + request.getHeader("Referer");
			}
		}catch(Exception e) {
			e.printStackTrace();
			redirectAttributes.addFlashAttribute("modalColor", "R");
			redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 수정요청에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}finally {
			redirectAttributes.addFlashAttribute("alertTitle", "어트랙션 수정서비스");
		}
	}
	
	/**
	 * @method : 어트랙션 이용률 관리페이지
	 */
	@RequestMapping("/utilization.do")
	public String showAttractionUtilizationPage() {
		return "facility/attraction/attraction_utilization";
	}
	
	
	
}
