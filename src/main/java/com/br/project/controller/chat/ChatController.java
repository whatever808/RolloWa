package com.br.project.controller.chat;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.handler.annotation.SendTo;
import org.springframework.messaging.simp.SimpMessagingTemplate;
import org.springframework.stereotype.Controller;

import com.br.project.dto.chat.ChatMessageDto;
import com.br.project.dto.member.MemberDto;
import com.br.project.dto.notification.NotificationSendDto;
import com.br.project.service.chat.ChatService;
import com.br.project.service.member.MemberService;
import com.br.project.service.notification.NotificationService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Controller
@RequiredArgsConstructor
@Slf4j
public class ChatController {

	private final SimpMessagingTemplate template; //특정 Broker로 메세지를 전달
	private final ChatService chatService;
	private final NotificationService notificationService;
	private final MemberService memberService;
	
	//json을 Map으로 변환
	public Map<String, Object> jsonToMap(String json) throws Exception
	{
	    ObjectMapper objectMapper = new ObjectMapper();
	    TypeReference<Map<String, Object>> typeReference = new TypeReference<Map<String,Object>>() {};
	    
	    return objectMapper.readValue(json, typeReference);
	}
	
	//Map을 json으로 변환
	public String mapToJson(Map<String, Object> map) {
		ObjectMapper objectMapper = new ObjectMapper();
		String json = null;
		try {
			json = objectMapper.writeValueAsString(map);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		
		return json;
	}
	
    // 채팅 메세지 데이터베이스에 저장
    public int insertChatMsg(Map<String, Object> map) {    	
    	ChatMessageDto chatMsg = ChatMessageDto.builder()
				.msgContent((String)map.get("msgContent"))
				.chatRoomNo(Integer.parseInt(String.valueOf(map.get("roomNo"))))
				.userNo(Integer.parseInt(String.valueOf(map.get("userNo"))))
				.sendDate((String)map.get("sendDate"))
				.build();

    	return chatService.insertChatMsg(chatMsg);
    }
    
    // 알림 보내기
    @MessageMapping(value = "/alram/send")
    public void alram(String json) {
    	try {
			Map<String, Object> map = jsonToMap(json);
			
			if(map.get("flag").equals("1")) {
				// 공지사항 알림일 경우
				map.put("type", "N");
				// 결과 저장
				int result = 0;
				
				// 알림 보낸 사람을 제외한 부서원 조회
				List<String> teamMemberList = memberService.selectTeamMember(map);
				
				map.put("teamMemberList", teamMemberList);
				
				// 알림 전송 내역 저장
				for(String userNo : teamMemberList) {
					map.put("receiveUserNo", String.valueOf(userNo));
					
					result += notificationService.insertNotificationSend(map);
				}

				// 알림을 성공적으로 저장 했을 경우
				if(result == teamMemberList.size()) {
					template.convertAndSend("/topic/chat/alram", mapToJson(map));
					log.debug("알림 전송 성공");
				} else {
					log.debug("알림 저장 실패");
				}
			} else if (map.get("flag").equals("2")) {
				// 일정 알림일 경우
				// CalendarController에서 알림 전송 정보 저장
				map.put("type", "C");
				int result = 0;
				// 팀코드 리스트에 담기
				/*List<String> teamCodeList = (List<String>)map.get("teamMemberList");
				
				for(int i = 0; i < teamCodeList.size(); i++) {
					map.put("receiveUserNo", teamCodeList.get(i));
					
					// url, type, recevieUserNo, sendUserNo
					result += notificationService.insertNotificationSend(map);
				}*/
				
				//if (result == teamCodeList.size()) {
					template.convertAndSend("/topic/chat/alram", mapToJson(map));
					/*log.debug("알림 전송 성공");
				} else {
					log.debug("알림 저장 실패");
				}*/
				
			} else if (map.get("flag").equals("3")) {
				// 채팅방 멘션일 경우
				List<String> mentionList = (List<String>)map.get("mentionList");
				
				// 알림 타입 지정
				map.put("type", "M");
				
				// 알림을 프론트에서 처리하기 위해 변수에 담기
				List<MemberDto> teamMemberList = new ArrayList<>();
				
				int result = 0;
				for(int i = 0; i < mentionList.size(); i++) {
					// 알림을 프론트에서 처리하기 위해 변수에 담기
					teamMemberList.add(memberService.selectMemberInfo(Integer.parseInt(mentionList.get(i))));
					map.put("receiveUserNo", mentionList.get(i));
					
					result += notificationService.insertNotificationSend(map);
				}
				map.put("teamMemberList", teamMemberList);
				
				if (result == mentionList.size()) {
					template.convertAndSend("/topic/chat/alram", mapToJson(map));
				} else {
					log.debug("알림 저장 실패");
				}
				
			}
			
			
			
		} catch (Exception e) {
			e.printStackTrace();
		}
    }
    
		
	// 채팅방 입장
	@MessageMapping(value = "/chat/invite")
    public void enter(String json){
		try {
			log.debug("함수 실행");
			// **님이 **님을 채팅방에 초대하였습니다.
			Map<String, Object> map = jsonToMap(json);
			String partUserName = memberService.selectUserName((String)map.get("partUserNo"));
			
			map.put("msgContent", map.get("userName") + "님이 " + partUserName + "님을 채팅방에 초대하였습니다.");
			
			// flag 번호 부여
			map.put("flag", "0");
			
			int result = insertChatMsg(map);
			
			if (result > 0) {
				template.convertAndSend("/topic/chat/alram", mapToJson(map));
			} else {
				log.debug("채팅 메세지 저장 중 오류 발생");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}         
    }
	
	// 채팅방 퇴장
	@MessageMapping(value = "chat/quit")
	public void quit(String json) {
		try {
			Map<String, Object> map = jsonToMap(json);
			log.debug("map : {}", map);
			
			// 채팅 메세지 생성
			map.put("msgContent", map.get("userName") + "님이 채팅방을 나갔습니다.");
			// 채팅 메세지 저장
			int result = insertChatMsg(map);
			
			
			// 방 번호로 채팅 메세지 전송
			if (result > 0) {
				template.convertAndSend("/topic/chat/room/" + map.get("roomNo"), mapToJson(map));
			} else {
				log.debug("퇴장 메세지 보내기 실패");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	// 채팅방 메세지 전송 및 기록
    @MessageMapping(value = "/chat/message/{roomNo}")
    public void message(String json){
		try {
			Map<String, Object> map = jsonToMap(json);
			int result = insertChatMsg(map);
			
			if (result > 0) {
				template.convertAndSend("/topic/chat/room/" + map.get("roomNo"), mapToJson(map));
			} else {
				log.debug("채팅 메세지 저장 중 오류 발생");
			}
			
		} catch (Exception e) { 
			e.printStackTrace();
		}   
    }
    
}

