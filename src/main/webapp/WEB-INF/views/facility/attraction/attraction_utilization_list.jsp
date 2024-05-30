<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>어트랙션 이용률</title>
	
	<!-- 어트랙션 이용률 스타일 -->
	<link href="${ contextPath }/resources/css/facility/attraction/attraction_utilization_list.css" rel="stylesheet">
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
		<!-- content 추가 -->
  	<div class="content p-5">
	  
	  <h1 class="page-title">어트랙션 이용률</h1>
		
		<!-- location select start -->
		<select class="location-select form-control py-2" style="width: 150px;">
			<option>전체</option>
			<option>언더우드</option>
			<option>언더우드</option>
			<option>지하나라</option>
		</select>
		<!-- location select end -->
		
		<!-- statics list div start -->
		<div class="statics-list-div">
			
			<!-- statics list start -->
			<table class="table text-center">
				<thead>
					<tr>
						<th>어트랙션</th>
						<th>연간 이용률</th>
						<th>월간 이용률</th>
						<th>일간 이용률</th>
					</tr>
				<thead>
				
				<tbody>
					<tr>
						<td>원더랜드</td>
						<td>20.00%</td>
						<td>20.00%</td>
						<td>30.00%</td>
					</tr>
				</tbody>
			</table>
			
			<!-- statics list end -->
			
		</div>
    <!-- statics list div end -->
  
  </div>
  <!-- content 끝 -->
	
	<!-- chat floating -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />

</body>

<!-- 어트랙션 이용률 스크립트 -->
<script>
	var today = new Date();
	var sysYear = today.getFullYear();
	var sysMonth = today.getMonth() + 1;
	var sysDate = today.getDate();
	$(document).ready(function(){
		// "년", "월", "일" 옵션값 생성 ==============================================================
		for(let y=sysYear ; y>=2000 ; y--){
			$("#year-select").append("<option value='" + y + "'>" + y + "년</option>");
		}
		for(let m=1 ; m<=sysMonth ; m++){
			$("#month-select").append("<option value='" + m + "'>" + m + "월</option>");
		}
		for(let d=1 ; d<=sysDate ; d++){
			$("#date-select").append("<option value='" + d + "'>" + d + "일</option>");
		}
		
		// 오늘날짜로 선택값 초기화 ====================================================================
		$("#year-select").children("option").each(function(){
			$(this).val() == sysYear && $(this).attr("selected", true);
		});
		$("#month-select").children("option").each(function(){
			$(this).val() == sysMonth && $(this).attr("selected", true);
		});
		$("#date-select").children("option").each(function(){
			$(this).val() == sysDate && $(this).attr("selected", true);
		});
		
		// "년" 선택값이 바뀌었을 경우 ==================================================================
		$("#year-select").on("change", function(){
			let month = ($(this).val() == sysYear) ? sysMonth : 12;
			let oldMonth = $("#month-select").val();
			
			$("#month-select").empty();
			
			for(let m=1 ; m<=month ; m++){
				$("#month-select").append("<option value='" + m + "'>" + m + "월</option>");
			}
			
			$("#month-select").children("option").each(function(){
				$(this).val() == oldMonth && $(this).attr("selected", true);
			});
			
		});
		
		// "월" 선택값이 바뀌었을 경우 ==================================================================
		$(document).on("change", "#year-select, #month-select", function(){
			let year = (sysYear - $("#year-select").val() <= 0) ? sysYear :  (sysYear - (sysYear - $("#year-select").val()));
			let month = $("#month-select").val();
			let oldDate = $("#date-select").val();
			let lastDate = (new Date(year, month, 0)).getDate();
			if(year == sysYear && month == sysMonth){
				lastDate = sysDate;
			}
			
			$("#date-select").empty();
			
			for(let d=1 ; d<=lastDate ; d++){
				$("#date-select").append("<option value='" + d + "'>" + d + "일</option>");
			}
			
			$("#date-select").children("option").each(function(){
				$(this).val() == oldDate && $(this).attr("selected", true);
			})
		});
		
		
	});
</script>

</html>