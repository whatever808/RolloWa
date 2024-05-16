package com.br.project.dao.facility;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.facility.AttractionDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class AttractionDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	/**
	 * @param attraction : 등록할 어트랙션 정보가 담긴 어트랙션 객체
	 * @return : 등록된 어트랙션 갯수
	 */
	public int insertAttraction(AttractionDto attraction) {
		return sqlSessionTemplate.insert("attractionMapper.insertAttraction", attraction);
	}
	
}
