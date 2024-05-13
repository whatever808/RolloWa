<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>2.1 출결 조회</title>

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
    
    /* 출결상태 조회 css */
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
        color: black !important;
    }
    .table{
        width: 100% !important;
    }
    .table_1{
        font-size: 20px !important;
        margin: auto;
        margin-bottom: 50px !important;
        width: 600px !important;
        text-align: center;
    }
    .table_2{
        font-size: 25px;
        margin: auto;   
        width: 350px;
    }
    /* 조회 메뉴 css */
    .search_menu td{
        table-layout: fixed !important;
    }
    .td_1{
        text-align: right;
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
    .employee_info td img{
        border: 1px solid gainsboro;
        border-radius: 100%;
        width: 50px;
        height: 50px;
        object-fit: cover;
        margin: -10px;
    }

    /* 맨 밑 여백 주기 */
    .container{
        padding-bottom: 100px;
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
	    
		<!-- ------------ -->
	
		<!-- 일별, 월별 조회-->
            <div>
                <button class="btn btn-primary">일별 조회</button>
                <button class="btn btn-secondary">월별 조회</button>
            </div>

            <!--날짜, 오늘 선택-->
            <div class="select_date">
                <table class="table_2">
                    <tr>
                        <td><h2><div class="arrow">◀</div></h2></td>
                        <td><h2>2024년 5월 2일 (목)</h2></td>
                        <td><h2><div class="arrow">▶</div></h2></td>
                    </tr>
                </table>
                <button class="btn btn-outline-primary today_btn">오늘</button>
            </div>

            <!--출근, 퇴근, 결근, 조퇴, 휴가 현황 조회-->
            <table class="table table_1" border="1">     
                <tr>
                    <td class="table-success">출근</td>
                    <td class="table-danger">결근</td>
                    <td class="table-secondary">퇴근</td>
                    <td class="table-warning">조퇴</td>
                    <td class="table-info">휴가</td>
                </tr>
                <tr>
                    <td class="table-success">50</td>
                    <td class="table-danger">19</td>
                    <td class="table-secondary">5</td>
                    <td class="table-warning">5</td>
                    <td class="table-info">3</td>
                </tr>
            </table>

            <!-- 직원 출결 데이터 start -->
            <table class="table table-responsive">
                <tr class="search_menu">
                    <td>
                        <!-- 전체 인원수 -->
	    				<h5 class="employee_count">전체 ${ listCount }명</h5>
                        
                    </td>
                    <td>
                        <select name="department" id="department" class="form-control">
                            <option value="">전체 부서</option>
                            <option value="">부서1</option>
                            <option value="">부서2</option>
                            <option value="">부서3</option>
                        </select>
                    </td>
                    <td>
                        <select name="" id="" class="form-control">
                            <option value="">전체 팀</option>
                            <option value="">1팀</option>
                            <option value="">2팀</option>
                            <option value="">3팀</option>
                        </select>
                    </td>
                    <td>
                        <select name="" id="" class="form-control">
                            <option value="">전체 상태</option>
                            <option value="">출근</option>
                            <option value="">결근</option>
                            <option value="">퇴근</option>
                            <option value="">휴가</option>
                            <option value="">조퇴</option>
                        </select>
                    </td>
                    <td class="td_1">
                        <input type="text" placeholder="이름 입력">
                        <button class="btn btn-primary">검색</button>
                        <button class="btn btn-outline-primary">초기화</button>
                    </td>
                </tr>
            </table>

            <!-- 직원 정보 테이블 start-->
            <table class="table employee_info">
                <tr>
                    <th>프로필 사진</th>
                    <th>성명</th>
                    <th>부서</th>
                    <th>팀명</th>
                    <th>직급</th>
                    <th>출근시간</th>
                    <th>퇴근시간</th>
                    <th>상태</th>
                </tr>
                
                <!-- 출결 조회(이름,부서,팀명,직급, 오늘날짜의 출석시간, 오늘날짜 퇴근시간, 상태) -->
                <c:choose>
			        <c:when test="${ not empty list }">
			        	<c:forEach var="m" items="${ list }">
					        <tr>
					            <td>
						            <c:choose>
						            	<c:when test="${ not empty m.profileURL }">
							                <img src="${ m.profileURL }" class="profile_img">
						            	</c:when>
						            	<c:otherwise>
							                <img src="${ contextPath }/resources/images/defaultProfile.png">
						            	</c:otherwise>
						            </c:choose>
					            </td>
					            <td>${ m.userName }</td>
					            <td>${ m.dept }</td>
					            <td>${ m.team }</td>
					            <td>${ m.posi }</td>
					            <td>
					            	<fmt:formatDate value="${ m.todayIn }" pattern="HH:mm:ss"/>
					            </td>
					            <td>
					            	<fmt:formatDate value="${ m.todayOut }" pattern="HH:mm:ss"/>
					            </td>
					            <td
			                    <c:choose>
			                        <c:when test="${ m.requestDetail == '출근' }">class="table-success"</c:when>
			                        <c:when test="${ m.requestDetail == '결근' }">class="table-danger"</c:when>
			                        <c:when test="${ m.requestDetail == '퇴근' }">class="table-secondary"</c:when>
			                        <c:when test="${ m.requestDetail == '조퇴' }">class="table-warning"</c:when>
			                        <c:when test="${ m.requestDetail == '휴가' }">class="table-info"</c:when>
			                    </c:choose>
								>
			                    	${ m.requestDetail }
			                	</td>
					        </tr>
				        </c:forEach>
			        </c:when>
	        	</c:choose>
	        	
                
            </table>
            <!-- 직원 테이블 end -->
            

            <!--페이징 처리 start-->
		    <div class="container">
		        <ul class="pagination justify-content-center">
		        	<li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/attendance/list.do?page=${pi.currentPage-1}">Previous</a></li>
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/attendance/list.do?page=${p}">${ p }</a></li>
					</c:forEach>
					<li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/attendance/list.do?page=${pi.currentPage+1}">Next</a></li> 
		        </ul>
		    </div>
	    	<!--페이징 처리 end-->
	
	
		<!-- ------------ -->
	
	</div>
	<!-- 메인 영역 end-->
		
</body>
</html>