<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3.3 비품 관리</title>

  
	<style>
    .main_content{
    	width: 1200px !important;
        padding: 20px;
    }
    
    /* css */
    /* 비품 예약 css */
    .div_date{
        margin-top: 20px;
        text-align: center;
    }
    .table_date{
        font-size: 25px;
        margin: auto;   
        width: 350px;
    }
    .button_today{
        position: relative;
        top: -40px;
        left: 250px;
    }
    .div_search table{
        display: flex;
        justify-content: center;
        margin-bottom: 50px;
    }
    .th_title{
        background-color: aquamarine !important;
        width: 170px;
        height: 60px;
        text-align: center;
        border-radius: 10px;
    }
    .div_search input{
        width: 400px !important;
        margin-left: 20px;
    }
    .date{
        font-size: 20px !important;
    }
    .td_noSelect{
        user-select: none;
    }
    .btn_center{
        display: flex;
        text-align: center;
    }
    .div_searchBtn{
        display: flexbox;
        text-align: center;
    }
    .div_searchBtn button{
        margin: 20px 5px;
        width: 100px;
    }
    .div_common{
        display: flex;
        justify-content: center;
    }
    .table_count{
        width: 100%;
        margin: 10px 50px;
    }
    .td_left{
        text-align: left;
    }
    .td_right{
        text-align: right;
    }
    
    h6{
        font-size: 15px !important;
    }
    .tr_time th,td{
        width: 18px;
        height: 35px;
        text-align: center;
    }
    .th_white{
        white-space: nowrap;
    }
    .th_name{
        width: 200px !important;
    }
    .tr_time th{
        background-color: gainsboro;
    }

    .td_reserve{
        background-color: cyan;
        white-space: nowrap;
    }
    .td_limit{
        background-color: red;
        color: white;
    }

    .tr_cursor{
        cursor: pointer;
    }
    .tr_cursor:hover{
        background-color: rgb(255,247,208);
    }

    .table_modal{
        margin:auto;
        display: flex;
        justify-content: center;
        width: 500px;
        text-align: center;
    }
    .table_modal th{
        width: 100px;
        background-color: gainsboro;
    }
    .table_modal td{
        width: 300px;
    }
    .table_modal input[type="text"]{
        width: 80%;
    }
    .div_reserveTime{
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .div_count{
        display: flex;
        align-items: center;
        justify-content: center;
        user-select: none;
    }
    .div_count i {
        width: 1.5em;
        height: 1.5em;
    }
    .modal_count{
        width: 80px !important;
        text-align: center;
    }
    .i_minus{
        background-color: red;
    }
    .i_plus{
        background-color: green ;
    }
    .div_count h5{
        margin: 0 30px;
    }
    .h6_separator{
        margin: 0  10px;
    }

   
    .div_page{
        margin-top: 30px;
    }

    /* css */
    .div_1{
        display: flex;
    }
    .div_1 h4{
        margin-right: auto;
    }
    .div_1 div{
        justify-content: flex-end;
    }


    .table th{
        background-color: gainsboro;
    }
    .td_1{
        background-color: rgb(184, 184, 184) !important;
    }
    .td_2{
        background-color: rgb(95, 164, 255) !important;
    }
    

    </style>
</head>
<body>

	<!-- 사이드바 해더 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
	    <h2>비품 관리</h2>
	    <hr>
	    
		<!-- ------------ -->
	
		<div class="div_1">
                <h4>전체 12개</h4>
                <div>
                    <button>상태 수정</button>
                    <button>비품 삭제</button>
                    <button>비품 추가</button>
                </div>
            </div>

            <table class="table">
                <tr>
                    <th>
                        <input type="checkbox">
                        체크 박스
                    </th>
                    <th>관리번호</th>
                    <th>비품명</th>
                    <th>예약 상태 설정</th>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox">
                    </td>
                    <td>1</td>
                    <td>비품명1</td>
                    <td class="td_1">예약불가 설정</td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox">
                    </td>
                    <td>1</td>
                    <td>비품명1</td>
                    <td class="td_1">예약불가 설정</td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox">
                    </td>
                    <td>1</td>
                    <td>비품명1</td>
                    <td class="td_2">예약불가 해제</td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox">
                    </td>
                    <td>1</td>
                    <td>비품명1</td>
                    <td class="td_1">예약불가 설정</td>
                </tr>
                <tr>
                    <td>
                        <input type="checkbox">
                    </td>
                    <td>1</td>
                    <td>비품명1</td>
                    <td class="td_1">예약불가 설정</td>
                </tr>
            </table>
	
	
		<!-- ------------ -->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>