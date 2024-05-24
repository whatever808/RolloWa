package com.br.project.dao.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dao.organization.OrganizationDao;
import com.br.project.dto.reservation.ReservationDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Repository
@RequiredArgsConstructor
@Slf4j
public class ReservationDao {

	private final SqlSessionTemplate sqlSessionTemplate;
	
	// 비품 출력 dao
	public int selectEquipmentListCount() {
		return sqlSessionTemplate.selectOne("reservationMapper.selectEquipmentListCount");
	}
	public List<HashMap<String, Object>> selectEquipmentList(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("reservationMapper.selectEquipmentList", paramMap);
	}

	// 예약 출력 dao
	public List<HashMap<String, Object>> selectReservationState(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("reservationMapper.selectReservationState", paramMap);
	}
	
	
	
}
