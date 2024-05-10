<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>1.3 조직관리</title>

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
        width: 100%;
    }
    
    /* 조직관리 css */
	.table{
		text-align: center;
	}
	.table th{
	    background-color: lightgray !important;
	    vertical-align: middle !important;
	    font-size: 20px;
	}
	.table td{
	    vertical-align: middle !important;
	}
	.table td input{
	    width: 100%;
	}
	
	.button{
	     text-align: center;
	}


    </style>
</head>
<body>

	<!-- 사이드바 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
	    <h2>직원 검색</h2>
	    <hr>
	    
		<!-- ------------ -->
		
		
		<table id="table" class="table">
		    <tr>
		        <th>번호</th>
		        <th>부서명</th>
		        <th>팀명</th>
		        <th>
		            <button class="btn btn-success" onclick="addRow();">행 추가</button>
		        </th>
		    </tr>
		
			<c:forEach var="d" items="${ dept }" begin="0" end="${ dept.size() }" varStatus="status">
			    <tr>
			        <td>${ status.index+1 }</td>
				        <td>
				            <input type="text" value="${ d.dept }">
				        </td>
				        <td>
				            <input type="text" value="${ d.team }">
				        </td>
			        <td>
			            <button class="btn btn-danger">행 삭제</button>
			        </td>
			    </tr>
		    </c:forEach>
		</table>
		
		<!-- 저장 버튼 -->
		<div class="button">
		    <button class="btn btn-outline-secondary" type="reset">원래대로</button>
		    <button class="btn btn-primary">저장</button>
		</div>
	
		<!-- 행 추가 스크립트 작성중 -->
		<script>
			function addRow() {
				let table = document.getElementById('table');
			    let newRow = table.insertRow(table.rows.length);
				
				let newCell1 = newRow.insertCell(0);
				let newCell2 = newRow.insertCell(1);
				let newCell3 = newRow.insertCell(2);
				let newCell4 = newRow.insertCell(3);
				
				let input1 = document.createElement('span');
		        input1.innerText = '';
		        newCell1.appendChild(input1);

		        let input2 = document.createElement('input');
		        input2.setAttribute('type', 'text');
		        input2.setAttribute('value', '');
		        newCell2.appendChild(input2);

		        let input3 = document.createElement('input');
		        input3.setAttribute('type', 'text');
		        input3.setAttribute('value', '');
		        newCell3.appendChild(input3);
		        
		        let deleteButton = document.createElement('button');
		        deleteButton.innerText = '행 삭제';
		        deleteButton.className = 'btn btn-danger';
		        deleteButton.onclick = function() {
		            let row = this.parentNode.parentNode;
		            row.parentNode.removeChild(row);
		        };
		        newCell4.appendChild(deleteButton);
			}
		</script>
	
	
		<!-- ------------ -->
	
	</div>
	<!-- 메인 영역 end-->
		
</body>
</html>