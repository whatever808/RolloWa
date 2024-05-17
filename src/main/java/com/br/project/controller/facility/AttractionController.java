package com.br.project.controller.facility;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.br.project.dto.facility.AttractionDto;
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
	
	@RequestMapping("/regist.do")
	public void insertAttraction(AttractionDto attraction) {
		
	}
	
	
}
