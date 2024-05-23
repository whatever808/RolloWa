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
    <title>2.1 출결 조회</title>

	<!-- css -->
	<link rel="stylesheet" href="${contextPath}/resources/css/attendance/attendance.css">

	<style>
    .main_content{
    	width: 1200px !important;
        padding: 20px;
    }
  	
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
            <button class="btn btn-primary btn_daily" onclick="showDailyData()">일별 조회</button>
            <button class="btn btn-secondary btn_monthly" onclick="showMonthlyData()">월별 조회</button>
        </div>

		<!-- 날짜 영역 start -->
        <!--날짜, 오늘 선택-->
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
		window.onload = function(){
			showDailyData();
			changeDate(0);
		}
			
		let currentDate = new Date(); // 다음값 : Tue May 21 2024 13:16:45 GMT+0900 (한국 표준시)
		
		let currentYear = currentDate.getFullYear(); // 년도
		let currentMonth = currentDate.getMonth() + 1; // 월
		let currentDay = currentDate.getDate(); // 일
		
		// 일별 조회 함수
        function showDailyData() {
            // 일별 조회 버튼에 활성화 클래스 추가
            document.querySelector('.btn_daily').classList.add('btn-primary');
            document.querySelector('.btn_daily').classList.remove('btn-secondary');
            document.querySelector('.btn_monthly').classList.add('btn-secondary');
            document.querySelector('.btn_monthly').classList.remove('btn-primary');

            /* currentDateElement.value = today.toISOString().split('T')[0];
            console.log(currentDate.value); */
            
            document.querySelector('.daily_data').style.display = 'block';
            document.querySelector('.monthly_data').style.display = 'none';
            
            // input 형식 : date
            document.getElementById('currentDate').type = 'date';
            
         	// 날짜 형식 2024-05-00 으로 설정
			let currentMonthString = currentYear + '-' + (currentMonth < 10 ? '0' : '') + currentMonth + '-' + (currentDay < 10 ? '0' : '') + currentDay;
			document.getElementById('currentDate').value = currentMonthString;
        }
        // 월별 조회 함수
        function showMonthlyData() {
		    document.querySelector('.btn_monthly').classList.add('btn-primary');
		    document.querySelector('.btn_monthly').classList.remove('btn-secondary');
		    document.querySelector('.btn_daily').classList.add('btn-secondary');
		    document.querySelector('.btn_daily').classList.remove('btn-primary');
		
		    /* currentDateElement.value = today.toISOString().split('-').slice(0, 2).join('-');
		    console.log(currentDate.value); */
		    
		    document.querySelector('.monthly_data').style.display = 'block';
		    document.querySelector('.daily_data').style.display = 'none';

			// input 형식 : month
		    document.getElementById('currentDate').type = 'month';
		    
		 	// 날짜 형식 2024-05로 설정
			let currentMonthString = currentYear + '-' + (currentMonth < 10 ? '0' : '') + currentMonth;
			document.getElementById('currentDate').value = currentMonthString;
		}
     	// 날짜 변경 함수
        function changeDate(number) {
        	let currentDateInput = document.getElementById('currentDate').value;
        	let currentDate, newDate, selectedDate;
			
			if (document.getElementById('currentDate').type == 'date') {
		        // input 형식이 date인 경우
		        currentDate = new Date(currentDateInput);
		        newDate = new Date(currentDate);
		        newDate.setDate(currentDate.getDate() + number);
		        let newYear = newDate.getFullYear();
		        let newMonth = newDate.getMonth() + 1;
		        let newDay = newDate.getDate();
		        selectedDate = newYear + '-' + (newMonth < 10 ? '0' : '') + newMonth + '-' + (newDay < 10 ? '0' : '') + newDay;
		    } else if (document.getElementById('currentDate').type == 'month') {
		        // input 형식이 month인 경우
		        currentDate = new Date(currentDateInput + '-01'); // 현재 입력된 날짜 가져오기 (일자는 항상 01로 고정)
		        newDate = new Date(currentDate);
		        newDate.setMonth(newDate.getMonth() + number);
		        let newYear = newDate.getFullYear();
		        let newMonth = newDate.getMonth() + 1;
		        selectedDate = newYear + '-' + (newMonth < 10 ? '0' : '') + newMonth;
		    }
			
			document.getElementById('currentDate').value = selectedDate;
			console.log("현재 날짜 : ", selectedDate);
			
			let department = $("#department").val();
			let team = $("#team").val();
			let attendanceStatus = $("#attendanceStatus").val();
			let name = $("#name").val();
			
			$.ajax({
				url:"${ contextPath }/attendance/search.do",
				type:"GET",
				data:{
					selectedDate: selectedDate,
					department: department,
					team: team,
					attendanceStatus: attendanceStatus, 
					name: name
				},
				success: function(data){
					//console.log("통신 성공");
					
					// 출결 인원 수
					$(".table_1 tbody").html($(data).find(".table_1 tbody").html());

					// 직원 테이블 업데이트
					$(".employee_info tbody").html($(data).find(".employee_info tbody").html());
					
					// 검색한 사용자 수
					let totalRows = $(data).find(".employee_info tbody > tr").length-1;
					if (totalRows > 0) {
				        let isEmptyMessage = $(data).find(".employee_info tbody > tr td[colspan='8']").text();
				        if (isEmptyMessage === "조회된 직원이 없습니다.") {
				            totalRows--;
				        }
				    }
				    $(".employee_count").text("전체 " + totalRows + "명");
					
				}, error: function(){
					//console.log("통신 실패");
				}
			})
			
     	}
     	
		</script>
        
        <!-- 일별 화면 -->
        <div class="daily_data">

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
				<input type="hidden" name="selectedDate" id="selectedDate" value="${ selectedDate }">
				<table class="table table_search">
					<tr class="search_menu">
						<!-- 전체 인원수 수정해야함-->
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
							<select name="attendanceStatus" id="attendanceStatus" class="form-select">
							    <option value="전체 상태">전체 상태</option>
							    <option value="출근">출근</option>
							    <option value="결근">결근</option>
							    <option value="퇴근">퇴근</option>
							    <option value="휴가">휴가</option>
							    <option value="조퇴">조퇴</option>
							</select>
						</td>
						
						<!-- 이름 -->
						<td class="td_search">
						    <input type="text" id="name" placeholder="이름 입력" class="form-control input_name">
						    <!-- <button class="btn btn-primary">검색</button> -->
						    <button type="reset" class="btn btn-outline-primary" onclick="resetForm();">초기화</button>
						</td>
					</tr>
				</table>
			</form>
	            
	        <!-- 검색 기능 : 부서, 팀 조회하기-->
		    <script>
			let departmentSelect = $("#department");
			let teamSelect = $("#team");
			let attendanceStatusSelect = $("#attendanceStatus");
			let nameSelect = $("#name");
	 		
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
				changeDate(0);
	 		});
	 		// 팀를 선택했을 경우 실행될 function
	 		teamSelect.on("change", function() {
				changeDate(0);
	 		});
		 	// 상태를 선택했을 경우 실행될 function
	 		attendanceStatusSelect.on("change", function() {
				changeDate(0);
	 		});
	 		// 이름을 작성할때 마다 실행될 function( 3개를 써야 정상적으로 검색이되고 깜빡임이 있음)
	 		nameSelect.on("input change blur", function() {
				changeDate(0);
	 		});
	 		
	 		// input text에서 엔터눌러도 페이지 안바뀌게
			document.addEventListener('keydown', function(event) {
			  if (event.keyCode === 13) {
			    event.preventDefault();
			  };
			}, true);
			
			// 초기화 버튼 함수 
	 		function resetForm() {
	            document.getElementById('department').selectedIndex = 0;
	            document.getElementById('team').selectedIndex = 0;
	            document.getElementById('attendanceStatus').value = '';
	            document.getElementById('name').value = '';
	            changeDate(0);
	 		}
		    </script>
           <!-- 직원 정보 테이블 start-->
           <table class="table table-bordered line-shadow employee_info">
               <tr>
                   <th>프로필사진</th>
                   <th>이름</th>
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
						                <img src="${ m.profileURL }" class="profile_img" onerror="this.onerror=null; this.src='${contextPath}/resources/images/defaultProfile.png';">
						            </c:when>
						            <c:otherwise>
						                <img src="${ contextPath }/resources/images/defaultProfile.png" class="profile_img">
						            </c:otherwise>
						        </c:choose>
				            </td>
				            <td>${ m.userName }</td>
				            <td>${ m.dept }</td>
				            <td>${ m.team }</td>
				            <td>${ m.posi }</td>
		                	<td>
				            	<c:choose>
		                            <c:when test="${ m.requestDetail == '휴가' }">
		                            </c:when>
		                            <c:otherwise>
		                                <fmt:formatDate value="${ m.todayIn }" pattern="HH:mm:ss"/>
		                            </c:otherwise>
                        		</c:choose>
				            </td>
				            <td>
				            	<c:choose>
		                            <c:when test="${ m.requestDetail == '휴가' }">
		                                
		                            </c:when>
		                            <c:otherwise>
		                                <fmt:formatDate value="${ m.todayOut }" pattern="HH:mm:ss"/>
		                            </c:otherwise>
                        		</c:choose>
				            </td>
		                	<td
		                        <c:choose>
		                            <c:when test="${ m.requestDetail == '출근' }">class="table-success"</c:when>
		                            <c:when test="${ m.requestDetail == '결근' }">class="table-danger"</c:when>
		                            <c:when test="${ m.requestDetail == '퇴근' }">class="table-secondary"</c:when>
		                            <c:when test="${ m.requestDetail == '조퇴' }">class="table-warning"</c:when>
		                            <c:when test="${ m.requestDetail == '휴가' }">class="table-info"</c:when>
		                            <c:otherwise>class="table-danger"</c:otherwise>
		                        </c:choose>
                    			>
		                        <c:choose>
		                            <c:when test="${ m.requestDetail == null }">결근</c:when>
		                            <c:otherwise>${ m.requestDetail }</c:otherwise>
		                        </c:choose>
                    		</td>
				        </tr>
			        </c:forEach>
		        </c:when>
		        <c:otherwise>
		        	<tr>
		        		<td colspan="8">조회된 직원이 없습니다.</td>
		        	</tr>
		        </c:otherwise>
        	</c:choose>
           </table>
           <!-- 직원 테이블 end -->
	           
	
			<!--페이징 처리 start-->
			<!-- 
		    <div class="container">
		        <ul class="pagination justify-content-center">
		        	<li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }">
		        		<a class="page-link" href="${ contextPath }/attendance/list.do?page=${pi.currentPage-1}">Previous</a>
	        		</li>
					<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
						<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }">
							<a class="page-link" href="${ contextPath }/attendance/list.do?page=${p}">${ p }</a>
						</li>
					</c:forEach>
					<li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }">
						<a class="page-link" href="${ contextPath }/attendance/list.do?page=${pi.currentPage+1}">Next</a>
					</li> 
		        </ul>
		    </div>
		    -->
	    	<!--페이징 처리 end-->
	    	<!-- 
	    	<div class="container">
			    <ul class="pagination justify-content-center">
			        <li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }">
			            <a class="page-link" href="${ contextPath }/attendance/search.do?page=${pi.currentPage-1}">Previous</a>
			        </li>
			        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
			            <li class="page-item ${ pi.currentPage == p ? 'active' : '' }">
			                <a class="page-link" href="${ contextPath }/attendance/search.do?page=${p}">${ p }</a>
			            </li>
			        </c:forEach>
			        <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }">
			            <a class="page-link" href="${ contextPath }/attendance/search.do?page=${pi.currentPage+1}">Next</a>
			        </li> 
			    </ul>
			</div>
	    	 -->
		    	
    	</div>
    	
    	<!-- ----------------------------월별 화면  --------------------------->
    	<div class="monthly_data">
    	 	<h2> 월별 출력 </h2>
    	</div>
	
	
	<!-- ------------ -->
	
	</div>
	<!-- 메인 영역 end-->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>