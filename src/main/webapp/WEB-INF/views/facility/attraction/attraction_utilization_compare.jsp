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
			
			// 차트 옵션값 지정
			mOptions = {
		    title: '월별 이용률',
		    legend: {
		    	position: 'bottom',
		    	maxLines: 3,
		    },
		    chartArea: {
			  width: '75%',
			  height: '75%',
			},
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
		    legend: {
		    	position: 'bottom',
		    	maxLines: 3,
		    },
		    chartArea: {
					width: '75%',
					height: '75%',
				},
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
			
			$("#compareList").children('input[name=attractionNo]').each(function(){
				ajaxSelectAttractionUtilization('year', $(this).val(), $(this).next().val());
				ajaxSelectAttractionUtilization('month',  $(this).val(), $(this).next().val());	
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
  			<h1 class="page-title">이용률 비교</h1>
  			<a href="${ contextPath }/attraction/utilization.do" class="go-list" id="back-to-list">목록가기</a>
  			
  			<!-- parameter for list page -->
  			<form method="post" id="compareList" class="d-none">
  				<c:forEach var="attraction" items="${ sessionScope.attractionCompareList }">
						<input type="hidden" name="attractionNo" value="${ attraction.attractionNo }">
						<input type="hidden" name="attractionName" value="${ attraction.attractionName }">
					</c:forEach>
  			</form>
  			
  		</div>
  		
  		<!-- about compare items start -->
  		<div class="d-flex justify-content-between align-items-center mt-4">
  			<!-- selected attraction name list start -->
	  		<div class="selected-attraction-list">
	  			<c:forEach var="attraction" items="${ sessionScope.attractionCompareList }">
	  				<div class="selected-attraction d-inline-block">
	  					<input type="hidden" name="attractionNo" value="${ attraction.attractionNo }">
	  					<label class="me-2">${ attraction.attractionName }</label>
	  					<label type="button" class="selected-attraction-remove">✖️</label>
	  				</div>
	  			</c:forEach>
	  		</div>
	  		<!-- selected attraction name list end -->
  			
  			<!-- button for modal -->
  			<button type="button" id="addItemsBtn" class="btn" data-bs-toggle="modal" data-bs-target="#attractionListModal">
				  ➕ 추가
				</button>
				
  			<!-- 비교대상 추가 modal start -->
				<div class="modal fade" id="attractionListModal" tabindex="-1" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header" style="background-color: #ffdd7391">
				        <h5 class="modal-title" id="exampleModalLabel">어트랙션 리스트</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
				      </div>
				      <div class="modal-body" id="attraction-list"></div>
				    </div>
				  </div>
				</div>
				<!-- 비교대상 추가 modal end -->
				
  		</div>
  		<!-- about compare items end -->
  		
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
			
			$("#compareList").children('input[name=attractionNo]').each(function(){
				ajaxSelectAttractionUtilization('year', $(this).val(), $(this).next().val());
				ajaxSelectAttractionUtilization('month',  $(this).val(), $(this).next().val());	
			});
			
		});
		
		// "월" 선택값이 바뀌었을 경우 ==================================================================
		$(document).on("change", "#month-select", function(){
			$("#compareList").children('input[name=attractionNo]').each(function(){
				ajaxSelectAttractionUtilization('month', $(this).val(), $(this).next().val());
			});
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
				console.log(type, " chartData : ", data);
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
		// 기존의 데이터가 없을 경우에 추가될 컬럼 및 행
		if(dataTable.getNumberOfColumns() == 0 || dataTable.getNumberOfRows() != data.length){
			dataTable.removeColumns(0, dataTable.getNumberOfColumns());
			dataTable.removeRows(0, dataTable.getNumberOfRows());
			dataTable.addColumn('string', '기간');
			for(let i=0 ; i<data.length ; i++){
				dataTable.addRow([data[i].L]);
			}
		}
		
		// 새로 생성할 데이터 컬럼 추가
		dataTable.addColumn('number', attractionName + '이용률');
		for(let i=0 ; i<data.length ; i++){
			let rowIndex = data[i].L - 1;
			let colIndex = dataTable.getNumberOfColumns() - 1;
			dataTable.setCell(rowIndex, colIndex, data[i].usage);
		}
		
		// 차트 그리기
		chart.draw(dataTable, options);
	}
	
	// 비교 어트랙션 추가, 제거 관련 ====================================================================================
	$(document).ready(function(){
		ajaxSelectAttractionList();
 				
		// 모달에서 비교 어트랙션 추가, 취소 버튼 클릭시
		$(document).on("click", ".modal-add-btn", function(){
			let $this = $(this);
			let $compareList = $("#compareList");
			let $selectedAttractionList = $(".selected-attraction-list");
			let itemCount = $compareList.children("[name=attractionNo]").length;
			let $attractionNo = $(this).data("attractionno");
			let $attractionName = $(this).prev().text();
		
			if($(this).text() == '➕'){
				if(itemCount >= 5){
 						redAlert('최대 5개의 어트랙션만 비교 가능합니다.', '');
 					}else{
  					$.ajax({// 세션의 비교목록에서 해당 어트랙션 추가
							url: "${ contextPath }/attraction/utilization/compare/insert.do",
							method: "get",
							async: false,
							data:{
								attractionNo: $attractionNo,
								attractionName: $attractionName,
							},
							success:function(){
								$compareList.append("<input type='hidden' name='attractionNo' value='" + $attractionNo + "'>");
								$compareList.append("<input type='hidden' name='attractionName' value='" + $attractionName + "'>");
								
								$this.css("background-color", "#FFA7A7").text("✖️");
								
								let str  = "<div class='selected-attraction d-inline-block'>";
									str +=		"<input type='hidden' name='attractionNo' value='" + $attractionNo + "'>";
									str += 		"<label class='me-2'>" + $attractionName + "</label>";
									str += 		"<label type='button' class='selected-attraction-remove'>✖️</label>"; 
								    str += "</div>";
									$selectedAttractionList.append(str);
								
								
								ajaxSelectAttractionUtilization('year', $attractionNo, $attractionName);
								ajaxSelectAttractionUtilization('month',  $attractionNo, $attractionName);	
								
								/*
								drawDefaultChart();
								$("#compareList").children('input[name=attractionNo]').each(function(){
									ajaxSelectAttractionUtilization('year', $(this).val(), $(this).next().val());
									ajaxSelectAttractionUtilization('month',  $(this).val(), $(this).next().val());	
								});
								*/
							},error:function(){
								console.log("INSERT ATTRACTION TO COMPARE LIST AJAX FAILED");
							}
						});
 					}
			}else{
				if(itemCount == 1){
					redAlert('최소 1개 이상의 비교값이 존재해야합니다.', '');
				}else{
					$.ajax({// 세션의 비교목록에서 해당 어트랙션 삭제
							url: "${ contextPath }/attraction/utilization/compare/delete.do",
							method: "get",
							data:{attractionNo: $attractionNo},
							async: false,
							success:function(){
								$compareList.children("[value='" + $attractionNo + "']").remove();
								$compareList.children("[value='" + $attractionName + "']").remove();
								
								$this.css('background-color', 'white').text('➕');
								
								$selectedAttractionList.find('[name=attractionNo]').each(function(){
								$(this).val() == $attractionNo && $(this).parent().remove();
								
								let colIdx = mDataTable.getColumnIndex($attractionName + '이용률');
								mDataTable.removeColumn(colIdx);
								mChart.draw(mDataTable, mOptions);
								dDataTable.removeColumn(colIdx);
								dChart.draw(dDataTable, dOptions);
								
								/*
								drawDefaultChart();
								$("#compareList").children('input[name=attractionNo]').each(function(){
									ajaxSelectAttractionUtilization('year', $(this).val(), $(this).next().val());
									ajaxSelectAttractionUtilization('month',  $(this).val(), $(this).next().val());	
								});
								*/
							});
							},error:function(){
								console.log("DELETE ATTRACTION FROM COMPARE LIST AJAX FAILED");
							}
						});
				}
			}
		});
	});
 			
	// 어트랙션 리스트 조회 AJAX
	function ajaxSelectAttractionList(){
		$.ajax({
				url: "${ contextPath }/attraction/utilization/attraction/list.ajax",
				method: "get",
				async: false,
				success: function(attractionList){
					let list = "";
					if(attractionList.length == 0){
						list += "<div class='d-flex justify-content-center align-items-center'>비교가능한 어트랙션이 없습니다.</div>";
					}else{
						for(let i=0 ; i<attractionList.length ; i++){
							list += "<div class='d-flex justify-content-between align-items-center mb-2'>";
							list += 	"<span class='fw-bold'>" + attractionList[i].attractionName + "</span>";
							list += 	"<span class='btn modal-add-btn' data-attractionno='" + attractionList[i].attractionNo + "'>➕</span>";
							list += "</div>";
						}
						
						$("#attraction-list").html(list);
						
						$("#attraction-list").find(".modal-add-btn").each(function(){
							let $span = $(this);
							let $attractionNo = $(this).data("attractionno");
						$("#compareList").children("[name=attractionNo]").each(function(){
								$(this).val() == $attractionNo && $span.css("backgroundColor", "#FFA7A7").text("✖️");
							});
						});
					}
				},error: function(){
					console.log("SELECT ATTRACTION LIST FOR COMPARE AJAX FAILED");
				}
			});
 		}
	
	// 비교 목록에서 어트랙션 삭제
	$(document).ready(function(){
		$(document).on("click", ".selected-attraction-remove", function(event){
			let $this = $(this);
			let $compareList = $("#compareList");
			let $attractionNo = $(this).siblings("[name=attractionNo]").val();
			let $attractionName = $(this).prev().text();
			
			if($compareList.children().length / 2 == 1){
				redAlert('최소 1개 이상의 비교값이 존재해야합니다.', '');
			}else{
				$.ajax({// 세션의 비교목록에서 해당 어트랙션 삭제
					url: "${ contextPath }/attraction/utilization/compare/delete.do",
					method: "get",
					data:{attractionNo: $attractionNo},
					async: false,
					success:function(){
						$compareList.children("[value='" + $attractionNo + "']").remove();
						$compareList.children("[value='" + $attractionName + "']").remove();
						
						$this.parent().remove();
						
						ajaxSelectAttractionList();
						
						let colIdx = mDataTable.getColumnIndex($attractionName + '이용률');
						mDataTable.removeColumn(colIdx);
						mChart.draw(mDataTable, mOptions);
						dDataTable.removeColumn(colIdx);
						dChart.draw(dDataTable, dOptions);
						/*
						drawDefaultChart();
						$("#compareList").children('input[name=attractionNo]').each(function(){
							ajaxSelectAttractionUtilization('year', $(this).val(), $(this).next().val());
							ajaxSelectAttractionUtilization('month',  $(this).val(), $(this).next().val());	
						});
						*/
					},error:function(){
						console.log("DELETE ATTRACTION FROM COMPARE LIST AJAX FAILED");
					}
				});
			} 					
		});
	});
</script>

</html>