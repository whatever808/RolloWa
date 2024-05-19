package com.br.project.dao.facility.store;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class StoreDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
}
