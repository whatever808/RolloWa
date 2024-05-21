package com.br.project.interceptor.facility.attraction;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.support.RequestContextUtils;

import com.br.project.dto.member.MemberDto;

public class AttractionManageAuthorizationCheckInterceptor implements HandlerInterceptor{

	/**
	 * @interceptor : 어트랙션 관리자 권한 유무확인
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		
		MemberDto loginMember = (MemberDto)request.getSession().getAttribute("loginMember");
		
		if(loginMember != null && loginMember.getTeamCode().equals("B")) {
			return true;
		}else {
			FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
			
			FlashMap flashMap = new FlashMap();
			flashMap.put("alertTitle", "비정상적인 접근시도");
			flashMap.put("alertMsg", "어트랙션 관리자 권한이 없는 사용자입니다.");
			
			flashMapManager.saveOutputFlashMap(flashMap, request, response);
			
			response.sendRedirect(request.getContextPath());
			
			return false;
		}
		
	}
	
}
