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
            <button id="addDepartmentBtn" class="btn btn-success">부서 추가</button>
            <ul id="departmentList">
                <c:set var="prevDept" value="" />
                <c:forEach var="d" items="${dept}">
                    <c:if test="${d.dept ne prevDept}">
                        <li>
                            <span class="level2">${d.dept}</span>
                            <ul>
                                <c:forEach var="team" items="${dept}">
                                    <c:if test="${d.dept eq team.dept}">
                                        <ul>
                                            <c:if test="${not empty team.team}">
                                                <li>
                                                    <span class="level3">${team.team}</span>
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

            $('#addDepartmentBtn').click(function() {
                var deptName = prompt('부서명을 입력하세요:');
                console.log("deptName값 : ", deptName);
                if (deptName) {
                    $.ajax({
                        url: '${contextPath}/organization/insertDepartment.do',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({ 
                        	dept: deptName 
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