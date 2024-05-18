package com.br.project.interceptor.board;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.br.project.dto.member.MemberDto;

public class BoardAuthorizationCheckInterceptor implements HandlerInterceptor{

	/**
	 * @interceptor : 게시글 등록 or 관리 관련 서비스 요청시 작성자 권한 유무체크
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
	
		MemberDto loginMember = (MemberDto)request.getSession().getAttribute("loginMember");
		
		if(loginMember.getPosition().equals("E") || loginMember.getPosition().equals("F")) {
			return true;
		}else {
			FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
			
			FlashMap flashMap = new FlashMap();
			flashMap.put("alertTitle", "비정상적인 접근시도");
			flashMap.put("alertMsg", "게시글 관리권한이 없는 사용자입니다.");
			
			flashMapManager.saveOutputFlashMap(flashMap, request, response);
			
			response.sendRedirect(request.getHeader("Referer"));
			
			return false;
		}

	}
	
}
