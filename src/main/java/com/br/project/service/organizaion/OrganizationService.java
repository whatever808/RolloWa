package com.br.project.service.organizaion;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.organization.OrganizationDao;
import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrganizationService {
	
	private final OrganizationDao organizationDao;

	public int selectOrganizationListCount() {
		return organizationDao.selectOrganizationListCount();
	}

	public List<MemberDto> selectOrganizationList(PageInfoDto pi) {
		return organizationDao.selectOrganizationList(pi);
	}

	public List<GroupDto> selectOrganizationChart() {
		return organizationDao.selectOrganizationChart();
	}
	
	/* 부서, 팀, 직급, 상태 조회 service */
	public List<GroupDto> selectDepartment() {
		return organizationDao.selectDepartment();
	}
	public List<GroupDto> selectTeamAll(String selectedDepartment) {
		return organizationDao.selectTeamAll(selectedDepartment);
	}
	public List<GroupDto> selectTeam(String selectedDepartment) {
		return organizationDao.selectTeam(selectedDepartment);
	}
	public List<GroupDto> selectPosition() {
		return organizationDao.selectPosition();
	}


	/* 직원 검색 service */
	public int selectSearchListCount(Map<String, String> search) {
		return organizationDao.selectSearchListCount(search);
	}
	public List<MemberDto> selectSearchList(Map<String, String> search, PageInfoDto pi) {
		return organizationDao.selectSearchList(search, pi);
	}

	

}
