<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>1.2 직원 검색</title>
	
	<!-- css -->
	<link rel="stylesheet" href="${contextPath}/resources/css/organization/organization.css">

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
	
	<!-- 메인 영역 -->
	<div class="main_content">
	    <h2>직원 검색</h2>
	    <hr>
	    
	    <!-- ------------ -->
	    <form id="search_Form" action="${ contextPath }/organization/search.do" method="GET">
	    	<input type="hidden" name="page" value="1">
			
	        <table class="table table_search">
	
	            <tr class="tr_search">
	                <!-- 검색 메뉴 1 : 부서명-->
                	<th>부서명</th>
	                <td>
	                    <select name="department" id="department" class="form-select">
                    	</select>
	                </td>
	                <!-- 검색 메뉴 2 : 전화번호 -->
	                <th>전화번호</th>
	                <td>
	                    <input type="text" id="phone" name="phone" class="form-control" placeholder="전화번호를 입력하세요.">
	                </td>
	            </tr>
	            <tr class="tr_search">
	                <!-- 검색 메뉴 3 : 팀명 -->
	                <th>팀명</th>
	                <td>
	                    <select name="team" id="team" class="form-select">
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
	    let initialDepartment = "${department}";
	    let initialTeam = "${team}";

	    $(document).ready(function() {
	        // 부서 조회
	        selectDepartmentList();

	        // 자동 검색 실행
	        if (initialDepartment !== "" || initialTeam !== "" || "${request.getParameter('phone')}" !== "" || "${request.getParameter('name')}" !== "") {
	            search();
	        }

	        // 검색 이후 초기화 작동하도록 하기
	        $("#search_Form button[type=reset]").click(function() {
	            $("#search_Form")[0].reset();

	            $("#search_Form #department").val("전체 부서");
	            $("#search_Form #team").val("전체 팀");

	            return false;
	        });
	    });

	    // 부서조회
	    function selectDepartmentList() {
	        departmentSelect.empty();
	        departmentSelect.append($('<option>', {
	            value: "전체 부서",
	            text: "전체 부서"
	        }));

	        $.ajax({
	            url: "${contextPath}/organization/department.do",
	            type: "GET",
	            success: function(data) {
	                $.each(data, function(index, organizationDto) {
	                    $.each(organizationDto.groupList, function(index, groupDto) {
	                        departmentSelect.append($('<option>', {
	                            value: groupDto.codeName,
	                            text: groupDto.codeName
	                        }));
	                    });
	                });

	                if (initialDepartment !== "") {
	                    $("#search_Form #department").val(initialDepartment);
	                    selectTeamList(initialDepartment); // 초기 부서 선택 시 팀 목록 갱신
	                } else {
	                    selectTeamList("전체 부서"); // 초기 로드 시 전체 팀 목록 설정
	                }
	            },
	            error: function() {
	                console.log("ajax 부서 조회 실패 입니다.")
	            }
	        });
	    }

	    // 팀조회
	    function selectTeamList(selectedDepartment) {
	        teamSelect.empty();
	        teamSelect.append($('<option>', {
	            value: "전체 팀",
	            text: "전체 팀"
	        }));

	        $.ajax({
	            url: "${contextPath}/organization/team.do?selectedDepartment=" + selectedDepartment,
	            type: "GET",
	            success: function(data) {
	                $.each(data, function(index, organizationDto) {
	                    $.each(organizationDto.groupList, function(index, groupDto) {
	                        teamSelect.append($('<option>', {
	                            value: groupDto.codeName,
	                            text: groupDto.codeName
	                        }));
	                    });
	                });

	                if (initialTeam !== "") {
	                    $("#search_Form #team").val(initialTeam);
	                    initialTeam = ""; // 초기 설정 후 값을 초기화하여 이후 선택 시 영향을 미치지 않도록 함
	                } else {
	                    $("#search_Form #team").val("전체 팀");
	                }
	            },
	            error: function() {
	                console.log("ajax 팀 조회 실패 입니다.")
	            }
	        });
	    }

	    // 부서를 선택했을 경우 실행될 function
	    departmentSelect.on("change", function() {
	        let selectedDepartment = $(this).val();
	        selectTeamList(selectedDepartment);
	    });

	    // 검색 버튼
	    function search() {
	        let department = $("#department").val();
	        let phone = $("#phone").val();
	        let team = $("#team").val();
	        let name = $("#name").val();

	        $.ajax({
	            url: "${contextPath}/organization/search.do",
	            type: "GET",
	            data: {
	                department: department,
	                phone: phone,
	                team: team,
	                name: name
	            },
	            success: function(response) {
	                // 검색 결과 처리
	            },
	            error: function() {
	                console.log("검색 요청 실패");
	            }
	        });
	    }
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
						                <img src="${contextPath}/${m.profileUrl}" class="profile_img">
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
		        <!-- 처음 페이지로 이동 -->
		        <li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }">
		            <a class="page-link" href="${ contextPath }/organization/list.do?page=1">처음</a>
		        </li>
		
		        <!-- 이전 페이지로 이동 -->
		        <li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }">
		            <a class="page-link" href="${ contextPath }/organization/list.do?page=${pi.currentPage-1}">◀</a>
		        </li>
		
		        <!-- 페이지 번호 링크 -->
		        <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
		            <li class="page-item ${ pi.currentPage == p ? 'active' : '' }">
		                <a class="page-link" href="${ contextPath }/organization/list.do?page=${p}">${ p }</a>
		            </li>
		        </c:forEach>
		
		        <!-- 다음 페이지로 이동 -->
		        <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }">
		            <a class="page-link" href="${ contextPath }/organization/list.do?page=${pi.currentPage+1}">▶</a>
		        </li>
		
		        <!-- 끝 페이지로 이동 -->
		        <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }">
		            <a class="page-link" href="${ contextPath }/organization/list.do?page=${pi.maxPage}">끝</a>
		        </li>
		    </ul>
		</div>
		
		<c:if test="${ not empty search }">
		    <script>
		        $(document).ready(function(){
		            $("#search_Form #team").val("${ search.team }");
		            $("#search_Form #phone").val("${ search.phone }");
		            $("#search_Form #name").val("${ search.name }");
		
		            // 검색결과 페이지일 경우 페이징바 페이지 요청시 ==> <a> 기본이벤트 제거
		            $("#pagingArea a").on("click", function(){
		                if($(this).text() == '처음'){
		                    $("#search_Form input[name=page]").val(1);
		                } else if($(this).text() == '◀'){
		                    $("#search_Form input[name=page]").val("${pi.currentPage}" - 1);
		                } else if($(this).text() == '▶'){
		                    $("#search_Form input[name=page]").val(Number("${pi.currentPage}") + 1);
		                } else if($(this).text() == '끝'){
		                    $("#search_Form input[name=page]").val("${pi.maxPage}");
		                } else {
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
		
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
	
</body>
</html>

	