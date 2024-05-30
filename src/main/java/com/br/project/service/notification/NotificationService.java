package com.br.project.service.notification;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.notification.NotificationDao;
import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.notification.NotificationDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class NotificationService {
	private final NotificationDao nDao;
	private Map<String, String> tokenMap = new HashMap();
	
	// 전체 알림 갯수 조회
	public int selectNotiListCount() {
		return nDao.selectNotiListCount();
	}
	
	// 전체 알림 정보 조회
	public List<NotificationDto> selectNoti(PageInfoDto pageInfo) {
		return nDao.selectNoti(pageInfo);
	}

	public int insertNoti(NotificationDto notification) {
		return nDao.insertNoti(notification);
	}

	public int deleteNoti(String notiNo) {
		return nDao.deleteNoti(notiNo);
	}

	// 최신 공지사항 글 번호 조회
	public int selectLatestBno(String teamCode) {
		return nDao.selectLatestBno(teamCode);
	}
	
	// 알림 전송 이력 저장
	public int insertNotificationSend(Map<String, Object> map) {
		return nDao.insertNotificationSend(map);
	}

	// 회원에게 전달된 알림 중 확인하지 않은 알림 조회
	public List<NotificationDto> selectNotification(String userNo) {
		return nDao.selectNotification(userNo);
	}

	// 회원에게 전달된 최신 알림의 확인 날짜 update
	public int updateLatestCheckDate(Map<String, String> map) {
		return nDao.updateLatestCheckDate(map);
	}

	// 회원에게 전달된 공지 알림 확인 날짜 update
	public int updateNoticeCheckDate(Map<String, String> map) {
		return nDao.updateNoticeCheckDate(map);
	}

	// 회원에게 전달된 일정 알림 확인 날짜 모두 update
	public int updateCallendarCheckDate(Map<String, String> map) {
		return nDao.updateCallendarCheckDate(map);
	}	
	
}
