package com.br.project.dao.common.department;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.common.GroupDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class DepartmentDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	public List<GroupDto> selectDepartmentList(){
		return sqlSessionTemplate.selectList("departmentMapper.selectDepartmentList");
	}
	
}
