package com.br.project.dao.organization;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class OrganizationDao {
	private final SqlSessionTemplate sqlSessionTemplate;

	public int selectDepartment(int result) {
		
		return result;
	}
}
