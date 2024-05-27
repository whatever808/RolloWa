package com.br.project.service.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.reservation.ReservationDao;
import com.br.project.dto.reservation.ReservationDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReservationService {
	
	private final ReservationDao reservationDao;
	
	// 비품 출력 service
	public int selectEquipmentListCount() {
		return reservationDao.selectEquipmentListCount();
	}
	public List<HashMap<String, Object>> selectEquipmentList(Map<String, Object> paramMap) {
		return reservationDao.selectEquipmentList(paramMap);
	}
	
	// 예약 출력 service
	public List<HashMap<String, Object>> selectReservationState(Map<String, Object> paramMap) {
		return reservationDao.selectReservationState(paramMap);
	}
	
	// 1. 먼저 예약 가능한지 시간 체크하기
	public int selectTimeCheck(Map<String, Object> paramMap) {
		return reservationDao.selectTimeCheck(paramMap);
	}
	// 2. 예약 하기
	public int insertReservation(Map<String, Object> paramMap) {
		return reservationDao.insertReservation(paramMap);
	}

	
	
}
