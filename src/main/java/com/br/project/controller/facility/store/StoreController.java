package com.br.project.controller.facility.store;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.br.project.service.facility.store.StoreService;
import com.br.project.util.PagingUtil;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="/store")
@RequiredArgsConstructor
@Slf4j
public class StoreController {

	private final StoreService storeService;
	private final PagingUtil pagingUtil;
	
	/**
	 * @method : 입접점포 등록페이지 반환
	 */
	@RequestMapping("/regist.page")
	public String showRegistPage() {
		return "facility/store/store_regist";
	}
	
}
