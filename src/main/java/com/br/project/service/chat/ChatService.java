package com.br.project.service.chat;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Service;

import com.br.project.dao.chat.ChatDao;
import com.br.project.dto.chat.ChatRoomDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ChatService {
	private final ChatDao chatDao;

	// 채팅방 생성
	public int insertChatRoom(Map<String, Object> map) {
		// 채팅방 생성
		int result1 = chatDao.insertChatRoom(map);
		
		// 채팅방 생성 회원 채팅방 참여목록에 추가
		int result2 = chatDao.insertChatParti(map);
		
		// 채팅방 번호
		if(result1 * result2 > 0) {
			return chatDao.selectSeqCurrVal();
		}		
		return result1 * result2;
	}
	
	// 채팅방 참여인원 생성
	public int insertChatParticipation(Map<String, Object> map) {
		return chatDao.insertChatParti(map);		
	}

	// 최신 채팅방 번호 조회
	public int selectLatestChatRoomNo() {
		return chatDao.selectLatestChatRoomNo();
	}

	// 로그인한 회원의 채팅방 목록 조회
	public List<ChatRoomDto> selectChatRoom(int userNo) {
		return chatDao.selectChatRoom(userNo);
	}
}
