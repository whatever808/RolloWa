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
    
    /* css */
    /* 화살표 */
    .arrow{
        margin: 0 60px;
    }

    /* 출력상태 조회 css */
    .select_date{
        margin-top: 20px;
        text-align: center;
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
	.arrow{
    	cursor: pointer;	
   	}
    h3{
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .table{
        white-space: nowrap;
    }
    .td_1{
        text-align: right;
    }
    .td_1 button {
        width: 90px;
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
    .td_search{
    	display: flex;
    	align-items: center;
    	white-space: nowrap;
    }
    .td_search input{
    	width: 250px;
    	margin: 0 50px;
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

    /* 직원 정보 테이블 */
    .employee_count {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-left: 10px;
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
		object-fit: cover; /* 다른 사이즈 이미지도 안잘리고 동일하게 조절하기 */
	    margin: -10px;
 	}
    
    .tr_1:hover td{
        cursor: pointer;
        background-color: gainsboro;
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
                    <td><input type="month" id="currentDate"></td>
                    <td><h3><div class="arrow" onclick="changeDate(1);">▶</div></h3></td>
                </tr>
            </table>
        </div>
        
        <!-- 날짜 관련 js -->
        <script>
        let currentDateElement = document.getElementById('currentDate');
        let today = new Date();

        const koreanTimezoneOffset = 540; // GMT+09

		today.setMinutes(today.getMinutes() + koreanTimezoneOffset);

        // 날짜를 페이지 로드시 바로 출력합니다.
		window.onload = function(){
			showMonthlyData();
		}
        
        // 날짜 값 형식을 2024-05 같은 형식으로 설정 : input타입 month 형식이라서
		function showMonthlyData() {
		    document.getElementById('currentDate').type = 'month';
		    currentDateElement.value = today.toISOString().split('-').slice(0, 2).join('-');
		    console.log(currentDate.value);
		}
        
		// 날짜 변경 함수
		function changeDate(direction) {
		    let dateString = currentDateElement.value;
		    let currentDate = new Date(dateString);

		    if (currentDateElement.type === 'month') {
		        currentDate.setMonth(currentDate.getMonth() + direction);
		        currentDateElement.valueAsDate = currentDate;
		    } else {
		        currentDate.setDate(currentDate.getDate() + direction);
		        currentDateElement.value = currentDate.toISOString().split('T')[0];
		    }

		    let formData = new FormData();
		    formData.append('selectedDate', currentDateElement.value);

		    $.ajax({
		        type:"GET",
		        url:"${contextPath}/attendance/search.do",
		        data:{ selectedDate: currentDateElement.value },
		        success: function(response) {
		            // 성공적으로 데이터를 받았을 때 실행할 코드를 작성합니다.
		            //console.log("서버 응답:", response);
			    	console.log("사용자가 선택한 날짜 : ",currentDateElement.value);
		        },
		        error: function(xhr, status, error) {
		            // 에러가 발생했을 때 실행할 코드를 작성합니다.
		            console.error("에러:", error);
		        }
		    });
		}

		// 사용자가 선택한 날짜 값
		currentDateElement.addEventListener('change', function() {
		    document.getElementById("selectedDate").value = currentDateElement.value;
		    // 인자를 전달하지 않고 changeDate를 호출하여 날짜를 갱신
		    changeDate(0);
		});
		</script>
        

		<!-- 직원 출결 데이터 start -->
		<form id="search_Form" action="${ contextPath }/attendance/search.do" method="GET">
			<input type="hidden" name="page" value="1">
			<input type="hidden" name="selectedDate" id="selectedDate" value="${ selectedDate }">
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
 				url:"${contextPath}/attendance/accountSearch.do",
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
		
		

           <!-- 직원 정보 -->
           <table class="table table-bordered employee_info">
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
           <div class="container">
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