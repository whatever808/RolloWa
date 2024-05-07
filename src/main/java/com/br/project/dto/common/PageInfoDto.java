package com.br.project.dto.common;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
@Builder
public class PageInfoDto {

	private int listCount;
	private int currentPage;
	private int pageLimit;
	private int listLimit;
	private int maxPage;
	private int startPage;
	private int endPage;
	
}
