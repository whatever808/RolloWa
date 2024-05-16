package com.br.project.controller.location;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.br.project.service.location.LocationService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping(value="/location")
@RequiredArgsConstructor
@Slf4j
public class LocationController {

	private LocationService locationService;
	
}
