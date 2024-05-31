<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>어트랙션 이용률 상세</title>
	
	<!-- 어트랙션 이용률 분석차트 스타일 -->
	<link href="${ contextPath }/resources/css/facility/attraction/attraction_utilization_detail.css" rel="stylesheet">
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
		<!-- content 추가 start -->
  	<div class="content p-5">
  		
  		<h1 class="page-title">어트랙션 이용률 상세</h1>
  		
  		<div class="chart-list-div">
  			
  			<!-- year chart start -->
  			<div class="chart"></div>
  			<!-- year chart end -->
  			
  			<!-- month chart start -->
  			<div class="chart"></div>
				<!-- month chart end -->
				
				<!-- daily chart start -->
  			<div class="chart"></div>
  			<!-- daily chart end -->
  		</div>
  		
  	</div>
  	<!-- content 추가 end -->
	
	<!-- chat floating -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />

</body>
</html>