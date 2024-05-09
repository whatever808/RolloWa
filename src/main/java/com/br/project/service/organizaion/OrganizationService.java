package com.br.project.service.organizaion;

import org.springframework.stereotype.Service;

import com.br.project.dao.organization.OrganizationDao;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrganizationService {
	public final OrganizationDao organizationDao;

	
	public int selectDepartment(int result) {
		return organizationDao.selectDepartment(result);
	}

}
