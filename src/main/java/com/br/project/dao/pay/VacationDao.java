package com.br.project.dao.pay;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.dto.pay.VacationDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class VacationDao {
	private final SqlSessionTemplate sqlSession;

	public List<VacationDto> ajaxSelectVacation(Object request) {
		return sqlSession.selectList("vacationMapper.ajaxSelectVacation",request);
	}

	public int insertVacation(VacationDto vacation) {
		return sqlSession.insert("vacationMapper.insertVacation", vacation);
	}

	public List<VacationDto> selectRequest(int userNo) {
		return sqlSession.selectList("vacationMapper.selectRequest", userNo);
	}

	public int selectVacarionCount(VacationDto vacation) {
		return sqlSession.selectOne("vacationMapper.selectVacarionCount", vacation);
	}

	public int updateVacation(VacationDto vacationDto) {
		return sqlSession.update("vacationMapper.updateVacation", vacationDto);
	}

	public int deleteRcequest(String vacaNo) {
		return sqlSession.update("vacationMapper.deleteRcequest", vacaNo);
	}

	public List<VacationDto> searchOld(Map<String, Object> map) {
		PageInfoDto page = (PageInfoDto)map.get("paging");
		RowBounds row = new RowBounds(page.getListLimit()* (page.getCurrentPage()-1)
									, page.getListLimit());
		return sqlSession.selectList("vacationMapper.searchOld", map.get("vacation"), row);
	}

	public int RRequest(VacationDto vacation) {
		return sqlSession.update("vacationMapper.RRequest", vacation);
	}

	public int updateYearLabor() {
		return sqlSession.update("vacationMapper.updateYearLabor");
	}

	public int updateAnuul(MemberDto member) {
		return sqlSession.update("vacationMapper.updateOverAnuul", member);
	}
	public int selectRefuseRequest(VacationDto vacation) {
		return sqlSession.selectOne("vacationMapper.selectRefuseRequest", vacation);
	}
	public List<VacationDto> searchreQuest(Map<String, Object> map) {
		PageInfoDto page = (PageInfoDto)map.get("paging");
		RowBounds row = new RowBounds(page.getListLimit()* (page.getCurrentPage()-1)
									, page.getListLimit());
		return sqlSession.selectList("vacationMapper.searchreQuest", map.get("vacation") , row);
	}
	public int singRefuse(VacationDto vacation) {
		return sqlSession.update("vacationMapper.singRefuse", vacation);
	}
	public int singConfirm(VacationDto vacation) {
		return sqlSession.update("vacationMapper.singConfirm", vacation);
	}

	public int requestRefuse(VacationDto vacation) {
		return sqlSession.update("vacationMapper.requestRefuse", vacation);
	}

	public int requestConfine(VacationDto vacation) {
		return sqlSession.update("vacationMapper.requestConfine", vacation);
	}

	public String selectUpperMember(int emp) {
		return sqlSession.selectOne("vacationMapper.selectUpperMember", emp);
	}
	public int vacationExpire(VacationDto vacation) {
		return sqlSession.update("vacationMapper.vacationExpire", vacation);
	}

	
}
