package com.br.project.service.pay;

import java.util.List;

import org.springframework.stereotype.Service;

import com.br.project.dao.pay.VacationDao;
import com.br.project.dto.pay.VacationDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class VacationService {
	private final VacationDao vacationDao;

	/**
	 * 일정에 휴가를 조회하는 문
	 * @author dpcks
	 * @return
	 */
	public List<VacationDto> ajaxSelectVacation(Object request) {
		return vacationDao.ajaxSelectVacation(request);
	}
	
	
}
