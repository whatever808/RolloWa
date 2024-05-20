<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>롤러와</title>
	
	<!-- 메인페이지 스타일 -->
	<link href="${ contextPath }/resources/css/mainPage/mian_page.css" rel="stylesheet">
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
	<!-- content 추가 -->
	<div class="content">

        <!-- weather-clock (top) -->
        <div class="weather-clock-div h-2">
            
            <!-- date & time-->
            <div class="date-time-div">
                <div class="date text-center"></div>
                <div class="time text-center"></div>
            </div>

            <!-- weather -->
            <div class="weather-div">
            </div>

        </div>
        <!-- weather-clock (top) -->

        <!-- main contents start (bottom) -->
        <div class="main-content">
            
            <!-- main-left start -->
            <div class="mian-content-left">

                <!-- profile & attend (main-left-top)-->
                <div class="profile-attend-div">

                    <div class="profile-img-div">
                        <img src="${ contextPath }/resources/images/defaultProfile.png" alt="user profile">

                        <h6 class="mt-3 fw-bold">${ loginMember.userName } / 팀장 / 판다월드</h6>
                    </div>
					
					<script>
						$(document).ready(function(){
							console.log(${ loginMember });
						})
					</script>
					
                    <div class="profile-attend pe-4">
                        <div class="attend-button d-flex my-2">
                            <button class="btn btn-outline-primary px-4 me-auto">출근</button>
                            <label class="attend-time">10:00:00</label>
                        </div>

                        <div class="attend-button d-flex my-2">
                            <button class="btn btn-outline-danger px-4 me-auto">퇴근</button>
                            <label class="attend-time">10:00:00</label>
                        </div>

                        <div class="attend-button d-flex my-2">
                            <button class="btn btn-outline-warning px-4 me-auto">조퇴</button>
                            <label class="attend-time">10:00:00</label>
                        </div>
                    </div>
                </div>
                <!-- profile & attend (main-left-top)-->

                <!-- today's schedule (main-left-bottom)-->
                <div class="today-schedule">
                    <h5 class="fw-bold text-end mb-3">오늘의 일정</h5>
                    <div class="mb-2">맛점하기</div>
                    <div class="mb-2">부서미팅</div>
                    <div class="mb-2">퇴근하기</div>
                </div>
                <!-- today's schedule (main-left-bottom)-->
            </div>
            <!-- amin-left-end -->

            <!-- main-right start-->
            <div class="main-content-right">

                <!-- my attendance (main-right-top) -->
                <div class="my-attend h-3">

                    <h4>근태관리</h4>

                    <div class="my-attend-content">
                        <!-- my attend select (left) -->
                        <div class="my-attend-select-div">
                            <select class="year form-select text-center">
                                <option>2000</option>
                                <option>2001</option>
                                <option>2001</option>
                                <option>2001</option>
                                <option>2001</option>
                                <option>2001</option>
                                <option>2001</option>
                                <option>2001</option>
                            </select>
        
                            <select class="month form-select text-center">
                                <option>1월</option>
                                <option>2</option>
                                <option>2</option>
                                <option>2</option>
                                <option>2</option>
                                <option>2</option>
                                <option>2</option>
                                <option>2</option>
                                <option>2</option>
                                <option>2</option>
                                <option>2</option>
                                <option>2</option>
                            </select>
                        </div>
                        <!-- my attend select (left) -->

                        <!-- my attend info (right) -->
                        <div class="my-attend-info-div">
                            <div class="attend-info-div">
                                <div class="attend-info">17</div>
                                <div class="attend-title text-center mt-2 fw-bold">총 연차</div>
                            </div>

                            <div class="attend-info-div">
                                <div class="attend-info">17</div>
                                <div class="attend-title text-center mt-2 fw-bold">사용 연차</div>
                            </div>

                            <div class="attend-info-div">
                                <div class="attend-info">17</div>
                                <div class="attend-title text-center mt-2 fw-bold">잔여 연차</div>
                            </div>

                            <div class="attend-info-div">
                                <div class="attend-info">17</div>
                                <div class="attend-title text-center mt-2 fw-bold">지작계</div>
                            </div>

                            <div class="attend-info-div">
                                <div class="attend-info">17</div>
                                <div class="attend-title text-center mt-2 fw-bold">조퇴계</div>
                            </div>

                            <div class="attend-info-div">
                                <div class="attend-info">17</div>
                                <div class="attend-title text-center mt-2 fw-bold">결근계</div>
                            </div>

                        </div>
                        <!-- my attend info (right) -->
                    </div>
                    
                </div>
                <!-- my attendance (main-right-top) -->

                <!-- alert list start (main-right-middle) -->
                <div class="alert-list-div">
                    <h4>알림</h4>
                    <table class="table table-hover">
                        <tr>
                            <td class="list-title">유재석 총무부 부장발령</td>
                            <td class="list-date">2024-05-20</td>
                        </tr>

                        <tr>
                            <td class="list-title">유재석 총무부 부장발령</td>
                            <td class="list-date">2024-05-20</td>
                        </tr>

                        <tr>
                            <td class="list-title">유재석 총무부 부장발령</td>
                            <td class="list-date">2024-05-20</td>
                        </tr>

                        <tr>
                            <td class="list-title">유재석 총무부 부장발령</td>
                            <td class="list-date">2024-05-20</td>
                        </tr>

                        <tr>
                            <td class="list-title">유재석 총무부 부장발령</td>
                            <td class="list-date">2024-05-20</td>
                        </tr>
                    </table>
                </div>
                <!-- alert list end (main-right-middle) -->


                <!-- notice list start (main-right-bottom) -->
                <div class="notice-list-div">
                    <h4>공지사항</h4>
                    <table class="table table-hover">
                        <tr>
                            <td class="list-title">유재석 총무부 부장발령</td>
                            <td class="list-date">2024-05-20</td>
                        </tr>

                        <tr>
                            <td class="list-title">유재석 총무부 부장발령</td>
                            <td class="list-date">2024-05-20</td>
                        </tr>

                        <tr>
                            <td class="list-title">유재석 총무부 부장발령</td>
                            <td class="list-date">2024-05-20</td>
                        </tr>

                        <tr>
                            <td class="list-title">유재석 총무부 부장발령</td>
                            <td class="list-date">2024-05-20</td>
                        </tr>

                        <tr>
                            <td class="list-title">유재석 총무부 부장발령</td>
                            <td class="list-date">2024-05-20</td>
                        </tr>
                    </table>
                </div>
                <!-- notice list end (main-right-bottom) -->
            </div>
            <!-- main-right end-->
        </div>
        <!-- main contents end (bottom) -->
        
    </div>
    <!-- content end -->
	
	<!-- chat floating -->
  	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />

</body>

<script>
    $(document).ready(function(){
        getToday(); // 오늘날짜 출력
        
        getClock(); // 실시간 시간
        setInterval(getClock, 1000); 
        
    })

    // 실시간 시간
    function getClock() {
        const date = new Date();
        const hours = String(date.getHours()).padStart(2, "0");
        const minutes = String(date.getMinutes()).padStart(2, "0");
        const seconds = String(date.getSeconds()).padStart(2, "0");

        $(".time").text(hours + ' : ' + minutes + ' : ' + seconds);
    }

    // 오늘 날짜
    function getToday() {
        const todaydate = new Date();
        const days = ['일요일', '월요일', '화요일', '수요일', '목요일', '긑요일', '토요일'];
        const days_num = todaydate.getDay();
        const year = todaydate.getFullYear();
        const month = todaydate.getMonth() + 1;
        const date = todaydate.getDate();
        const day = days[days_num];

        $(".date").text(year + "년 " + month + "월 " + date+ "일 " + day); 
    }
</script>

</html>