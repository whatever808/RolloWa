package com.br.project.controller.facility.attraction;

import static com.br.project.controller.common.CommonController.getParameterMap;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
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
			// 파라미터값
			HashMap<String, Object> params = getParameterMap(request);
			MemberDto loginMember = (MemberDto)request.getSession().getAttribute("loginMember");
			params.put("modifyEmp", loginMember.getUserNo());
			params.put("thumbnailURL", request.getParameter("oldThumbnailURL"));
			
			// 신규 업로드 대표이미지 저장
			MultipartFile newThumbnail = request.getFile("thumbnail");
			String newThumbnailURL = null;
			if(newThumbnail != null) {
				newThumbnailURL = fileUtil.getFileUrl(newThumbnail, "attraction");
				params.put("thumbnailURL", newThumbnailURL);				
			}
			
			if(attractionService.updateAttraction(params) > 0) {
				redirectAttributes.addFlashAttribute("modalColor", "G");
				redirectAttributes.addFlashAttribute("alertMsg", "어트랙션 정보가 수정되었습니다.");
				return "redirect:/attraction/manage/list.do";
			}else {
				if(newThumbnailURL != null) {
					new File(newThumbnailURL).delete();
				}
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
	public String showAttractionUtilizationListPage(HttpServletRequest request, HttpSession session) {
		try {
			/*
			HashMap<String, Object> params = getParameterMap(request);
			if(params != null && !params.isEmpty()) {
				List<Map<String, String>> compareList = new ArrayList<>();
				for(int i=0 ; i<((String[])params.get("attractionNo")).length ; i++) {
					Map<String, String> attraction = new HashMap<>();
					
					attraction.put("attractionNo", ((String[])params.get("attractionNo"))[i]);
					attraction.put("attractionName", ((String[])params.get("attractionName"))[i]);
					
					compareList.add(attraction);
				}
				session.setAttribute("attractionCompareList", compareList);
			}
			*/
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			request.setAttribute("locationList", locationService.selectLocationList());
		}
		
		return "facility/attraction/attraction_utilization_list";
	}
	
	/**
	 * @method : 연간, 월간, 일간 어트랙션 이용률 리스트
	 */
	@RequestMapping(value="/utilization/list.ajax", produces="application/json; charset=utf-8")
	@ResponseBody
	public Map<String, Object> ajaxSelectAttractionUtilizationList(HttpServletRequest request){
		HashMap<String, Object> params = getParameterMap(request);
		PageInfoDto pageInfo = pagingUtil.getPageInfoDto(attractionService.selectUsingAttractionCount(params), Integer.parseInt(request.getParameter("page")), 5, 10);
		List<Map<String, Object>> usageList = attractionService.selectAttractionUtilizationList(params, pageInfo);
		
		Map<String, Object> response = new HashMap<>();
		response.put("pageInfo", pageInfo);
		response.put("usageList", usageList);
		
		return response;
	}
	
	/**
	 * @method : 어트랙션 이용률 상세조회 페이지
	 */
	@RequestMapping("/utilization/detail.page")
	public String showAttractionUtilizationPage(HttpServletRequest request) {
		try {
			HashMap<String, Object> params = getParameterMap(request);
			for(String key : params.keySet()) {
				request.setAttribute(key, params.get(key));
			}
			request.setAttribute("attraction", attractionService.selectAttraction(getParameterMap(request)));
		}catch(Exception e){
			e.printStackTrace();
		}
		return "/facility/attraction/attraction_utilization_detail";
	}
	
	/**
	 * @method : 월별 or 일별 어트랙션 이용률
	 */
	@RequestMapping(value="/utilization/detail.ajax", produces="application/json; charset=utf-8")
	@ResponseBody
	public List<Map<String, Object>> ajaxSelectAttractionUtilization(HttpServletRequest request){
		return attractionService.selectAttractionUtilization(getParameterMap(request));
	}
	
	/**
	 * @method : 어트랙션 이용률 비교 페이지 이동
	 */
	@RequestMapping("/utilization/compare.page")
	public String showAttractionUtilizationComparePage(HttpServletRequest request) {
		try {
			/*
			HashMap<String, Object> params = getParameterMap(request);
			if(params != null && !params.isEmpty()) {
				List<Map<String, String>> compareList = new ArrayList<>();
				for(int i=0 ; i<((String[])params.get("attractionNo")).length ; i++) {
					Map<String, String> attraction = new HashMap<>();
					attraction.put("attractionNo", ((String[])params.get("attractionNo"))[i]);
					attraction.put("attractionName", ((String[])params.get("attractionName"))[i]);
					compareList.add(attraction);
				}
				session.setAttribute("attractionCompareList", compareList);
			}
			*/
			request.setAttribute("year", request.getParameter("year"));
			request.setAttribute("month", request.getParameter("month"));
		}catch(Exception e) {
			e.printStackTrace();
		}
		return "facility/attraction/attraction_utilization_compare";
	}
	
	/**
	 * @method : 세션영역의 이용률 비교 어트랙션 리스트에 어트랙션 추가
	 */
	@RequestMapping(value="/utilization/compare/insert.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public void insertAttractionCompareList(HttpServletRequest request, HttpSession session) {
		List<Map<String, String>> compareList = (List<Map<String, String>>)session.getAttribute("attractionCompareList");
		HashMap<String, Object> params = getParameterMap(request);
		Map<String, String> attraction = new HashMap<>();
		attraction.put("attractionNo", params.get("attractionNo").toString());
		attraction.put("attractionName", params.get("attractionName").toString());
		
		if(compareList == null) {
			List<Map<String, String>> list = new ArrayList<>();
			list.add(attraction);
			session.setAttribute("attractionCompareList", list);
		}else {
			compareList.add(attraction);
		}
	}
	
	/**
	 * @method : 세션영역의 이용률 비교 어트랙션 리스트에서 어트랙션 제거
	 */
	@RequestMapping(value="/utilization/compare/delete.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public void deleteFromAttractionCompareList(String attractionNo, HttpSession session) {
		List<Map<String, String>> compareList = (List<Map<String, String>>)session.getAttribute("attractionCompareList");
		for(int i=0 ; i<compareList.size() ; i++) {
			Map<String, String> attraction = compareList.get(i);
			if(attraction.get("attractionNo").equals(attractionNo)) {
				compareList.remove(i);
			}
		}
		session.setAttribute("attractionCompareList", compareList);
	}
	
	@RequestMapping(value="/utilization/attraction/list.ajax", produces="application/json; charset=utf-8")
	@ResponseBody
	public List<Map<String, Object>> ajaxSelectUsingAttractionList(){
		return attractionService.selectUsingAttractionList();
	}
	
	/**
	 * @method : 
	 */
	@RequestMapping(value="/utilization/compare.do", produces="application/json; charset=utf-8")
	@ResponseBody
	public List<Map<String, Object>> ajaxSelectAttractionUtilizationForComparing(HttpServletRequest request, @RequestParam(value="noList[]", defaultValue="") List<String> noList) {
		HashMap<String, Object> params = getParameterMap(request);
		params.put("noList", noList);
		return attractionService.selectAttractionUtilization(params);
	}
	
}
