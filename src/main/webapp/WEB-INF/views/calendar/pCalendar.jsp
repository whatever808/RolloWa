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
<!-- 애니메이션  -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />

<!-- 부트스트랩 -->
<link href="${path }/resources/css/common/bootstrap.min.css"
	rel="stylesheet">
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="${path }/resources/js/common/bootstrap.bundle.min.js"></script>

<!-- 사이드바 -->
<link href="${path }/resources/css/common/sidebars.css" rel="stylesheet">
<script src="${path }/resources/js/common/sidebars.js"></script>

<!-- 제이쿼리 -->
<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

<!-- 모달 관련 -->
<script src="${path }/resources/js/iziModal.min.js"></script>
<link rel="stylesheet"
	href="${path }/resources/css/iziModal.min.css">

<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap"
	rel="stylesheet">

<!-- 체크박스 관련 스타일 -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/pretty-checkbox@3.0/dist/pretty-checkbox.min.css">

<!-- fullcalendar -->
<script
	src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
<style>
/* *{border: 1px solid black;} */
.out-line {
	min-height: 800px;
	width: 100%;
	display: flex;
	flex-direction: row;
	box-sizing: border-box;
}

.radious10 {
	border-radius: 10px;
}

.line-shadow {
	box-shadow: 3px 3px 5px 2px rgb(166, 166, 166);
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

.calender-area {
	padding: 10px;
}

.mydiv-area {
	width: 20%;
}

.memebrdiv-area {
	width: 80%;
	gap: 30px;
	overflow-y: auto;
}

.line-cirecle {
	border-radius: 100%;
	height: 80px;
	width: 80px;
	cursor: pointer;
}

.display-item-center {
	display: flex;
	justify-content: center;
	align-items: center;
}

.memebrdiv-area {
	display: -webkit-box;
	-webkit-box-align: center;
}

.font-size25 {
	font-size: 25px;
}

.content-area {
	width: 75%;
	max-width: 1120px;
	padding: 30px;
}

.content-area .member-search-area, .content-area .calender-area {
	margin-left: 30px;
}
</style>
<!-- 사이드 바 스타일 -->
<style>
.b-example-divider {
	width: 100%;
	height: 3rem;
	background-color: rgba(0, 0, 0, .1);
	border: solid rgba(0, 0, 0, .15);
	border-width: 1px 0;
	box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em
		rgba(0, 0, 0, .15);
}

.bi {
	vertical-align: -.125em;
	fill: currentColor;
}

.nav-scroller {
	position: relative;
	z-index: 2;
	height: 2.75rem;
	overflow-y: hidden;
}

.nav-scroller .nav {
	display: flex;
	flex-wrap: nowrap;
	padding-bottom: 1rem;
	margin-top: -1px;
	overflow-x: hidden;
	text-align: center;
	white-space: nowrap;
	-webkit-overflow-scrolling: touch;
}

.active .bi {
	display: block !important;
}
/* content의 height와 height 값을 동일하게 */
.b-example-vr {
	flex-shrink: 0;
	width: 1.5rem;
	height: 1200px;
	background-color: rgb(255, 247, 208);
}

.content {
	height: 1200px;
	width: 1500px;
}
</style>
<!-- input, textarea 스타일 -->
<style>
input[type=text], input[type=file], input[type=date], input[type=time],
	textarea {
	font-size: 15px;
	color: #222222;
	width: fit-content;
	border: none;
	border-bottom: solid rgb(170, 170, 170) 1px;
	padding-bottom: 10px;
	padding-left: 10px;
	position: relative;
	background: none;
	z-index: 5;
}

input[type=text]:focus, input[type=file]:focus, input[type=date]:focus,
	input[type=time]:focus, textarea:focus {
	outline: none;
	border-bottom: 2px solid rgb(0, 0, 0);
}

.myfile {
	display: flex;
}

.myfile>div {
	border-bottom: 1px solid rgb(170, 170, 170);
}

.jua-regular {
	font-family: "Jua", sans-serif;
	font-weight: 400;
	font-style: normal;
}
</style>
<!-- 모달 스타일 -->
<style>
.Category, .Co-worker {
	display: -webkit-box;
	overflow-y: hidden;
}

.line-shadow {
	box-shadow: 3px 3px 5px 2px rgb(166, 166, 166);
}

.line-cirecle-sm {
	border-radius: 100%;
	margin-left: 20px;
	margin-bottom: 10px;
	padding: 5px;
	text-align: center;
	height: fit-content;
	cursor: pointer;
}

#color-style {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 30px;
	height: 30px;
	background-color: transparent;
	border: none;
	cursor: pointer;
}

#color-style::-webkit-color-swatch {
	border-radius: 10px;
	border: none;
}

#color-style::-moz-color-swatch {
	border-radius: 10px;
	border: none;
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

.date-area {
	height: 30px;
}

.time-area {
	height: 50px;
}

.border1 {
	border: 1px solid;
}

.line-border-square {
	border-radius: 10px;
	width: 80px;
	text-align: center;
	padding: 5px;
}

.content-text-area {
	width: 500px;
	min-height: 150px;
}
</style>
<!-- 애니메이션 script -->
<script>
	    const animateCSS = (element, animation, prefix = 'animate__') =>
	    new Promise((resolve, reject) => {
	        const animationName = `${prefix}${animation}`;
	        const node = document.querySelector(element);
	
	        node.classList.add(`${prefix}animated`, animationName);
	
	        function handleAnimationEnd(event) {
	        event.stopPropagation();
	        node.classList.remove(`${prefix}animated`, animationName);
	        resolve('Animation ended');
	        }
	
	        node.addEventListener('animationend', handleAnimationEnd, {once: true});
	    });
	</script>
</head>
<body>
	<div class="out-line">
		<!-- 메뉴판 -->
		<main class="d-flex flex-nowrap">
			<div class="flex-shrink-0 p-3" style="width: 280px;">
				<a href="/"
					class="d-flex align-items-center pb-3 mb-3 link-body-emphasis text-decoration-none border-bottom">
					<svg class="bi pe-none me-2" width="30" height="24">
	                  <use xlink:href="#bootstrap" />
	              </svg> <span class="fs-5 fw-semibold">회사로고</span>
				</a>
				<ul class="list-unstyled ps-0">
					<li class="mb-1">
						<button
							class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
							data-bs-toggle="collapse" data-bs-target="#home-collapse"
							aria-expanded="true">Home</button>
						<div class="collapse show" id="home-collapse">
							<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">Overview</a>
								</li>
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">Updates</a>
								</li>
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">Reports</a>
								</li>
							</ul>
						</div>
					</li>
					<li class="mb-1">
						<button
							class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
							data-bs-toggle="collapse" data-bs-target="#dashboard-collapse"
							aria-expanded="false">Dashboard</button>
						<div class="collapse" id="dashboard-collapse">
							<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">Overview</a>
								</li>
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">Weekly</a>
								</li>
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">Monthly</a>
								</li>
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">Annually</a>
								</li>
							</ul>
						</div>
					</li>
					<li class="mb-1">
						<button
							class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
							data-bs-toggle="collapse" data-bs-target="#orders-collapse"
							aria-expanded="false">Orders</button>
						<div class="collapse" id="orders-collapse">
							<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">New</a></li>
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">Processed</a>
								</li>
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">Shipped</a>
								</li>
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">Returned</a>
								</li>
							</ul>
						</div>
					</li>
					<li class="border-top my-3"></li>
					<li class="mb-1">
						<button
							class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
							data-bs-toggle="collapse" data-bs-target="#account-collapse"
							aria-expanded="false">Account</button>
						<div class="collapse" id="account-collapse">
							<ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">New...</a>
								</li>
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">Profile</a>
								</li>
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">Settings</a>
								</li>
								<li><a href="#"
									class="link-body-emphasis d-inline-flex text-decoration-none rounded">Sign
										out</a></li>
							</ul>
						</div>
					</li>
				</ul>
			</div>
		</main>
		<div class="b-example-divider b-example-vr"></div>
		<!-- 컨텐츠 영역 -->
		<div class="content-area">
			<!-- 직원 div 영역 -->
			<div class="member-search-area radious10 line-shadow">
				<div class="mydiv-area display-item-center">
					<div
						class="line-cirecle display-item-center line-shadow my-element"
						onclick="repeat_anmation()">홍길동</div>
				</div>
				<div class="memebrdiv-area display-item-center">
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
					<div class="line-cirecle display-item-center line-shadow">홍길동</div>
				</div>
			</div>
			<br> <br>
			<!-- 캘린더 스타일 -->
			<style>
			#calendar a {
				color: rgb(130, 130, 130);
				text-decoration-line: none;
			}
			
			.fc-button-primary {
				background-color: rgb(160, 160, 160) !important;
				border: 0 !important;
			}
			
			.fc-day-sat a {
				color: #007bff !important;
			}
			
			.fc-day-sun a {
				color: #dc3545 !important;
			}
			</style>
			<!-- 캘린더 영역 -->
			<div class="calender-area radious10 line-shadow ">
				<div id="calendar"></div>
			</div>
			<!-- 캘린더 스타일 -->
			<script>
          // 캘린더 설정 및 선언
          document.addEventListener('DOMContentLoaded', function() {
              var calendarEl = document.getElementById('calendar');
              var calendar = new FullCalendar.Calendar(calendarEl, {
                  initialView: 'dayGridMonth',
                  locale: 'ko',
                  buttonText:{prev:'이전',next:'다음',today: '오늘',year:'연도',month:'월',week:'주',},
                  headerToolbar:{start: 'prev today',center: 'title',end: 'multiMonthYear,dayGridMonth,timeGridWeek next'},
                  views:{year:{titleFormat:{year: '2-digit'},multiMonthMaxColumns: 1},
                      	month:{titleFormat:{year: '2-digit', month: 'short'}},
                      	week: {titleFormat:{year: '2-digit'}},
                      	day: {titleFormat:{month: 'short',day:'2-digit'}}},
                  buttonIcons: false,
                  navLinks: true,
                  slotMinTime: "06:00:00",
                  timeZone: 'Asia/Seoul',
                  editable: true,
                  droppable: true,
                  eventStartEditable: true,
                  eventResizableFromStart: true,
                  eventClick:function(info){
                      alert('Event: ' + info.event.title);
                  },
                  eventMouseEnter:function(info){
                      info.el.style.transform = 'scale(1.05)';
                      info.el.style.cursor = 'pointer';
                  },
                  eventMouseLeave:function(info){
                      info.el.style.transform = '';
                  },
	              	eventSources: [{
	            		events: function(info, successCallback, failureCallback) {
	            			$.ajax({
	            				url: "${path}/calendar/selectCal.do",
	            				type: 'POST',
            				  dataType: 'json',
	            				data: {
	            					start : info.startStr,
	            					end : info.endStr
	            				},
	            				success: function(data) {
	            					console.log(data);
	            					for(let i =0; i<data.length; i++){
	            						let event = {
	            								start: data[i].statrDate,
	            								end: data[i].endDate,
	            								title: data[i].calTitle
	            						}
		            					calendar.addEvent(event);
	            					}
	            				}
	            			});
	            		}
	            	}]
               });

              // 캘린더 객체 호출
              calendar.render();
          });
      </script>

			<br>
			<button data-izimodal-open="#cal_modal"
				class="btn btn-outline-secondary">Modal</button>
		</div>
	</div>

	<!-- 상세보기 일정 모달 -->
	<div id="cal_modal">
		<div
			style="display: flex; justify-content: space-between; align-items: center">
			<div class="jua-regular">Category</div>
			<div
				class="pretty p-default p-round p-smooth font-size20 privateArea"
				id="privateName">
				<input type="checkbox" />
				<div class="state p-danger">
					<label class="jua-regular">private</label>
				</div>
			</div>
		</div>
		<br>
		<div class="Category">
			<div class="line-cirecle-sm line-shadow">이벤트</div>
			<div class="line-cirecle-sm line-shadow">이벤트</div>
			<div class="line-cirecle-sm line-shadow">이벤트</div>
			<div class="line-cirecle-sm line-shadow">이벤트</div>
			<div class="line-cirecle-sm line-shadow">이벤트</div>
		</div>

		<div class="jua-regular">Co-worker</div>
		<br>
		<div class="Co-worker">
			<div class="line-cirecle-sm line-shadow">홍길동</div>
			<div class="line-cirecle-sm line-shadow">홍길동</div>
			<div class="line-cirecle-sm line-shadow">홍길동</div>
			<div class="line-cirecle-sm line-shadow">홍길동</div>
			<div class="line-cirecle-sm line-shadow">홍길동</div>
		</div>
		<br>
		<div class="jua-regular">
			Color <input type="color" id="color-style">
		</div>
		<br>
		<div style="display: flex; justify-content: space-between;">
			<div class="jua-regular">All Day</div>

			<div class="pretty p-switch all_day">
				<input type="checkbox" />
				<div class="state p-success">
					<label>종일</label>
				</div>
			</div>
		</div>
		<br>
		<div class="date-time-area">
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular" type="date" id="currentDate1">
				</div>
				<br>
				<div>
					<input class="time-area jua-regular" type="time" id="currentTime1">
				</div>
			</div>
			<div style="place-self: center; font-size: xx-large;">~</div>
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular" type="date" id="currentDate2">
				</div>
				<br>
				<div>
					<input class="time-area jua-regular" type="time" id="currentTime2">
				</div>
			</div>
		</div>
		<br>
		<div class="jua-regular">Content</div>
		<div>
			<textarea class="content-text-area"
				style="resize: none; height: 200px;"></textarea>
		</div>
		<br>
		<div class="jua-regular">Place</div>
		<div class="Place">
			<input style="width: 80%" type="text">
		</div>
		<br>
		<div align="end">
			<button class="btn btn-outline-warning">수정</button>
		</div>
	</div>

	<!-- 모달 스크립트문 -->
	<script>
      function repeat_anmation(){
          animateCSS('.my-element', 'bounce');
      }

      $('#cal_modal').iziModal({
      title: '상세보기',
      subtitle: '수정도 가능합니다.',
      headerColor: ' rgb(255,247,208)', 
      theme:'light',
      padding: '15px',
      radius: 10, 
      zindex:	300,
      focusInput:	true,
      restoreDefaultContent: false, 
  });
  </script>
	<!-- input 날짜 설정 스크립트문 -->
	<script>
      const offset = new Date().getTimezoneOffset() * 60000;
      const today = new Date(Date.now() - offset);
      let dateData = today.toISOString().slice(0, 10);
      let timeData = today.toISOString().slice(11, 16);
      document.getElementById('currentDate1').value = dateData;
      document.getElementById('currentTime1').value = timeData;
      
      today.setDate(today.getDate() + 1);
      today.setTime(today.getTime() + 12*1000*60*60);

      dateData = today.toISOString().slice(0, 10);
      timeData = today.toISOString().slice(11, 16);
      document.getElementById('currentDate2').value = dateData;
      document.getElementById('currentTime2').value = timeData;
  </script>

</body>
</html>