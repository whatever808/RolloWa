<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1.3 조직 관리</title>

    <!-- css -->
    <link rel="stylesheet" href="${contextPath}/resources/css/organization/organization.css">

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
        
        <form id="org_Form" action="" method="GET" onsubmit="return false;">
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
			                        <button class="btn btn-success add_team" onclick="addTeam(this);">팀 추가</button>
			                        <a href="#"><span class="level2"><input type="text" value="${d.dept}"></span></a>
			                        <ul>
			                            <c:forEach var="team" items="${dept}">
			                                <c:if test="${d.dept eq team.dept}">
			                                    <ul>
			                                        <li>
			                                            <a href="#"><span class="level3"><input type="text" value="${team.team}"></span></a>
			                                            <button class="btn btn-danger delete_team" onclick="deleteTeam(this);">팀 삭제</button>
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
			
			<div class="div_btn">
				<h2>
					<button type="reset" class="btn btn-outline-primary" onclick="resetForm();">되돌리기</button>
					<button type="button" class="btn btn-primary" onclick="saveForm();">저장</button>
				</h2>
			</div>
		</form>
		
		<script>
		// 부서 추가
	    function addDepartment() {
	        // 새로운 부서 요소 생성
	        let newDepartment = document.createElement("li");
	        newDepartment.innerHTML = `
               	<button class="btn btn-danger delete_department" onclick="deleteDepartment(this);">부서 삭제</button>
	            <button class="btn btn-success add_team" onclick="addTeam(this);">팀 추가</button>
	            <a href="#"><span class="level2"><input type="text" value="새로운 부서"></span></a>
	            <ul>
	            	<ul>
		                <li>
		                    <a href="#"><span class="level3"><input type="text" value="새로운 팀"></span></a>
		                    <button class="btn btn-danger delete_team" onclick="deleteTeam(this);">팀 삭제</button>
		                </li>
	                </ul>
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
        function addTeam(button) {
            let newTeam = document.createElement("ul");
            newTeam.innerHTML = `
            	<li>
	                <a href="#"><span class="level3"><input type="text" value="새로운 팀"></span></a>
	                <button type="button" class="btn btn-danger delete_team" onclick="deleteTeam(this);">팀 삭제</button>
                </li>
            `;
            let departmentItem = button.parentNode.querySelector('ul');
            departmentItem.appendChild(newTeam);
            alert("팀이 추가되었습니다.");
        }

		// 팀 삭제
		function deleteTeam(button) {
		    // 팀 요소의 부모 요소(li)를 찾아서 삭제
		    let teamItem = button.parentElement;
		    teamItem.parentNode.removeChild(teamItem);
		    alert("팀이 삭제되었습니다.");
		}
		
		// 폼 되돌리기
		function resetForm() {
			// 새로고침으로 되돌리기
			location.reload();
		}
		
		// 폼 저장
		function saveForm() {
			// 추가 작성
			
			let newDepartments = document.querySelectorAll('.tree > li > ul > li');
			let departmentData = [];
			
			newDepartments.forEach(function(department) {
		        let departmentName = department.querySelector('input[type="text"]').value;
		        let newTeams = department.querySelectorAll('ul > li');
		        let teamsData = [];
		        newTeams.forEach(function(team) {
		            let teamName = team.querySelector('input[type="text"]').value;
		            teamsData.push(teamName);
		        });
		        departmentData.push({departmentName: departmentName, teams: teamsData});
		    });
			
		        $.ajax({
		            type: "POST",
			        url:"${ contextPath }/organization/addDepartment.do",
		            contentType: "application/json",
		            data: JSON.stringify(departmentData),
		            success: function(response) {
		                alert("폼 데이터가 저장되었습니다.");
		            },
		            error: function(xhr, status, error) {
		                alert("오류가 발생했습니다.");
		            }
		        });
			
		}
		</script>
		
		
		
		<!-- ------------ -->
	
	</div>
	<!-- 메인 영역 end-->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>