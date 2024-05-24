<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3.1 비품 예약</title>

	<style>
    .main_content{
    	width: 1200px !important;
        padding: 20px;
    }
    
    /* 비품 예약 css */
    .select_date{
    	margin: 50px;
    }
    .table_2{
	    font-size: 25px;
	    margin: auto;   
	    width: 350px;
	}
	#currentDate{
    	white-space: nowrap;
    	font-size: 25px;
    }
    .div_date{
        margin-top: 20px;
        text-align: center;
    }
    .table_date{
        font-size: 25px;
        margin: auto;   
        width: 350px;
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
        align-items: center;
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
	    
		<!-- ----------------------------------------------------------------------------------------- -->
	
		<!--날짜, 오늘 선택 -->
		<div class="select_date">
			<table class="table_2">
		    	<tr>
					<td><h3><div class="arrow" onclick="changeDate(-1);">◀</div></h3></td>
					<td><input type="date" id="currentDate" onchange="changeDate(0);"></td>
					<td><h3><div class="arrow" onclick="changeDate(1);">▶</div></h3></td>
				</tr>
		    </table>
		</div>
		
		<!-- 날짜 관련 js -->
		<script>
		// 페이지 로드시 오늘 날짜 표시하기 
        window.onload = function() {
        	todayDate();
        }
		
        let currentDate = new Date(); // 다음값 : Tue May 21 2024 13:16:45 GMT+0900 (한국 표준시)
        
		let currentYear = currentDate.getFullYear(); // 2024
		let currentMonth = currentDate.getMonth() + 1; // 5
		let currentDay = currentDate.getDate(); // 일
		
		// 오늘 날짜로 설정하기 (2024-05-11 형식)
        function todayDate(){
			
			// 날짜 형식 2024-05로 설정
			let currentMonthString = currentYear + '-' + (currentMonth < 10 ? '0' : '') + currentMonth + '-' + (currentDay < 10 ? '0' : '') + currentDay;
			
			document.getElementById('currentDate').value = currentMonthString;
        }
        
     	// 날짜 변경 함수
		function changeDate(number) {
			let currentDateInput = document.getElementById('currentDate').value;
			
			currentDate = new Date(currentDateInput);
	        newDate = new Date(currentDate);
	        newDate.setDate(currentDate.getDate() + number);
			
			let newYear = newDate.getFullYear();
			let newMonth = newDate.getMonth() + 1;
			let newDay = newDate.getDate();
			let selectedDate = newYear + '-' + (newMonth < 10 ? '0' : '') + newMonth + '-' + (newDay < 10 ? '0' : '') + newDay;
			
			document.getElementById('currentDate').value = selectedDate;
			console.log("현재 날짜 : ", selectedDate);
			
			$.ajax({
				url:"${ contextPath }/reservation/search.do",
				type:"GET",
				data:{ 
					selectedDate: selectedDate,
				},
				success: function(data){	
					//console.log("통신 성공");
					
					$(".table_time tbody").html($(data).find(".table_time tbody").html());
					
				}, error: function(){
					//console.log("통신 실패");
				}
			})
		}
        
		</script>

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
                    <td class="td_left"><h4>전체 ${ listCount }개</h4></td>
                    <td class="td_right">
                        <input type="checkbox" id="checkEquipment" name="checkEquipment" class="form-check-input">
                        <label for="checkEquipment">
                            <h4>사용불가 제외</h4>
                        </label>
                    </td>
                </tr>
            </table>
        </div>
        
        <!-- 모달창 스크립트 -->
        <script>
        document.addEventListener("DOMContentLoaded", function() {
			// console.log("loginMember: ", MemberDto(userNo=1109, userName=박호중, userId=user60, 
			// userPwd=$2a$10$PWYc/G1CPm2svFw4HehFXuDjDWYHyc7h.1Lee.XB9hTZrGkdBqk4., phone=null, 
			// postCode=null, address=null, detailAddress=null, totalAddress=null, bankAccount=null, bank=null, email=null, 
			// profileURL=null, countFail=0, enrollDate=null, enrollUserNo=0, modifyDate=null, modifyUserNo=0, status=null, 
			// vacationCount=0, authLevel=0, salary=0, teamCode=C, positionCode=C, position=null));
            const trElements = document.querySelectorAll('.tr_cursor'); // 클릭할 tr 요소를 선택합니다.
        	const userName = "${loginMember.userName}";
        	const userId = "${loginMember.userId}";
        	//const userDepartment = "${loginMember.teamCode}";
        	
            trElements.forEach(function(trElement) {
                trElement.addEventListener('click', function() {
                    const equipmentName = trElement.querySelector('td:nth-child(2) h6').textContent; // 클릭한 tr 요소에서 비품명을 가져옵니다.
                    
                    document.getElementById('userName').textContent = userName + "(" + userId + ")";
                    document.getElementById('selectedEquipmentName').textContent = equipmentName;
                    
                    //const department = userDepartment === 'C' ? 'C이다' : '아니다';
                    //document.getElementById('department').textContent = department;

                });
            });
        });
        </script>

        <!-- 비품 예약 모달창 -->
        <div id="modal_reserve">
            <div class="div_modal">
                <table class="table-bordered table_modal">
                    <tr>
                        <th><h5>예약자</h5></th>
                        <td><h5 id="userName"></h5></td>
                    </tr>
                    
                    <tr>
                        <th><h5>부서명</h5></th>
                        <td><h5 id="department"></h5></td>
                    </tr>

                    <tr>
                        <th><h5>비품명</h5></th>
                        <td><h5 id="selectedEquipmentName"></h5></td>
                    </tr>

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
                    
                    <c:choose>
                    	<c:when test="${ not empty list }">
                    		<c:forEach var="e" items="${list}" varStatus="loop">
							    <tr data-izimodal-open="#modal_reserve" class="tr_cursor">
							        <!-- 비품 정보 표시 -->
							        <td><h6>${loop.index + 1}</h6></td>
							        <td><h6>${e.equipmentName}</h6></td>
							        
							        <!-- 비품 예약 확인 -->
							        <c:set var="reservationFound" value="false"/>
							        <c:forEach var="r" items="${reservationList}">
							            <c:if test="${e.code eq r.equipmentCode}">
							                <c:set var="reservationFound" value="true"/>
							                <!-- 날짜 형식 : 2024-05-05 00:00:00.0 -->
							                
							                <!-- 시작 시간까지 채우기 -->
							                <c:forEach begin="1" end="${fn:substring(r.reserveStart, 11, 13)*2}" varStatus="loop">
						                    	<td></td>
							                </c:forEach>
							                
							                <!-- 예약한 시간 채우기(시간) -->
							                <c:forEach begin="1" end="${(fn:substring(r.reserveEnd, 11, 13)- fn:substring(r.reserveStart, 11, 13))*2}" varStatus="loop">
							                    <td class="td_reserve"></td>
							                </c:forEach>
							                
							                <!-- 예약한 시간 채우기(분) -->
							                <c:forEach begin="1" end="${fn:substring(r.reserveStart, 14, 16)}" varStatus="loop">
							                    <c:if test="${loop.index == 1}">
							                        <td class="td_reserve"></td>
							                    </c:if>
							                </c:forEach>
							                
							                <!-- 나머지 시간 매꾸기 -->
							                <c:forEach begin="1" end="${ 48-fn:substring(r.reserveStart, 11, 13)*2
							                                                -(fn:substring(r.reserveEnd, 11, 13)- fn:substring(r.reserveStart, 11, 13))*2
							                                                -(fn:substring(r.reserveStart, 14, 16)/30)
							                                                }" varStatus="loop">
							                    <td></td>
							                </c:forEach>
							            </c:if>
							        </c:forEach>
							        
							        <!-- 예약이 없는 경우 -->
							        <c:if test="${not reservationFound}">
							            <c:forEach begin="1" end="48">
							                <td></td>
							            </c:forEach>
							        </c:if>
							    </tr>
							</c:forEach>
					    </c:when>
					    
				    	<c:otherwise>
					        <tr>
					            <td colspan="26">조회된 비품이 없습니다.</td>
					        </tr>
					    </c:otherwise>
					</c:choose>

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