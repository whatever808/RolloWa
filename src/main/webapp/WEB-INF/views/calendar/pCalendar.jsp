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
<title>Document</title>

<!-- fullcalendar -->
<script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>

<style>
	.out-line {
		min-height: 800px;
		width: 100%;
		display: flex;
		flex-direction: row;
		box-sizing: border-box;
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
		background-color: rgb(160, 160, 160) !important;
		border: 0 !important;
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
</style>
</head>
<body>
	<!-- 상세보기 일정 모달 -->
	<div id="cal_modal">
	<form action="${path}/calendar/calUpdate.do" method="post">
		<input type="hidden" name="calNO">
		<div>
			<div class="jua-regular">Title</div>
			<div><input type="text" name="calTitle" style="width: 80%"></div>
		</div>
		<br>
		<div style="display: flex; justify-content: space-between; align-items: center">
			<div class="jua-regular">Category</div>
			
			<div
				class="pretty p-default p-round p-smooth font-size20 privateArea"
				id="privateName">
				<input type="checkbox" name="calSort" value="P">
				<div class="state p-danger">
					<label class="jua-regular">private</label>
				</div>
			</div>  

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
		<script>
			
		</script>
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
			<button class="btn btn-outline-warning" onclick="return checkDate();">수정</button>
		</div>
	</form>
  <script>
 		function checkDate(){
 			let date2 = $('#currentDate2').val()+ " " + $('#currentTime2').val();
 			let date1 = $('#currentDate1').val()+ " " + $('#currentTime1').val();
 			let checkDate =  new Date(date2) >= new Date(date1);
 			let checkTime = (new Date(date2).getTime() - new Date(date1).getTime())/60000 >= 30;
       console.log(checkDate);
       console.log(checkTime);
       if(checkDate && checkTime){
       	return true;
       }else {
       	alert('날짜 및 시간을 확인 해 주세요.');
        return false;		        	
       }  
   	};
	</script>
	</div>
	
	<div class="out-line">
		<!-- 메뉴판 -->
		<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>

		<!-- 컨텐츠 영역 content-area -->
		<div class="content" style="max-width: 1120px; padding: 30px;">
			<!-- 직원 div 영역 -->
			<div class="member-search-area radious10 line-shadow">
	
				<!-- when : 로그인한 회원의 위치 -->
				<!-- other :  같은 팀의 다른 사람들-->	
				<c:forEach var="t" items="${teams}">
					<c:choose>
						<c:when test="${'1055' eq t.userNo}">
							<div class="mydiv-area display-item-center">
								<div class="line-cirecle display-item-center line-shadow">
									<img src="${t.profileURL}" class="rounded" style="overflow:hidden;" >
									<span class="img_postion">${t.userName}</span>
								</div>
							</div>
						</c:when>
						<c:otherwise>
							<div class="memebrdiv-area display-item-center">
								<div class="line-cirecle display-item-center line-shadow">
									<img src="${t.profileURL}" class="rounded" style="overflow:hidden;" >
									<span class="img_postion">${t.userName}</span>
								</div>
							</div>						
						</c:otherwise>
					</c:choose>
			
				</c:forEach>
				
			</div>
			<br> <br>
			<!-- 캘린더 영역 -->
			<div class="calender-area radious10 line-shadow "><div id="calendar"></div></div>
			<!-- 캘린더 스타일 -->
			<script>
			// 캘린더 설정 및 선언
			document.addEventListener('DOMContentLoaded', function() {
					var calendarEl = document.getElementById('calendar');
					var calendar = new FullCalendar.Calendar(calendarEl, {
						initialView: 'dayGridMonth',
						locale: 'ko',
						customButtons: {
							 enrollButton:{text: '일정 등록',click: function(){location.href="${path}/calendar/calEnroll.page";}}
						},
						buttonText:{prev:'이전',next:'다음',today: '오늘',year:'연도',month:'월',week:'주'
						},
						headerToolbar:{start: 'prev today enrollButton',
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
						eventClick:function(info){	
							//console.log(info.event.extendedProps.extendeProps);
							
							$(document).on('opening', '#cal_modal', function (e) {
							    const extend = info.event.extendedProps.extendeProps;
							    $('#color-style').val(info.event.backgroundColor);
							    $('#currentDate1').val(info.event.startStr.slice(0,10));
							    $('#currentTime1').val(info.event.startStr.slice(11));
							    $('#currentDate2').val(info.event.endStr.slice(0,10));
							    $('#currentTime2').val(info.event.endStr.slice(11));
							    $('#cal_modal').find('.content-text-area').val(extend.content);
							    $('#cal_modal').find('input[name=place]').val(extend.place);
							    $('input[name=calTitle]').val(extend.caltitle);
							    
								if(extend.calSort == 'P'){
									$('#cal_modal').find('input[name=calSort]').attr('checked', true);										
								}else{
									const $cate = $('input[name=groupCode]');
									for (let i = 0; i<$cate.length; i++){
										if($cate[i].value == extend.groupCode){
											$cate[i].checked = true;
										}
									};
								}
								
								$('input[name=coworker]').each(function(){
			                        $(this).prop('checked', false);
			                    });
									
								const sortArr = extend.cowoker.split(",");
								sortArr.forEach(s => {
									$('input[name=coworker]').each(function() {
										if ($(this).val() == s) {
											 $(this).prop('checked', true);
										}
									  });
								});
										
							}); //ismodal open function
							
					/* 		$(document).on('closing', '#cal_modal', function (e) {
								$('input[name=coworker]').each(function(){
			                        $(this).prop('checked', false);
			                    });
							});//ismodal closing function */
				     	 	
				     	 	$('#cal_modal').iziModal('setSubtitle', info.event.id);  
				     	 	$('#cal_modal').iziModal('setTitle', info.event.title);  
				      		$('#cal_modal').iziModal('open');
						},// event click
						eventMouseEnter:function(info){
							info.el.style.transform = 'scale(1.05)';
							info.el.style.cursor = 'pointer';
						},
						eventMouseLeave:function(info){
							info.el.style.transform = '';
						},	
						events:[
							<c:forEach var="c" items="${list}">
								{
									id:			'${c.calNO}',
									title: 		'${c.group.upperCode}'+'${c.group.codeName}',
									start: 		'${c.startDate }',
									end: 		'${c.endDate }',
									color: 		'${c.color }',
									extendeProps:{
										content:  	'${c.calContent}',
										caltitle: 	'${c.calTitle }',
										place: 	  	'${c.place}',
										calSort:  	'${c.calSort}',
										groupCode: 	'${c.groupCode}',
										cowoker: 	'<c:forEach var="co" items="${c.coworker}">${co.userNo},</c:forEach>'								
									}
								},
							</c:forEach>
						]// event end
					});
					calendar.render();
				});	

	      </script>
		</div>
	</div>
	<!-- 모달 스크립트문 -->
<script>
     $('#cal_modal').iziModal({
     subtitle: '수정도 가능합니다.',
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
<!-- 이예찬 -->
</html>