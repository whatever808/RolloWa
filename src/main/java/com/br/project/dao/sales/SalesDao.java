package com.br.project.dao.sales;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class SalesDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
}
