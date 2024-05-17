package com.br.project.dao.organization;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.common.GroupDto;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
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

	
	
	/* 부서, 팀, 직급, 상태 조회 DAO */
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

	/* 직원 검색 dao */
	public int selectSearchListCount(Map<String, String> search) {
		return sqlSessionTemplate.selectOne("organizationMapper.selectSearchListCount", search);
	}
	public List<MemberDto> selectSearchList(Map<String, String> search, PageInfoDto pi) {
		RowBounds rowBounds = new RowBounds((pi.getCurrentPage()-1) * pi.getListLimit(), pi.getListLimit());
		return sqlSessionTemplate.selectList("organizationMapper.selectSearchList", search, rowBounds);
	}


	

	
	
}
