<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.TimeZone" %>
<%@ page import="java.util.Calendar" %>
<%
    // 대한민국 시간 설정
    Calendar calendar = Calendar.getInstance(TimeZone.getTimeZone("Asia/Seoul"));
    java.util.Date currentDateKST = calendar.getTime();
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<c:set var="itemsPerPage" value="10"/>
<c:set var="startNo" value="${listCount - (pi.currentPage - 1) * itemsPerPage}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 관리</title>

	<style>
    .main_content{
    	width: 1300px !important;
        padding: 20px;
    }
    
    /* css */
    /* 내 비품 예약 css */
    .table_1 {
        table-layout: fixed;
        width: 100%;
    }
    .tb_select{
    	width: 150px;
    }
    .tb_no{ width: 80px; }
    .tb_img{ width: 120px; }
    .tb_name{ width: 100px; }
    .tb_equipment{ 
    	/* width: 150px;  */
    	white-space: nowrap;
   	}
   	.tb_date1{
   		width: 150px;
   		white-space: nowrap;
   	}
   	.tb_date2, .tb_date3{
   		width: 100px;
   	}
    .table_1 th{
    	background-color: gainsboro !important;
    	white-space: nowrap;
    }
    .table_1 td img{
	    border: 1px solid gainsboro;
	    border-radius: 100%;
	    width: 50px;
	    height: 50px;
		object-fit: cover; /* 다른 사이즈 이미지도 안잘리고 동일하게 조절하기 */
	   margin: -10px;
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

    .table th{
        background-color: gainsboro;
        text-align: center;
    }
    .table td{
        text-align: center;
    }
    

    </style>
</head>
<body>

	<!-- 로그인 체크 -->
	<c:if test="${empty loginMember}">
	    <script>
	        alert("로그인 후 이용가능합니다.");
	        window.location.href = "${pageContext.request.contextPath}/";
	    </script>
	</c:if>

	<!-- 사이드바 해더 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
	    <h2>예약 관리</h2>
	    <hr>
	    
		<!-- ------------ -->
	
		<div class="div_1">
		<h4 id="totalCount">전체 ${ listCount }개</h4>
			<div>
				<button class="btn btn-primary" id="cancelReservationBtn">예약 삭제</button>
			</div>
		</div>

		<table class="table table-bordered line-shadow table_1">
		    <thead>
		        <tr>
		            <th class="tb_select">
		                <input type="checkbox" id="selectAll" class="form-check-input">
		                <label for="selectAll">전체 선택</label>
		            </th>
		            <th class="tb_no">번호</th>
		            <th class="tb_img">프로필 사진</th>
		            <th class="tb_name">이름</th>
		            <th class="tb_equipment">비품명</th>
		            <th class="tb_date1">날짜</th>
		            <th class="tb_date2">예약 시간</th>
		            <th class="tb_date3">반납 시간</th>
		            <th>내용</th>
		        </tr>
		    </thead>
		    <tbody>
		        <c:choose>
		            <c:when test="${not empty list}">
		                <c:forEach var="r" items="${list}" varStatus="status">
		                    <tr>
		                        <c:set var="endTime" value="${r.endTime}" />
		                        <c:set var="currentTime" value="<%= currentDateKST.getTime() %>" />
		                        <c:set var="returnTime" value="${endTime.time}" />
		                        <c:choose>
		                            <c:when test="${returnTime >= currentTime}">
		                                <td class="checkbox-cell">
		                                    <input type="checkbox" id="selectOne-${r.reservationNo}" class="form-check-input selectOne" data-reservation-no="${r.reservationNo}">
		                                    <label for="selectOne-${r.reservationNo}">선택</label>
		                                </td>
		                            </c:when>
		                            <c:otherwise>
		                                <td class="checkbox-cell"></td>
		                            </c:otherwise>
		                        </c:choose>
		                        <td>${startNo - status.index}</td>
		                        <td>
		                        	<c:choose>
							            <c:when test="${ not empty r.profileURL }">
							                <img src="${contextPath}/${r.profileURL}" class="profile_img">
							            </c:when>
							            <c:otherwise>
							                <img src="${ contextPath }/resources/images/defaultProfile.png" class="profile_img">
							            </c:otherwise>
						            </c:choose>
		                        </td>
		                        <td>${r.userName }</td>
		                        <td>${r.equipmentName}</td>
		                        <td><fmt:formatDate value="${r.startTime}" pattern="yyyy-MM-dd(E)"/></td>
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
		    </tbody>
		</table>
		
		<div id="pagingArea" class="container">
		    <ul class="pagination justify-content-center">
		        <!-- 처음 페이지로 이동 -->
		        <li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }">
		            <a class="page-link" href="javascript:showlist(1);">처음</a>
		        </li>
		
		        <!-- 이전 페이지로 이동 -->
		        <li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }">
		            <a class="page-link" href="javascript:showlist(${pi.currentPage-1});">◀</a>
		        </li>
		
		        <!-- 페이지 번호 링크 -->
		        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
		            <li class="page-item ${ pi.currentPage == p ? 'active' : '' }">
		                <a class="page-link" href="javascript:showlist(${p});">${ p }</a>
		            </li>
		        </c:forEach>
		
		        <!-- 다음 페이지로 이동 -->
		        <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }">
		            <a class="page-link" href="javascript:showlist(${pi.currentPage+1});">▶</a>
		        </li>
		
		        <!-- 끝 페이지로 이동 -->
		        <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }">
		            <a class="page-link" href="javascript:showlist(${pi.maxPage});">끝</a>
		        </li>
		    </ul>
		</div>
		
		
		<script>
		window.onload = function(){
		    showlist(${pi.currentPage});
		}
		
		function showlist(page){
		    $.ajax({
		        url: "${contextPath}/reservation/manager.do",
		        type: "GET",
		        data: { 
		            userNo: "${loginMember.userNo}",
		            page: page 
		        },
		        success: function(data) {
		            var parser = new DOMParser();
		            var doc = parser.parseFromString(data, 'text/html');
		            
		            var tableHtml = doc.querySelector('tbody').innerHTML;
		            var pagingHtml = doc.querySelector('#pagingArea').innerHTML;
		            var totalCount = doc.querySelector('#totalCount').innerText.match(/\d+/)[0];
		            
		            $(".table_1 tbody").html(tableHtml);
		            $("#pagingArea").html(pagingHtml);
		            $("#totalCount").text('전체 ' + totalCount + '개');
		
		            // 페이지당 항목 수와 현재 페이지 번호를 이용하여 시작 번호 계산
		            var itemsPerPage = 10;  // 한 페이지당 항목 수를 10으로 설정합니다.
		            var totalItems = parseInt(totalCount); // 전체 항목 수를 가져옵니다.
		            var startNo = totalItems - ((page - 1) * itemsPerPage);
		
		            // 번호 출력, 체크박스 표시 설정
		            $(".table_1 tbody tr").each(function(index) {
		                $(this).find('td:nth-child(2)').text(startNo - index);
		
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

		            // 체크박스 기능 초기화
		            initializeCheckboxes();
		        }, 
		        error: function() {
		            alert('데이터를 불러오는 중 오류가 발생했습니다.');
		        }
		    });
		}

		function initializeCheckboxes() {
		    $('#selectAll').on('change', function() {
		        var isChecked = $(this).is(':checked');
		        $('.selectOne').prop('checked', isChecked);
		    });

		    $('.selectOne').on('change', function() {
		        var totalCheckboxes = $('.selectOne').length;
		        var checkedCheckboxes = $('.selectOne:checked').length;
		        $('#selectAll').prop('checked', totalCheckboxes === checkedCheckboxes);
		    });
		}
		document.getElementById('cancelReservationBtn').addEventListener('click', function() {
		    var selectedReservations = [];
		    document.querySelectorAll('.selectOne:checked').forEach(function(checkbox) {
		        selectedReservations.push(checkbox.getAttribute('data-reservation-no'));
		    });

		    if (selectedReservations.length == 0) {
		        alert('삭제할 예약을 선택하세요.');
		        return;
		    }

		    var confirmation = confirm('선택한 예약을 삭제하시겠습니까?');
		    if (!confirmation) {
		        return;
		    }

		    $.ajax({
		        url: '${contextPath}/reservation/cancel.do',
		        type: 'POST',
		        contentType: 'application/json; charset=UTF-8',
		        data: JSON.stringify({ reservationNo: selectedReservations }),
		        success: function(response) {
		            alert('선택한 예약이 삭제되었습니다.');
		            location.reload();
		        },
		        error: function() {
		            alert('예약 삭제 중 오류가 발생했습니다.');
		        }
		    });
		});

		function initializeCheckboxes() {
		    $('#selectAll').on('change', function() {
		        var isChecked = $(this).is(':checked');
		        $('.selectOne').prop('checked', isChecked);
		    });

		    $('.selectOne').on('change', function() {
		        var totalCheckboxes = $('.selectOne').length;
		        var checkedCheckboxes = $('.selectOne:checked').length;
		        $('#selectAll').prop('checked', totalCheckboxes === checkedCheckboxes);
		    });
		}
		</script>
	
		<!-- ------------ -->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>