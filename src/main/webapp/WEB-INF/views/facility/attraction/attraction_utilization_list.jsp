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
		
		<!-- select filter div start -->
		<div class="select-filter-div">
			<select class="form-control form-select" id="location-select">
				<option value="">전체</option>
				<c:forEach var="location" items="${ locationList }">
					<option value="${ location.locationNo }">${ location.locationName }</option>
				</c:forEach>
			</select>
		
			<select class="form-control form-select" id="year-select"></select>
			
			<select class="form-control forms-select" id="month-select"></select>
			
			<select class="form-control form-select" id="date-select"></select>
		</div>
		<!-- select filter div end -->

		<!-- statics list div start -->
		<div class="statics-list-div">
		
			<!-- statics list start -->
			<table class="table table-hover text-center">
				<thead>
					<tr>
						<th>어트랙션</th>
						<th>연간 이용률</th>
						<th>월간 이용률</th>
						<th>일간 이용률</th>
					</tr>
				<thead>
				
				<tbody id="utilization-list"></tbody>
				
			</table>
			<!-- statics list end -->
			
			</div>
    	<!-- statics list div end -->
    	
    	<nav class="d-flex justify-content-center">
			  <ul class="pagination"></ul>
			</nav>
  
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
			$("#month-select").append("<option value='" + ((m < 10) ? '0' + m : m ) + "'>" + m + "월</option>");
		}
		for(let d=1 ; d<=sysDate ; d++){
			$("#date-select").append("<option value='" + ((d < 10) ? '0' + d : d ) + "'>" + d + "일</option>");
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
				$("#month-select").append("<option value='" + ((m < 10) ? '0' + m : m ) + "'>" + m + "월</option>");
			}
			
			$("#month-select").children("option").each(function(){
				$(this).val() == oldMonth && $(this).attr("selected", true);
			});
			
			ajaxSelectAttractionUtilizationList();	// 이용률 리스트 조회
			
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
				$("#date-select").append("<option value='" + ((d < 10) ? '0' + d : d ) + "'>" + d + "일</option>");
			}
			
			$("#date-select").children("option").each(function(){
				$(this).val() == oldDate && $(this).attr("selected", true);
			});
			
			ajaxSelectAttractionUtilizationList();	// 이용률 리스트 조회
			
		});
		
		// "일" 선택값이 바뀌었을 경우 ===================================================================================
		$("#date-select").on("change", function(){
			ajaxSelectAttractionUtilizationList();	// 이용률 리스트 조회
		});
		
	});
	
	// 어트랙션 이용률 조회 관련 ============================================================================
	$(document).ready(function(){
		ajaxSelectAttractionUtilizationList();
		
		$("#location-select").on("change", function(){
			ajaxSelectAttractionUtilizationList();
		});
	});
	
	// 전체 어트랙션 연간, 월간, 일간 이용율 리스트 조회 AJAX
	function ajaxSelectAttractionUtilizationList(pageNo){
		let page = (pageNo == undefined) ? 1 : pageNo;
		let $location = $("#location-select").val();
		let $year = $("#year-select").val();
		let $month = $("#month-select").val();
		let $date = $("#date-select").val();
		
		$.ajax({
			url: "${ contextPath }/attraction/utilization/list.ajax",
			method: "get",
			data: {
				page: page,
				location: $location,
				year: $year,
				month: $month,
				date: $date,
			},
			success:function(response){
				let list = response.usageList;
				let pageInfo = response.pageInfo;
				let listStr = "";
				let pageStr = "";
				
				if(list.length == 0){
					listStr += "<tr>";
					listStr += 	"<td colspan='4'>조회된 내역이 없습니다.</td>";
					listStr += "</tr>";
				}else{
					for(let i=0 ; i<list.length ; i++){
						listStr += "<tr onclick='atrtUsageChart(" + list[i].attractionNo + ");'>";
						listStr += 	"<td class='td1'>" + list[i].attractionName + "</td>";
						listStr += 	"<td class='td2'>" + list[i].yearUsage + "%</td>";
						listStr += 	"<td class='td3'>" + list[i].monthUsage + "%</td>";
						listStr +=	"<td class='td4'>" + list[i].dailyUsage + "%</td>";
						listStr += "<tr>";
					}
					
					pageStr += "<li class='page-item " + (pageInfo.currentPage == 1 ? 'disabled' : '') + "'" + (pageInfo.currentPage != 1 ? "onclick='ajaxSelectAttractionUtilizationList(" + (pageInfo.currentPage - 1) + ");'" : "") + ">";
					pageStr += 		"<span class='page-link'>" + "◁" + "</span>";
					pageStr += "</li>";
					
					for(let p=pageInfo.startPage ; p<=pageInfo.endPage ; p++){
						pageStr += "<li class='page-item " + (pageInfo.currentPage == p ? 'disabled' : '') + "' onclick='ajaxSelectAttractionUtilizationList(" + p + ");'>";
						pageStr +=		"<span class='page-link'>" + p + "</span>";
						pageStr += "</li>";
					}
					
					pageStr += "<li class='page-item " + (pageInfo.currentPage == pageInfo.maxPage ? 'disabled' : '') + "'" + (pageInfo.currentPage != pageInfo.maxPage ? "onclick='ajaxSelectAttractionUtilizationList(" + (pageInfo.currentPage + 1) + ");'" : "") + ">";
					pageStr += 		"<span class='page-link'>" + "▷" + "</span>";
					pageStr += "</li>";
				}
				
				$("#utilization-list").html(listStr);
				console.log(pageStr);
				$(".pagination").html(pageStr);
				
			},error:function(){
				console.log("ATTRACTION UTILIZATION LIST AJAX FAILED");
			}
		});
	}
	
	// 지정 어트랙션 이용률 상세차트 페이지 이동
	function atrtUsageChart(attractionNo){
		let urlSearchParams = new URLSearchParams();
		urlSearchParams.append("no", attractionNo);
		urlSearchParams.append("year", $("#year-select").val());
		urlSearchParams.append("month", $("#month-select").val());

		location.href = "${ contextPath }/attraction/utilization/detail.page?" + urlSearchParams.toString();
	}
</script>

</html>
