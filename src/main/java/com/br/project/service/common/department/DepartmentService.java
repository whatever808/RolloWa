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

		/*
		 * groud_code 조회 시 Map의 key : code
		 * upper_code 조회 시 Map의 key : upperCdoe
		 */

		return departmentDao.selectDepartmentList(map);
	}
	
	/**
	 * 부서별 팀과 팀원들을 조회 해오는 쿼리
	 * @dpcks
	 * @return
	 */
	public List<Map<String, Object>> selectTeam() {
		return departmentDao.selectTeam();
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
	
	/* ================================================= "기웅" 구역 start ================================================= */
		
	
	/* ================================================= "기웅" 구역 end ================================================= */
}
