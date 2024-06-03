<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>조직 관리</title>

    <!-- 조직도 참고 사이트
       https://www.cssscript.com/clean-tree-diagram/
    -->

	<!-- css -->
	<link rel="stylesheet" href="${contextPath}/resources/css/organization/organization.css">
	
	
	<style>
	</style>
</head>
<body>

	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
        <h2>조직 관리</h2>
        <hr>
            
        <ul class="tree">
          <li>
            <span class="level1">대표이사</span>
            <button id="addDepartmentBtn" class="btn btn-success add_department">부서 추가</button>
            <ul id="departmentList">
                <c:set var="prevDept" value="" />
                <c:forEach var="d" items="${dept}">
                    <c:if test="${d.dept ne prevDept}">
                        <li>
                        	<input type="hidden" class="code" value="${d.code}">
                        	<button class="btn btn-danger delete_department" id="deleteTeamBtn">부서 삭제</button>
	                        <button class="btn btn-success add_team">팀 추가</button>
                            <span class="level2">${d.dept}</span>
                            <ul>
                                <c:forEach var="team" items="${dept}">
                                    <c:if test="${d.dept eq team.dept}">
                                        <ul>
                                            <c:if test="${not empty team.team}">
                                                <li>
                                                    <span class="level3">${team.team}</span>
                                                    <button class="btn btn-danger delete_team"">팀 삭제</button>
                                                </li>
                                            </c:if>
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
        $(document).ready(function() {
            var treeItems = $('.tree > li > ul > li').length;
            if (treeItems > 1) {
                $('.tree > li > ul').css('display', 'flex');
                $('.tree > li > ul').css('flex-wrap', 'wrap');
            }

            let userNo = ${ loginMember.userNo };
            
            // 부서 추가
            $('#addDepartmentBtn').click(function() {
                var deptName = prompt('부서명을 입력하세요:');
                console.log("deptName값 : ", deptName);
                if (deptName) {
                    $.ajax({
                        url: '${contextPath}/organization/insertDepartment.do',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({ 
                        	dept: deptName,
                        	userNo: userNo
                       	}),
                        success: function(response) {
                            console.log("통신 성공");
                            if (response) {
                                $('#departmentList').append(
                                    '<li><span class="level2">' + deptName + '</span><ul></ul></li>'
                                );
                            } else {
                                alert('부서 추가에 실패했습니다.');
                            }
                            location.reload();
                        }, 
                        error: function(xhr, status, error) {
                            console.log("통신 실패");
                        }
                    });
                }
            });
            
            // 팀 추가
            $(document).on('click', '.add_team', function() {
                var deptCode = $(this).siblings('.code').val();
                var teamName = prompt('팀명을 입력하세요:');
                console.log("teamName값 : ", teamName);
                if (teamName) {
                    $.ajax({
                        url: '${contextPath}/organization/insertTeam.do',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({ 
                        	deptCode: deptCode,
                            teamName: teamName,
                            userNo: userNo
                        }),
                        success: function(response) {
                            console.log("통신 성공");
                            if (response) {
                                $('button[data-dept="' + deptCode + '"]').siblings('ul').append(
                                    '<li><span class="level3">' + teamName + '</span></li>'
                                );
                            } else {
                                alert('팀 추가에 실패했습니다.');
                            }
                            location.reload();
                        }, 
                        error: function(xhr, status, error) {
                            console.log("통신 실패");
                        }
                    });
                }
            });
            
            
            // 팀 삭제
         // 팀 삭제
            $(document).on('click', '.delete_team', function() {
                var teamName = $(this).siblings('.level3').text();
                var deptCode = $(this).closest('li').parent().siblings('.code').val();
                console.log("삭제할 팀명: ", teamName);
                console.log("부서 코드: ", deptCode);

                if (confirm('정말로 이 팀을 삭제하시겠습니까?')) {
                    $.ajax({
                        url: '${contextPath}/organization/deleteTeam.do',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({ 
                            deptCode: deptCode,
                            teamName: teamName,
                            userNo: userNo
                        }),
                        success: function(response) {
                            console.log("팀 삭제 통신 성공");
                            if (response) {
                                location.reload(); // 페이지 새로고침
                            } else {
                                alert('팀 삭제에 실패했습니다.');
                            }
                        },
                        error: function(xhr, status, error) {
                            console.log("통신 실패");
                        }
                    });
                }
            });
            
            
        });
        </script>
        
        <!-- ------------ -->
    
    </div>
	<!-- 메인 영역 end-->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>