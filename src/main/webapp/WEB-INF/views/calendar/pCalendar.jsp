<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>부서 일정</title>

<!-- fullcalendar -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<!-- google calendar 연동 -->
<script src='https://cdn.jsdelivr.net/npm/@fullcalendar/google-calendar@6.1.13/index.global.min.js'></script>
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
		gap: 25px;
		background: url(${path}/resources/images/rollowa.jpg);
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
	.calender-area {
		padding: 10px;
    background: #f7efc9;
	}
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
		background-color: rgb(0 0 0) !important;
		border-radius: 10px !important;
	}
	.fc .fc-timegrid-col.fc-day-today{
		background-color: rgb(246 239 201 / 0.05) !important;
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
	.member-search-area:hover :not(:hover){
		opacity: 0.5;
	}
	.fc .fc-toolbar-title {
    font-size: 2.3em;
    margin: 0px;
}

.fc .fc-button-primary {
    font-size: 1.3rem;
}
	
</style>
</head>
<body>
	<div class="out-line">
		<!-- 메뉴판 -->
		<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
		<script>
		/* 캘린더 설정 및 선언 */
		  let calendar;
			function declareCalendar(){
				document.addEventListener('DOMContentLoaded', function() {
					var calendarEl = document.getElementById('calendar');
					calendar = new FullCalendar.Calendar(calendarEl, {
						initialView: 'dayGridMonth',
						locale: 'ko',
		        //height: '700px',
				 	  googleCalendarApiKey: 'AIzaSyBEu59fao26o4oQSM2gXavGYR9eMTxd1nE',
						customButtons: {
							 enrollButton:{text: '일정 등록',click: function(){location.href="${path}/calendar/calEnroll.page";}}
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
						events:{
                googleCalendarId :  'ko.south_korea.official#holiday@group.v.calendar.google.com',
                backgroundColor: 		'red',
                className:					'holliDay',
                extendedProps:{
	                status: 					'N',
               	},
            }
					});
				});					
			}
			/* 미리 선언 하지않으면 뒤에서 let calendar에서 undifieded로 변수가 설정 되어 버림 */
			declareCalendar();
			
	    /* 수정시 입력 받은 데이터 유효성 체크 */
	 		function checkDate(){
	 			let date2 = $('#currentDate2').val()+ " " + $('#currentTime2').val();
	 			let date1 = $('#currentDate1').val()+ " " + $('#currentTime1').val();
	 			let checkDate =  new Date(date2) >= new Date(date1);
	 			let checkTime = (new Date(date2).getTime() - new Date(date1).getTime())/60000 >= 30;
	       if(checkDate && checkTime){
	    	   updateCal();
	       }else {
	    	   redAlert('일정 수정','날짜 및 시간을 확인 해 주세요.');
	       }  
	   	}; 
	   	
		  /* 캘린더 이벤트를 믈릭시 실행되는  */
			function modalOn(info){
			  //console.log(info.event.extendedProps.status);
			  if(info.event.extendedProps.status != 'Y'){
					$(document).on('opening', '#cal_modal', function (e) {
							const event = info.event;
					    const extend = info.event.extendedProps;
					    $('#color-style').val(event.backgroundColor);
					    $('#currentDate1').val(event.startStr.slice(0,10));
					    $('#currentTime1').val(event.startStr.slice(11));
					    $('#currentDate2').val(event.endStr.slice(0,10));
					    $('#currentTime2').val(event.endStr.slice(11));
					    $('#cal_modal').find('.content-text-area').val(extend.content);
					    $('#cal_modal').find('input[name=place]').val(extend.place);
					    $('input[name=calTitle]').val(extend.caltitle);
					    $('input[name=calNO]').val(event.id);
					    /* 카테고리를 선택하는 부분 */
							const $cate = $('input[name=groupCode]');
							for (let i = 0; i<$cate.length; i++){
								if($cate[i].value == extend.groupCode){
									$cate[i].checked = true;
								}
							}
						
							/* 동료 체크 부분 초기화 */
							$('input[name=coworker]').each(function(){
		       				$(this).prop('checked', false);
		    			})
		    
							/* 동료를 체크하는 부분   */
							extend.cowoker.forEach((w) => {
								$('input[name=coworker]').each(function() {
									if ($(this).val() == w.userNo) {
										 $(this).prop('checked', true);
									}
							  })
							})
								
					}) //ismodal open function
	     	 	
	     	 	$('#cal_modal').iziModal('setSubtitle', info.event.id);  
	     	 	$('#cal_modal').iziModal('setTitle', info.event.title);  
	  			$('#cal_modal').iziModal('open');
			  }else {
				  return false;
			  }// if End
			}
		  
		  /* 이벤트를 불러들어 오는 부분 */
		  function addEvent(num){
			  $.ajax({
					url:'${path}/calendar/selectCal.ajax',
					type:'post',
				  contentType: 'application/json',
					data:JSON.stringify({ userNO: num }),
					success:function(map){
						//console.log(map);
						removeAll();
						
						/* 해당 사원에 해당하는 일정이 존재하지 않을 경우 실행 */
						if(map.noSearch == 'Y'){
						/* 	alertify.alert('일정 조회','해당 사원의 일정을 조회 할 수 없습니다.'); */
							yellowAlert('일정 조회','해당 사원의 일정을 조회 할 수 없습니다.');
						}
						
						map.list.forEach((e) => {
							 calendar.addEventSource(
							 [{
									  id:						e.calNO,
										title:				e.group.upperCode + " " + e.group.codeName,
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
						map.vacaList.forEach((e) => {
							 calendar.addEventSource(
							 [{
									  id:						e.vacaNO,
										title:				e.group.upperCode+ " " + e.member.userName,
										start: 				e.vacaStart,
										end:					e.vacaEnd,
										color: 				e.vacaColor,
										allDay:       true,
										extendedProps:{
											status:			e.vacationApprorvalStatus,
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
		  
	   	/* 일정 update ajax */
		  function updateCal(){
			  $.ajax({
				  url:'${path}/calendar/calUpdate.do',
				  type: 'post',
				  data: $('#updateForm').serialize(),
				  success:function(result){
						if(result > 0){
							 greenAlert('일정 수정','성공적으로 갱신 되었습니다.');
						} else {
							redAlert('일정 수정','관리자를 호출해 주세요.');
						}
					  
						removeAll();
					  addEvent(null);
					  $('#cal_modal').iziModal('close');
				  },
				  error:function(){
					  console.log('update Calendar fail');
				  }
			  })
		  }
	   	
	   	function removeAll(){
			  calendar.getEvents().forEach((e) => {
				  e.remove();
			  })
	   	}
	   	
			function allDate(e){
				
				const offset = new Date().getTimezoneOffset() * 60000;
				const today = new Date(Date.now() - offset);
				let dateData = today.toISOString().slice(0, 10);
				let timeData = today.toISOString().slice(11, 16);
				
				if($(e).children('input').is(':checked')){
			    $('#currentDate1').val(dateData);
			    $('#currentTime1').val('00:00:00');
			    $('#currentDate2').val(dateData);
			    $('#currentTime2').val('23:59:00');
		
				}else {
					document.getElementById('currentDate1').value = dateData;
					document.getElementById('currentTime1').value = timeData;
	
					today.setDate(today.getDate() + 1);
					today.setTime(today.getTime() + 12 * 1000 * 60 * 60);
	
					dateData = today.toISOString().slice(0, 10);
					timeData = today.toISOString().slice(11, 16);
					document.getElementById('currentDate2').value = dateData;
					document.getElementById('currentTime2').value = timeData;
				}
			}
		  
   		/* document 후 실행 될 함수 */
			$(document).ready(function(){
				addEvent(null);
				console.log("ready 함수 실행됨");
				
				$('.member-search-area .line-cirecle').click(function(){
					addEvent($(this).next().val());
				})
				
				$('#allDate').on('click', function(){
					allDate(this);
				});
			})
		</script>
		<!-- 컨텐츠 영역 content-area -->
		<div class="content" style="max-width: 1500px; padding: 30px;">
			<!-- 직원 div 영역 -->
			<div class="member-search-area radious10 line-shadow">
	
				<!-- when : 로그인한 회원의 위치 -->
				<!-- other :  같은 팀의 다른 사람들-->	
				<c:forEach var="t" items="${teams}">
					<c:choose>
						<c:when test="${loginMember.userNo eq t.userNo}">
							<div class="mydiv-area display-item-center">
								<div class="line-cirecle display-item-center line-shadow">
									<img src="${path}${t.profileURL}" class="rounded" style="overflow:hidden;" >
									<span class="img_postion jua-regular">${t.userName}</span>
								</div>
								<input type="hidden" value="${t.userNo}">
							</div>
						</c:when>
						<c:otherwise>
							<div class="memebrdiv-area display-item-center">
								<div class="line-cirecle display-item-center line-shadow">
									<img src="${path}${t.profileURL}" class="rounded" style="overflow:hidden;" >
									<span class="img_postion jua-regular">${t.userName}</span>
								</div>
								<input type="hidden" value="${t.userNo}">
							</div>						
						</c:otherwise>
					</c:choose>
				</c:forEach>
			</div>
			<br> <br>
			<!-- 캘린더 영역 -->
			<div class="calender-area radious10 line-shadow "><div id="calendar"></div></div>
		</div>
	</div>
	<!-- 상세보기 일정 모달 -->
	<div id="cal_modal">
	<form id="updateForm">
		<input type="hidden" name="calNO" required>
		<div>
			<div class="jua-regular">Title</div>
			<div><input type="text" name="calTitle" style="width: 80%" required></div>
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
		<div class="jua-regular">Co-worker</div>
		<div class="Co-worker">
	    <c:forEach var="t" items="${teams}">
		    <div class="pretty p-default p-round p-smooth p-plain">
		        <input type="checkbox" name="coworker" value="${t.userNo}">
		        <div class="state p-success-o">
		            <label>${t.userName}</label>
		        </div>
		    </div>
	    </c:forEach>
		</div>
		<br>
		<div class="jua-regular">
			Color <input type="color" name="color" id="color-style" style="width: 30px; height: 30px;">
		</div>
		<br>
		<div style="display: flex; justify-content: space-between;">
			<div class="jua-regular">All Day</div>

		<div class="pretty p-switch all_day" id="allDate">
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
					<input class="date-area jua-regular" type="date" id="currentDate1" name="date" required>
				</div>
				<br>
				<div>
					<input class="time-area jua-regular" type="time" id="currentTime1" name="time" required>
				</div>
			</div>
			<div style="place-self: center; font-size: xx-large;">~</div>
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular" type="date" id="currentDate2" name="date" required>
				</div>
				<br>
				<div>
					<input class="time-area jua-regular" type="time" id="currentTime2" name="time" required>
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
	<script>
	/* 모달 스크립트문 */
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
</html>