package com.br.project.dao.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.common.PageInfoDto;

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
	public List<HashMap<String, Object>> selectMyReservation(PageInfoDto pi, int userNo) {
		int limit = pi.getListLimit();
		int offset = (pi.getCurrentPage()-1) * limit;
		log.debug("오프셋 : {}, 제한 : {}", offset, limit);
		
		RowBounds rowBounds = new RowBounds(offset, limit);
		
		return sqlSessionTemplate.selectList("reservationMapper.selectMyReservation", userNo, rowBounds);
	}
	// 4. 내 예약 취소하기
	public int updateReservation(Map<String, Object> params) {
		return sqlSessionTemplate.update("reservationMapper.updateReservation", params);
	}
	// 비품 추가,수정,삭제
	public int insertEquipment(Map<String, Object> paramMap) {
		return sqlSessionTemplate.insert("reservationMapper.insertEquipment", paramMap);
	}
	public int updateEquipment(Map<String, Object> paramMap) {
		return sqlSessionTemplate.update("reservationMapper.updateEquipment", paramMap);
	}
	public int deleteEquipment(List<Integer> ids) {
		return sqlSessionTemplate.update("reservationMapper.deleteEquipment", ids);
	}
	// 내 예약 수 조회 (페이징처리)
	public int selectMyReservationCount(int userNo) {
		return sqlSessionTemplate.selectOne("reservationMapper.selectMyReservationCount", userNo);
	}
	
	
	
}
