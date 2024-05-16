package com.br.project.controller.facility;

import static com.br.project.controller.common.CommonController.getParameterMap;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

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
	@RequestMapping("/list.do")
	public String selectAttractionList(HttpServletRequest request) {
		try {
			return "facility/attraction/list";
		}catch(Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("alertTitle", "어트랙션 조회서비스");
			request.getSession().setAttribute("alertMsg", "어트랙션 목록조회에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	/**
	 * @method : 어트랙션 목록조회 (AJAX)
	 */
	@RequestMapping("/list.ajax")
	@ResponseBody
	public List<HashMap<String, String>> ajaxSelectAttractionList(HttpServletRequest request){
		return null;
	}
	
	/**
	 * @method : 어트랙션 상세조회
	 */
	@RequestMapping("/detail.do")
	public String selectAttraction(HttpServletRequest request) {
		try {
			request.setAttribute("attraction", getParameterMap(request));
			return "facility/attraction/detail";
		}catch(Exception e){
			e.printStackTrace();
			request.getSession().setAttribute("alertTitle", "어트랙션 조회서비스");
			request.getSession().setAttribute("alertMsg", "어트랙션 상세조회에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	/**
	 * @method : 어트랙션 등록페이지
	 */
	@RequestMapping("/regist.page")
	public String showRegistPage(HttpServletRequest request) {
		try {
			request.setAttribute("locationList", locationService.selectLocationList());
			return "facility/attraction/regist";
		}catch(Exception e) {
			e.printStackTrace();
			request.getSession().setAttribute("alertTitle", "어트랙션 등록서비스");
			request.getSession().setAttribute("alertMsg", "어트랙션 등록요청에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	/**
	 * @method : 어트랙션 등록
	 */
	@RequestMapping("/regist.do")
	public void insertAttraction(HttpServletRequest request) {
		try {
			HashMap<String, Object> params = getParameterMap(request);
			MemberDto loginMember = (MemberDto)request.getSession().getAttribute("loginMember");
			params.put("registEmp", loginMember.getUserNo());
			params.put("modifyEmp", loginMember.getUserNo());
			params.put("manageEmp", loginMember.getUserNo());
			
			if(attractionService.insertAttraction(params) > 0) {
				log.debug("등록성공");
				// 리스트 페이지 리다이렉트
			}else {
				// 이전페이지 이동
				
			}
		}catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	/**
	 * @method : 어트랙션 정보수정 페이지
	 */
	@RequestMapping("/modify.page")
	public String showModifyPage(HttpServletRequest request) {
		try {
			request.setAttribute("locationList", locationService.selectLocationList());
			request.setAttribute("attraction", attractionService.selectAttraction(getParameterMap(request)));
			return "facility/attraction/modify";
		}catch(Exception e) {
			e.printStackTrace();
			e.printStackTrace();
			request.getSession().setAttribute("alertTitle", "어트랙션 수정서비스");
			request.getSession().setAttribute("alertMsg", "어트랙션 수정요청에 실패했습니다.");
			return "redirect:" + request.getHeader("Referer");
		}
	}
	
	
}
