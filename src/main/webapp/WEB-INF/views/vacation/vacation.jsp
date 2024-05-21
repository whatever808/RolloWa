<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
.out-line {
	min-height: 800px;
	width: 100%;
	display: flex;
	flex-direction: row;
	box-sizing: border-box;
}

.line-shadow {
	box-shadow: 3px 3px 5px 2px rgb(166, 166, 166);
}

.content-area {
	width: 75%;
	max-width: 1120px;
	padding: 30px;
}

.radious10 {
	border-radius: 10px;
}

.line-border-square {
	border-radius: 10px;
	width: 80px;
	text-align: center;
	padding: 5px;
}

.vacation-request>.line-border-square:hover {
	cursor: pointer;
	background-color: rgba(160, 160, 128, 0.2);
}

.vacation-area, .vacation-request{
   display: grid;
   grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
   row-gap: 15px;
}

.s-wrap {
	display:grid;
	grid-template-columns: 50px 50px 1fr;
	align-items: center;
	column-gap: 10px;
	padding: 10px;
	border-bottom: 2px solid rgb(160, 160, 160);
}

.s-wrap>.inner-line {
	padding: 25px;
}

.inner-line>div {
	margin-left: 25px;
}

.standby, .retract {
	display: grid;
	gap: 10px;
}

.standby *:hover, .retract *:hover {
	cursor: pointer;
	background-color: rgba(160, 160, 128, 0.2);
}

.RedContext {
	color: #dc3545;
	font-weight: bolder;
}

.gContext {
	color: #28a745;
	font-weight: bolder;
}

.content-area {
	max-width: 800px;
}

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
}

#color-style {
	-webkit-appearance: none;
	-moz-appearance: none;
	appearance: none;
	width: 30px !important;
	height: 30px !important;
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

.cal_modal {
	display: flex;
	flex-direction: column;
}

.half_time {
	display: flex;
	justify-content: space-around;
	text-align: center;
	position: fixed;
	width: 100%;
}

.half-line-border-square {
	border: 3px solid rgb(160, 160, 160);
	border-radius: 10px;
	width: 35%;
	height: fit-content;
	font-size: 20px;
}

.half-line-border-square:hover {
	cursor: pointer;
	background-color: rgb(170, 170, 170, 0.2);
	font-size: 1.5em;
}

.content-text-area {
	width: 80%;
}

#color-style {
	width: 30px;
	height: 30px;
}

a {
	color: rgb(2, 2, 2)!important;
	text-decoration: unset;
}
</style>
</head>
<body>
	<div class="out-line">
		<!-- 메뉴판 -->
		<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
		<!-- 컨텐츠 영역 -->
		<div class="content-area">
			<fieldset class="line-shadow radious10 inner-line"
				style="padding: 30px">
				<legend
					class="font-size25 jua-regular animate__animated animate__bounce">
					<h1>휴가</h1>
				</legend>

				<div class="font-size25 jua-regular">연차 현황</div>
				<br>
				<div class="vacation-area" id="vacation-area">
					<div class="line-border-square line-shadow">
						연차<br> <br>15일
					</div>
					<div class="line-border-square line-shadow">
						소실<br> <br> <span class="RedContext">1일</span>
					</div>
					<div class="line-border-square line-shadow">
						사용<br> <br> <span class="RedContext">33일</span>
					</div>
					<div class="line-border-square line-shadow">
						지급일<br> <br> <span class="gContext">3일</span>
					</div>
					<div class="line-border-square line-shadow">
						근무 연수<br> <br>3년
					</div>
				</div>
				<br>
<!-- 				연차	<i class="fa-solid fa-plane"></i>
						반차 	<i class="fa-solid fa-bolt"></i>
						병가 	<i class="fa-solid fa-pills"></i>
						소집일	<i class="fa-solid fa-street-view"></i>
						기타	<i class="fa-solid fa-earth-americas"></i> -->
				<div class="font-size25 jua-regular">휴가 신청</div>
				<br>
				
				<div class="vacation-request">
					<c:forEach var="va" items="${vactList}">
					<div class="line-border-square line-shadow">
						<a href="#" data-izimodal-open="#vact_${va.code}">
							<div data-code="${va.code}">
								${va.codeName}
								<br><br>
							</div>
						</a>
					</div>
					</c:forEach>
				</div>
				
				<br>
				<div class="font-size25 jua-regular">결재 대기</div>
				<div class="standby">
					<a href="#" data-izimodal-open="#standby_request">
						<div class="s-wrap radious10">
							<div class="s-category line-border-square-sm">연차</div>
							<div class="s-situation line-border-square-sm gContext">대기</div>
							<div class="s-date line-border-square-sm">2024-04-24 ~
								2024-05-25</div>
						</div>
					</a>
					<div class="s-wrap radious10">
						<div class="s-category line-border-square-sm">연차</div>
						<div class="s-situation line-border-square-sm gContext">대기</div>
						<div class="s-date line-border-square-sm">2024-04-24 ~
							2024-05-25</div>
					</div>
				</div>

				<div class="font-size25 jua-regular">철회</div>
				<div class="retract">
					<a href="#" data-izimodal-open="#retract_request">
						<div class="s-wrap radious10">
							<div class="s-category line-border-square-sm">연차</div>
							<div class="r-situation line-border-square-sm RedContext">철회</div>
							<div class="s-date line-border-square-sm">2024-04-24 ~
								2024-05-25</div>
						</div>
					</a>
					<div class="s-wrap radious10">
						<div class="s-category line-border-square-sm">연차</div>
						<div class="r-situation line-border-square-sm RedContext">철회</div>
						<div class="s-date line-border-square-sm">2024-04-24 ~
							2024-05-25</div>
					</div>
					<div class="s-wrap radious10">
						<div class="s-category line-border-square-sm">연차</div>
						<div class="r-situation line-border-square-sm RedContext">철회</div>
						<div class="s-date line-border-square-sm">2024-04-24 ~
							2024-05-25</div>
					</div>
				</div>
			</fieldset>
		</div>
	</div>
	<!-- 아이콘 삽입  -->
	<script>
	
	</script>
	<!-- 등록 ajax -->
	<script>
		function insertVact(e){
			console.log($(e).parents('form').serialize());
			console.log($(e).parents('form'));
			//console.log($(e).parents('.iziModal-content').find('input.date-area'));
			
			let formData = new FormData();
			
			$.ajax({
				url:'${path}/vacation/insertVact.do',
				type:'post',
				data:$(e).parents('form').serialize(),
				success:function(r){},
				error:function(){}
			})		
				
		}
	</script>
	
	
	<!-- 휴가신청 모달 영역 -->
	<!-- 연차 -->
	<form id="vact_A">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm">
				<i class="fa-solid fa-plane"></i>
				<input type="hidden" name="code">
			</div>
		</div>
		<div class="jua-regular">
			Color <input type="color" id="color-style" name="vacaColor">
		</div>
		<br>
		<div class="jua-regular">Date</div>
		<div class="date-time-area">
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular currentDate1" type="date" name="vacaStart">
				</div>
			</div>
			<div style="place-self: center; font-size: xx-large;">~</div>
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular currentDate2" type="date" name="vacaEnd">
				</div>
			</div>
		</div>
		<br>
		<div class="jua-regular">Content</div>
		<div>
			<textarea class="content-text-area"
				style="resize: none; height: 200px;" name="vacaComment"></textarea>
		</div>
		<br>
		<div align="end">
			<button class="btn btn-outline-primary" type="button" onclick="insertVact(this);">신청</button>
		</div>
	</form>
	<script>
		$('#vact_A').iziModal({
			title : '휴가 신청',
			subtitle : '연차',
			headerColor : ' rgb(255,247,208)',
			theme : 'light',
			padding : '15px',
			radius : 10,
			zindex : 300,
			focusInput : true,
			restoreDefaultContent : false,
			onOpening: function(e){
				console.log(e);
			}
		});
	</script>
	<!-- 소집일 -->
	<form id="vact_G">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm">
				<i class="fa-solid fa-street-view"></i>
			</div>
		</div>
		<div class="jua-regular">
			Color <input type="color" id="color-style" name="">
		</div>
		<br>
		<div class="jua-regular">Date</div>
		<div class="date-time-area">
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular currentDate1" type="date" name="date">
				</div>
			</div>
			<div style="place-self: center; font-size: xx-large;">~</div>
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular currentDate2" type="date" name="date">
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
		<div class="myfile">
			<div class="jua-regular">Submit</div>
			<input type="file" style="width: 71%;" name="file">
		</div>
		<br>
		<div align="end">
			<button class="btn btn-outline-primary" onclick="insertVact(this);">신청</button>
		</div>
	</form>
	<script>
		$('#vact_G').iziModal({
			title : '휴가 신청',
			subtitle : '소집일',
			headerColor : ' rgb(255,247,208)',
			theme : 'light',
			padding : '15px',
			radius : 10,
			zindex : 300,
			focusInput : true,
			restoreDefaultContent : false,
		});
	</script>
	<!-- 병가 -->
	<div id="vact_C">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm">
				<i class="fa-solid fa-pills"></i>
			</div>
		</div>
		<div class="jua-regular">
			Color <input type="color" id="color-style">
		</div>
		<br>
		<div class="jua-regular">Date</div>
		<div class="date-time-area">
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular currentDate1" type="date" name="date">
				</div>
			</div>
			<div style="place-self: center; font-size: xx-large;">~</div>
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular currentDate2" type="date" name="date">
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
		<div class="myfile">
			<div class="jua-regular">Submit</div>
			<input type="file" style="width: 71%;">
		</div>
		<br>
		<div align="end">
			<button class="btn btn-outline-primary" onclick="insertVact(this);">신청</button>
		</div>
	</div>
	<script>
		$('#vact_C').iziModal({
			title : '휴가 신청',
			subtitle : '병가',
			headerColor : ' rgb(255,247,208)',
			theme : 'light',
			padding : '15px',
			radius : 10,
			zindex : 300,
			focusInput : true,
			restoreDefaultContent : false,
		});
	</script>
	<!-- 반차 -->
	<div id="vact_B">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm">
				<i class="fa-solid fa-bolt"></i>
			</div>
		</div>
		<div class="jua-regular">
			Color <input type="color" id="color-style">
		</div>
		<br>
		<div class="jua-regular jua-regular">Date</div>
		<div>
			<div style="text-align: -webkit-center;">
				<div style="width: 85%;">
					<input class="date-area jua-regular currentDate1" type="date">
				</div>
			</div>
			<br>
			<div class="half_time">
				<div class="half-line-border-square jua-regular">오전</div>
				<div class="half-line-border-square jua-regular">오후</div>
			</div>
		</div>
		<br> <br> <br>
		<div class="jua-regular">Content</div>
		<div>
			<textarea class="content-text-area"
				style="resize: none; height: 200px;"></textarea>
		</div>
		<br>
		<div align="end">
			<button class="btn btn-outline-primary" onclick="insertVact(this);">신청</button>
		</div>
	</div>
	
	<script>
		$('#vact_B').iziModal({
			title : '휴가 신청',
			subtitle : '반차',
			headerColor : ' rgb(255,247,208)',
			theme : 'light',
			padding : '15px',
			radius : 10,
			zindex : 300,
			focusInput : true,
			restoreDefaultContent : false,
		});
	</script>
	<!-- 기타 -->
	<div id="vact_H">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm">
				<i class="fa-solid fa-earth-americas"></i>
			</div>
		</div>
		<div class="jua-regular">
			Color <input type="color" id="color-style">
		</div>
		<br>
		<div class="jua-regular">Date</div>
		<div class="date-time-area">
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular currentDate1" type="date">
				</div>
			</div>
			<div style="place-self: center; font-size: xx-large;">~</div>
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular currentDate2" type="date">
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
		<div class="myfile">
			<div class="jua-regular">Submit</div>
			<input type="file" style="width: 71%;">
		</div>
		<br>
		<div align="end">
			<button class="btn btn-outline-primary" onclick="insertVact(this);">신청</button>
		</div>
	</div>
	<script>
		$('#vact_H').iziModal({
			title : '휴가 신청',
			subtitle : '기타',
			headerColor : 'rgb(255,247,208)', //red: #dc3545 ,green: #28a745
			theme : 'light',
			padding : '15px',
			radius : 10,
			zindex : 300,
			focusInput : true,
			restoreDefaultContent : false,
		});
	</script>

	<!-- 대기 -->
	<div id="standby_request">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm"></div>
			<i class="fa-regular fa-star"></i>
		</div>
		<div class="jua-regular">
			Color <input type="color" id="color-style">
		</div>
		<br>
		<div class="jua-regular">Date</div>
		<div class="date-time-area">
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular" type="date">
				</div>
			</div>
			<div style="place-self: center; font-size: xx-large;">~</div>
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular" type="date">
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
		<div class="myfile">
			<div class="jua-regular">Submit</div>
			<input type="file" style="width: 71%;">
		</div>
		<br>
		<div align="end">
			<button class="btn btn-outline-warning" >수정</button>
		</div>
	</div>
	<script>
		$('#standby_request').iziModal({
			title : '대기 중',
			subtitle : '결제가 대기 중 입니다.',
			headerColor : '#28a745',
			theme : 'light',
			padding : '15px',
			radius : 10,
			zindex : 300,
			focusInput : true,
			restoreDefaultContent : false,
		});
	</script>

	<!-- 철회 -->
	<div id="retract_request">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm">
				<i class="fa-regular fa-star"></i>
			</div>
		</div>
		<br>
		<div class="jua-regular">Date</div>
		<div class="date-time-area">
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular" type="date" readonly>
				</div>
			</div>
			<div style="place-self: center; font-size: xx-large;">~</div>
			<div style="width: 40%;">
				<div>
					<input class="date-area jua-regular" type="date" readonly>
				</div>
			</div>
		</div>
		<br>
		<div class="jua-regular">Content</div>
		<div>
			<textarea class="content-text-area"
				style="resize: none; height: 200px;" readonly></textarea>
		</div>
		<br>
		<div align="end">
			<button class="btn btn-outline-danger">삭제</button>
		</div>
	</div>
	<script>
		$('#retract_request').iziModal({
			title : '철회',
			subtitle : '결제가 철회 되었습니다.',
			headerColor : '#dc3545',
			theme : 'light',
			padding : '15px',
			radius : 10,
			zindex : 300,
			focusInput : true,
			restoreDefaultContent : false,
		});
	</script>

	<script>
		const offset = new Date().getTimezoneOffset() * 60000;
		const today = new Date(Date.now() - offset);
		let dateData = today.toISOString().slice(0, 10);

		today.setDate(today.getDate() + 1);
		today.setTime(today.getTime() + 12 * 1000 * 60 * 60);

		let dateData0 = today.toISOString().slice(0, 10);
	</script>

	<script>
		$(document).ready(function() {
			let date = document.getElementsByClassName("currentDate1");
			let dare0 = document.getElementsByClassName("currentDate2");

			for (let i = 0; i < date.length; i++) {
				date[i].value = dateData;
			}
			for (let i = 0; i < dare0.length; i++) {
				dare0[i].value = dateData0;
			}
		})
	</script>
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
</body>
</html>