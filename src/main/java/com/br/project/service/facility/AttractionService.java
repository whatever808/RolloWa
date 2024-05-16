package com.br.project.service.facility;

import org.springframework.stereotype.Service;

import com.br.project.dao.facility.AttractionDao;
import com.br.project.dto.facility.AttractionDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class AttractionService {

	private final AttractionDao attractionDao;
	
	/**
	 * @param attraction : 등록할 어트랙션 정보가 담긴 어트랙션 객체
	 * @return : 등록된 어트랙션 갯수
	 */
	public int insertAttraction(AttractionDto attraction) {
		return attractionDao.insertAttraction(attraction);
	}
	
}
