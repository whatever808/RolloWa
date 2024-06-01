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
	.fc-day-sat .fc-col-header-cell-cushion,
	.fc-day-sat .fc-daygrid-day-number
	{color: #007bff !important;}
	.fc-day-sun .fc-col-header-cell-cushion,
	 .fc-day-sun .fc-daygrid-day-number
	{color: #dc3545 !important;}
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
	.fc-direction-ltr{
		text-align: center;
	}
	.fc .fc-daygrid-day.fc-day-today{
		background-color: rgb(0 0 0) !important;
		border-radius: 10px !important;
	}
	.fc .fc-timegrid-col.fc-day-today{
		background-color: rgb(0 0 0) !important;
		border-radius: 5px !important;
	}
	.fc-scroller.fc-scroller-liquid-absolute{
    overflow: hidden;
	}
	.fc-theme-standard td, .fc-theme-standard th,
	table.fc-scrollgrid.fc-scrollgrid-liquid, td{
		border: 0px; 
	}
 	.fc-daygrid-day-frame.fc-scrollgrid-sync-inner{
		background-color: #fff !important;
    padding: 1px;
    background-clip: content-box;
    border-radius: 15px !important;
	}
	td.fc-day.fc-timegrid-col{
		background-color: #fff !important;
    padding: 1px;
    background-clip: content-box;
	}
	.fc .fc-multimonth-singlecol .fc-multimonth-daygrid-table, .fc .fc-multimonth-singlecol .fc-multimonth-header-table{
	  background: #f7efc9 !important;
	}
	.fc .fc-multimonth-title{
		background: #f7efc9 !important;
	}
	.fc .fc-toolbar-title{
    font-size: 1.5em !important;
	}
	.fc-daygrid-dot-event{
    /* display: inline-flex; */
    display: grid;
   	justify-items: center;
	}
 	.fc-daygrid-event-dot{
    height: -webkit-fill-available;
    width: 60%;
    position: absolute;
    padding: 10px;
    border-radius: 50px;
	} 
	.fc-daygrid-block-event{
		border-radius: 50px;
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
				headerToolbar:{start: 'title',center: '',end: ''
			    },
				views:{ month:{titleFormat:{year: '2-digit', month: 'short'} },
				},
				buttonIcons: false,
				slotMinTime: "06:00:00",
				timeZone: 'Asia/Seoul',
			});
		});					
	}
	declareCalendar();

	function addEvent(){
	  $.ajax({
			url:'${path}/mainCalendar.ajax',
			type:'post',
		  contentType: 'application/json',
			success:function(map){
				const depart =  map.depart;
				const company =  map.company;
	
				let arr = [];
				arr.push(depart);
				arr.push(company);
				console.log("arr",arr);
				
				for(let list of arr) {
					list.forEach((e) => {
						 calendar.addEventSource(
						 [{
								  id:						e.calNO,
									title:				e.group.upperCode +' '+' '+' '+  e.group.codeName,
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