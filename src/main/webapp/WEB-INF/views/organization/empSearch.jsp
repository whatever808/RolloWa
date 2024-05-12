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
 	.profile_img:hover {
		transform: scale(10) translate(70%, -40%);
    	border-radius: 0;
    	border: 0px;
    	object-fit: contain;
	}
	
 	
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
	    <form id="search_Form" action="${ contextPath }/orginfo/empSearch.do" method="GET">
	        <table class="table table_search">
	
	            <tr class="tr_search">
	                <!-- 검색 메뉴 1 : 부서명-->
                	<th>부서명</th>
	                <td>
	                	
	                    <select id="dept" name="dept" class="form-control">
	                        <option value="전체 부서">전체 부서</option>
	                        <c:forEach var="d" items="${ dept }">
		                        <option value="${d.codeName}">${d.codeName}</option>
	                        </c:forEach>
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
	                        <option value="전체 팀">전체 팀</option>
	                        <c:forEach var="t" items="${ team }">
		                        <option value="${t.codeName}">${t.codeName}</option>
	                        </c:forEach>
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
	                        <button class="btn btn-primary">검색</button>
	                    </h2>
	                </td>
	            </tr>
	        </table>
	    </form>
	    
	    <!-- 스크립트 작성중 -->
	    <script>
		    $(document).ready(function() {
		        $('#dept').change(function() {
		            let selectDept = $(this).val();
		            console.log("선택한 부서명: ", selectDept);
		            
		            $.ajax({
		                url: '${contextPath}/orginfo/empSearch.do', // 중복된 부분을 한 번만 포함
		                type: 'GET',
		                data: { codeName: selectDept },
		                dataType: 'json',
		                success: function(data){
		                    $('#team').empty();
		                    $('#team').append('<option value="전체">전체 팀</option>'); // 기본 옵션 추가
		                    $.each(data, function(index, team) {
		                        $('#team').append('<option value="' + team.codeName + '">' + team.codeName + '</option>');
		                    });
		                    console.log("선택한 부서의 팀 : ", data);
		                },
		                error: function(xhr, status, error) {
		                    console.error('통신 실패', error);
		                }
		            });
		        });
		    });
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
	            <th>성명</th>
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
	        </c:choose>
	        
	    </table>
	    
	    <!-- 직원 테이블 end -->
	
	    <!--페이징 처리 start-->
	    <div class="container">
	        <ul class="pagination justify-content-center">
	        	<li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/orginfo/empSearch.do?page=${pi.currentPage-1}">Previous</a></li>
				<c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
					<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/orginfo/empSearch.do?page=${p}">${ p }</a></li>
				</c:forEach>
				<li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/orginfo/empSearch.do?page=${pi.currentPage+1}">Next</a></li> 
	        </ul>
	    </div>
	    <!--페이징 처리 end-->
		
	</div>
	<!-- 메인 영역 end-->
		
</body>
</html>

	