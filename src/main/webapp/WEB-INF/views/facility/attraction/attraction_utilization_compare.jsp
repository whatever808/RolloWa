<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>어트랙션 이용률 상세</title>
	
	<!-- 어트랙션 이용률 분석차트 스타일 -->
	<link href="${ contextPath }/resources/css/facility/attraction/attraction_utilization_compare.css" rel="stylesheet">
	<link href="https://fonts.googleapis.com/css2?family=Do+Hyeon&display=swap" rel="stylesheet">
	
	<!-- Google Chart Script -->
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
	<script>
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawDefaultChart);
		
		// 디폴트 차트 생성 함수
		function drawDefaultChart(){
			// 차트 데이터 테이블
			mDataTable = new google.visualization.DataTable();
			dDataTable = new google.visualization.DataTable();
			console.log("데이터 먼스 : ", mDataTable);
			console.log("데이타 데이 : ", dDataTable);
			
			// 차트 옵션값 지정
			mOptions = {
		      title: '월별 이용률',
		      colors: [''],
		      legend: 'none',
		      animation:{	
				startup:true,
				duration: 1000,
				easing: 'out',
			  },
			  vAxis: {
				title: '이용률 (단위 : %)',
				minValue: 0,
				maxValue: 100,
			  },
			  pointSize: 9,
			  curveType: 'function',
	        }
			
			dOptions = {
		      title: '일별 이용률',
		      colors: [''],
		      legend: 'none',
		      animation:{	
				startup:true,
				duration: 1000,
				easing: 'out',
			  },
			  vAxis: {
				title: '이용률 (단위 : %)',
				minValue: 0,
				maxValue: 100,
			  },
			  pointSize: 9,
			  curveType: '',
		    }
			
			mChart = new google.visualization.LineChart(document.getElementById('monthly-chart'));
			dChart = new google.visualization.LineChart(document.getElementById('daily-chart'));
			
			// monthlyChart.draw(monthlyData, monthlyOptions);
			// dailyChart.draw(dailyData, dailyOptions);
			
			$("input[name=attraction]").each(function(){
				ajaxSelectAttractionUtilization('year', $(this).data("attractionno"), $(this).data("attractionname"));
				ajaxSelectAttractionUtilization('month', $(this).data("attractionno"), $(this).data("attractionname"));
			});
		}		
	</script>

</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
		<!-- content 추가 start -->
  		<div class="content p-5">
  		
  		<div class='d-flex justify-content-between align-itmes-center'>
  			<div>
  				<h1 class="page-title">이용률 비교</h1>
  				
  			</div>
  		
  			<a href="${ contextPath }/attraction/utilization.do" class="go-list" id="back-to-list">목록가기</a>
  		</div>
  		
  		<!-- 비교할 어트랙션 번호 목록 -->
  		<div class="d-none">
  			<c:forEach var="attraction" items="${ attractionList }">
				<input type="hidden" name="attraction" data-attractionno="${ attraction.attractionNo }" data-attractionname="${ attraction.attractionName }">
  			</c:forEach>
  		</div>
  		<!-- 비교할 어트랙션 번호 목록 -->
  		
  		<div class="chart-list-div">
  			
  			<div class="chart-div">
  				<select class="select form-control form-select py-2 fw-bold" id="year-select"></select>
  			
	  			<!-- monthly chart start -->
	  			<div class="chart" id="monthly-chart"></div>
				<!-- monthly chart end -->
  			</div>
				
			<div class="chart-div">
				<select class="select form-control form-select py-2 fw-bold" id="month-select"></select>
			
			<!-- daily chart start -->
  			<div class="chart" id="daily-chart"></div>
  			<!-- daily chart end -->
			</div>
  			
  		</div>
  		
  	</div>
  	<!-- content 추가 end -->
	
	<!-- chat floating -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />

</body>

<!-- 어트랙션 이용률 상세 스크립트 -->
<script>
	var today = new Date();
	var sysYear = today.getFullYear();
	var sysMonth = today.getMonth() + 1;
	var sysDate = today.getDate();
	$(document).ready(function(){
		// "년", "월" 옵션값 생성 ==============================================================
		for(let y=sysYear ; y>=2000 ; y--){
			$("#year-select").append("<option value='" + y + "'>" + y + "년</option>");
		}
		
		for(let m=1 ; m<=sysMonth ; m++){
			$("#month-select").append("<option value='" + ((m < 10) ? '0' + m : m ) + "'>" + m + "월</option>");
		}
		for(let d=1 ; d<=sysDate ; d++){
			$("#date-select").append("<option value='" + ((d < 10) ? '0' + d : d ) + "'>" + d + "일</option>");
		}
		
		// 날짜 선택값 초기화 ====================================================================
		$("#year-select").children("option").each(function(){
			$(this).val() == ${ year } && $(this).attr("selected", true);
		});
		$("#month-select").children("option").each(function(){
			$(this).val() == ${ month } && $(this).attr("selected", true);
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
			
			// ajaxSelectAttractionUtilization('year');
			// ajaxSelectAttractionUtilization('month');
		});
		
		// "월" 선택값이 바뀌었을 경우 ==================================================================
		$(document).on("change", "#month-select", function(){
			// ajaxSelectAttractionUtilization('month');
		});	
	});
	
	// 차트 관련 =================================================================================
	// 차트 데이터 조회
	function ajaxSelectAttractionUtilization(type, attractionNo, attractionName){
		let $year = $("#year-select").val();
		let $month = $("#month-select").val();
		
		$.ajax({
			url: "${ contextPath }/attraction/utilization/detail.ajax",
			method: "get",
			async: false,
			data: {
				no: attractionNo,
				year: $year,
				month: (type == 'year') ? '' : $month,
			},
			success: function(data){
				console.log("chartData : ", data);
				if(type == 'year'){
					drawChart(attractionName, data, mDataTable, mOptions, mChart);
				}else{
					drawChart(attractionName, data, dDataTable, dOptions, dChart);
				}
			},error: function(){
				console.log("SELECT ATTRACTION UTILIZATION LIST TO COMPARE FAILED");
			}
		});
	}
	
	// 차트 그리기
	function drawChart(attractionName, data, dataTable, options, chart) {
		console.log("options : ", options.title);
		
		// 기존의 데이터가 없을 경우에 추가될 컬럼 및 행
		if(dataTable.getNumberOfColumns() == 0){
			dataTable.addColumn('string', '기간');
			for(let i=0 ; i<data.length ; i++){
				console.log(data[i].L);
				dataTable.addRow([data[i].L]);
			}
		}
		
		// 새로 생성할 데이터 컬럼 추가
		dataTable.addColumn('number', attractionName + '이용률');
		for(let i=0 ; i<data.length ; i++){
			console.log(data[i].usage);
			dataTable.addRow([data[i].usage]);
		}
		
		// 옵션 수정
		// 차트 그리기
		
		/* 차트 데이터 추가
		for(let i=0 ; i<chartData.length ; i++){
			data.addRow([chartData[i].L, chartData[i].usage]);
		}
			  
		  var chart = new google.visualization.LineChart(document.getElementById(areaId));
		  chart.draw(data, options);
		  */
	}
</script>

</html>