package com.br.project.dao.location;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.location.LocationDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class LocationDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @return : 등록된 위치객체 리스트
	 */
	public List<LocationDto> selectLocationList(){
		return sqlSessionTemplate.selectList("locationMapper.selectLocationList");
	}
	
}
