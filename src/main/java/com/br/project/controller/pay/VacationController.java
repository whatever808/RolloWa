package com.br.project.controller.pay;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.br.project.service.pay.VacationService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/vacation")
@RequiredArgsConstructor
public class VacationController {
	private final VacationService vacaService;
	
	
}
