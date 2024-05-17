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
    #currentDate{
    	white-space: nowrap;
    	font-size: 25px;
    }
    .mouse_pointer{
    	cursor: pointer;	
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
    .table_1 tr{}
    .table_2{
        font-size: 25px;
        margin: auto;   
        width: 350px;
    }
    /* 조회 메뉴 css */
    .table_search{
    	/* display: flex;
    	flex: wrap; */
    	justify-content: space-between;
    	align-items: center;
    	width: 100% !important;
    }
    .search_menu {
        flex: 1 1 auto;
        margin-right: 10px; /* 필요에 따라 조정 */
    }
    .employee_count{
    }
    .td_search{
    	display: flex;
    	align-items: center;
    	white-space: nowrap;
    }
    .td_search input{
    	width: 150px;
    }
    .td_search button{
    	margin: 0 10px;
    	width: 100px;
    }
    .input_name{
    	width: 100px;
    }
    .search_menu select{
        width: 150px;
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
    .td_status{
    	he: 100px;
    }

    /* 맨 밑 여백 주기 */
    .container{
        padding-bottom: 100px;
    }
    
    /*
    input[type=text]::-ms-clear {
		display:none;
	}
  	*/
    </style>
</head>
<body>

	<!-- 사이드바 해더 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
	    <h2>출결 조회</h2>
	    <hr>
	    
		<!-- ------------------------------------------ -->
	
		<!-- 일별, 월별 조회-->
        <div>
            <button class="btn btn-primary">일별 조회</button>
            <button class="btn btn-secondary">월별 조회</button>
        </div>

		<!-- 날짜 영역 start -->
        <!--날짜, 오늘 선택-->
        <div class="select_date">
            <table class="table_2">
                <tr class="mouse_pointer">
                    <td><h3><div class="arrow" onclick="changeDate(-1);">◀</div></h3></td>
                    <!-- <td><h3 id="currentDate" onclick="editDate();"></h3></td> -->
                    <td><h3 id="currentDate"></h3></td>
                    <td><h3><div class="arrow" onclick="changeDate(1);">▶</div></h3></td>
                </tr>
            </table>
            <button class="btn btn-outline-primary today_btn" onclick="goToToday();">오늘</button>
        </div>
            
        <script>
		var daysOfWeek = ['일', '월', '화', '수', '목', '금', '토'];
		let nowDate = getCurrentDate();
		
		// 초기 실행 시, 저장된 날짜 불러와서 출력함
		window.onload = function() {
		    updateCurrentDate();
		    sendNowDate();
		};
		
		// 날짜 표시하기 : ◀ 2024년 5월 18일 (토) ▶
		function getCurrentDate() {
		    var currentDate = new Date();
		    var dayOfWeekIndex = currentDate.getDay();
		    var dayOfWeek = '(' + daysOfWeek[dayOfWeekIndex] + ')';
		    var year = currentDate.getFullYear();
		    var month = currentDate.getMonth() + 1;
		    var day = currentDate.getDate();
		    var formattedDate = year + '년 ' + month + '월 ' + day + '일 ' + dayOfWeek;
		    return formattedDate;
		}
		function updateCurrentDate() {
		    var currentDateElement = document.getElementById('currentDate');
		    if (currentDateElement) {
		        currentDateElement.textContent = getCurrentDate();
			    nowDate = currentDateElement.textContent;
			    console.log(nowDate);
		    }
		}
		
		function changeDate(offset) {
		    var currentDateElement = document.getElementById('currentDate');
		    var currentDateText = currentDateElement.textContent;
		    var dateRegex = /(\d{4})년 (\d{1,2})월 (\d{1,2})일/; // 날짜 형식을 정의합니다.
		    var matches = dateRegex.exec(currentDateText); // 현재 날짜에서 년, 월, 일을 추출합니다.
		    var year = parseInt(matches[1]);
		    var month = parseInt(matches[2]) - 1; // JavaScript의 월은 0부터 시작하므로 1을 빼줍니다.
		    var day = parseInt(matches[3]);
		    var currentDate = new Date(year, month, day);
		    currentDate.setDate(currentDate.getDate() + offset); // 날짜를 변경합니다.
		    
		    var dayOfWeekIndex = currentDate.getDay();
		    var dayOfWeek = '(' + daysOfWeek[dayOfWeekIndex] + ')';
		    var newDateText = currentDate.getFullYear() + '년 ' + (currentDate.getMonth() + 1) + '월 ' + currentDate.getDate() + '일 ' + dayOfWeek;
		    
		    currentDateElement.textContent = newDateText; // 변경된 날짜를 화면에 표시합니다.
		    
		    nowDate = newDateText;
		    console.log(nowDate);
		    sendNowDate();
		}
		
		// 오늘날짜로 바꾸기
		function goToToday() {
		    updateCurrentDate();
		    var url = "${contextPath}/attendance/list.do?nowDate=" + encodeURIComponent(nowDate);
		    window.location.href = url;
		}
		
		/* 날짜값 컨트롤러로 넘기기 */
		function sendNowDate(){
			$.ajax({
				type:"GET",
				url:"${ contextPath }/attendance/list.do",
				data: { nowDate: nowDate},
				success: function(response){
					console.log("날짜 전송 성공");
				},
				error: function(xhr, status, error) {
		            console.error("전송 실패 : ", error);
		        }
			})
		}
		</script>
		<!-- 날짜 영역 end -->
		    

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
		        <td class="table-success">${ attendanceCount[0].a }</td>
		        <td class="table-danger">${ attendanceCount[0].b }</td>
		        <td class="table-secondary">${ attendanceCount[0].c }</td>
		        <td class="table-warning">${ attendanceCount[0].d }</td>
		        <td class="table-info">${ attendanceCount[0].e }</td>
		    </tr>
		</table>

		<!-- 직원 출결 데이터 start -->
		<form id="search_Form" action="${ contextPath }/attendance/search.do" method="GET">
			<input type="hidden" name="page" value="1">
			<table class="table table_search">
				<tr class="search_menu">
					<!-- 전체 인원수 -->
					<td>
						<h5 class="employee_count">전체 ${ listCount }명</h5>
					</td>
					
	          		<!-- 부서 -->
					<td>
						<select name="department" id="department" class="form-select"></select>
					</td>
					
					<!-- 팀 -->
					<td>
						<select name="team" id="team" class="form-select"></select>
					</td>
					
					<!-- 상태 -->
					<td class="td_status">
						<select name="status" id="status" class="form-select">
						    <option value="">전체 상태</option>
						    <option value="">출근</option>
						    <option value="">결근</option>
						    <option value="">퇴근</option>
						    <option value="">휴가</option>
						    <option value="">조퇴</option>
						</select>
					</td>
					
					<!-- 이름 -->
					<td class="td_search">
					    <input type="text" id="name" placeholder="이름 입력(한글만)" class="form-control input_name">
					    <button class="btn btn-primary">검색</button>
					    <button type="reset" class="btn btn-outline-primary">초기화</button>
					</td>
				</tr>
			</table>
		</form>
            
        <!-- 검색 기능 : 부서, 팀 조회하기-->
	    <script>
		let departmentSelect = $("#department");
		let teamSelect = $("#team");
 		
		$(document).ready(function(){

			// 부서 조회 이동
			selectDepartmentList();
			
			// 팀 조회 이동
			selectTeamList();
			
			
 		})
 		
 		// 부서조회
 		function selectDepartmentList(){
			departmentSelect.empty();
			departmentSelect.append($('<option>', {
				value: "전체 부서",
				text: "전체 부서"
			}));
			
			$.ajax({
		 		url:"${contextPath}/attendance/department.do",
		 		type:"GET",
		 		async:"false",
		 		success: function(data){
		 			
		 			$.each(data, function(index, organizationDto) {
		 			    $.each(organizationDto.groupList, function(index, groupDto) {
		 			        departmentSelect.append($('<option>', {
		 			            value: groupDto.codeName,
		 			            text: groupDto.codeName
					        	}));
					    	});
					    });
		 			
		 				if(${ not empty search }){
		 					$("#search_Form #department").children("option").each(function(){
					        	$(this).val() == "${ search.department }" && $(this).attr("selected", true);
					        })
		 				} 
		 				
		 		},
		 		error: function(){
		 			console.log("ajax 부서 조회 실패 입니다.")
		 		}
			});
		}
 		
 		// 팀조회
 		function selectTeamList(){
 			
 			teamSelect.empty();
			 	teamSelect.append($('<option>', {
	 	        value: "전체 팀",
	 	        text: "전체 팀"
	 	    }));
 			
	 	    $.ajax({
	 	        url:"${contextPath}/attendance/team.do?selectedDepartment=" + departmentSelect.val(),
	 	        type:"GET",
	 	        async:"false",
	 	        success: function(data){
	 	        	
	 	            $.each(data, function(index, organizationDto) {
	 	                $.each(organizationDto.groupList, function(index, groupDto) {
	 	                    teamSelect.append($('<option>', {
	 	                        value: groupDto.codeName,
	 	                        text: groupDto.codeName
	 	                    }));
	 	                });
	 	            });
					if(${ not empty search }){
	 					$("#search_Form #team").children("option").each(function(){
				        	$(this).val() == "${ search.team }" && $(this).attr("selected", true);
				        })
	 				}
	 	        },
	 	        error: function(){
	 	            console.log("ajax 팀 조회 실패 입니다.")
	 	        }
	 	    });
		}
 		
 		// 부서를 선택했을 경우 실행될 function
 		departmentSelect.on("change", function() {
 			let selectedDepartment = $(this).val();
			selectTeamList(selectedDepartment);
 		});
 		
 		// 검색 이후 초기화 작동하도록 하기
 		/*
 		$(document).ready(function(){
 		    $("#search_Form button[type=reset]").click(function() {
 		        $("#search_Form")[0].reset();
 		        
 		        $("#search_Form #department").val("전체 부서");
 		        $("#search_Form #team").val("전체 팀");

 		        return false;
 		    });
 		});
 		*/
 		
 		// 검색 버튼
 		function search(){
	 		let department = $("#department").val();
	 		let phone =  $("#phone").val();
	 		let team = $("#team").val();
	 		let status = $("#status").val();
	 	    let name = $("#name").val();
	 	 
 			$.ajax({
 				url:"${contextPath}/attendance/search.do",
 				type: "GET",
 				data: {
 		            department: department,
 		            phone: phone,
 		            team: team,
 		            status: status,
 		            name: name
 		        },
				success: function(response) {
 		            console.log("검색 결과:", response);
 		        },
 		        error: function() {
 		            console.log("검색 요청 실패");
 		        }
 			})
 		}
	    </script>
	    
	    <script>
        /* 이름 : 한글만 입력되고 나머지 글자는 공백으로 변환 */
        $("#search_Form input[name=name]").on("keyup", function(){
            let regExp = $(this).val().replace(/[^가-힣ㄱ-ㅎ]+/g, '');
            $(this).val(regExp);
        })
	    </script>

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
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>