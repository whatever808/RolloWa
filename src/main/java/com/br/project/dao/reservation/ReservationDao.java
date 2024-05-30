package com.br.project.dao.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

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
	
	// 1. 먼저 예약 가능한지 시간 체크하기
	public int selectTimeCheck(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectOne("reservationMapper.selectTimeCheck", paramMap);
	}
	// 2. 예약 하기
	public int insertReservation(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("reservationMapper.insertReservation", paramMap);
	}
	// 3. 내 예약 조회하기
	public List<HashMap<String, Object>> selectMyReservation(Map<String, Object> paramMap) {
		return sqlSessionTemplate.selectList("reservationMapper.selectMyReservation", paramMap);
	}
	// 4. 내 예약 취소하기
	public int updateReservation(Map<String, Object> params) {
		return sqlSessionTemplate.update("reservationMapper.updateReservation", params);
	}
	
	
}
