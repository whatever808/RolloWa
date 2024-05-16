package com.br.project.util;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.br.project.dto.common.PageInfoDto;
import com.br.project.service.facility.AttractionService;

import lombok.NoArgsConstructor;

@Component
@NoArgsConstructor
public class AttractionUtil {

	@Autowired
	private AttractionService attractionService;
	
	public List<HashMap<String, String>> getAttractionList(HttpServletRequest request){
		// 페이징바 
		PageInfoDto pageInfo = new PagingUtil().getPageInfoDto(attractionService.selectTotalAttractionCount()
															  ,Integer.parseInt(request.getParameter("page"))
															  ,10, 10);
		return null;
	}
	
}
