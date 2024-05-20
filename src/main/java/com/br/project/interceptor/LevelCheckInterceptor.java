package com.br.project.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;

import com.br.project.dto.member.MemberDto;

public class LevelCheckInterceptor implements HandlerInterceptor {
	
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
		response.setCharacterEncoding("UTF-8");
		String position = (String)((MemberDto)request.getSession().getAttribute("loginMember")).getPositionCode();
		if(position != null && (position.equals("E") || position.equals("F"))) {
			return true;
		}else {
			PrintWriter out = response.getWriter();
			out.print("<html><head><meta charset=\"UTF-8\">");
			out.print("<script src='\"+ request.getContextPath()+\"/resources/alertify/js/alertify.min.js'></script>\"");
			out.print("<link href='"+ request.getContextPath()+"/resources/alertify/css/alertify.min.css' rel='stylesheet'>");
			out.print("<link href='"+ request.getContextPath()+"/resources/alertify/css/default.min.css' rel='stylesheet'>");
			out.print("<link href='"+ request.getContextPath()+"/resources/alertify/css/semantic.min.css' rel='stylesheet'>");
			out.print("</head><body><script>alertify.alert('권한 체크', '해당 계정으로 사용할 수 없습니다.', function(){history.back();});</script></body></html>");
			return false;
		}
		
		
	}
}
