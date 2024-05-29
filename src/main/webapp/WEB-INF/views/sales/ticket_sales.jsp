<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>이용권 매출관리</title>
	
	<!-- 이용권 매출관리 스타일 -->
	<link href="${ contextPath }/resources/css/sales/ticket_sales.css" rel="stylesheet">

	<!-- Google Chart API -->
	<script src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
	<!-- content 추가 -->
    <div class="content p-5">

        <!-- management page start -->
        <div class="sales-management-page">

            <div class="d-flex justify-content-between">
            	<h1 class="page-title">이용권 매출관리</h1>
            	<span class="mt-4 me-5">매출액 단위 : (원)</span>
            </div>

            <!-- main top start(filter) -->
            <div class="main-top">

                <!-- year filter area start -->
                <div class="filter-div year-filter-div">

                    <!-- year select -->
                    <select class="filter-select form-control py-2 fw-bold" id="year-select"></select> 

                    <!-- year sales info -->
                    <div class="filter-table year-sales-table">
                       
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">총 매출액</b>
                            <span class="filter-table-content sum-sales">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">평균 매출액</b>
                            <span class="filter-table-content avg-sales">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">최고 매출액</b>
                            <span class="filter-table-content max-sales">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">최저 매출액</b>
                            <span class="filter-table-content min-sales">2000</span>
                        </div>
                        
                    </div>

                </div>
                <!-- year filter area end -->

                <!-- month filter area start -->
                <div class="filter-div year-filter-div">

                    <!-- month select -->
                    <select class="filter-select form-control py-2 fw-bold" id="month-select"></select> 

                    <!-- month sales info -->
                    <div class="filter-table month-sales-table">
                        
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">총 매출액</b>
                            <span class="filter-table-content sum-sales">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">평균 매출액</b>
                            <span class="filter-table-content avg-sales">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">최고 매출액</b>
                            <span class="filter-table-content max-sales">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">최저 매출액</b>
                            <span class="filter-table-content min-sales">2000</span>
                        </div>
                        
                    </div>

                </div>
                <!-- month filter area end -->

                <!-- date filter area start -->
                <div class="filter-div day-filter-div">

                    <!-- date select -->
                    <select class="filter-select form-control py-2 fw-bold" id="date-select"></select> 

                    <!-- date sales info -->
                    <div class="filter-table date-sales-table">
                        
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">총 매출액</b>
                            <span class="filter-table-content sum-sales">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">평균 매출액</b>
                            <span class="filter-table-content avg-sales">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">최고 매출액</b>
                            <span class="filter-table-content max-sales">2000</span>
                        </div>
                        <div class="d-flex mb-2 justify-content-between">
                            <b class="filter-table-title">최저 매출액</b>
                            <span class="filter-table-content min-sales">2000</span>
                        </div>
                        
                    </div>

                </div>
                <!-- date filter area end -->

            </div>
            <!-- main top end(filter) -->

            <!-- main bottom start (chart) -->
            <div class="main-bottom">
            	
                <div class="chart-left h-5 w-5" id="sales-chart-div" style="border: 1px solid tomato; width: 800px; height: 500px;">

                </div>

                <div class="chart-right h-5 w-5" style="border: 1px solid tomato; height: 100px;">

                </div>
                    

            </div>
            <!-- main bottom end (chart) -->
        
        </div>
        <!-- mangement page end -->
    
    </div>
    <!-- content 끝 -->
	
	<!-- chat floating -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
	
</body>

<!-- 이용권 매출관리 스크립트 -->
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
			
			ajaxSelectTicketSalesByTicketType({	// 년도별 매출 데이터 조회
				year: $("#year-select").val(),
				month: '',
				date: '',
			}, $(".year-sales-table"));	
			
			ajaxSelectTicketSalesByTicketType({	// 월별 매출 데이터 조회
				year: $("#year-select").val(),
				month: $("#month-select").val(),
				date: '',
			}, $(".month-sales-table"));
			
			ajaxSelectTicketSalesByTicketType({	// 일별 매출 데이터 조회
				year: $("#year-select").val(),
				month: $("#month-select").val(),
				date:  $("#date-select").val(),
			}, $(".date-sales-table"));	
			
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
			
			ajaxSelectTicketSalesByTicketType({	// 월별 매출 데이터 조회
				year: $("#year-select").val(),
				month: $("#month-select").val(),
				date:  '',
			}, $(".month-sales-table"));	
			
			ajaxSelectTicketSalesByTicketType({	// 일별 매출 데이터 조회
				year: $("#year-select").val(),
				month: $("#month-select").val(),
				date:  $("#date-select").val(),
			}, $(".date-sales-table"));
		});
		
		// "일" 선택값이 바뀌었을 경우
		$("#date-select").on("change", function(){
			ajaxSelectTicketSalesByTicketType({	// 일별 매출 데이터 조회
				year: $("#year-select").val(),
				month: $("#month-select").val(),
				date:  $("#date-select").val(),
			}, $(".date-sales-table"));	
		});
	});
	
	// 이용권 매출정보 관련 ===============================================================================================
	$(document).ready(function(){
		ajaxSelectTicketSalesByTicketType({	// 년도별 매출 데이터 조회
			year: $("#year-select").val(),
			month: '',
			date: '',
		}, $(".year-sales-table"));	
		
		ajaxSelectTicketSalesByTicketType({	// 월별 매출 데이터 조회
			year: $("#year-select").val(),
			month: $("#month-select").val(),
			date: '',
		}, $(".month-sales-table"));
		
		ajaxSelectTicketSalesByTicketType({	// 일별 매출 데이터 조회
			year: $("#year-select").val(),
			month: $("#month-select").val(),
			date:  $("#date-select").val(),
		}, $(".date-sales-table"));	
	});
	
	// 년, 월, 일별 이용권 매출정보 조회 AJAX
	function ajaxSelectTicketSalesByTicketType(params, table){
		$.ajax({
			url: "${ contextPath }/sales/ticket/table.ajax",
			method: "get",
			data: params,
			success: function(salesList){
				let sumSales = 0;
				let avgSales = 0;
				let maxSales = 0;
				let minSales = 0;
				
				for(let i=0 ; i<salesList.length ; i++){
					sumSales += salesList[i].sumSales;
					avgSales += salesList[i].avgSales;
					maxSales += salesList[i].maxSales;
					minSales += salesList[i].minSales;
				}
			
				table.find('.sum-sales').text(sumSales.toLocaleString());
				table.find('.avg-sales').text(Number(avgSales.toFixed(2)).toLocaleString());
				table.find('.max-sales').text(maxSales.toLocaleString());
				table.find('.min-sales').text(minSales.toLocaleString());
			},error: function(){
				console.log("SELECT TICKET SALES FOR TABLE AJAX FAILED");
			}
		});
	}
	
	// 차트 관련 ==================================================================================================
	$(document).ready(function(){
		drawChart();
	});
	
	// 매출금액별 차트
	function drawChart(){
		google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawChart);

		function drawChart(){
			// 매출 데이터
			let chartData = ajaxSelectSalesListForChart({	
				year: $("#year-select").val(),
				chart: 'year',
			});
			
			console.log("chart : ", chartData.length);
			console.log("chart : ", chartData);
			
			// 차트 데이터 설정 (컬럼명, 셀값)
			let data = new google.visualization.DataTable();
			data.addColumn('string', '기간');
			data.addColumn('number', '일반이용권 총매출');
			data.addColumn('number', '정기이용권 총매출');
			data.addColumn('number', '일반이용권 평균매출');
			data.addColumn('number', '정기이용권 평균매출');
			for(let i=0 ; i<chartData.length ; i+=2){
				nSales = chartData[i];
				sSales = chartData[i+1];
				data.addRow([nSales.period, nSales.sumSales, sSales.sumSales, nSales.avgSales, sSales.avgSales]);
			}
			
			// 차트 옵션 설정 (제목, 범례 등)
			let options = {
					title : '이용권별 매출',
					vAxis: {title: '매출액 (단위 : 원)'},
					hAxis: {title: '기간'},
					seriesType: 'bars',
					series: {
						2: {type: 'line'},
						3: {type: 'line'},
					
					}
			};
			
			// 차트 그리기
			let chart = new google.visualization.ComboChart(document.getElementById('sales-chart-div'));
			chart.draw(data, options);
		}
	}
	
	// 월|일 이용권별 총매출액, 평균매출액 조회 AJAX (차트)
	function ajaxSelectSalesListForChart(params){
		let chartData = [];
		$.ajax({
			url: "${ contextPath }/sales/ticket/chart.ajax",
			method: "get",
			data: params,
			async: false,
			success: function(salesList){
				for(let i=0 ; i<salesList.length ; i++){
					chartData.push(salesList[i]);
				}
			},error: function(){
				console.log("SELECT TICKET SALES FOR CHART AJAX FAILED");
			}
		});
		
		return chartData;
	}
	
	
</script>

</html>