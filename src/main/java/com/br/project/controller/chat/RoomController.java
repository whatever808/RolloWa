package com.br.project.controller.chat;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.br.project.dao.chat.ChatDao;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("/chat")
@RequiredArgsConstructor
public class RoomController {
	private final ChatDao chatDao;
	
	// 채팅방 목록 조회
	@GetMapping("/rooms")
	public String rooms(Model model) {
		//model.addAttribute("list", chatDao.findAllRooms());
		
		return "chat/rooms";
	}
	
	// 채팅방 생성
	@PostMapping("/room")
	public String create(String name, RedirectAttributes redirectAttribute) {
		//redirectAttribute.addFlashAttribute("roomName", chatDao.createChatRoomDto(name));
		return "redirect:/chat/rooms";
	}
	
	// 채팅방 조회
	@GetMapping("/room")
	public void getRoom(String roomId, Model model) {
		//model.addAttribute("room", chatDao.findRoomById(roomId));
	}
}
