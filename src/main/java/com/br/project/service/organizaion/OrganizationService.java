package com.br.project.service.organizaion;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.br.project.dao.organization.OrganizationDao;
import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.dto.organization.OrganizationDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class OrganizationService {
	
	@Autowired
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

	// 급여 조회
	public List<MemberDto> selectAccountList(Map<String, Object> paramMap) {
		return organizationDao.selectAccountList(paramMap);
	}
	// 급여 조회 상세페이지
	public List<MemberDto> selectAccountDetail( ) {
		return organizationDao.selectAccountDetail();
	}

	
	// 수정중
	public boolean hasEmployeesInDepartment(String departmentName) {
		int employeeCount = organizationDao.countEmployeesInDepartment(departmentName);
        return employeeCount > 0;
    }
    public boolean hasEmployeesInTeam(String teamName) {
        int employeeCount = organizationDao.countEmployeesInTeam(teamName);
        return employeeCount > 0;
    }

    // 조직 관리 service -----------------------------
    // 부서추가
    public int insertDepartment(Map<String, Object> paramMap) {
		return organizationDao.insertDepartment(paramMap);
	}
	// 팀 추가
	public int insertTeam(Map<String, Object> paramMap) {
		return organizationDao.insertTeam(paramMap);
	}
	// 팀 삭제
	public int deleteTeam(Map<String, Object> paramMap) {
		return organizationDao.deleteTeam(paramMap);
	}
	// 팀 사용자 인원수 카운트
	public List<Map<String, Object>> countMember() {
		return organizationDao.countMember();
	}
	// 부서 삭제
	public int deleteDepartment(Map<String, Object> paramMap) {
		return organizationDao.deleteDepartment(paramMap);
	}
	// 부서명 수정 
	public int updateDepartmentName(Map<String, Object> paramMap) {
		return organizationDao.updateDepartmentName(paramMap);
	}
	// 팀명 수정
	public int updateTeamName(Map<String, Object> paramMap) {
		return organizationDao.updateTeamName(paramMap);
	}

	// 동일한 부서 생성 못하게 하기	
    public int countDepartmentByName(Map<String, Object> paramMap) {
        return organizationDao.countDepartmentByName(paramMap);
    }
    // 동일한 팀 생성 못하게 하기 다른부서 동일한 팀은 가능
    public int countTeamByNameAndDept(Map<String, Object> paramMap) {
    	return organizationDao.countTeamByNameAndDept(paramMap);
    }
	

}
