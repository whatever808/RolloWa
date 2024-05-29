<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>2.2 급여 조회 상세페이지</title>

	<!-- css -->
	<link rel="stylesheet" href="${contextPath}/resources/css/attendance/account.css">

	<style>
    .main_content{
    	width: 1200px !important;
        padding: 20px;
    }
    .profile_img{
    	width: 400px;
    }
    .inputFont{
    	font-size: 30px !important;
    	text-align: right;
    	width: 200px;
    }
    
    </style>
</head>
<body>

	<!-- 사이드바 해더 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
	    <h2>급여 조회 상세페이지</h2>
	    <hr>
	    
		<!-- ------------ -->

        <!-- 직원 정보 -->
        <table class="table table-responsive">
            <tr>
                <th colspan="4">
                    <c:choose>
		            	<c:when test="${ not empty m.profileURL }">
			                <img src="${ m.profileURL }" class="profile_img" onerror="this.onerror=null; this.src='${contextPath}/resources/images/defaultProfile.png';">
		            	</c:when>
		            	<c:otherwise>
			                <img src="${ contextPath }/resources/images/defaultProfile.png" class="profile_img">
		            	</c:otherwise>
		            </c:choose>
                </th>
            </tr>

            <tr>
                <td><h3>이름</h3></td>
                <td class="td_2"><h3>${ m.userName }</h3></td>
                
                <td><h3>아이디</h3></td>
                <td class="td_2"><h3>${ m.userId }</h3></td>
                
            </tr>

            <tr>
                <td><h3>부서명</h3></td>
                <td class="td_2"><h3>${ m.department }</h3></td>
                
                <td><h3>팀명</h3></td>
                <td class="td_2"><h3>${ m.team }</h3></td>
            </tr>
            
            <tr>
            	<td><h3>직급</h3></td>
                <td class="td_2"><h3>${ m.position }</h3></td>
                
                <td><h3>시급</h3></td>
                <td>
                    <h3><input type="text" value="${ m.salary }" id="salary" class="inputFont"></h3>
                </td>
            </tr>
        </table>


        <div class="btn_center">
            <button class="btn btn-outline-primary" type="button" onclick="location.href='${contextPath}/attendance/accountList.do'"><h5>뒤로가기</h5></button>
            <button class="btn btn-primary" onclick="accountSave();"><h5>저장</h5></button>
        </div>
        
        <script>
        function accountSave() {
        	let userNo = ${ m.userNo };
        	let salary = document.getElementById('salary').value;
			$.ajax({
				url:"${ contextPath }/attendance/accountDetailSave.do",
				type:"GET",
				data:{
					userNo: userNo
					, salary: salary 
				},
				success: function(data){	
					//console.log("통신 성공");
					alert("급여 수정을 하였습니다.")
				    
				}, error: function(){
					//console.log("통신 실패");
					alert("급여 수정에 실패하였습니다.")
				}
			})
		}
        </script>
		
	
		<!-- ------------ -->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>