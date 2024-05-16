<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
				buttonText:{prev:'이전',next:'다음',today: '오늘',year:'연도',month:'월',week:'주'
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