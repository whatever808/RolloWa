package com.br.project.dao.chat;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;

import com.br.project.dto.chat.ChatMessageDto;
import com.br.project.dto.chat.ChatRoomDto;

import lombok.RequiredArgsConstructor;

@Repository
@RequiredArgsConstructor
public class ChatDao {
	private final SqlSessionTemplate sqlSessionTemplate;

	public int insertChatRoom(Map<String, Object> map) {
		return sqlSessionTemplate.insert("chatMapper.insertChatRoom", map);
	}

	public int insertChatParti(Map<String, Object> map) {
		return sqlSessionTemplate.insert("chatMapper.insertChatParti", map);
	}

	public int selectLatestChatRoomNo() {
		return sqlSessionTemplate.selectOne("chatMapper.selectLatestChatRoomNo");
	}

	// seq_crno.currval 반환
	public int selectSeqCurrVal() {
		return sqlSessionTemplate.selectOne("chatMapper.selectSeqCurrVal");
	}
	
	// 로그인한 회원의 채팅방 목록 조회
	public List<ChatRoomDto> selectChatRoom(int userNo) {
		return sqlSessionTemplate.selectList("chatMapper.selectChatRoom", userNo);
	}

	public int insertChatMsg(ChatMessageDto chatMsg) {
		return sqlSessionTemplate.insert("chatMapper.insertChatMsg", chatMsg);
	}

	public List<ChatMessageDto> selectChatMsg(String roomNo) {
		return sqlSessionTemplate.selectList("chatMapper.selectChatMsg", roomNo);
	}
	
	// 채팅방 접속 날짜 수정
	public int updateChatInDate(Map<String, String> map) {
		return sqlSessionTemplate.update("chatMapper.updateChatInDate", map);
	}
	
	// 읽지 않은 메세지 갯수 조회
	public int selectUnreadMsg(Map<String, String> map) {
		return sqlSessionTemplate.selectOne("chatMapper.selectUnreadMsg", map);
	}

	public int quitChat(Map<String, String> map) {
		return sqlSessionTemplate.update("chatMapper.quitChat", map);
	}
	
}
