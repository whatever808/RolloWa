<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>1.2 직원검색</title>

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
	
	.search_menu{
	    justify-content: center;
	    width: 100%;
	}
	.tr_search th{
	    background-color: rgb(203, 237, 255) !important;
	    text-align: center;
	    width: 20%;
	    vertical-align: middle !important;
	    font-size: 30px;
	}
	.tr_search td{
	    width: 200px;
	    text-align: center;
	}
	.tr_search input {
	    width: 100% !important;
	}
	.btn_center{
	    text-align: center;
	    padding-top: 30px !important;
	}
	.btn_center button {
	    width: 140px;
	    height: 50px;
	    font-size: 20px;
	}
	.employee_count {
	    margin-left: 10px;
	}
	table{
		table-layout: fixed;
	}
	.table_empinfo {
	    text-align: center;
	    table-layout: fixed !important;
	}
	.table_empinfo th{
	    background-color: rgb(255,247,208) !important;
	    font-size: 19px;
	}
	.table_empinfo td{
	    vertical-align: middle !important;
	}
	.table_empinfo td img{
	    border: 1px solid gainsboro;
	    border-radius: 100%;
	    width: 50px;
	    height: 50px;
		object-fit: cover; /* 다른 사이즈 이미지도 안잘리고 동일하게 조절하기 */
	    margin: -10px;
 	}
 	/*
 	.profile_img:hover {
		transform: scale(10) translate(70%, -40%);
    	border-radius: 0;
    	border: 0px;
    	object-fit: contain;
	}
	*/
 	
	</style>
</head>
<body>

	<!-- 사이드바 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
	
	<!-- 메인 영역 -->
	<div class="main_content">
	    <h2>직원 검색</h2>
	    <hr>
	    
	    <!-- ------------ -->
	    <form id="search_Form" action="${ contextPath }/orginfo/search.do" method="GET">
	    	<input type="hidden" name="page" value="1">
			
	        <table class="table table_search">
	
	            <tr class="tr_search">
	                <!-- 검색 메뉴 1 : 부서명-->
                	<th>부서명</th>
	                <td>
	                    <select name="department" id="department" class="form-control">
	                        	<!-- <option value="전체 부서">전체 부서</option> -->
                    	</select>
	                </td>
	                <!-- 검색 메뉴 2 : 전화번호 -->
	                <th>전화번호</th>
	                <td>
	                    <input type="text" id="phone" name="phone" class="form-control" placeholder="전화번호를 입력하세요.(숫자만 입력)">
	                </td>
	            </tr>
	            <tr class="tr_search">
	                <!-- 검색 메뉴 3 : 팀명 -->
	                <th>팀명</th>
	                <td>
	                    <select name="team" id="team" class="form-control">
	                        	<!-- <option value="전체 팀">전체 팀</option> -->
                    	</select>
	                </td>
	                <!-- 검색 메뉴 4 : 이름 -->
	                <th>이름</th>
	                <td>
	                    <input type="text" id="name" name="name" class="form-control" placeholder="이름을 입력하세요.">
	                </td>
	            </tr>
	            <tr>
	                <td class="btn_center" colspan="4">
	                    <h2>
	                        <button class="btn btn-outline-primary" type="reset">초기화</button>
	                        <button class="btn btn-primary" onclick="search();">검색</button>
	                    </h2>
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
			 		url:"${contextPath}/orginfo/department.do",
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
		 	        url:"${contextPath}/orginfo/team.do?selectedDepartment=" + departmentSelect.val(),
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
		 	    // 팀 조회
		 	   selectTeamList();
			    
	 		});
	 		
	 		
	 		// 검색 이후 초기화 작동하도록 하기
	 		$(document).ready(function(){
	 		    $("#search_Form button[type=reset]").click(function() {
	 		        $("#search_Form")[0].reset();
	 		        
	 		        $("#search_Form #department").val("전체 부서");
	 		        $("#search_Form #team").val("전체 팀");

	 		        return false;
	 		    });
	 		});
	 		
	 		
	 		// 검색 버튼
	 		function search(){
		 		let department = $("#department").val();
		 		let phone =  $("#phone").val();
		 		let team = $("#team").val();
		 	    let name = $("#name").val();
		 	 
	 			$.ajax({
	 				url:"${contextPath}/orginfo/search.do",
	 				type: "GET",
	 				data: {
	 		            department: department,
	 		            phone: phone,
	 		            team: team,
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
	        /* 전화번호 : 숫자만 입력되고 나머지 글자는 공백으로 변환 */
	        $("#search_Form input[name=phone]").on("keyup", function(){
	            let regExp = $(this).val().replace(/[^\d]+/g, '');
	            $(this).val(regExp);
	        })
	
	        /* 이름 : 한글만 입력되고 나머지 글자는 공백으로 변환 */
	        $("#search_Form input[name=name]").on("keyup", function(){
	            let regExp = $(this).val().replace(/[^가-힣ㄱ-ㅎ]+/g, '');
	            $(this).val(regExp);
	        })
	    </script>
	    
	    <!-- 전체 인원수 -->
	    <h5 class="employee_count">전체 ${ listCount }명</h5>
	
	    <!-- 직원 정보 테이블 start-->
	    <table class="table table_empinfo line-shadow">
	        <tr>
	            <th>프로필 사진</th>
	            <th>이름</th>
	            <th>부서</th>
	            <th>팀명</th>
	            <th>직급</th>
	            <th>전화번호</th>
	            <th>이메일</th>
	        </tr>
	        
	        <!-- 이름, 부서, 팀명, 직급, 전화, 이메일 -->
	        <c:choose>
		        <c:when test="${ not empty list }">
		        	<c:forEach var="m" items="${ list }">
				        <tr>
				            <td>
					            <c:choose>
					            	<c:when test="${ not empty m.profileUrl }">
						                <img src="${ m.profileUrl }" class="profile_img">
					            	</c:when>
					            	<c:otherwise>
						                <img src="${contextPath}/resources/images/defaultProfile.png">
					            	</c:otherwise>
					            </c:choose>
				            </td>
				            <td>${ m.userName }</td>
				            <td>${ m.dept }</td>
				            <td>${ m.team }</td>
				            <td>${ m.posi }</td>
				            <td>${ m.phone }</td>
				            <td>${ m.email }</td>
				        </tr>
			        </c:forEach>
		        </c:when>
		        <c:otherwise>
		        	<tr>
		        		<td colspan="7">조회된 직원이 없습니다.</td>
		        	</tr>
		        </c:otherwise>
	        </c:choose>
	        
	    </table>
	    
	    <!-- 직원 테이블 end -->
	
	    <!--페이징 처리 start-->
		<div id="pagingArea" class="container">
	        <ul class="pagination justify-content-center">
	        	<li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/orginfo/list.do?page=${pi.currentPage-1}">Previous</a></li>
				
				<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
					<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/orginfo/list.do?page=${p}">${ p }</a></li>
				</c:forEach>
				
				<li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/orginfo/list.do?page=${pi.currentPage+1}">Next</a></li> 
	        </ul>
	    </div>
	    
	    <c:if test="${ not empty search }">
			<script>
			     $(document).ready(function(){
			        /* $("#search_Form #department").val("${ search.department }");
			        $("#search_Form #department").children("option").each(function(){
			        	$(this).val() == "${ search.department }" && $(this).attr("selected", true);
			        })
			        */
			        $("#search_Form #team").val("${ search.team }");
			        $("#search_Form #phone").val("${ search.phone }");
			        $("#search_Form #name").val("${ search.name }");
			        
			        // 검색결과 페이지일 경우 페이징바 페이지 요청시 ==> <a> 기본이벤트 제거
			        $("#pagingArea a").on("click", function(){
						if($(this).text() == 'Previous'){
							$("#search_Form input[name=page]").val("${pi.currentPage}" - 1);
						}else if($(this).text() == 'Next' ){
							$("#search_Form input[name=page]").val(Number("${pi.currentPage}") + 1);
						}else{
							$("#search_Form input[name=page]").val($(this).text());                   
						}
						$("#search_Form").submit();
			           
						return false;
					})
					
				})
			</script>
		</c:if>
	     
	    <!--페이징 처리 end-->
		
	</div>
	<!-- 메인 영역 end-->
		
</body>
</html>

	