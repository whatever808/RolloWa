package com.br.project.service.reservation;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.reservation.ReservationDao;
import com.br.project.dto.common.PageInfoDto;
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
	
	// 먼저 예약 가능한지 시간 체크하기
	public int selectTimeCheck(Map<String, Object> paramMap) {
		return reservationDao.selectTimeCheck(paramMap);
	}
	// 예약 하기
	public int insertReservation(Map<String, Object> paramMap) {
		return reservationDao.insertReservation(paramMap);
	}

    // 내 예약 조회
    public List<HashMap<String, Object>> selectMyReservation(PageInfoDto pi, int userNo) {
        return reservationDao.selectMyReservation(pi, userNo);
    }
    // 전체 예약 조회
    public List<HashMap<String, Object>> selectAllReservation(PageInfoDto pi) {
    	return reservationDao.selectAllReservation(pi);
    }
    // 예약 취소
	public int updateReservation(Map<String, Object> params) {
		return reservationDao.updateReservation(params);
	}
	// 비품 추가,삭제,수정 관련
	public int insertEquipment(Map<String, Object> paramMap) {
		return reservationDao.insertEquipment(paramMap);
	}
	public int deleteEquipment(List<Integer> ids) {
		return reservationDao.deleteEquipment(ids);
	}
	public int updateEquipment(Map<String, Object> paramMap) {
		return reservationDao.updateEquipment(paramMap);
	}
	// 내 예약 수 조회 (페이징처리)
	public int selectMyReservationCount(int userNo) {
		return reservationDao.selectMyReservationCount(userNo);
	}
	// 전체 예약수 카운트
	public int selectAllReservationCount() {
		return reservationDao.selectAllReservationCount();
	}
	
}
