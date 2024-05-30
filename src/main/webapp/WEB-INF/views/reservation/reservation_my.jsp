<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>3.2 내 예약 조회</title>

	<style>
    .main_content{
    	width: 1200px !important;
        padding: 20px;
    }
    
    /* css */
    /* 내 비품 예약 css */
    .table_1 th{
    	background-color: gainsboro !important;
    }
    .div_1{
        display: flex;
        margin-top: 50px;
        margin-bottom: 10px;
    }
    .div_1 h4{
        margin-right: auto;
    }
    .div_1 div{
        justify-content: flex-end;
    }


    .reservation_1,
    .reservation_2,
    .reservation_3,
    .reservation_4{
        color: white !important;
    }
    .table th{
        background-color: gainsboro;
        text-align: center;
    }
    .table td{
        text-align: center;
    }

    .reservation_1{
        background-color: green !important;
    }
    .reservation_2{
        background-color: rgb(255, 30, 30) !important;
    }
    .reservation_3{
        background-color: rgb(64, 196, 248) !important;
    }
    .reservation_4{
        background-color: orange !important;
    }

    </style>
</head>
<body>

	<!-- 사이드바 해더 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
	    <h2>내 예약 조회</h2>
	    <hr>
	    
		<!-- ------------ -->
	
		<div class="div_1">
		<h4>전체 개</h4>
			<div>
				<!-- <button class="btn btn-outline-primary">예약 수정</button> -->
				<button class="btn btn-primary" id="cancelReservationBtn">예약 취소</button>
			</div>
		</div>

		<table class="table table-bordered line-shadow table_1 ">
			<tr>
				<th>
					<input type="checkbox" id="selectAll" class="form-check-input">
					<label for="selectAll">전체 선택</label>
				</th>
				<th>번호</th>
				<th>비품명</th>
				<th>날짜</th>
				<th>예약 시간</th>
				<th>반납 예정 시간</th>
				<th>내용</th>
			</tr>
			<c:choose>
				<c:when test="${ not empty reservationList }">
					<c:forEach var="r" items="${reservationList}">
					    <tr>
					        <td class="checkbox-cell">
							    <input type="checkbox" id="selectOne-${r.reservationNo}" class="form-check-input" data-reservation-no="${r.reservationNo}">
							    <label for="selectOne-${r.reservationNo}">선택</label>
							</td>
					        <td>${r.reservationNo}</td>
					        <td>${r.equipmentName}</td>
					        <td><fmt:formatDate value="${r.startTime}" pattern="yyyy년 MM월 dd일(E)"/></td>
					        <td><fmt:formatDate value="${r.startTime}" pattern="HH:mm"/></td>
					        <td><fmt:formatDate value="${r.endTime}" pattern="HH:mm"/></td>
					        <td>${r.content}</td>
					    </tr>
					</c:forEach>
				</c:when>
				<c:otherwise>
		        	<tr>
		        		<td colspan="8">조회된 예약이 없습니다.</td>
		        	</tr>
		        </c:otherwise>
	        </c:choose>
           </table>
            
            <script>
            //console.log("user: ", ${loginMember.userNo});
            $(document).ready(function() {
	            $.ajax({
		 	        url: "${contextPath}/reservation/my.do",
		 	        type: "GET",
					data:{ userNo: "${ loginMember.userNo }" },
		 	        success: function(data){
						//console.log("통신 성공");
						
						// 예약 정보 테이블에 출력
						$(".table_1 tbody").html($(data).find(".table_1 tbody").html());
						
						// 번호 출력, 체크박스 표시 설정
						$(".table_1 tbody tr").each(function(index) {
		                    $(this).find('td:nth-child(2)').text(index);
		
		                    var endTime = $(this).find('td:nth-child(5)').text();
		                    var currentTime = new Date();
		                    var returnTime = new Date(endTime.replace(/-/g, '/'));
		
		                    if (returnTime < currentTime) {
		                        $(this).find('.checkbox-cell').html('');
		                    }
		                });
						
						// 시간 데이터에서 .0 제거
		                $(".table_1 tbody td:nth-child(4), .table_1 tbody td:nth-child(5)").each(function() {
		                    var time = $(this).text();
		                    time = time.split(".")[0]; // 소수점 이하 부분 제거
		                    $(this).text(time);
		                });
						
						// 예약한 개수 출력
		                var rowCount = $(".table_1 tbody tr").length;
		                var lastRow = $(".table_1 tbody tr:last-child");

		                // 마지막 행이 colspan을 사용하는지 확인
		                var colspan = lastRow.find("td").attr("colspan");

		                if (colspan) {
		                    // colspan이 존재하면 rowCount에서 2를 뺌
		                    rowCount -= 2;
		                } else {
		                    // 그렇지 않으면 rowCount에서 1을 뺌
		                    rowCount -= 1;
		                }

		                $("h4").html("전체 " + rowCount + "개");
					    
		 	        },
		 	        error: function(){
		 	            //console.log("통신 실패");
		 	        }
		 	    });
            });
         	// 전체 선택 체크박스 클릭 시
            $(document).on('click', '#selectAll', function() {
                var isChecked = $(this).prop('checked');
                $('.table_1 tbody input[type="checkbox"]').prop('checked', isChecked);
            });

         	// 개별 체크박스 클릭 시
            $(document).on('click', '.table_1 tbody input[type="checkbox"]', function() {
                var totalCheckboxes = $('.table_1 tbody input[type="checkbox"]').length;
                var checkedCheckboxes = $('.table_1 tbody input[type="checkbox"]:checked').length;
                var isAllChecked = totalCheckboxes === checkedCheckboxes;

                $('#selectAll').prop('checked', isAllChecked);
            });
         	
         	// 예약 취소 버튼 클릭 시 예약 취소
            $('#cancelReservationBtn').on('click', function() {
                var selectedReservations = [];
                $('.table_1 tbody input[type="checkbox"]:checked').each(function() {
                    selectedReservations.push($(this).data('reservation-no'));
                });

                if (selectedReservations.length > 0) {
                    $.ajax({
                        url: "${contextPath}/reservation/cancel.do",
                        type: "POST",
                        contentType: "application/json",
                        data: JSON.stringify({ reservationNo: selectedReservations }),
                        success: function(response) {
                            // 성공적으로 예약 취소 처리 후 테이블 갱신
                            if (response == "SUCCESS") {
	                            alert('예약이 취소되었습니다.');
	                            location.reload();
                            } else {
	                            alert('예약이 취소 실패!');
                            	
                            }
                        },
                        error: function() {
                            alert('예약 취소에 실패했습니다.');
                        }
                    });
                } else {
                    alert('취소할 예약을 선택해주세요.');
                }
            });
            
            
            
            </script>
	
		<!-- ------------ -->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>