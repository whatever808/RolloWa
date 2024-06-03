package com.br.project.dao.organization;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.dto.organization.OrganizationDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class OrganizationDao {
	
	private final SqlSessionTemplate sqlSessionTemplate;

	public int selectOrganizationListCount() {
		return sqlSessionTemplate.selectOne("organizationMapper.selectOrganizationListCount");
	}

	public List<MemberDto> selectOrganizationList(PageInfoDto pi) {
		
		int limit = pi.getListLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSessionTemplate.selectList("organizationMapper.selectOrganizationList", null, rowBounds);
		
	}
	public List<GroupDto> selectOrganizationChart() {
		return sqlSessionTemplate.selectList("organizationMapper.selectOrganizationChart");
	}

	
	
	// 부서, 팀, 직급, 상태 조회 dao
	public List<GroupDto> selectDepartment() {
		return sqlSessionTemplate.selectList("organizationMapper.selectDepartment");
	}
	public List<GroupDto> selectTeamAll(String selectedDepartment) {
		return sqlSessionTemplate.selectList("organizationMapper.selectTeamAll", selectedDepartment);
	}
	public List<GroupDto> selectTeam(String selectedDepartment) {
		return sqlSessionTemplate.selectList("organizationMapper.selectTeam", selectedDepartment);
	}
	public List<GroupDto> selectPosition() {
		return sqlSessionTemplate.selectList("organizationMapper.selectPosition");
	}
	public List<GroupDto> selectStatus() {
		return sqlSessionTemplate.selectList("organizationMapper.selectStatus");
	}

	// 직원 검색 dao
	public int selectSearchListCount(Map<String, String> search) {
		return sqlSessionTemplate.selectOne("organizationMapper.selectSearchListCount", search);
	}
	public List<MemberDto> selectSearchList(Map<String, String> search, PageInfoDto pi) {
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage()-1) * pi.getListLimit(), pi.getListLimit());
		return sqlSessionTemplate.selectList("organizationMapper.selectSearchList", search, rowBounds);
	}

	// 급여 조회 dao
	public List<MemberDto> selectAccountList(Map<String, Object> paramMap) {
		// 해당 값에 month, year 값 등이 들어있음
		//log.debug("paramMap : {}",paramMap);
	    return sqlSessionTemplate.selectList("organizationMapper.selectAccountList", paramMap);
	}

	// 급여 상세조회 dao
	public List<MemberDto> selectAccountDetail() {
		return sqlSessionTemplate.selectList("organizationMapper.selectAccountDetail");
	}

	// 수정중
    public int countEmployeesInDepartment(String departmentName) {
        return sqlSessionTemplate.selectOne("organization.countEmployeesInDepartment", departmentName);
    }
    public int countEmployeesInTeam(String teamName) {
        return sqlSessionTemplate.selectOne("organization.countEmployeesInTeam", teamName);
    }

    //  부서 추가
	public int insertDepartment(String deptName) {
		return sqlSessionTemplate.insert("organization.insertDepartment", deptName);
	}

	
	
}
