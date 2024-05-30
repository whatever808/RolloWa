<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>구성원 상세 조회</title>

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
    .today_btn{
        position: relative;
        top: -40px;
        left: 230px;
    }
    h3{
        display: flex;
        align-items: center;
        justify-content: center;
    }
    .table{
        white-space: nowrap;
    }
    .table_1{
        margin-top: 50px;
    }
    .td_1{
        text-align: right;
    }
    .td_1 button {
        width: 90px;
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
        width: 40px;
        margin: -5px;
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
	    <h2>구성원 상세 조회</h2>
	    <hr>
	    
		<!-- ------------ -->
	
		<!-- 전체 인원수 -->
		<!-- 직원 급여 데이터 start -->
		<form id="search_Form"
			action="${ contextPath }/attendance/accountSearch.do" method="GET">
			<input type="hidden" name="selectedDate" id="selectedDate"
				value="${ selectedDate }">
			<table class="table table_search">
				<tr class="search_menu">
					<!-- 전체 인원수 -->
					<td>
						<h5 class="employee_count">전체 ${ listCount } 명</h5>
					</td>
					<td><select name="department" id="department" class="form-select"></select></td>

					<td><select name="team" id="team" class="form-select"></select>
					</td>

					<td class="td_search"><input type="text" id="name" placeholder="이름 입력" class="form-control input_name" onsubmit="return false">
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
  if (event.keyCode == 13) {
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
        

        <!-- 직원 정보 -->
        <table class="table table-bordered employee_info">
            <tr>
                <th>프로필사진</th>
                <th>이름</th>
                <th>아이디</th>
                <th>부서명</th>
                <th>팀명</th>
                <th>직급</th>
                <th>전화번호</th>
                <th>이메일</th>
                <th>주소</th>
            </tr>

            <tr class="tr_1">
                <td>
                    <img src="../../../resources/images/defaultProfile.png" class="profile_img">
                </td>
                <td>황지수</td>
                <td>hwangjisu</td>
                <td>마케팅부</td>
                <td>마케팅1팀</td>
                <td>대리</td>
                <td>010-4523-7948</td>
                <td>hwangjisu <br>
                    @gmail.com</td>
                <td>서울시 금천구 가산디지털 3단지 <br>
                    101호</td>
            </tr>
            
        </table>
	
	
		<!-- ------------ -->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>