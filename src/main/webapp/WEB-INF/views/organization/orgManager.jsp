<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1.1 조직도</title>

    <!-- 조직도 참고 사이트
       https://www.cssscript.com/clean-tree-diagram/
    -->

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

    <!-- sidebar -->
    <script src="${contextPath}/resources/js/common/sidebars.js"></script>
    
    <!-- 조직도 css : 기존 조직도에서 가져옴 -->
    <link rel="stylesheet" href="${contextPath}/resources/css/organization/organization.css">
    
    <style>
    .main_content{
    	width: 1200px !important;
        padding: 20px;
    }
    .level2:hover{
		background-color: rgb(0, 183, 165);
	}
	.level3:hover {
		background-color: gainsboro;
	}
	.level2, .level3 {
		cursor: default;
	}
	.add_department{
		position: absolute;
    	z-index: 1;
    	top: 20px;
    	right: 400px;
    	white-space: nowrap;
    	outline: none;
	}
    .add_team{
    	position: absolute;
    	z-index: 1;
    	top: 50px;
    	left: 200px;
    	white-space: nowrap;
    }
    .delete_department{
		position: absolute;
    	z-index: 1;
    	top: 10px;
    	left: 40px;
    	white-space: nowrap;
    }
    .delete_team{
    	position: absolute;
    	z-index: 1;
    	top: 15px;
    	left: 200px;
    	white-space: nowrap;
    }
    
    </style>
</head>
<body>

	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
	    <h2>조직 관리</h2>
	    <hr>
	    
	    <script>
		  $(document).ready(function() {
		      var treeItems = $('.tree > li > ul > li').length;
		      if (treeItems > 4) {
		          $('.tree > li > ul').css('display', 'flex');
		          $('.tree > li > ul').css('flex-wrap', 'wrap');
		        }
		  });
		</script>
            
		<ul class="tree">
		    <li>
		        <span class="level1">대표이사</span>
		        <button class="btn btn-success add_department" onclick="addDepartment();">부서 추가</button>
		        <ul id="departmentList">
		            <c:set var="prevDept" value="" />
		            <c:forEach var="d" items="${dept}">
		                <c:if test="${d.dept ne prevDept}">
		                    <li>
		                    	<button class="btn btn-danger delete_department" onclick="deleteDepartment(this);">부서 삭제</button>
		                        <button class="btn btn-success add_team" onclick="addTeam();">팀 추가</button>
		                        <a href="#"><span class="level2">${d.dept}</span></a>
		                        <ul>
		                            <c:forEach var="team" items="${dept}">
		                                <c:if test="${d.dept eq team.dept}">
		                                    <ul>
		                                        <li>
		                                            <a href="#"><span class="level3">${team.team}</span></a>
		                                            <button class="btn btn-danger delete_team" onclick="deleteTeam();">팀 삭제</button>
		                                        </li>
		                                    </ul>
		                                </c:if>
		                            </c:forEach>
		                        </ul>
		                    </li>
		                    <c:set var="prevDept" value="${d.dept}" />
		                </c:if>
		            </c:forEach>
		        </ul>
		    </li>	
		</ul>
		
		<script>
		// 부서 추가
	    function addDepartment() {
	        // 새로운 부서 요소 생성
	        let newDepartment = document.createElement("li");
	        newDepartment.innerHTML = `
               	<button class="btn btn-danger delete_department" onclick="deleteDepartment(this);">부서 삭제</button>
	            <button class="btn btn-success add_team" onclick="addTeam();">팀 추가</button>
	            <a href="#"><span class="level2">새로운 부서</span></a>
	            <ul>
	                <li>
	                    <a href="#"><span class="level3">새로운 팀</span></a>
	                    <button class="btn btn-danger delete_team" onclick="deleteTeam();">팀 삭제</button>
	                </li>
	            </ul>
	        `;
	
	        // 새로운 부서 요소 추가
	        let departmentList = document.querySelector('.tree > li > ul');
	        departmentList.appendChild(newDepartment);
	        alert("부서가 추가되었습니다.");
	    }
		// 부서 삭제
		function deleteDepartment(button) {
		    // 삭제할 부서 요소의 부모 노드(li) 찾기
		    let departmentItem = button.parentNode;
		    // 해당 부서 요소를 부모 노드에서 제거
		    departmentItem.parentNode.removeChild(departmentItem);
		    alert("부서가 삭제되었습니다.");
		}
		
		// 팀 추가
	    function addTeam() {
	        let newTeam = document.createElement("li");
	        newTeam.innerHTML = `
	            <ul>
	                <li>
						<a href="#"><span class="level3">새로운 팀</span></a>
						<button class="btn btn-danger delete_team" onclick="deleteTeam();">팀 삭제</button>
	                </li>
	            </ul>
	        `;
	
	        // 새로운 부서 요소 추가
	        let TeamList = document.querySelector('.tree > li > ul');
	        TeamList.appendChild(newTeam);
	        alert("팀이 추가되었습니다.");
	    }
		// 팀 삭제
		function deleteTeam(button) {
		    let teamItem = button.parentNode;
		    // 해당 부서 요소를 부모 노드에서 제거
		    teamItem.parentNode.removeChild(teamItem);
		    alert("팀이 삭제되었습니다.");
		}

		
		</script>
		
		<!-- ------------ -->
	
	</div>
	<!-- 메인 영역 end-->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>