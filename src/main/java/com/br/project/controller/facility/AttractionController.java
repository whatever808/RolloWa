package com.br.project.controller.facility;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.br.project.dto.facility.AttractionDto;
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
	 * @method : 어트랙션 등록페이지 반환
	 */
	@RequestMapping("/regist.page")
	public String showRegistPage(Model model) {
		// 위치 목록조회 
		model.addAttribute("locationList", locationService.selectLocationList());
		return "facility/attraction/regist";
	}
	
	/**
	 * @method : 어트랙션 등록
	 */
	@RequestMapping("/regist.do")
	public void insertAttraction(AttractionDto attraction
								,HttpServletRequest request) {
		try {
			MemberDto loginMember = (MemberDto)request.getSession().getAttribute("loginMember");
			attraction.setRegistEmp(String.valueOf(loginMember.getUserNo()));
			attraction.setModifyEmp(String.valueOf(loginMember.getUserNo()));
			
			if(attractionService.insertAttraction(attraction) > 0) {
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
	public String showModifyPage() {
		return "facility/attraction/modify";
	}
	
	
}
