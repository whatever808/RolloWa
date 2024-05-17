package com.br.project.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.FlashMap;
import org.springframework.web.servlet.FlashMapManager;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.support.RequestContextUtils;


public class loginCheckInterceptor implements HandlerInterceptor{

	/**
	 *@method : 컨트롤러에 서비스요청전, 클라이언트의 로그인여부 체크
	 */
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
		   throws Exception {
		
		if(request.getSession().getAttribute("loginMember") == null) {
			FlashMapManager flashMapManager = RequestContextUtils.getFlashMapManager(request);
			
			FlashMap flashMap = new FlashMap();
			flashMap.put("alertTitle", "비정상적인 접근시도");
			flashMap.put("alertMsg", "로그인 후 이용가능한 서비스입니다.");
			
			flashMapManager.saveOutputFlashMap(flashMap, request, response);
			
			response.sendRedirect(request.getContextPath());
			
			return false;
		}else {
			return true;
		}
		
	}
	
}
