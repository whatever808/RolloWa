package com.br.project.service.common.department;

import java.util.List;

import org.springframework.stereotype.Service;

import com.br.project.dao.common.department.DepartmentDao;
import com.br.project.dto.common.GroupDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DepartmentService {

	private final DepartmentDao departmentDao;
	
	public List<GroupDto> selectDepartmentList(String code){
		return departmentDao.selectDepartmentList(code);
	}
	
}
