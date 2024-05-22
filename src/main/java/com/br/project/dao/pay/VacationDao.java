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
	
	
	
}
