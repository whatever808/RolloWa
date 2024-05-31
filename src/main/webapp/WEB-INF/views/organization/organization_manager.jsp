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
	        let newDepartmentName = "새로운 부서";
	        newDepartment.innerHTML = `
	            <button class="btn btn-danger delete_department" onclick="deleteDepartment(this);">부서 삭제</button>
	            <button class="btn btn-success add_team" onclick="addTeam(this);">팀 추가</button>
	            <a href="#"><span class="level2"><input type="text" value="${newDepartmentName}"></span></a>
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
	        
	        // 서버에 새로운 부서 추가 요청
	        $.ajax({
	            url: "${contextPath}/organization/addDepartment.do",
	            type: "POST",
	            contentType: "application/json",
	            data: JSON.stringify({ codeName: newDepartmentName, registEmp: '등록자ID' }),
	            success: function(response) {
	                console.log("부서 추가 성공:", response);
	                alert("부서가 추가되었습니다.");
	            },
	            error: function(xhr, status, error) {
	                console.log("부서 추가 실패:", error);
	            }
	        });
	    }
		// 부서 삭제
		function deleteDepartment(button) {
			// 삭제할 부서 요소의 부모 노드(li) 찾기
		    let departmentItem = button.parentNode;
		    let departmentCode = $(button).siblings('a').find('input').val();
		    
		    // 서버에 부서 삭제 요청
		    $.ajax({
		        url: "${contextPath}/organization/deleteDepartment.do",
		        type: "POST",
		        data: { departmentCode: departmentCode },
		        success: function(response) {
		            console.log("부서 삭제 성공:", response);
		            departmentItem.parentNode.removeChild(departmentItem);
		            alert("부서가 삭제되었습니다.");
		        },
		        error: function(xhr, status, error) {
		            console.log("부서 삭제 실패:", error);
		            alert("부서에 소속된 직원이 있어 삭제할 수 없습니다.");
		        }
		    });
		    
		}
		
		// 팀 추가
        function addTeam(button) {
        	let newTeamName = "새로운 팀";
            let departmentCode = $(button).siblings('a').find('input').val();
            let newTeam = document.createElement("ul");
            newTeam.innerHTML = `
                <li>
                    <a href="#"><span class="level3"><input type="text" value="${newTeamName}"></span></a>
                    <button type="button" class="btn btn-danger delete_team" onclick="deleteTeam(this);">팀 삭제</button>
                </li>
            `;
            let departmentItem = button.parentNode.querySelector('ul');
            departmentItem.appendChild(newTeam);

            // 서버에 새로운 팀 추가 요청
            $.ajax({
                url: "${contextPath}/organization/addTeam.do",
                type: "POST",
                contentType: "application/json",
                data: JSON.stringify({ codeName: newTeamName, upperCode: departmentCode, registEmp: '등록자ID' }),
                success: function(response) {
                    console.log("팀 추가 성공:", response);
                    alert("팀이 추가되었습니다.");
                },
                error: function(xhr, status, error) {
                    console.log("팀 추가 실패:", error);
                }
            });
        }

		// 팀 삭제
		function deleteTeam(button) {
			let teamItem = button.parentElement;
		    let teamCode = $(button).siblings('a').find('input').val();

		    // 서버에 팀 삭제 요청
		    $.ajax({
		        url: "${contextPath}/organization/deleteTeam.do",
		        type: "POST",
		        data: { teamCode: teamCode },
		        success: function(response) {
		            console.log("팀 삭제 성공:", response);
		            teamItem.parentNode.removeChild(teamItem);
		            alert("팀이 삭제되었습니다.");
		        },
		        error: function(xhr, status, error) {
		            console.log("팀 삭제 실패:", error);
		            alert("팀에 소속된 직원이 있어 삭제할 수 없습니다.");
		        }
		    });
		}
		
		// 폼 되돌리기
		function resetForm() {
			// 새로고침으로 되돌리기
			location.reload();
		}
		
		// 폼 저장
		function saveForm() {
			// 부서 및 팀 데이터를 수집
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
		        departmentData.push({ departmentName: departmentName, teams: teamsData });
		    });

		    // 서버에 데이터 저장 요청
		    $.ajax({
		        type: "POST",
		        url: "${contextPath}/organization/saveDepartmentsAndTeams.do",
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