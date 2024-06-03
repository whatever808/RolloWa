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
    <title>비품 예약</title>

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
    .table_time {
    	width: 1000px;
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
        	const urlParams = new URLSearchParams(window.location.search);
            const selectedDate = urlParams.get('selectedDate');

            if (selectedDate) {
                document.getElementById('currentDate').value = selectedDate;
            } else {
                todayDate();
            }

            disablePastDates();
        }
        
        let currentDate = new Date(); 
        
        let currentYear = currentDate.getFullYear(); 
        let currentMonth = currentDate.getMonth() + 1; 
        let currentDay = currentDate.getDate(); 
        
        // 오늘 날짜로 설정하기 (2024-05-11 형식)
        function todayDate(){
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
                url:"${contextPath}/reservation/search.do",
                type:"GET",
                data:{ 
                    selectedDate: selectedDate,
                },
                success: function(data){    
                    $(".table_time tbody").html($(data).find(".table_time tbody").html());
                    $('.tr_cursor').on('click', function() {
                        let equipmentName = $(this).find('td:nth-child(2) h6').text();
                        $('#selectedEquipmentName').text(equipmentName);
                    });
                    disablePastDates();  // 날짜 변경 후 오늘 이전 날짜 비활성화
                }, 
                error: function(){
                    console.error("통신 실패");
                }
            });
        }

        // 오늘 이전 날짜의 행을 비활성화하는 함수
        function disablePastDates() {
            const today = new Date();
            today.setHours(0, 0, 0, 0);

            document.querySelectorAll('.tr_cursor').forEach(row => {
                const rowDate = new Date(document.getElementById('currentDate').value);
                rowDate.setHours(0, 0, 0, 0);
                
                if (rowDate < today) {
                    row.style.pointerEvents = 'none'; // 클릭 비활성화
                    row.style.backgroundColor = '#f0f0f0'; // 시각적 비활성화 표시 (선택 사항)
                } else {
                    row.style.pointerEvents = 'auto'; // 클릭 활성화
                    row.style.backgroundColor = ''; // 원래 색상으로 복구 (선택 사항)
                }
            });
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
                            <input type="text" id="searchInput" placeholder="비품명을 입력하세요." onkeyup="searchEquipment()">
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
                </tr>
            </table>
        </div>
        
        <!-- 비품 예약 모달창 -->
        <form id="modalForm" method="post">
        
        <div id="modal_reserve">
            <div class="div_modal">
                <table class="table-bordered table_modal">
                    <tr>
                        <th><h5>예약자</h5></th>
                        <td><h5 id="userName"></h5></td>
                    </tr>

                    <tr>
                        <th><h5>비품명</h5></th>
                        <td><h5 id="selectedEquipmentName"></h5></td>
                    </tr>

                    <tr>
                        <th><h5>예약일</h5></th>
                        <td><h5 id="modal_date"></h5></td>
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
                                        <option value="13:00:00">오후 13:00</option>
                                        <option value="13:30:00">오후 13:30</option>
                                        <option value="14:00:00">오후 14:00</option>
                                        <option value="14:30:00">오후 14:30</option>
                                        <option value="15:00:00">오후 15:00</option>
                                        <option value="15:30:00">오후 15:30</option>
                                        <option value="16:00:00">오후 16:00</option>
                                        <option value="16:30:00">오후 16:30</option>
                                        <option value="17:00:00">오후 17:00</option>
                                        <option value="17:30:00">오후 17:30</option>
                                        <option value="18:00:00">오후 18:00</option>
                                        <option value="18:30:00">오후 18:30</option>
                                        <option value="19:00:00">오후 19:00</option>
                                        <option value="19:30:00">오후 19:30</option>
                                        <option value="20:00:00">오후 20:00</option>
                                        <option value="20:30:00">오후 20:30</option>
                                        <option value="21:00:00">오후 21:00</option>
                                        <option value="21:30:00">오후 21:30</option>
                                        <option value="22:00:00">오후 22:00</option>
                                        <option value="22:30:00">오후 22:30</option>
                                        <option value="23:00:00">오후 23:00</option>
                                        <option value="23:30:00">오후 23:30</option>						
                                    </select>
                                <h6 class="h6_separator">~</h6>
                                    <select id="end" class="select-box form-control" style="width:125px;">
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
                                        <option value="13:00:00">오후 13:00</option>
                                        <option value="13:30:00">오후 13:30</option>
                                        <option value="14:00:00">오후 14:00</option>
                                        <option value="14:30:00">오후 14:30</option>
                                        <option value="15:00:00">오후 15:00</option>
                                        <option value="15:30:00">오후 15:30</option>
                                        <option value="16:00:00">오후 16:00</option>
                                        <option value="16:30:00">오후 16:30</option>
                                        <option value="17:00:00">오후 17:00</option>
                                        <option value="17:30:00">오후 17:30</option>
                                        <option value="18:00:00">오후 18:00</option>
                                        <option value="18:30:00">오후 18:30</option>
                                        <option value="19:00:00">오후 19:00</option>
                                        <option value="19:30:00">오후 19:30</option>
                                        <option value="20:00:00">오후 20:00</option>
                                        <option value="20:30:00">오후 20:30</option>
                                        <option value="21:00:00">오후 21:00</option>
                                        <option value="21:30:00">오후 21:30</option>
                                        <option value="22:00:00">오후 22:00</option>
                                        <option value="22:30:00">오후 22:30</option>
                                        <option value="23:00:00">오후 23:00</option>
                                        <option value="23:30:00">오후 23:30</option>
                                        <option value="23:59:59">오전 00:00</option>			
                                    </select>
                                </div>
                            </h6>
                        </td>
                    </tr>

                    <tr>
                        <th><h5>내용</h5></th>
                        <td>
                            <h5>
                                <input id="content" type="text" placeholder="내용을 입력하세요." required>
                            </h5>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2">
                            <div class="div_searchBtn">
                                <!-- <button class="btn btn-outline-primary button-close"><h6>닫기</h6></a></button> -->
                                <button type="submit" class="btn btn-primary" onclick="reserveSubmit();"><h6>예약하기</h6></button>
                            </div>
                        </td>
                    </tr>

                </table>
            </div>
        </div>
		</form>
        
		<script>
	    function reserveSubmit() {
	        
	    	const userNo = "${loginMember.userNo}";
	        const equipmentName = document.getElementById('selectedEquipmentName').textContent;
	        const reserveDate = document.getElementById('modal_date').textContent;
	        const startTime = document.getElementById('start').value;
	        const endTime = document.getElementById('end').value;
	        const content = document.getElementById('content').value;
	        
	        console.log("사용자번호: ", userNo);
	        console.log("비품명: ", equipmentName);
	        console.log("예약일: ", reserveDate);
	        console.log("예약 시간: ", startTime + " ~ " + endTime);
	        console.log("내용: ", content);
	        
	        if (startTime >= endTime) {
	            //console.log("예약을 실패했습니다. 시작 시간이 종료 시간과 같거나 더 늦습니다.");
	            alert("예약을 실패했습니다. 시작 시간이 종료 시간과 같거나 더 늦습니다.")
	            return;
	        }
	        
	        const formData = new FormData();
	        formData.append('userNo', "${loginMember.userNo}");
	        formData.append('equipmentName', document.getElementById('selectedEquipmentName').textContent);
	        formData.append('reserveDate', document.getElementById('modal_date').textContent);
	        formData.append('startTime', document.getElementById('start').value);
	        formData.append('endTime', document.getElementById('end').value);
	        formData.append('content', document.getElementById('content').value);
	
	        $.ajax({
	            type: "POST",
	            url: "${contextPath}/reservation/reserve.do",
	            data: formData,
	            processData: false,
	            contentType: false,
	            success: function(response) {
	            	if(response.success == false){
	                	console.log("예약이 실패되었습니다. 다른 직원이 예약중인 시간입니다.");
	                	alert("예약이 실패되었습니다. 다른 직원이 예약한 시간입니다.")
	            	} else{
	                	console.log("예약이 성공적으로 완료되었습니다.");
	                	alert("예약이 성공적으로 완료되었습니다.");
	                	$('#modal_reserve').iziModal('close');
	                	//location.reload();
	                	
	                	const currentDate = document.getElementById('currentDate').value;
	                    const url = new URL(window.location);
	                    url.searchParams.set('selectedDate', currentDate);
	                    window.location.href = url.toString();
	            	}
	            },
	            error: function(xhr, status, error) {
	                console.error("오류가 발생했습니다:", error);
	            }
	        });
	    }
		</script>

            <!-- 모달창 -->
            <script>
            $(document).ready(function(){
            	
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
                    onOpening: function(modal){
    		            // 모달 열릴 때 실행할 함수
    		            
    		            console.log('모달이 열립니다.');
    		            var userNo = "${ loginMember.userNo }";
    		            var userName = "${ loginMember.userName }";
    		            var userId = "${ loginMember.userId }";
                    	var equipmentName = $('#selectedEquipmentName').text();
    		            var currentDate = document.getElementById('currentDate').value;
    		            
    		            $('#userName').html('<span>' + userName + '</span><span>(' + userId + ')</span>');
    		            $('#selectedEquipmentName').text(equipmentName);
    		            $('#modal_date').text(currentDate);
    		            
    		        },
                    onClosing: function(modal) {
                        // 모달이 닫힐 때 실행할 작업
                        console.log('모달이 닫힙니다.');
                    }
                });
             	// 비품 검색 테이블의 각 행에 대한 클릭 이벤트 설정
                $('.tr_cursor').on('click', function() {
                    // 클릭된 행에서 비품명 가져오기
                    let equipmentName = $(this).find('td:nth-child(2) h6').text();

                    // 가져온 비품명을 모달에 표시
                    $('#selectedEquipmentName').text(equipmentName);
                });       		
        		
    		});
    		
    		
            
            
            
            function searchEquipment() {
                var input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("searchInput");
                filter = input.value.toUpperCase();
                table = document.getElementsByClassName("table_time")[0];
                tr = table.getElementsByTagName("tr");

                var found = false; // found 변수를 정의하고 초기화합니다.

                for (i = 1; i < tr.length; i++) { // 첫 번째 행을 건너뛰고 두 번째 행부터 시작합니다.
                    td = tr[i].getElementsByTagName("td")[1]; // 비품명이 들어있는 열(2번째 열)
                    if (td) {
                        txtValue = td.textContent || td.innerText;
                        if (txtValue.toUpperCase().indexOf(filter) > -1) {
                            tr[i].style.display = "";
                            found = true; // 일치하는 항목이 있음을 표시합니다.
                        } else {
                            tr[i].style.display = "none";
                        }
                    }
                }

                // 이전에 추가된 메시지가 있다면 제거합니다.
                var existingMessage = table.querySelector('.noResultMessage');
                if (existingMessage) {
                    existingMessage.parentNode.removeChild(existingMessage);
                }

                if (!found) {
                    var noResultRow = document.createElement('tr');
                    var noResultCell = document.createElement('td');
                    noResultCell.colSpan = "50";
                    noResultCell.innerText = "조회된 비품이 없습니다.";
                    noResultCell.className = 'noResultMessage'; // 클래스를 추가하여 메시지를 식별합니다.
                    noResultRow.appendChild(noResultCell);
                    table.appendChild(noResultRow); // tbody가 아닌 table에 추가합니다.
                }
            }
			
			// 검색 시 엔터키 사용 안되게하기
	        function handleKeyPress(event) {
	            if (event.keyCode === 13) {
	                event.preventDefault();
	                searchEquipment();
	            }
	        }
			// 초기화
	        function reload() {
	        	let input = document.getElementById("searchInput");
	        	$('#modal_reserve').iziModal('close');
	            searchEquipment();
	        }
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
					    <c:when test="${not empty list}">
					        <c:forEach var="e" items="${list}" varStatus="loop">
					            <tr data-izimodal-open="#modal_reserve" class="tr_cursor" data-equipment-name="${e.equipmentName}">
					                <!-- 비품 정보 표시 -->
					                <td><h6>${loop.index + 1}</h6></td>
					                <td><h6>${e.equipmentName}</h6></td>
					                
					                <!-- 시간표 셀 채우기 -->
					                <c:forEach var="timeSlot" begin="1" end="48">
					                    <c:set var="reserved" value="false" />
					                    <!-- 예약된 시간 확인 -->
					                    <c:forEach var="r" items="${reservationList}">
					                        <c:if test="${e.code eq r.equipmentCode}">
					                            <!-- 시간 계산 -->
					                            <c:set var="startHour" value="${fn:substring(r.reserveStart, 11, 13)}" />
					                            <c:set var="startMinute" value="${fn:substring(r.reserveStart, 14, 16)}" />
					                            <c:set var="endHour" value="${fn:substring(r.reserveEnd, 11, 13)}" />
					                            <c:set var="endMinute" value="${fn:substring(r.reserveEnd, 14, 16)}" />
					                            <c:set var="startSlot" value="${startHour * 2 + (startMinute / 30)}" />
					                            <!-- 예약 종료 시간이 23:59:59인 경우 48로 설정 -->
					                            <c:if test="${endHour eq '23' and endMinute eq '59'}">
					                                <c:set var="endSlot" value="48" />
					                            </c:if>
					                            <c:if test="${not (endHour eq '23' and endMinute eq '59')}">
					                                <c:set var="endSlot" value="${endHour * 2 + (endMinute / 30)}" />
					                            </c:if>
					                            <!-- 시작 시간과 종료 시간 비교 -->
					                            <c:if test="${timeSlot > startSlot and timeSlot <= endSlot}">
					                                <!-- 해당 시간대에 예약이 있는 경우 -->
					                                <c:set var="reserved" value="true" />
					                                <!-- 색상 변경 또는 다른 표시 방법을 여기에 추가 -->
					                            </c:if>
					                        </c:if>
					                    </c:forEach>
					                    <!-- 예약된 시간이 있는 경우 -->
					                    <c:if test="${reserved}">
					                        <!-- 예약이 있는 경우에 대한 표시를 여기에 추가 -->
					                        <td class="td_reserve"></td>
					                    </c:if>
					                    <!-- 예약된 시간이 없는 경우 -->
					                    <c:if test="${not reserved}">
					                        <!-- 예약이 없는 경우에 대한 표시를 여기에 추가 -->
					                        <td></td>
					                    </c:if>
					                </c:forEach>
					            </tr>
					        </c:forEach>
					    </c:when>
					    <c:otherwise>
					        <tr>
					            <td colspan="48">조회된 비품이 없습니다.</td>
					        </tr>
					    </c:otherwise>
					</c:choose>

                </table>
            </div>
			<!-- ------------ -->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>