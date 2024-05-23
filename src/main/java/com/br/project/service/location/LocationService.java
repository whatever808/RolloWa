package com.br.project.service.location;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.location.LocationDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LocationService {

	private final LocationDao locationDao;
	
	/**
	 * @return : 등록된 위치객체 리스트
	 */
	public List<Map<String, Object>> selectLocationList(){
		return locationDao.selectLocationList();
	}
	
}
