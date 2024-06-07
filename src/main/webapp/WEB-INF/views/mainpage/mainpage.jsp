<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>롤러와</title>
	
	<!-- 메인페이지 스타일 -->
	<link href="${ contextPath }/resources/css/mainPage/main_page.css" rel="stylesheet">
	
	<!-- fullcalendar -->
	<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
	<style>
		.weather-clock-div{
			background: url(${contextPath}/resources/images/rollowa.jpg);
		}
	</style> 
	
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
            	<span class="weather-place"></span>
            	<span class="weather-temp"></span>
            	<span class="weather-description"></span>
            	<img class="weather-icon" src="">
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
                    		<!-- 기웅 추가 -->
                    		<div class="alram-div"><button type="button" class="btn alram-btn" style="box-shadow: none;"><i class="fa-solid fa-bell fa-2x" style="color: #ff939e;"></i></button></div>
                    		<!-- 기웅 추가 -->
                        <img src="${ contextPath }${ loginMember.profileURL }" alt="user profile">

                        <h5 class="mt-4 fw-bold">${ loginMember.userName } / ${ loginMember.positionName } / ${ loginMember.teamName }</h5>
                    </div>
					
                    <div class="profile-attend pe-4">
                        <div class="attend-button d-flex my-3">
                            <button class="work-on btn btn-outline-primary px-4 me-auto" data-attendanceno="">출근</button>
                            <label class="work-on-time attend-time"></label>
                        </div>

                        <div class="attend-button d-flex my-3">
                            <button class="work-off btn btn-outline-danger px-4 me-auto disabled">퇴근</button>
                            <label class="work-off-time attend-time"></label>
                        </div>

                        <div class="attend-button d-flex my-3">
                            <button class="leave-early btn btn-outline-warning px-4 me-auto disabled">조퇴</button>
                            <label class="leave-early-time attend-time"></label>
                        </div>
                    </div>
                </div>
                <!-- profile & attend (main-left-top)-->

                <!-- login user list (main-left-bottom)-->
                <div class="login-user-list-div">
                    <h5 class="fw-bold text-end mb-4">현재접속자</h5>
                    <div class="login-user-list"></div>
                </div>
                <!-- login user list (main-left-bottom)-->
                
                
            </div>
            <!-- main-left-end -->

            <!-- main-right start-->
            <div class="main-content-right">

                <!-- my attendance (main-right-top) -->
                <div class="my-attend h-3">

                    <h4>근태관리</h4>
                    
                    <div class="my-attend-content">
                        <!-- my attend select (left) -->
                        <div class="my-attend-select-div">
                            <select class="year form-select text-center" name="year"></select>
        
                            <select class="month form-select text-center" name="month"></select>
                        </div>
                        <!-- my attend select (left) -->

                        <!-- my attend info (right) -->
                        <div class="my-attend-info-div">
                            <div class="attend-info-div">
                                <div class="attend-info total-vacation-count">${ loginMemberAttend.vacationCount }</div>
                                <div class="attend-title text-center mt-2 fw-bold">총 연차</div>
                            </div>

                            <div class="attend-info-div">
                                <div class="attend-info used-vacation-count">${ loginMemberAttend.usedVacationCount }</div>
                                <div class="attend-title text-center mt-2 fw-bold">사용 연차</div>
                            </div>

                            <div class="attend-info-div">
                                <div class="attend-info left-vacation-count">${ loginMemberAttend.leftVacationCount }</div>
                                <div class="attend-title text-center mt-2 fw-bold">잔여 연차</div>
                            </div>

                            <div class="attend-info-div">
                                <div class="attend-info leave-early-count">${ loginMemberAttend.leaveEarlyCount }</div>
                                <div class="attend-title text-center mt-2 fw-bold">조퇴계</div>
                            </div>

                            <div class="attend-info-div">
                                <div class="attend-info day-off-count">${ loginMemberAttend.dayOffCount }</div>
                                <div class="attend-title text-center mt-2 fw-bold">결근계</div>
                            </div>

                        </div>
                        <!-- my attend info (right) -->
                        
                    </div>
                    
                </div>
                <!-- my attendance (main-right-top) -->
                
                <!-- notice list start (main-right-middle) -->
                <div class="notice-list-div">
                    <h4>공지사항</h4>
                    
                    <div class="notice-category">
										  <span class="normal">일반공지</span>
										  <span class="department">부서공지</span>
										</div>
                    
                    <table class="notice-table table table-hover table-responsive">
                    	<tbody class="notice-table-tbody">
                    		<!-- 공지사항 리스트 영역 -->
                    	</tbody>
                    </table>
                </div>
                <!-- notice list end (main-right-middle) -->
                
                <!-- calendar (main-right-bottom) -->
                <div class="calendar-div">
                    <div class="calendar box">
											<!-- main calendar -->
											<jsp:include page="/WEB-INF/views/common/mainCal.jsp" />
											<div id="calendar"></div>
										</div>
                </div>
                <!-- calendar (main-right-bottom) -->

        	</div>
        	<!-- main right end -->
        	        
        </div>
        <!-- main contents end (bottom) -->
        
      	<!-- 알람 조회 modal -->
				<div id="alram_list">
					<div class="list-group list-group-light alram_list">
						<!-- 알림 영역 -->
					</div>
				</div>
      	<!-- 알람 조회 modal -->
    </div>
    <!-- content end -->
	
	<!-- chat floating -->
  	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />

</body>

<script>
	// 날씨 관련 =============================================================================================================================
	$(document).ready(function(){
		navigator.geolocation.getCurrentPosition(success);
	})
	const API_KEY = "6a6c38789cdffc510c99641864cf9f76";
	
	// 사용자가 현재 위치 추적을 허용하지 않은 경우
	const fail = () => {
		console.log("좌표를 받아올 수 없습니다.");
	}
	
	// 사용자가 현재 위치 추적을 허용했을 경우
	const success = (position) => {
		// const latitude = position.coords.latitude;
		// const longitude = position.coords.longitude;
		
		getWeather(35.6895, 139.6917);
	}
	
	const getWeather = (lat, lon) => {
		fetch(
			"https://api.openweathermap.org/data/2.5/weather?lat=" + lat + "&lon=" + lon + "&appid=" + API_KEY + "&units=metric&lang=kr"
		).then((response) => {
			return response.json();
		}).then((json) => {
			const place = json.name;
			const temperature = json.main.temp;
			const description = json.weather[0].description;
			const icon = json.weather[0].icon;
			const iconURL = 'http://openweathermap.org/img/wn/' + icon + '@2x.png';
			
			$(".weather-place").text(place);
			$(".weather-temp").text(temperature +' ℃');
			$(".weather-description").text(description);
			$(".weather-icon").attr("src", iconURL);
		}).catch((error) => {
			console.log("WEATHER ERROR");
		})
	}
	
	// 출근/퇴근/조퇴 등록 관련 ===================================================================================
	$(document).ready(function(){
		// 사용자 출석체크 여부확인 & 값출력 --------------------------------------------------------------------------
		if(${ not empty loginMemberTodayAttend}){
			const clockIn = "${ loginMemberTodayAttend.clockIn }";
			const clockOut = "${ loginMemberTodayAttend.clockOut }";
			const requestDetail = "${ loginMemberTodayAttend.requestDetail }";
			
			if(requestDetail != '휴가'){
				// 출근시간 출력 & 출근버튼 비활성화
				$(".work-on-time").text(clockIn);
				$(".work-on").attr("data-attendanceno", "${ loginMemberTodayAttend.attendanceNo }")
							 .addClass("disabled");
				
				// 조퇴/퇴근시간 출력 & 버튼 비활성화
				if(clockOut != null && clockOut != ''){
					if(requestDetail == '퇴근'){
						$(".work-off-time").text(clockOut);
					}else if(requestDetail == '조퇴'){
						$(".work-off-time").text(clockOut);
					}
					$(".work-off").addClass("disabled");
					$(".leave-early").addClass("disabled");
				}else{
					$(".work-off").removeClass("disabled");
					$(".leave-early").removeClass("disabled");
				}
			}
		}
	
		// 출근체크
		$(".work-on").on("click", function(){
			ajaxAttendCheck("출근");
		});
		// 퇴근체크
		$(".work-off").on("click", function(){
			ajaxAttendCheck("퇴근");
		});
		// 조퇴체크
		$(".leave-early").on("click", function(){
			ajaxAttendCheck("조퇴");
		});
		
		// 출근/퇴근/조퇴 등록 AJAX
		function ajaxAttendCheck(requestDetail){
			const requestURL = "${ contextPath }/attendance";
			
			if(confirm(requestDetail + '체크를 하시겠습니까?')){
				$.ajax({
					url: requestURL + (requestDetail == '출근' ? "/insert.ajax" : "/update.ajax"),
					method:"get",
					data:{
						userNo: ${ loginMember.userNo },
						requestDetail: requestDetail,
						attendanceNo: $(".work-on").attr("data-attendanceno")
					},
					success:function(attendCheckData){
						let result = attendCheckData.result;
						if(result == 'SUCCESS'){
							switch (requestDetail){
								case '출근' :
									$(".work-on-time").text(attendCheckData.attendTime.clockIn);
									$(".work-on").attr("data-attendanceno", attendCheckData.attendTime.attendanceNo)
												 .addClass("disabled");
									$(".work-off").removeClass("disabled");
									$(".leave-early").removeClass("disabled");
									break;
								case '퇴근' :
									$(".work-off-time").text(attendCheckData.attendTime.clockOut);
									$(".work-off").addClass("disabled");
									$(".leave-early").addClass("disabled");
									break;
								case '조퇴' :
									$(".leave-early-time").text(attendCheckData.attendTime.clockOut);
									$(".leave-early").addClass("disabled");
									$(".work-off").addClass("disabled");
									break;
							}
						}else{
							redAlert(requestDetail + "체크 서비스", requestDetail + " 등록에 실패했습니다.");
						}
					},error:function(){
						console.log("INSERT ATTENDANCE AJAX FAILED");
					}
				});
			}
		}
	});
	
	// 근태조회 관련 ===================================================================================
	$(document).ready(function(){
		const sysdate = new Date();
		const sysYear = sysdate.getFullYear();
		const sysMonth = sysdate.getMonth() + 1;
		
		// "년" 옵션값 생성 및 설정
		for(let y=sysYear ; y>=2000 ; y--){
			$("select[name=year]").append("<option value='" + y + "'>" + y + "년</option>");
		}
		// "년" 선택값 변경시
		$("select[name=year]").on("change", function(){
			let maxMonth = ($("select[name=year]").val() == sysYear) ? sysMonth : 12;
			let oldMonth = $("select[name=month]").val();
			const $monthSelect = $("select[name=month]");
			
			$monthSelect.empty();
			
			for(let m=1 ; m<=maxMonth ; m++){
				$monthSelect.append("<option value='" + m + "'>" + m + "월</option>");
			}
			
			$monthSelect.children("option").each(function(){
				$(this).val() == oldMonth && $(this).attr("selected", true);
			});
		});
		
		// "월" 옵션값 생성 및 설정
		for(let m=1 ; m<=sysMonth ; m++){
			$("select[name=month]").append("<option value='" + m + "'>" + m + "월</option>");
		}
		$("select[name=month]").children("option").each(function(){
			$(this).val() == sysMonth && $(this).attr("selected", true);
		});
		
		// 년도별 나의 근태조회
		$("select[name=year]").on("change", function(){
			ajaxSelectMyAttend();
		})
		// 월별 나의 근태조회
		$("select[name=month]").on("change", function(){
			ajaxSelectMyAttend();
		})
		
		// 년도 & 월 별 나의 근태현황 조회
		function ajaxSelectMyAttend(){
			$.ajax({
				url:"${ contextPath }/attendance/myAttend.do",
				method:"get",
				data:{
					userNo:${ loginMember.userNo },
					year:$("select[name=year]").val(),
					month:$("select[name=month]").val()
				},
				success:function(responseData){
					let result = responseData.result;
					console.log(responseData, "델ㅇ");
					if(result == 'SUCCESS'){
						$(".total-vacation-count").text(responseData.attendInfo.vacationCount);
						$(".used-vacation-count").text(responseData.attendInfo.usedVacationCount);
						$(".left-vacation-count").text(responseData.attendInfo.leftVacationCount);
						$(".leave-early-count").text(responseData.attendInfo.leaveEarlyCount);
						$(".day-off-count").text(responseData.attendInfo.dayOffCount);
					}else{
						redAlert("근태조회 서비스", "근태조회에 실패했습니다.");
					}
				},error:function(){
					console.log("SELECT MEMBER ATTENDANCE FAILED");
				}
			})
		}
	})
	
	// 실시간 시간 관련 ==============================================================================================
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
        const days = ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'];
        const days_num = todaydate.getDay();
        const year = todaydate.getFullYear();
        const month = todaydate.getMonth() + 1;
        const date = todaydate.getDate();
        const day = days[days_num];

        $(".date").text(year + "년 " + month + "월 " + date+ "일 " + day); 
    }
    
   	// 공지사항 목록조회 관련 ==========================================================================================================
   	$(document).ready(function(){
		// 카테고리별 공지사항 목록조회 AJAX
		$(".notice-category").on("click", "span", function(){
			$(this).addClass("bg-secondary text-white");
			$(this).siblings().removeClass("bg-secondary text-white");
			
   			$.ajax({
       			url:"${ contextPath }/board/main/list.ajax",
       			method:"get",
       			data:{
       				category: $(this).hasClass('department') ? 'department' : 'normal',
       				department: $(this).hasClass('department') ? '${ loginMember.deptCode }' : ''
       			},
       			async:false,
       			success:function(boardList){
       				list = "";
       				if(boardList.length == 0){
       					list += "<tr>";
       					list += 	"<td cospan='3'>조회된 공지사항이 없습니다.</td>";
       					list += "<tr>";
       				}else{
       					for(let i=0 ; i<5 ; i++){
       						list += "<tr>";
       						list += 	"<td class='list-title' data-boardno='" + boardList[i].boardNo + "'>" + boardList[i].title + "</td>";
       						list += 	"<td class='list-writer'>";
       						list += 		"<img src='" + ("${ contextPath }" + boardList[i].profileURL) + "' class='writer-profile'>";
       						list += 		"<span class='writer-name' data-writerno='" + boardList[i].modifyEmp + "'>" + boardList[i].writerName + "</span>";
       						list += 	"</td>";
       						list += 	"<td class='list-date'>" + boardList[i].modifyDate + "</td>";
       						list += "</tr>"
       					}
       				}
       				
       				$(".notice-table-tbody").html(list);
       			},error:function(){
       				console.log("SELECT NOTICE LIST AJAX FAILED");
       			}
       		});
   		});
   		
   		// 페이지 로딩즉시(요소가 다 생성된 후)
   		$("span.normal").click();
   		
   		// 공지사항 상세페이지 요청
   		$(".notice-table-tbody").on("click", ".list-title", function(){
   			const loginUserNo = "${ loginMember.userNo }";
   			const boardWriterNo = $(this).siblings(".list-writer").children(".writer-name").data("writerno");
   			const boardNo = $(this).data("boardno");
   			
   			if(loginUserNo == boardWriterNo){
   				location.href = "${ contextPath }/board/detail.do?no=" + boardNo;
   			}else{
   				location.href = "${ contextPath }/board/reader/detail.do?no=" + boardNo;
   			}
   		});
   	});
	
		/* 오늘일정 관련 =====================================================================================================
   	$(document).ready(function(){
   		$.ajax({
   			url:"${ contextPath }/calendar/todaySchedule.ajax",
   			method:"get",
   			data: {
   				userNo:${ loginMember.userNo }
   			},
   			success:function(todayScheduleList){
 					if(todayScheduleList.length == 0){
 						$(".today-schedule-list").text("조회된 일정이 없습니다.")
 																		 .addClass('d-flex justify-content-center align-items-center text-secondary');
 					}else{
 						list = "";
 						for(let i=0 ; i<todayScheduleList.length ; i++){
 							list += "<div class='schedule mb-2'>";
							list += 	"<span class='schedule-color me-3' style='background-color: " + todayScheduleList[i].calColor + "'></span>";
							list += 	"<span class='schedule-title'><b>[" + todayScheduleList[i].calSortName + "]</b>&nbsp;&nbsp;" + todayScheduleList[i].calTitle + "</span>";
							list += "</div>";
 						}
 						$(".today-schedule-list").html(list);
 					}
   			},error:function(){
   				console.log("SELECT TODAY'S SCHEDULE AJAX FAILED");
   			}
   		})
   	})
		*/	
  	/* ============== 기웅 추가 알림 =============== */
  	// 알림 modal 스타일
  	$("#alram_list").iziModal({
			title: '<h6>알림</h6>'
			, subtitle: ''
			, headerColor: '#FEEFAD'
			, theme: 'light'
			, radius: '2'
			, arrowKeys: 'false'
			, navigateCaption: 'false'
  	})
  	
  	// 알림 버튼 스타일
  	$(".alram-btn").on("mouseenter", function() {
  		$(".alram-btn>i").addClass("fa-beat");
  	})
  	$(".alram-btn").on("mouseleave", function() {
  		$(".alram-btn>i").removeClass("fa-beat");
  	})
  	
  	// 메인페이지 접속 시 알림 조회
  	$(document).ready(function() {
  		selectAlram();
  	});
  	// 읽지 않은 알림 조회
  	function selectAlram() {
	  	$.ajax({
	  			url: "${contextPath}/notification/list"
	  			, method: "get"
	  			, data: {userNo: ${loginMember.userNo}}
	  			, async:false
	  			, success: function(notiList) {
	  				if(notiList.length != 0) {
	  					// 조회된 알림이 있을 시
	  					
	  					// 알림 구역 초기화
	  					$(".alram_list").empty();
	  					
	  					// 알림 아이콘에 표시
	  					$(".alram-btn>i").addClass("fa-bounce");
	  					
	  					for(var i = 0; i < notiList.length; i++) {
	  						// updateAlram 함수 실행 시 필요한 정보 담기
	  						var notiInfo = new Array();
		  					
		  					var alramText = "<div class='alram_el'>";
		  					alramText += "<div class='alram_info'>";
		  					alramText += "<a href='" + notiList[i].notiURL + "' onclick='return updateAlram(" + notiList[i].nsendNo + ", \"" + notiList[i].type + "\");'  class='list-group-item list-group-item-action px-3 border-0'>";
		  					
		  					if(notiList[i].type == 'N') {
		  						alramText += (i + 1) + "." + notiList[i].sendUserName + "님이 공지사항을 등록하였습니다.";
		  					} else if (notiList[i].type == 'C') {
		  						alramText += (i + 1) + "." + notiList[i].sendUserName + "님이 부서 일정을 등록하였습니다.";
		  					} /*else if (notiList[i].type == 'M') {
		  						alramText += (i + 1) + "." + notiList[i].sendUserName + "님이 나를 멘션 하였습니다.";
		  					}*/
		  					alramText += "</a>";
		  					alramText += "</div>";
		  					alramText += "<div class='alram_date'><span class='send_date'>" + notiList[i].notiSendDate + "</span></div>";
		  					alramText += "</div>";
		  					$(".alram_list").append(alramText);
		  				}
	  				} else {
	  					// 조회된 알림이 없을 시
	  					// 알림 구역 초기화
	  					$(".alram_list").empty();
	  					var alramText = "<span class='list-group-item list-group-item-action px-3 border-0'>";
	  					alramText += "도착한 알림이 없습니다.";
	  					alramText += "</span>";
	  					$(".alram_list").append(alramText);
	  				}
	  			}
	  			, error: function() {
	  				
	  			}
  			});
		}

  	// 알림 버튼 클릭 시 알림 조회
  	$(".alram-btn").on("click", function() {
			// 알림 아이콘 표시 제거
			$(".alram-btn>i").removeClass("fa-bounce");
			//알림 조회
			selectAlram();
			// 모달창 열기
			$("#alram_list").iziModal('open');
  	});
  	
  	// 알림 리스트 중 하나의 알림 클릭 시
  	function updateAlram(nsendNo, type) {
  		// 공지사항 알림일 경우 클릭한 알림만 update
  		// 일정 알림일 경우 일정 알림 전체 update
  		$.ajax({
  			url: "${contextPath}/notification/checkDate"
  			, method: "post"
  			, data: {userNo: ${loginMember.userNo}
  								, type: type
  								, nsendNo: nsendNo}
  			, success: function(result) {
  				if(result > 0) {
  					console.log("알림 확인 날짜 update 성공");
  				}
  			}
  			, error: function() {
  				console.log("알림 확인 날짜 update ajax 실패");
  			}
  		})
  	}
  	
  	// 접속자 관련 (웹소켓) =====================================================================================
  	loginLogout.onmessage = loginLogoutMsg;
  		
	// 메세지가 왔을 경우
	function loginLogoutMsg(event){
		// 로그인일 경우 : [login] [리스트의 모든 사원정보를 이은 문자열]
		// 로그아웃 경우 : [logout][사원번호]
		let msg = event.data.split("|");
		let type = msg[0]; 	// [login] or [logout]
		let addMembers = "";
		
		if(type == 'login'){
			let memberList = msg[1].split(",");	// [사번&프로필&이름/직급/소속팀][사번&프로필&이름/직급/소속팀]...
			for(let i=0 ; i<memberList.length ; i++){
				let member = memberList[i].split("&");	// [사번][프로필][이름/직급/소속팀]
				
				addMembers += "<div class='login-user d-flex align-items-center mb-3'>";
				addMembers +=	"<input type='hidden' name='userNo' value='" + member[0] + "'>";
				addMembers +=	"<img class='login-user-list-profile me-2' src='${ contextPath }" + member[1] + "' alt='user profile image'>";
				addMembers += 	"<span class='login-user-list-member-info'>" + member[2] + "</span>";
				addMembers += "</div>";
		
			}
			$(".login-user-list").html(addMembers);
		}else{
			let userNo = msg[1];
			$(".login-user-list").children(".login-user").each(function(){
				$(this).children("[name=userNo]").val() == userNo && $(this).remove();
			});
		}
	}
  	
</script>

</html>