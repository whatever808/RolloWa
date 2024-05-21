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
  
	<style>
    .main_content{
    	width: 1200px !important;
        padding: 20px;
    }
    
    /* css */
    /* 화살표 */
    .arrow{
        margin: 0 60px;
    }

    /* 출력상태 조회 css */
    .select_date{
        margin-top: 20px;
        text-align: center;
    }
    .today_btn{
        position: relative;
        top: -40px;
        left: 230px;
    }
    h3{
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .td_1 {
        text-align: right;
    }
    .td_2 * {
        margin-left: 90px;
    }

    /* 직원 정보 테이블 */
    .employee_count {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-left: 10px;
    }
    .employee_info {
        text-align: center;
    }
    .employee_info th{
        background-color: lightgray !important;
    }
    .employee_info td{
        vertical-align: middle !important;
    }
    .table{
        text-align: center;
    }
    .table_img{
        border: 1px solid gainsboro;
        border-radius: 100%;
        width: 300px;
        margin: -5px;
    }
    .form-control{
        width: 200px !important;
    }

    .btn_center{
        display: flex;
        justify-content: center;
        margin: 50px;
    }
    /* 맨밑 여백 주기 */
    .btn_center button{
        width: 130px;
        margin: 10px;
        margin-bottom: 100px;
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
                        <img src="../../../resources/images/defaultProfile.png" class="table_img">
                    </th>
                </tr>

                <tr>
                    <td><h3>이름</h3></td>
                    <td>
                        <input type="text" value="황지수">
                    </td>
                    <td><h3>아이디</h3></td>
                    <td>
                        <input type="text" value="hwangjisu">
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