<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1.1 조직도</title>

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
    
    <style>
    .main_content{
    	width: 1200px !important;
        padding: 20px;
    }

    /* 조직도 관련 css */
    /* 대표이사 위치 */
    .tree{
      width: 77.5em;
    }
    .tree, .tree ul, .tree li {
        list-style: none;
        margin: 0;
        padding: 0;
        position: relative;
    }
    .tree {
        margin: 20px;
        text-align: center;
    }
    .tree, .tree ul {
        display: table;
    }
    .tree ul {
        width: 100%;
    }
    .tree li {
        display: table-cell;
        padding: .5em 0;
        vertical-align: top;
        position: relative;
    }
    /* 가로줄 */
    .tree li:before {
        outline: solid 1px lightgray; 
        content: "";
        left: 0px;
        right: 0px;
        position: absolute;
        top: -.2em;
        z-index: -1;
    }
    /* 세로줄 */
    /* .tree ul:before  :  대표이사 */
    .tree ul:before{
      outline: solid 1px gainsboro;
      content: "";
      height: 2.5em;
      left: 50%;
      position: absolute;
      top: -2.8em !important;
      z-index: -1;
    }
    /* .tree span:before : 부서 및 팀 줄 */
    .tree span:before {
        outline: solid 1px gainsboro;
        content: "";
        height: 3.3em;
        left: 50%;
        position: absolute;
        top: -2.7em !important;
        z-index: -1;
    }
    /* 팀 이름에만 빨간색 선이 표시되도록 스타일 적용 */
    .tree ul > li > ul > li > a > .level3:before {
      outline: solid 1px white !important;
      z-index: -1;
    }

    /* 가로 수량 조절시 2개 같이 수정 */
    /* 줄 간격 넓히기 */
    .tree li:nth-child(n+5) {
      margin-top: 50px;
    }
    /* 크기 조절 */
    .tree code, .tree span {
        border: solid .1em gainsboro;
        border-radius: .3em;
        display: inline-block;
        /* 가운데 em : 가로 개수조절 */
        margin: 0 2em 2.3em;
        padding: 1em 1.5em;
        position: relative;
        width: 200px;
    }

    .tree li:first-child:before {
        left: 50%;
    }
    .tree li:last-child:before {
        right: 50%;
    }
    .tree ul:before {
        top: -1.8em;
    }
    .tree code:before, .tree span:before {
        top: -.55em;
    }
    .tree>li {
        margin-top: 0;
    }
    .tree>li:before,
    .tree>li:after,
    .tree>li>code:before,
    .tree>li>span:before {
        outline: none;
    }
    a:hover{
      text-decoration: none !important;
    }
    .level1{
      background-color: navy;
      color: white !important;
      width: 12em;
      z-index: 2;
    }
    .level2 {
      background-color: rgb(0, 183, 165);
      color: white !important;
      bottom: -2em;
    }
    .level3 {
      background-color: gainsboro;
      color: black !important;
      margin: -0.45em 0 !important;
    }
    </style>
</head>
<body>

	<!-- 사이드바 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
	    <h2>직원 검색</h2>
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
		
</body>
</html>