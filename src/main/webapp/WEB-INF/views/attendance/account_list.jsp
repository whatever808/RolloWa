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
    <title>2.2 급여 조회</title>

    <!-- css -->
	<link rel="stylesheet" href="${contextPath}/resources/css/attendance/account.css">
	
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
	    <h2>급여 조회</h2>
	    <hr>
	    
		<!-- ---------------------------- -->
		<!-- 날짜 영역 start -->
        <div class="select_date">
            <table class="table_2">
                <tr>
                    <td><h3><div class="arrow" onclick="changeDate(-1);">◀</div></h3></td>
                    <td><input type="month" id="currentDate" onchange="changeDate(0);"></td>
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
        
		// 오늘 날짜로 설정하기 (2024-05 형식)
        function todayDate(){
			let currentYear = currentDate.getFullYear(); // 2024
			let currentMonth = currentDate.getMonth() + 1; // 5
			// 날짜 형식 2024-05로 설정
			let currentMonthString = currentYear + '-' + (currentMonth < 10 ? '0' : '') + currentMonth;
	         
			document.getElementById('currentDate').value = currentMonthString;
        }
        
     	// 날짜 변경 함수
		function changeDate(number) {
			let currentDateInput = document.getElementById('currentDate').value;
			let currentDate = new Date(currentDateInput + '-01'); // 현재 입력된 날짜 가져오기 (일자는 항상 01로 고정)
			let newDate = new Date(currentDate); // 현재 날짜 가져오기
			
			newDate.setMonth(newDate.getMonth() + number);
			
			let newYear = newDate.getFullYear();
			let newMonth = newDate.getMonth() + 1;
			let selectedDate = newYear + '-' + (newMonth < 10 ? '0' : '') + newMonth;
			document.getElementById('currentDate').value = selectedDate;
			
			console.log("현재 날짜 : ", selectedDate);
			
			let department = $("#department").val();
			let team = $("#team").val();
			let name = $("#name").val();
			
			$.ajax({
				url:"${ contextPath }/attendance/accountSearch.do",
				type:"GET",
				data:{ 
					selectedDate: selectedDate,
					department: department,
					team: team,
					name: name
				},
				success: function(data){	
					//console.log("통신 성공");

					// 검색한 사용자 수
					let rowCount = $(data).find(".employee_info tbody tr").length;
					
					// 통신 성공 시 값 바꿔주기
					$(".employee_info tbody").html($(data).find(".employee_info tbody").html());
				}, error: function(){
					//console.log("통신 실패");
				}
			})
		}
		</script>
		

		<!-- 직원 출결 데이터 start -->
		<form id="search_Form" action="${ contextPath }/attendance/accountSearch.do" method="GET">
			<!-- <input type="hidden" name="page" value="1"> -->
			<input type="hidden" name="selectedDate" id="selectedDate" value="${ selectedDate }">

			<table class="table table_search">
				<tr class="search_menu">
					<!-- 전체 인원수 -->
					<td>
						<h5 class="employee_count">총 00명</h5>
					</td>
					<td>
					    <h5 class="employee_count">총 ${searchResultCount}명</h5>
					</td>
					
					<td>
						<select name="department" id="department" class="form-select"></select>
					</td>
					
					<td>
						<select name="team" id="team" class="form-select"></select>
					</td>
					
					<td class="td_search">
					    <input type="text" id="name" placeholder="이름 입력" class="form-control input_name" onsubmit="return false">
					    <!-- <button class="btn btn-primary">검색</button> -->
					    <button type="button" class="btn btn-outline-primary" onclick="resetForm();">초기화</button>
					</td>
				</tr>
			</table>
		</form>
			
		<!-- 검색 기능 : 부서, 팀 조회하기-->
	    <script>
		let departmentSelect = $("#department");
		let teamSelect = $("#team");
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
	 	// 이름을 작성할때 마다 실행될 function( 3개를 써야 정상적으로 검색이되고 깜빡임이 있음)
 		nameSelect.on("input change blur", function() {
			changeDate(0);
 		});
	 	
 		<!-- input text에서 엔터눌러도 페이지 안바뀌게 -->
		document.addEventListener('keydown', function(event) {
		  if (event.keyCode === 13) {
		    event.preventDefault();
		  };
		}, true);
		
		<!-- 초기화 버튼 함수 -->
 		function resetForm() {
            document.getElementById('department').selectedIndex = 0;
            document.getElementById('team').selectedIndex = 0;
            document.getElementById('name').value = '';
            changeDate(0);
 		}
 		
	    </script>
	    
	    <script>
        /* 이름 : 한글만 입력되고 나머지 글자는 공백으로 변환 */
        $("#search_Form input[name=name]").on("keyup", function(){
            let regExp = $(this).val().replace(/[^가-힣ㄱ-ㅎ]+/g, '');
            $(this).val(regExp);
        })
	    </script>
		
		

           <!-- 직원 정보 -->
           <table class="table table-bordered line-shadow employee_info">
               <tr>
                   <th>프로필사진</th>
                   <th>이름</th>
                   <th>아이디</th>
                   <th>부서</th>
                   <th>팀명</th>
                   <th>직급</th>
                   <th>총 근무시간</th>
                   <th>시급</th>
                   <th>지급 총액</th>
                   <th>지방소득세</th>
                   <th>실 지급액</th>
               </tr>


			<c:choose>
		        <c:when test="${ not empty list }">
		        	<c:forEach var="m" items="${ list }">
		                <tr class="tr_1" onclick="window.location.href='${contextPath}/attendance/accountDetail.do';">
		                    <td>	
					            <c:choose>
					            	<c:when test="${ not empty m.profileUrl }">
						                <img src="${ m.profileUrl }" class="profile_img" onerror="this.onerror=null; this.src='${contextPath}/resources/images/defaultProfile.png';">
					            	</c:when>
					            	<c:otherwise>
						                <img src="${ contextPath }/resources/images/defaultProfile.png" class="profile_img">
					            	</c:otherwise>
					            </c:choose>
				            </td>
		                    <td>${ m.userName }</td>
		                    <td>${ m.userId }</td>
		                    <td>${ m.dept }</td>
		                    <td>${ m.team }</td>
		                    <td>${ m.posi }</td>
		                    <td>${ m.alltime }</td>
		                    <td><fmt:formatNumber value="${m.salary}" pattern="#,##0" /></td>
		                    <td><fmt:formatNumber value="${m.totalSalary}" pattern="#,##0" /></td>
		                    <td>10%</td>
		                    <td><fmt:formatNumber value="${m.payment}" pattern="#,##0" /></td>
		                </tr>
	                </c:forEach>
        		</c:when>
        		
		        <c:otherwise>
		        	<tr>
		        		<td colspan="11">조회된 직원이 없습니다.</td>
		        	</tr>
		        </c:otherwise>
	        </c:choose>
           </table>

           <!--페이징 처리 start-->
           <!-- 일단 보류 -->
           <!--페이징 처리 end-->
           
           


	<!-- ------------ -->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>