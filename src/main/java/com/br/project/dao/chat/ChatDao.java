package com.br.project.dao.chat;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;

import org.springframework.stereotype.Repository;

import com.br.project.dto.chat.ChatRoomDto;

@Repository
public class ChatDao {
	private Map<String, ChatRoomDto> chatRoomDtoMap;
	
}
