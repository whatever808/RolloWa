package com.br.project.controller.chat;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.dao.chat.ChatDao;
import com.br.project.dto.chat.ChatMessageDto;
import com.br.project.dto.chat.ChatRoomDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.service.chat.ChatService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequestMapping("/chat")
@RequiredArgsConstructor
@Slf4j
public class RoomController {
	private final ChatService chatService;
		
	// 채팅방 생성
	@PostMapping("/room")
	@ResponseBody
	public String insertChatRoom(HttpSession session) {
		MemberDto loginMember = (MemberDto)session.getAttribute("loginMember");
		Map<String, Object> map = new HashMap<>();
		
		// 채팅방 생성 회원번호
		map.put("userNo", loginMember.getUserNo());
		
		// 채팅방 이름
		map.put("crName", UUID.randomUUID().toString());
		
		int result = chatService.insertChatRoom(map);
		
		if (result > 0) {
			// 채팅방 번호 반환
			return String.valueOf(result);
		}
		
		return "FAIL";
	}
	
	// 채팅방 참여인원 생성
	@PostMapping("/participants")
	@ResponseBody
	public String insertChatParticipation(@RequestParam(value="partUserNo") String partUserNo,
			HttpSession session
			, String chatRoomNo) {
		MemberDto loginMember = (MemberDto)session.getAttribute("loginMember");
		
		// 체크된 회원이 있을 시
		if(partUserNo != null) {
			Map<String, Object> map = new HashMap<>();
			
			// 채팅방 생성 회원번호
			map.put("userNo", loginMember.getUserNo());
			
			// 채팅방 번호
			map.put("chatRoomNo", chatRoomNo);
			
			// 채팅방 참여 회원번호
			map.put("partUserNo", partUserNo);
			
			int result = chatService.insertChatParticipation(map);
			
			if(result > 0) {
				return "SUCCESS";
			}
		}
		return "FAIL";
	}
	
	// 로그인한 회원의 채팅방 목록 조회
	@GetMapping(value="/rooms", produces="application/json; charset=utf-8")
	@ResponseBody
	public List<ChatRoomDto> selectChatRoom(HttpSession session) {
		MemberDto loginMember = (MemberDto)session.getAttribute("loginMember");
		
		List<ChatRoomDto> chatRoomList = chatService.selectChatRoom(loginMember.getUserNo());
		return chatRoomList;
	}
	
	// 채팅방의 참여인원 조회
	@GetMapping(value="/participants", produces="application/json; charset=utf-8")
	@ResponseBody
	public List<MemberDto> selectParticipants(String roomNo
					, HttpSession session) {
		MemberDto loginMember = (MemberDto)session.getAttribute("loginMember");
		List<MemberDto> memberList = new ArrayList<>();
		
		Map<String, Object> map = new HashMap<>();
		// 채팅방 번호
		map.put("roomNo", roomNo);
		// 로그인한 회원 번호
		map.put("userNo", loginMember.getUserNo());
		
		if(roomNo != null) {
			memberList = chatService.selectParticipants(map);
		}
		
		return memberList;
	}
	
	// 채팅방의 채팅 메세지 조회
	@GetMapping(value="/messages", produces="application/json; charset=utf-8")
	@ResponseBody
	public List<ChatMessageDto> selectChatMsg(String roomNo) {
		List<ChatMessageDto> msgList = new ArrayList<>();
		
		if(roomNo != null) {
			msgList = chatService.selectChatMsg(roomNo);
		}
		return msgList;
	}
	
	// 채팅방에서 나간 시간 update
	@PostMapping("/inDate")
	@ResponseBody
	public String updateChatInDate(@RequestParam Map<String, String> map) {
		int result = 0;
		
		if(map.get("roomNo") != null && map.get("userNo") != null) {
			result = chatService.updateChatInDate(map);
		}
		
		if(result > 0) {
			return "SUCCESS";
		}
		
		return "FAIL";
	}
	
	// 채팅방의 읽지 않은 메세지 갯수 조회
	@GetMapping("/messages/unread")
	@ResponseBody
	public String selectUnreadMsg(@RequestParam Map<String, String> map) {
		int unreadMsgCount = 0;
		
		if(map.get("roomNo") != null && map.get("userNo") != null) {
			unreadMsgCount = chatService.selectUnreadMsg(map);
		}
		
		return String.valueOf(unreadMsgCount);
	}

}
