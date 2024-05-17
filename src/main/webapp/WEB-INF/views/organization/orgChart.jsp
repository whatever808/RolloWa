<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1.3 조직 관리</title>

    <!-- 조직도 참고 사이트
       https://www.cssscript.com/clean-tree-diagram/
    -->

    <!-- animate -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />

    <!-- bootstrap -->
    <link href="${contextPath}/resources/css/common/bootstrap.min.css" rel="stylesheet">

    <!-- fontawesome -->
    <script src="https://kit.fontawesome.com/12ec987af7.js" crossorigin="anonymous"></script>

    <!-- Google Fonts Roboto -->
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap" />

    <!-- Google Fonts Jua -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">

    <!-- jQuery -->
    <script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- css -->
    <link href="${contextPath}/resources/css/common/sidebars.css" rel="stylesheet">
    <link rel="stylesheet" href="${contextPath}/resources/css/common.css">
    <link rel="stylesheet" href="${contextPath}/resources/css/common/mdb.min.css" />

    <!-- sidebar -->
    <script src="${contextPath}/resources/js/common/sidebars.js"></script>
    
	<!-- 조직도 관련 css -->
	<link rel="stylesheet" href="${contextPath}/resources/css/organization/organization.css">
	
    <style>
    .main_content{
    	width: 1200px !important;
        padding: 20px;
    }
    
    </style>
</head>
<body>

	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
	    <h2>조직도</h2>
	    <hr>
            
		<ul class="tree">
		  <li> <span class="level1">대표이사</span>
		    <ul>
			    <c:set var="prevDept" value="" />
				<c:forEach var="d" items="${dept}">
				    <c:if test="${d.dept ne prevDept}">
				        <li>
				            <a href="${contextPath}/orginfo/search.do?page=1&department=${d.dept}&phone=&team=전체 팀&name="><span class="level2">${d.dept}</span></a>
				            <ul>
				                <c:forEach var="team" items="${dept}">
				                    <c:if test="${d.dept eq team.dept}">
				                    <ul>
				                        <li><a href="${contextPath}/orginfo/search.do?page=1&department=${team.dept}&team=${team.team}&phone=&name="><span class="level3">${team.team}</span></a></li>
			                        </ul>
				                    </c:if>
				                </c:forEach>
				            </ul>
				        </li>
				        <c:set var="prevDept" value="${d.dept}" />
				    </c:if>
				</c:forEach>
			
		    </ul>
		  </li>
		</ul>
		
		<script>
		  $(document).ready(function() {
		      var treeItems = $('.tree > li > ul > li').length;
		      if (treeItems > 1) {
		          $('.tree > li > ul').css('display', 'flex');
		          $('.tree > li > ul').css('flex-wrap', 'wrap');
		        }
		  });
		</script>
		
		<!-- ------------ -->
	
	</div>
	<!-- 메인 영역 end-->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>