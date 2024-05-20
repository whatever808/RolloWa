<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사 일정</title>
<!-- fullcalendar -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<style>
	.out-line {
		min-height: 800px;
		width: 100%;
		box-sizing: border-box;
		display: flex;
	}	
	.member-search-area {
		height: 15%;
		padding: 10px;
		display: flex;
	}
	.move-month-area {
		height: 9.5%;
		display: grid;
		align-items: center;
	}	
	.month-area {
		display: flex;
		justify-content: center;
	}
	.month-area div {
		font-size: 30px;
		margin: 10px;
		padding: 10px;
	}
	.calender-area {padding: 10px;}
	.mydiv-area {width: 20%; position: relative;}
	.memebrdiv-area {
		width: 125px;
		overflow-y: auto;
		position: relative;
	}
	.line-cirecle {
		height: fit-content;
		width: 80px;
		cursor: pointer;
	}
	.display-item-center {
		display: flex;
		justify-content: center;
		align-items: center;
	}
	.font-size25 {font-size: 25px;}
	.member-search-area {margin-left: 30px; gap: 25px;}
	/* 모달 스타일 */
	.Category, .Co-worker {
		display: -webkit-box;
		overflow-y: hidden;
	}
	.date-time-area {
		display: flex;
		justify-content: space-evenly;
		text-align: center;
		width: 100%;
	}
	.date-area, .time-area {
		width: 100%;
		text-align: center;
	}
	.date-area {height: 30px;}
	.time-area {height: 50px;}
	.content-text-area {
		width: 500px;
		min-height: 120px;
	}
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
	<body>
    <div class="out-line">
        <!-- 메뉴판 -->
				<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
			  <script>
				// 캘린더 설정 및 선언
				  let calendar;	
				  function declareCalendar(){
				  document.addEventListener('DOMContentLoaded', function() {
				  		var calendarEl = document.getElementById('calendar');
				  		calendar = new FullCalendar.Calendar(calendarEl, {
				  			initialView: 'dayGridMonth',
				  			locale: 'ko',
				  			customButtons: {
				  				 enrollButton:{text: '일정 등록',click: function(){location.href="${path}/calendar/companyCalEnroll.page";}}
				  			},
				  			buttonText:{prev:'◁',next:'▷',today: '오늘',year:'연도',month:'월',week:'주'
				  			},
				  			headerToolbar:{start: 'prev today enrollButton',
				  						   center: 'title',
				  						   end: 'multiMonthYear dayGridMonth timeGridWeek next'
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
				  			eventClick:function(info){	
				  				modalOn(info);
				  			},
				  			eventMouseEnter:function(info){
				  				info.el.style.transform = 'scale(1.05)';
				  				info.el.style.cursor = 'pointer';
				  			},
				  			eventMouseLeave:function(info){
				  				info.el.style.transform = '';
				  			},	
				  		})
				  	})
				  }	
				  declareCalendar();
				  
			 		function checkDate(){
			 			let date2 = $('#currentDate2').val()+ " " + $('#currentTime2').val();
			 			let date1 = $('#currentDate1').val()+ " " + $('#currentTime1').val();
			 			let checkDate =  new Date(date2) >= new Date(date1);
			 			let checkTime = (new Date(date2).getTime() - new Date(date1).getTime())/60000 >= 30;
			       if(checkDate && checkTime){
			       	updateCal();
			       }else {
			    	   alertify.alert('일정 수정','날짜 및 시간을 확인 해 주세요.');
			       }
			   	};
			   	/* 일정 update ajax */
				  function updateCal(){
					  $.ajax({
						  url:'${path}/calendar/companyCalUpdate.do',
						  type: 'post',
						  data: $('#updateForm').serialize(),
						  success:function(result){
							  console.log(result);
							  console.log(calendar.getEvents());
							  calendar.getEvents().forEach((e) => {
								  e.remove();
							  })
							  addEvent();
							  $('#cal_modal').iziModal('close');
						  },
						  error:function(){
							  console.log('update Calendar fail');
						  }
					  })
				  }
				  
			   	function modalOn(info){
						$(document).on('opening', '#cal_modal', function (e) {
						    const extend = info.event.extendedProps;
						    $('#color-style').val(info.event.backgroundColor);
						    $('#currentDate1').val(info.event.startStr.slice(0,10));
						    $('#currentTime1').val(info.event.startStr.slice(11));
						    $('#currentDate2').val(info.event.endStr.slice(0,10));
						    $('#currentTime2').val(info.event.endStr.slice(11));
						    $('#cal_modal').find('.content-text-area').val(extend.content);
						    $('#cal_modal').find('input[name=place]').val(extend.place);
						    $('input[name=calTitle]').val(extend.caltitle);
						    $('input[name=calNO]').val(info.event.id);
						    $('input[name=team]').val(extend.team);
						    
								const $cate = $('input[name=groupCode]');
								for (let i = 0; i<$cate.length; i++){
									if($cate[i].value == extend.groupCode){
										$cate[i].checked = true;
									}
								};
					    
					}); //ismodal open function
		     	 	
		     	 	$('#cal_modal').iziModal('setSubtitle', info.event.id);  
		     	 	$('#cal_modal').iziModal('setTitle', info.event.title);  
	      		$('#cal_modal').iziModal('open');
			   	}
				  /* 이벤트를 불러들어 오는 부분 */
				  function addEvent(){
					  $.ajax({
							url:'${path}/calendar/companyCal.ajax',
							type:'post',
						  contentType: 'application/json',
							success:function(list){
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
													team:		e.team
													}		 
										 }]
									 );
								})
								calendar.render();
							},
							error:function(){
								console.log('calendar import error');
							}
					  })
				  }
				  
				  function checkAdmin(){
					  
				  }
				  
		   		/* document 후 실행 될 함수 */
					$(document).ready(function(){
						addEvent();
						condole.log('${loginMember}');
					})
				</script>
        <!-- 컨텐츠 영역 -->
       <div class="content" style="max-width: 1120px; padding: 30px;">
            <!-- 캘린더 영역 -->
            <div class="calender-area radious10 line-shadow "><div id="calendar"></div></div>
        </div>
    </div>


	<!-- 상세보기 일정 모달 -->
	<div id="cal_modal">
	<form id='updateForm'>
		<input type="hidden" name="calNO">
		<div>
			<div class="jua-regular">Title</div>
			<div><input type="text" name="calTitle" style="width: 80%"></div>
		</div>
		<br>
		<div style="display: flex; justify-content: space-between; align-items: center">
			<div class="jua-regular">Category</div>
		</div>
		
		<div class="Category">
			<c:forEach var="g" items="${group}">
		    <div class="pretty p-default p-curve">
		     	<input type="radio" name="groupCode" value="${g.code}">
		       <div class="state p-success-o">
		           <label>${g.codeName}</label>
		       </div>
		    </div>
			</c:forEach>
		</div>
		<br>
		<div>
			<div class="jua-regular">Team</div>
			<div><input type="text" name="team" style="width: 80%"></div>
		</div>
		
		<br>
		<div class="jua-regular">
			Color <input type="color" name="color" id="color-style" style="width: 30px; height: 30px;">
		</div>
		<br>
		<div style="display: flex; justify-content: space-between;">
			<div class="jua-regular">All Day</div>

		<div class="pretty p-switch all_day">
				<input type="checkbox">
				<div class="state p-success">
					<label>종일</label>
				</div> 
			</div>
		</div>
		<br>
		
		<div class="date-time-area">
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular" type="date" id="currentDate1" name="date">
				</div>
				<br>
				<div>
					<input class="time-area jua-regular" type="time" id="currentTime1" name="time">
				</div>
			</div>
			<div style="place-self: center; font-size: xx-large;">~</div>
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular" type="date" id="currentDate2" name="date">
				</div>
				<br>
				<div>
					<input class="time-area jua-regular" type="time" id="currentTime2" name="time">
				</div>
			</div>
		</div>
		<br>
		
		<div class="jua-regular" >Content</div>
		<div>
			<textarea class="content-text-area" name="calContent"></textarea>
		</div>
		<br>
		
		<div class="jua-regular">Place</div>
		<div class="Place">
			<input style="width: 80%" type="text" name="place">
		</div>
		<br>
		
		<div align="end">
			<button class="btn btn-outline-warning" type="button" onclick="checkDate();">수정</button>
		</div>
	</form>
	</div>
	
	<!-- 모달 스크립트문 -->
	<script>
	     $('#cal_modal').iziModal({
	     headerColor: ' rgb(255,247,208)', 
	     theme:'light',
	     padding: '15px',
	     radius: 10, 
	     focusInput:	true,
	     restoreDefaultContent: true, 
		  });      
	</script>
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
</body>
</body>
</html>