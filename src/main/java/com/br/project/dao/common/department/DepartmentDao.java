package com.br.project.dao.common.department;

import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.common.GroupDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class DepartmentDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	
	/**
	 * @param code : [그룹코드]
	 * @return : 조회된 부서 리스트
	 */
	public List<GroupDto> selectDepartmentList(String code){
		return sqlSessionTemplate.selectList("departmentMapper.selectDepartmentList", code);
	}
	
	/* ================================================= "가림" 구역 start ================================================= */
	/**
	 * @param params : [상위코드 그룹코드], [하위코드 그룹코드], [하위코드 코드]
	 * @return : [상위코드 그룹코드], [상위코드 코드명], [상위코드 코드명] 정보가 담긴 그룹객체
	 */
	public GroupDto selectUppderCode(Map<String, String> params) {
		return sqlSessionTemplate.selectOne("departmentMapper.selectUppderCode", params);
	}
	
	/* ================================================= "가림" 구역 end ================================================= */
	
}
