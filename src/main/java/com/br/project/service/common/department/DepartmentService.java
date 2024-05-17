package com.br.project.service.common.department;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.common.department.DepartmentDao;
import com.br.project.dto.common.GroupDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DepartmentService {

	private final DepartmentDao departmentDao;
	
	/**
	 * @param code : [그룹코드]
	 * @return : 해당 그룹코드를 가진 그룹객체 리스트
	 */
	public List<GroupDto> selectDepartmentList(Map<String, String> map){
		return departmentDao.selectDepartmentList(map);
	}
	
	/* ================================================= "가림" 구역 start ================================================= */
	/**
	 * @param params : [상위코드 그룹코드], [하위코드 그룹코드], [하위코드 코드]
	 * @return : [상위코드 그룹코드], [상위코드 코드명], [상위코드 코드명] 정보가 담긴 그룹객체
	 */
	public GroupDto selectUppderCode(HashMap<String, Object> params) {
		return departmentDao.selectUppderCode(params);
	}
	
	/* ================================================= "가림" 구역 end ================================================= */
	
}
