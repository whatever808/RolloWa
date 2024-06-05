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
	$(document).ready(function(){
		$("input[name=attraction]").each(function(){
			console.log("no : ", $(this).data("attractionno"), ", name : ", $(this).data("attractionname"));
			ajaxSelectAttractionUtilization('year', $(this).data("attractionno"), $(this).data("attractionname"));
			ajaxSelectAttractionUtilization('month', $(this).data("attractionno"), $(this).data("attractionname"));
		});
	});
	
	(function(){
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawDefaultChart);
		
		drawDefaultChart();
	}());
	
	// 디폴트 차트 생성 함수
	function drawDefaultChart(){
		// 차트 데이터 테이블
		monthlyData = new google.visualization.DataTable();
		dailyData = new google.visualization.DataTable();
		console.log("데이타 먼스 : ", monthlyData);
		console.log("데이타 데이 : ", dailyData);
		
		// 차트 컬럼
		monthlyData.addColumn('string', '기간');
		monthlyData.addColumn('number', '');
		
		dailyData.addColumn('string', '기간');
		dailyData.addColumn('number', '');
		
		// 디폴트 데이터
		monthlyData.addRow['', ''];
		dailyData.addRow['', ''];
		
		// 차트 옵션값 지정
		monthlyOptions = {
      title: '',
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
		
		dailyOptions = {
      title: '',
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
		
		monthlyChart = new google.visualization.LineChart(document.getElementById('monthly-chart'));
		dailyChart = new google.visualization.LineChart(document.getElementById('daily-chart'));
		
		monthlyChart.draw(monthlyData, monthlyOptions);
		dailyChart.draw(dailyData, dailyOptions);
	}
	
	// 차트 그리기
	function drawChart() {
		console.log("data month : ", monthlyData);
		console.log("data day : ", dailyData);
			/* 차트 데이터 추가
			for(let i=0 ; i<chartData.length ; i++){
				data.addRow([chartData[i].L, chartData[i].usage]);
		  }
			  
		  var chart = new google.visualization.LineChart(document.getElementById(areaId));
		  chart.draw(data, options);
		  */
		}
	
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
			success: function(chartData){
				console.log("chartData : ", chartData);
				if(type == 'year'){
					// drawUtilizationChart(attractionName, chartData, 'monthly-chart');	
					drawChart();
				}else{
					// drawUtilizationChart(attractionName, chartData, 'daily-chart');
					drawChart();
				}
			},error: function(){
				console.log("SELECT ATTRACTION UTILIZATION LIST TO COMPARE FAILED");
			}
		});
	}
	
	/* 차트 생성
	function drawUtilizationChart(attractionName, chartData, areaId){
			google.charts.load('current', {'packages':['corechart']});
		  google.charts.setOnLoadCallback(drawChart);
		  
		  function drawChart() {
			  let data = new google.visualization.DataTable();
				// 첫 그래프 생성시에만 컬럼 생성
				if(data.getNumberOfColumns() == 0){
					console.log("생성");
					data.addColumn('string', '기간');
					data.addColumn('number', attractionName + '이용률');
				}
				
				// 차트 데이터 추가
				for(let i=0 ; i<chartData.length ; i++){
					data.addRow([chartData[i].L, chartData[i].usage]);
			  }
					
		    var options = {
		      title: (areaId == 'monthly-chart') ? '${ attraction.attractionName } 월별 이용률'
		        								   							 : '${ attraction.attractionName } 일별 이용률',
		      colors: (areaId == 'monthly-chart') ? ['#FFA7A7'] : ['#FFDD73'],
		      legend: '',
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
		        curveType: areaId == 'monthly-chart' ? 'function' : '',
		    };
			      
			  var chart = new google.visualization.LineChart(document.getElementById(areaId));
			  chart.draw(data, options);
			}
	}
	 	
	$(document).ready(function(){
		ajaxSelectAttractionUtilization('year');
		ajaxSelectAttractionUtilization('month');
	});
	
	차트 데이터 조회
	function ajaxSelectAttractionUtilization(type){
		let $year = $("#year-select").val();
		let $month = $("#month-select").val();
		
		$.ajax({
			url: "${ contextPath }/attraction/utilization/detail.ajax",
			method: "get",
			data:{
				no: attractionNo,
				year: $year,
				month: (type == 'year') ? '' : $month,
			},
			success: function(chartData){
				if(type == 'year'){
					drawUtilizationChart(chartData, 'monthly-chart');	
				}else{
					drawUtilizationChart(chartData, 'daily-chart');					
				}
			}, error: function(){
				console.log("SELECT ATTRACTION UTILIZATION FOR CHART FAILED");
			}
		});
	}
	
	
	*/

</script>

</html>