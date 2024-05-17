<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>롤러와</title>
	
	<!-- 메인페이지 스타일시트 -->
	<link href="${ contextPath }/resources/css/mainPage/mainPage.css" rel="stylesheet">
	
	<!-- fullcalendar -->
	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
</head>
<body>
	
	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	<!-- content 추가 -->
	<div class="content p-5">
		
		<!-- nav bar start -->
		<div class="home-nav box">
			
			<div class="menu">
				<div class="icon">
					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clipboard" viewBox="0 0 16 16">
					  <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1z"/>
					  <path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0z"/>
					</svg>
				</div>
				<label class="icon-name mt-2">게시판</label>
			</div>
		
		</div>
		<!-- nav bar end -->
		
		<!-- main content area start -->
		<div class="content-wrap">
		
			<!-- profile start -->
			<div class="profile box">
				
			</div>
			<!-- profile end -->
			
			<!-- calendar start -->
			<div class="calendar box">
				<!-- main calendar -->
				<jsp:include page="/WEB-INF/views/common/mainCal.jsp" />
				<div id="calendar"></div>
			</div>
			<!-- calendar end -->
			
		</div>
		<!-- main content area end -->
		
		
	</div>
	<!-- content 끝 -->
	
	<!-- chat floating -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
	
</body>
</html>