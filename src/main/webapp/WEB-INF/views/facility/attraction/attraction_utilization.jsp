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
	<link href="${ contextPath }/resources/css/facility/attraction/attraction_utilization.css" rel="stylesheet">
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
	<!-- content 추가 -->
  <div class="content p-5">

      <!-- attraction usage page start -->
      <div class="attraction-usage-page">

          <h1 class="page-title">어트랙션 이용률</h1>

          <!-- main top start(filter) -->
          <div class="main-top">

              <!-- year filter area start -->
              <div class="filter-div year-filter-div">

                  <!-- year select -->
                  <select class="filter-select form-control py-2 fw-bold" id="year-select"></select>
                   
                  <!-- year utilizatin info -->
                  <div class="filter-table">
                      <div class="d-flex mb-2 justify-content-between">
                          <b class="filter-table-title">총 이용자수</b>
                          <span class="filter-table-content">2000</span>
                      </div>
                      <div class="d-flex mb-2 justify-content-between">
                          <b class="filter-table-title">평균 이용자수</b>
                          <span class="filter-table-content">2000</span>
                      </div>
                      <div class="d-flex mb-2 justify-content-between">
                          <b class="filter-table-title">최고 이용자수</b>
                          <span class="filter-table-content">2000</span>
                      </div>
                      <div class="d-flex mb-2 justify-content-between">
                          <b class="filter-table-title">최저 이용자수</b>
                          <span class="filter-table-content">2000</span>
                      </div>
                  </div>
                  
              </div>
              <!-- year filter area end -->

              <!-- month filter area start -->
              <div class="filter-div month-filter-div">
									
                  <!-- month select -->
                  <select class="filter-select form-control py-2 fw-bold" id="month-select"></select> 
                  
                  <!-- month utilization info -->
                  <div class="filter-table">
                      <div class="d-flex mb-2 justify-content-between">
                          <b class="filter-table-title">총 이용자수</b>
                          <span class="filter-table-content">2000</span>
                      </div>
                      <div class="d-flex mb-2 justify-content-between">
                          <b class="filter-table-title">평균 이용자수</b>
                          <span class="filter-table-content">2000</span>
                      </div>
                      <div class="d-flex mb-2 justify-content-between">
                          <b class="filter-table-title">최고 이용자수</b>
                          <span class="filter-table-content">2000</span>
                      </div>
                      <div class="d-flex mb-2 justify-content-between">
                          <b class="filter-table-title">최저 이용자수</b>
                          <span class="filter-table-content">2000</span>
                      </div>
                     
                  </div>

              </div>
              <!-- month filter area end -->

              <!-- date filter area start -->
              <div class="filter-div day-filter-div">

                  <!-- date select -->
                  <select class="filter-select form-control py-2 fw-bold" id="date-select"></select> 

                  <!-- date utilization info -->
                  <div class="filter-table">
                      <div class="d-flex mb-2 justify-content-between">
                          <b class="filter-table-title">총 이용자수</b>
                          <span class="filter-table-content">2000</span>
                      </div>
                      <div class="d-flex mb-2 justify-content-between">
                          <b class="filter-table-title">평균 이용자수</b>
                          <span class="filter-table-content">2000</span>
                      </div>
                      <div class="d-flex mb-2 justify-content-between">
                          <b class="filter-table-title">최고 이용자수</b>
                          <span class="filter-table-content">2000</span>
                      </div>
                      <div class="d-flex mb-2 justify-content-between">
                          <b class="filter-table-title">최저 이용자수</b>
                          <span class="filter-table-content">2000</span>
                      </div>
                      
                      
                  </div>

              </div>
              <!-- date filter area end -->

          </div>
          <!-- main top end(filter) -->

          <div class="chart-filter-div d-flex">
              <span class="chart-filter btn btn-secondary-outline fw-bold bg-warning text-white" style="font-size: 16px;">총 이용자수</span>
              <span class="chart-filter btn btn-secondary-outline fw-bold" style="font-size: 16px;">평균 이용자수</span>
          </div>

          <!-- main bottom start (chart) -->
          <div class="main-bottom">
              <div class="chart h-5 w-5" style="border: 1px solid tomato; height: 100px;">

              </div>
                  

          </div>
          <!-- main bottom end (chart) -->
      
      </div>
      <!-- attraction usage page end -->
  
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