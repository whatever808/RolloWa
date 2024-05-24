<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>2.2 급여 조회 상세페이지</title>

	<!-- css -->
	<link rel="stylesheet" href="${contextPath}/resources/css/attendance/account.css">

	<style>
    .main_content{
    	width: 1200px !important;
        padding: 20px;
    }
    
    </style>
</head>
<body>

	<!-- 사이드바 해더 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
	    <h2>급여 조회 상세페이지</h2>
	    <hr>
	    
		<!-- ------------ -->
	
		<!--날짜, 오늘 선택-->
            <div class="select_date">
                <h3>
                    <div class="arrow">◀</div>
                    2024년 5월
                    <div class="arrow">▶</div>
                </h3>
                <button class="btn btn-outline-primary today_btn"><h6>이번달</h6></button>
            </div>

            <!-- 직원 정보 -->
            <table class="table table-responsive">
                <tr>
                    <th colspan="4">
                        <c:choose>
			            	<c:when test="${ not empty m.profileUrl }">
				                <img src="${ m.profileUrl }" class="profile_img" onerror="this.onerror=null; this.src='${contextPath}/resources/images/defaultProfile.png';">
			            	</c:when>
			            	<c:otherwise>
				                <img src="${ contextPath }/resources/images/defaultProfile.png" class="profile_img">
			            	</c:otherwise>
			            </c:choose>
                    </th>
                </tr>

                <tr>
                    <td><h3>이름</h3></td>
                    <td>
                        <input type="text" value="${ user.name }">
                    </td>
                    <td><h3>아이디</h3></td>
                    <td>
                        <input type="text" value="${ user.userId }">
                    </td>
                    
                </tr>

                <tr>
                    <td><h3>총 근무시간</h3></td>
                    <td>
                        <input type="text" value="184 시간">
                    </td>

                    <td><h3>시급</h3></td>
                    <td>
                        <input type="text" value="10,000">
                    </td>
                </tr>

                <tr>
                    <td><h3>부서명</h3></td>
                    <td class="td_2">
                        <select name="department" id="department" class="form-control">
                            <option value="">전체 부서</option>
                            <option value="">마케팅부</option>
                            <option value="">부서2</option>
                            <option value="">부서3</option>
                        </select>
                    </td>
                    <td><h3>팀명</h3></td>
                    <td class="td_2">
                        <select name="" id="" class="form-control">
                            <option value="">마케팅1팀</option>
                            <option value="">마케팅2팀</option>
                            <option value="">마케팅3팀</option>
                        </select>
                    </td>
                </tr>

                <tr>
                    <td><h3>지급총액</h3></td>
                    <td>
                        <input type="text" value="1,840,000">
                    </td>
                </tr>

            </table>


            <div class="btn_center">
                <button class="btn btn-outline-primary" type="reset"><h5>뒤로가기</h5></button>
                <button class="btn btn-primary"><h5>저장</h5></button>
            </div>
	
	
		<!-- ------------ -->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>