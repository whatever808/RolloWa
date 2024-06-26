package com.br.project.dao.notification;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.common.PageInfoDto;
import com.br.project.dto.notification.NotificationDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class NotificationDao {
	private final SqlSessionTemplate sqlSessionTemplate;

	public int selectNotiListCount() {
		return sqlSessionTemplate.selectOne("notificationMapper.selectNotiListCount");
	}

	public List<NotificationDto> selectNoti(PageInfoDto pageInfo) {
		int offset = (pageInfo.getCurrentPage() - 1) * pageInfo.getListLimit();
		int limit = pageInfo.getListLimit();
		return sqlSessionTemplate.selectList("notificationMapper.selectNoti", null, new RowBounds(offset, limit));
	}

	public int insertNoti(NotificationDto notification) {
		return sqlSessionTemplate.insert("notificationMapper.insertNoti", notification);
	}

	public int deleteNoti(String notiNo) {
		return sqlSessionTemplate.update("notificationMapper.deleteNoti", notiNo);
	}

	// 최신 공지사항 글 번호 조회
	public int selectLatestBno(String teamCode) {
		return sqlSessionTemplate.selectOne("notificationMapper.selectLatestBno", teamCode);
	}

	// 알림 전송 이력 저장
	public int insertNotificationSend(Map<String, Object> map) {
		return sqlSessionTemplate.insert("notificationMapper.insertNotificationSend", map);
	}

	public List<NotificationDto> selectNotification(String userNo) {
		return sqlSessionTemplate.selectList("notificationMapper.selectNotification", userNo);
	}

	public int updateLatestCheckDate(Map<String, String> map) {
		return sqlSessionTemplate.update("notificationMapper.updateLatestCheckDate", map);
	}

	public int updateNoticeCheckDate(Map<String, String> map) {
		return sqlSessionTemplate.update("notificationMapper.updateNoticeCheckDate", map);
	}

	public int updateCallendarCheckDate(Map<String, String> map) {
		return sqlSessionTemplate.update("notificationMapper.updateCallendarCheckDate", map);
	}
}
