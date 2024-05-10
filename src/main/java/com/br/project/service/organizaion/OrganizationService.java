package com.br.project.service.organizaion;

import java.util.List;

import org.springframework.stereotype.Service;

import com.br.project.dao.organization.OrganizationDao;
import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class OrganizationService {
	public final OrganizationDao organizationDao;

	
	public int selectDepartment(int result) {
		return organizationDao.selectDepartment(result);
	}

	public int selectOrganizationListCount() {
		return organizationDao.selectOrganizationListCount();
	}

	public List<MemberDto> selectOrganizationList(PageInfoDto pi) {
		return organizationDao.selectOrganizationList(pi);
	}

	public List<GroupDto> selectDept() {
		return organizationDao.selectDept();
	}

	public List<GroupDto> selectTeam(String codeName) {
		return organizationDao.selectTeam();
	}

}
