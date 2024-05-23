<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3.1 비품 예약</title>

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
    .i_minus, .i_plus{
        border-radius: 30%;
    }
    .i_minus{
        background-color: rgb(255, 50, 50);
    }
    .i_plus{
        background-color: rgb(47, 180, 47) ;
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
    

    </style>
</head>
<body>

	<!-- 사이드바 해더 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
	    <h2>비품 예약</h2>
	    <hr>
	    
		<!-- ------------ -->
	
		<!--날짜, 오늘 선택 -->
            <div class="div_date">
                <table class="table_date">
                    <tr>
                        <td onclick="prevDate();" class="td_noSelect"><div>◀</div></td>
                        <td>
                            <h4>
                                <input type="date" class="date" id="todayDate">
                            </h4>
                        </td>
                        <td onclick="nextDate();" class="td_noSelect"><div>▶</div></td>
                    </tr>
                </table>
                <button class="btn btn-outline-primary button_today" onclick="setToday();"><h6>오늘</h6></button>
            </div>

            <!-- 비품명 검색 -->
            <div class="div_search">
                <form id="serarForm">
                    <table >
                        <tr>
                            <th class="th_title">
                                <h3>비품명</h3>
                            </th>
                            <td>
                                <input type="text" placeholder="비품명을 입력하세요.">
                            </td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <div class="div_searchBtn">
                                    <button type="reset" class="btn btn-outline-primary"><h6>초기화</h6></button>
                                    <button type="submit" class="btn btn-primary"><h6>검색</h6></button>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            
            <!-- 상단 수량, 사용불가 제외-->
            <div class="div_common">
                <table class="table_count">
                    <tr>
                        <td class="td_left"><h4>전체 10개</h4></td>
                        <td class="td_right">
                            <input type="checkbox" id="checkEquipment" name="checkEquipment" class="form-check-input">
                            <label for="checkEquipment">
                                <h4>사용불가 제외</h4>
                            </label>
                        </td>
                    </tr>
                </table>
            </div>

            <!-- 비품 예약 모달창 -->
            <div id="modal_reserve">
                <div class="div_modal">
                    <table class="table-bordered table_modal">
                        <tr>
                            <th><h5>예약자</h5></th>
                            <td><h5>김병오(kimbyungoh123)</h5></td>
                        </tr>
                        
                        <tr>
                            <th><h5>부서명</h5></th>
                            <td><h5>기획부</h5></td>
                        </tr>

                        <tr>
                            <th><h5>비품명</h5></th>
                            <td><h5>업무미팅룸 208호</h5></td>
                        </tr>

						<!-- 수량제거 예정
                        <tr>
                            <th><h5>수량</h5></th>
                            <td>
                                <div class="div_count">
                                    <h5>
                                        <i class="fa-solid fa-minus i_minus"></i>
                                        <input type="text" value="1" class="modal_count">
                                        <i class="fa-solid fa-plus i_plus"></i>
                                    </h5>
                                </div>
                            </td>
                        </tr>
 						-->
 						
                        <script>
                            // 마이너스 버튼 클릭 시
                            document.querySelector('.i_minus').addEventListener('click', function() {
                                var inputElement = document.querySelector('.modal_count');
                                var value = parseInt(inputElement.value);
                                if (value > 1) {
                                    inputElement.value = value - 1;
                                }
                            });
                        
                            // 플러스 버튼 클릭 시
                            document.querySelector('.i_plus').addEventListener('click', function() {
                                var inputElement = document.querySelector('.modal_count');
                                var value = parseInt(inputElement.value);
                                inputElement.value = value + 1;
                            });
                        </script>

                        <tr>
                            <th><h5>예약일</h5></th>
                            <td>
                                <h5>
                                    <input type="date" class="date" id="modal_date">
                                </h5>
                            </td>
                        </tr>

                        <tr>
                            <th><h5>예약시간</h5></th>
                            <td>
                                <h6>
                                    <div class="div_reserveTime">
                                        <select id="start" class="select-box form-control" style="width:125px;">
                                            <option value="00:00:00">오전 00:00</option>
                                            <option value="00:30:00">오전 00:30</option>
                                            <option value="01:00:00">오전 01:00</option>
                                            <option value="01:30:00">오전 01:30</option>
                                            <option value="02:00:00">오전 02:00</option>
                                            <option value="02:30:00">오전 02:30</option>
                                            <option value="03:00:00">오전 03:00</option>
                                            <option value="03:30:00">오전 03:30</option>
                                            <option value="04:00:00">오전 04:00</option>
                                            <option value="04:30:00">오전 04:30</option>
                                            <option value="05:00:00">오전 05:00</option>
                                            <option value="05:30:00">오전 05:30</option>
                                            <option value="06:00:00">오전 06:00</option>
                                            <option value="06:30:00">오전 06:30</option>
                                            <option value="07:00:00">오전 07:00</option>
                                            <option value="07:30:00">오전 07:30</option>
                                            <option value="08:00:00">오전 08:00</option>
                                            <option value="08:30:00">오전 08:30</option>
                                            <option value="09:00:00">오전 09:00</option>
                                            <option value="09:30:00">오전 09:30</option>
                                            <option value="10:00:00">오전 10:00</option>
                                            <option value="10:30:00">오전 10:30</option>
                                            <option value="11:00:00">오전 11:00</option>
                                            <option value="11:30:00">오전 11:30</option>
                                            <option value="12:00:00">오후 12:00</option>
                                            <option value="12:30:00">오후 12:30</option>
                                            <option value="13:00:00">오후 01:00</option>
                                            <option value="13:30:00">오후 01:30</option>
                                            <option value="14:00:00">오후 02:00</option>
                                            <option value="14:30:00">오후 02:30</option>
                                            <option value="15:00:00">오후 03:00</option>
                                            <option value="15:30:00">오후 03:30</option>
                                            <option value="16:00:00">오후 04:00</option>
                                            <option value="16:30:00">오후 04:30</option>
                                            <option value="17:00:00">오후 05:00</option>
                                            <option value="17:30:00">오후 05:30</option>
                                            <option value="18:00:00">오후 06:00</option>
                                            <option value="18:30:00">오후 06:30</option>
                                            <option value="19:00:00">오후 07:00</option>
                                            <option value="19:30:00">오후 07:30</option>
                                            <option value="20:00:00">오후 08:00</option>
                                            <option value="20:30:00">오후 08:30</option>
                                            <option value="21:00:00">오후 09:00</option>
                                            <option value="21:30:00">오후 09:30</option>
                                            <option value="22:00:00">오후 10:00</option>
                                            <option value="22:30:00">오후 10:30</option>
                                            <option value="23:00:00">오후 11:00</option>
                                            <option value="23:30:00">오후 11:30</option>						
                                        </select>
                                    <h6 class="h6_separator">~</h6>
                                        <select id="end" class="select-box form-control" style="width:125px;">
                                            <option value="00:00:00">오전 00:00</option>
                                            <option value="00:30:00">오전 00:30</option>
                                            <option value="01:00:00">오전 01:00</option>
                                            <option value="01:30:00">오전 01:30</option>
                                            <option value="02:00:00">오전 02:00</option>
                                            <option value="02:30:00">오전 02:30</option>
                                            <option value="03:00:00">오전 03:00</option>
                                            <option value="03:30:00">오전 03:30</option>
                                            <option value="04:00:00">오전 04:00</option>
                                            <option value="04:30:00">오전 04:30</option>
                                            <option value="05:00:00">오전 05:00</option>
                                            <option value="05:30:00">오전 05:30</option>
                                            <option value="06:00:00">오전 06:00</option>
                                            <option value="06:30:00">오전 06:30</option>
                                            <option value="07:00:00">오전 07:00</option>
                                            <option value="07:30:00">오전 07:30</option>
                                            <option value="08:00:00">오전 08:00</option>
                                            <option value="08:30:00">오전 08:30</option>
                                            <option value="09:00:00">오전 09:00</option>
                                            <option value="09:30:00">오전 09:30</option>
                                            <option value="10:00:00">오전 10:00</option>
                                            <option value="10:30:00">오전 10:30</option>
                                            <option value="11:00:00">오전 11:00</option>
                                            <option value="11:30:00">오전 11:30</option>
                                            <option value="12:00:00">오후 12:00</option>
                                            <option value="12:30:00">오후 12:30</option>
                                            <option value="13:00:00">오후 01:00</option>
                                            <option value="13:30:00">오후 01:30</option>
                                            <option value="14:00:00">오후 02:00</option>
                                            <option value="14:30:00">오후 02:30</option>
                                            <option value="15:00:00">오후 03:00</option>
                                            <option value="15:30:00">오후 03:30</option>
                                            <option value="16:00:00">오후 04:00</option>
                                            <option value="16:30:00">오후 04:30</option>
                                            <option value="17:00:00">오후 05:00</option>
                                            <option value="17:30:00">오후 05:30</option>
                                            <option value="18:00:00">오후 06:00</option>
                                            <option value="18:30:00">오후 06:30</option>
                                            <option value="19:00:00">오후 07:00</option>
                                            <option value="19:30:00">오후 07:30</option>
                                            <option value="20:00:00">오후 08:00</option>
                                            <option value="20:30:00">오후 08:30</option>
                                            <option value="21:00:00">오후 09:00</option>
                                            <option value="21:30:00">오후 09:30</option>
                                            <option value="22:00:00">오후 10:00</option>
                                            <option value="22:30:00">오후 10:30</option>
                                            <option value="23:00:00">오후 11:00</option>
                                            <option value="23:30:00">오후 11:30</option>						
                                        </select>
                                    </div>
                                </h6>
                            </td>
                        </tr>



                        <tr>
                            <th><h5>메모</h5></th>
                            <td>
                                <h5>
                                    <input type="text" placeholder="내용을 입력하세요.">
                                </h5>
                            </td>
                        </tr>

                        <tr>
                            <td colspan="2">
                                <div class="div_searchBtn">
                                    <button class="btn btn-outline-primary button-close" data-izimodal-close=""><h6>닫기</h6></a></button>
                                    <button type="submit" class="btn btn-primary"><h6>예약하기</h6></button>
                                </div>
                            </td>
                        </tr>

                    </table>
                </div>
            </div>


            <!-- 모달창 -->
            <script>
                $('#modal_reserve').iziModal({
                    title: '<h4>비품예약</h4>',
                    subtitle: '',
                    headerColor: ' rgb(255,247,208)', 
                    theme:'light',
                    padding: '15px',
                    radius: 10, 
                    zindex:	300,
                    focusInput:	true,
                    restoreDefaultContent: false, 
                });
            </script>

            <!-- 비품 테이블-->
            <div class="div_common">
                <table class="table-bordered table_time line-shadow">
                    <tr class="tr_time">
                        <th class="th_white"><h6>번호</h6></th>
                        <th class="th_name"><h6>비품명</h6></th>
                        <th colspan="2"><h6>00</h6></th>
                        <th colspan="2"><h6>01</h6></th>
                        <th colspan="2"><h6>02</h6></th>
                        <th colspan="2"><h6>03</h6></th>
                        <th colspan="2"><h6>04</h6></th>
                        <th colspan="2"><h6>05</h6></th>
                        <th colspan="2"><h6>06</h6></th>
                        <th colspan="2"><h6>07</h6></th>
                        <th colspan="2"><h6>08</h6></th>
                        <th colspan="2"><h6>09</h6></th>
                        <th colspan="2"><h6>10</h6></th>
                        <th colspan="2"><h6>11</h6></th>
                        <th colspan="2"><h6>12</h6></th>
                        <th colspan="2"><h6>13</h6></th>
                        <th colspan="2"><h6>14</h6></th>
                        <th colspan="2"><h6>15</h6></th>
                        <th colspan="2"><h6>16</h6></th>
                        <th colspan="2"><h6>17</h6></th>
                        <th colspan="2"><h6>18</h6></th>
                        <th colspan="2"><h6>19</h6></th>
                        <th colspan="2"><h6>20</h6></th>
                        <th colspan="2"><h6>21</h6></th>
                        <th colspan="2"><h6>22</h6></th>
                        <th colspan="2"><h6>23</h6></th>
                    </tr>

                    <tr data-izimodal-open="#modal_reserve" class="tr_cursor">
                        <td><h6>1</h6></td>
                        <td><h6>회의실1번회의실1번회의실1번회의실1번회의실1번회의실1번</h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        </a>
                    </tr>

                    <tr data-izimodal-open="#modal_reserve" class="tr_cursor">
                        <td><h6>2</h6></td>
                        <td><h6>회의실2번입니다.</h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td colspan="3" class="td_reserve"><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                    </tr>

                    <tr data-izimodal-open="#modal_reserve" class="tr_cursor">
                        <td><h6>3</h6></td>
                        <td><h6>회의실3번입니다.</h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                    </tr>

                    <tr>
                        <td><h6>3</h6></td>
                        <td><h6>회의실3번입니다.</h6></td>
                        <td colspan="48" class="td_limit"><h6>사용불가</h6></td>
                    </tr>

                    <tr data-izimodal-open="#modal_reserve" class="tr_cursor">
                        <td><h6>3</h6></td>
                        <td><h6>회의실3번입니다.</h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                    </tr>

                    <tr data-izimodal-open="#modal_reserve" class="tr_cursor">
                        <td><h6>3</h6></td>
                        <td><h6>회의실3번입니다.</h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td colspan="2" class="td_reserve"><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                    </tr>

                    <tr data-izimodal-open="#modal_reserve" class="tr_cursor">
                        <td><h6>3</h6></td>
                        <td><h6>회의실3번입니다.</h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td class="td_reserve"><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                        <td><h6></h6></td>
                    </tr>
                </table>
            </div>

            <!--페이징 처리 start-->
            <div class="div_page">
                <ul class="pagination justify-content-center">
                    <li class="page-item"><a class="page-link" href="javascript:void(0);">Previous</a></li>
                    <li class="page-item"><a class="page-link" href="javascript:void(0);">1</a></li>
                    <li class="page-item"><a class="page-link" href="javascript:void(0);">2</a></li>
                    <li class="page-item"><a class="page-link" href="javascript:void(0);">3</a></li>
                    <li class="page-item"><a class="page-link" href="javascript:void(0);">4</a></li>
                    <li class="page-item"><a class="page-link" href="javascript:void(0);">Next</a></li>
                </ul>
            </div>
            <!--페이징 처리 end-->
	
	
		<!-- ------------ -->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>