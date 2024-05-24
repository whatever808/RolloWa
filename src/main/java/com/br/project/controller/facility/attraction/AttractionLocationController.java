package com.br.project.controller.facility.attraction;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.br.project.service.location.LocationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("attraction/location")
@RequiredArgsConstructor
@Slf4j
public class AttractionLocationController {

	private final LocationService locationService;
	
	@RequestMapping(value="/list.ajax", produces="application/json; charset=utf-8")
	@ResponseBody
	public List<Map<String, Object>> selectLocationList(){
		return locationService.selectLocationList();
	}
	
}
