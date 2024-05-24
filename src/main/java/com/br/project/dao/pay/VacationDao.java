package com.br.project.dao.pay;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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

	public int selectVacarionCount(int userNo) {
		return sqlSession.selectOne("vacationMapper.selectVacarionCount", userNo);
	}

	public int updateVacation(VacationDto vacationDto) {
		return sqlSession.update("vacationMapper.updateVacation", vacationDto);
	}

	public int deleteRcequest(String vacaNo) {
		return sqlSession.update("vacationMapper.deleteRcequest", vacaNo);
	}
	
	
	
}
