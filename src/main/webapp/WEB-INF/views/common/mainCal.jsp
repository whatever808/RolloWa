<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
		/* 캘린더 스타일  */
	#calendar a {
		color: rgb(130, 130, 130);
		text-decoration-line: none;
	}
	.fc-button-primary {
		background-color: #000 !important;
		border: 0 !important;
		border-radius: 20px !important;
    color: #ffffff !important;
    font-weight: bolder !important;
	}
	.fc-day-sat a {color: #007bff !important;}
	.fc-day-sun a {color: #dc3545 !important;}
	.img_postion{
    position: absolute;
    font-weight: bolder;
    color: black;
    font-size: x-large;
    top: 0px;
	}
	.fc-event-time{
		display: none;
	}
	.fc-toolbar-title{
    padding: 5px !important;
    border-radius: 20px !important;
    background: black !important;
    color: #ffffff !important;
    width: 10em;
	}
	.fc-direction-ltr{
		text-align: center;
	}
	.fc .fc-daygrid-day.fc-day-today{
		background-color: rgb(160 160 160 / 30%) !important;
	}
	.fc .fc-timegrid-col.fc-day-today{
		background-color: rgb(160 160 160 / 30%) !important;
	}
	.fc-scroller.fc-scroller-liquid-absolute{
    overflow: hidden;
	}
	.fc-theme-standard td, .fc-theme-standard th,
	table.fc-scrollgrid.fc-scrollgrid-liquid, td{
		border: 0px; 
	}
 	.fc-daygrid-day-frame.fc-scrollgrid-sync-inner{
		background-color: rgb(200 200 200 / 20%) !important;
    padding: 1px;
    background-clip: content-box;
	}
	td.fc-day.fc-timegrid-col{
		background-color: rgb(200 200 200 / 20%) !important;
    padding: 1px;
    background-clip: content-box;
	}
</style>
</head>
<body>
	<script>
	let calendar;
	function declareCalendar(){
		document.addEventListener('DOMContentLoaded', function() {
			var calendarEl = document.getElementById('calendar');
			calendar = new FullCalendar.Calendar(calendarEl, {
				initialView: 'dayGridMonth',
				locale: 'ko',
				buttonText:{prev:'◁',next:'▷',today: '오늘',year:'연도',month:'월',week:'주'
				},
				headerToolbar:{start: 'prev today',
							   center: 'title',
							   end: 'multiMonthYear,dayGridMonth,timeGridWeek next'
			    },
				views:{year: {titleFormat:{year: '2-digit'}, multiMonthMaxColumns: 1},
				  	   month:{titleFormat:{year: '2-digit', month: 'short'} },
					   week: {titleFormat:{year: '2-digit'} },
					   day:  {titleFormat:{month: 'short', day:'2-digit'}}
				},
				buttonIcons: false,
				navLinks: true,
				slotMinTime: "06:00:00",
				timeZone: 'Asia/Seoul',
			});
		});					
	}
	/* 미리 선언 하지않으면 뒤에서 let calendar에서 undifieded로 변수가 설정 되어 버림 */
	declareCalendar();

	/* 이벤트를 불러들어 오는 부분 */
	function addEvent(){
	  $.ajax({
			url:'${path}/mainCalendar.ajax',
			type:'post',
		  contentType: 'application/json',
			success:function(map){
				console.log("map",map);
				const depart =  map.depart;
				console.log("depart",depart);
				const company =  map.company;
				console.log("company",company);
				
				let arr = [];
				arr.push(depart);
				arr.push(company);
				console.log("arr",arr);
				
				for(let list of arr) {
					list.forEach((e) => {
						 calendar.addEventSource(
						 [{
								  id:						e.calNO,
									title:				e.group.upperCode + e.group.codeName,
									start: 				e.startDate,
									end:					e.endDate,
									color: 				e.color,
									extendedProps:{
										content:  	e.calContent,
										caltitle: 	e.calTitle,
										place: 			e.place,
										calSort:  	e.calSort,
										groupCode: 	e.groupCode,
										cowoker:		e.coworker
										}		 
							 }]
						 );
					})
				}
				calendar.render();
			},
			error:function(){
				console.log('main calendar import error');
			}
	  })
	}

	$(document).ready(function(){
		addEvent(null);
	})
	</script>
</body>
</html>