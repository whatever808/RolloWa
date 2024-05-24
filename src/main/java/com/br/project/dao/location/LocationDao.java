package com.br.project.dao.location;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class LocationDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @return : 등록된 위치객체 리스트
	 */
	public List<Map<String, Object>> selectLocationList(){
		return sqlSessionTemplate.selectList("locationMapper.selectLocationList");
	}
	
}
