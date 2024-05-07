package com.br.project.util;

import org.springframework.stereotype.Component;

import com.br.project.dto.common.PageInfoDto;

@Component
public class PagingUtil {

	public PageInfoDto getPageInfoDto(int listCount, int currentPage, int pageLimit, int listLimit) {
	
		int maxPage = (int)Math.ceil((double)listCount / listLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + (pageLimit - 1);
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		return new PageInfoDto(listCount, currentPage, pageLimit, listLimit, maxPage, startPage, endPage);
	}
	
}