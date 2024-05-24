<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가 조회</title>
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
.info{
	display: none;
}
.attach-put{
	display:none;
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
				<div class="font-size25 jua-regular">휴가 신청</div>
				<br>
				<!--  data-izimodal-open="#vact_${va.code}" -->
				<div class="vacation-request">
					<c:forEach var="va" items="${vactList}">
					<div class="line-border-square line-shadow">
						<a href="#" onclick="selectModal('${va.code}')">
							<div class="vaCode" data-code="${va.code}">
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
				</div>

				<div class="font-size25 jua-regular">철회</div>
				<div class="retract">
				</div>
			</fieldset>
		</div>
	</div>
	<!-- 아이콘 삽입  -->
	<script>
		function insertIcon(){
			
			$('.vaCode').get().forEach((e) => {
				let str = document.createElement('i');
				let vaca_code = e.dataset.code;
				
				if(vaca_code == 'A'){ // 연차
					str.className = 'fa-solid fa-plane';
				}else if(vaca_code == 'B'){ // 반차
					str.className = 'fa-solid fa-bolt';
				}else if(vaca_code == 'C'){ // 병가
					str.className = 'fa-solid fa-pills';
				}else if(vaca_code == 'D'){ // 출산
					str.className = 'fa-solid';
				}else if(vaca_code == 'E'){ // 경조사
					str.className = 'fa-solid';
				}else if(vaca_code == 'F'){ // 생리
					str.className = 'fa-solid';
				}else if(vaca_code == 'G'){ // 소집일
					str.className = 'fa-solid fa-street-view';
				}else if(vaca_code == 'H'){ // 기타
					str.className = 'fa-solid fa-earth-americas';
				}
				
				e.appendChild(str);
			})
			
		}
	</script>
	<!-- 등록 ajax -->
	<script>
		function selectModal(c){
			$(document).on('opening', '#vact_' + c , function (e) {
			    $(this).find('.code').val(c)
			});
			$('#vact_' + c).iziModal('open');
		}
	
		function insertVact(e){			
			const file_input = $(e).parents('form').find('input[name=files]').get()[0];
			
			$.ajax({
				url:'${path}/vacation/insertVact.do',
				type:'post',
				data: new FormData($(e).parents('form')[0]),
				processData:false,
				contentType:false,
				enctype: 'multipart/form-data',
				success:function(r){
					if(r > 0){
						greenAlert('휴가신청', '신청 되었습니다.');
					}else {
						redAlert('휴가신청', '정상적으로 처리 되지않습니다. 관리자를 호출 해 주세요.');
					}
				},
				error:function(){
					console.log('휴가신청 오류');
				}
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
				<input type="hidden" name="group.code" class="code">
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
		});
	</script>
	<!-- 소집일 -->
	<form id="vact_G">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm">
				<i class="fa-solid fa-street-view"></i>
				<input type="hidden" name="group.code" class="code">
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
					<input class="date-area jua-regular currentDate2" type="date"  name="vacaEnd">
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
		<div class="myfile">
			<div class="jua-regular">Submit</div>
			<input type="file" style="width: 71%;" name="files" accept="image/*" multiple>
		</div>
		<br>
		<div align="end">
			<button class="btn btn-outline-primary" type="button" onclick="insertVact(this);">신청</button>
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
	<form id="vact_C">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm">
				<i class="fa-solid fa-pills"></i>
				<input type="hidden" name="group.code" class="code">
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
					<input class="date-area jua-regular currentDate2" type="date"  name="vacaEnd">
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
		<div class="myfile">
			<div class="jua-regular">Submit</div>
			<input type="file" style="width: 71%;" name="files" accept="image/*" multiple>
		</div>
		<br>
		<div align="end">
			<button class="btn btn-outline-primary" type="button" onclick="insertVact(this);">신청</button>
		</div>
	</form>
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
	<form id="vact_B">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm">
				<i class="fa-solid fa-bolt"></i>
				<input type="hidden" name="group.code" class="code">
			</div>
		</div>
		<div class="jua-regular">
			Color <input type="color" id="color-style" name="vacaColor">
		</div>
		<br>
		<div class="jua-regular jua-regular">Date</div>
		<div>
			<div style="text-align: -webkit-center;">
				<div style="width: 85%;">
					<input class="date-area jua-regular currentDate1" type="date" name="vacaStart">
				</div>
			</div>
			<br>
			<div class="half_time">
				<div class="half-line-border-square jua-regular">오전</div>
				<div class="half-line-border-square jua-regular">오후</div>
				<!-- 클릭요소에 따라서 12시 18시로 하면 될듯  -->
				<input type="hidden"  name="vacaEnd">
			</div>
		</div>
		<br> <br> <br>
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
	<form id="vact_H">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm">
				<i class="fa-solid fa-earth-americas"></i>
				<input type="hidden" name="group.code" class="code">
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
					<input class="date-area jua-regular currentDate2" type="date"  name="vacaEnd">
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
		<div class="myfile">
			<div class="jua-regular">Submit</div>
			<input type="file" style="width: 71%;" name="files" accept="image/*" multiple>
		</div>
		<br>
		<div align="end">
			<button class="btn btn-outline-primary" type="button" onclick="insertVact(this);">신청</button>
		</div>
	</form>
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
	<!-- =================================================================== -->
	<!-- 대기 -->
	<form id="standby_request">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm"></div>
			<i class="fa-regular fa-star"></i>
		</div>
		<div class="jua-regular">
			Color <input name="vacaColor" type="color" id="color-style" >
			<input name="vacaNO" type="hidden" readonly>
			<input name="vacaGroupCode" type="hidden" readonly>
		</div>
		<br>
		<div class="jua-regular">Date</div>
		<div class="date-time-area">
			<div style="width: 40%;">
				<div>
					<input name="vacaStart" class="date-area jua-regular" type="date">
				</div>
			</div>
			<div style="place-self: center; font-size: xx-large;">~</div>
			<div style="width: 40%;">
				<div>
					<input name="vacaEnd" class="date-area jua-regular" type="date">
				</div>
			</div>
		</div>
		<br>
		<div class="jua-regular">Content</div>
		<div>
			<textarea class="content-text-area" name="vacaComment"
				style="resize: none; height: 200px;"></textarea>
		</div>
		<br>
		<div class="myfile">
			<div class="jua-regular">Submit</div>
			<input type="file" style="width: 71%;" name="files" accept="image/*" multiple>
		</div>
		<br>
		<div class="download" style="overflow: hidden;"></div>
		<div align="end">
			<button type="button" class="btn btn-outline-warning" onclick="updateRequest(this);">수정</button>
		</div>
	</form>
	<script>
		$('#standby_request').iziModal({
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
	<form id="retract_request">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm">
				<i class="fa-regular fa-star"></i>
			</div>
		</div>
		<br>
		<input name="vacaNO" type="hidden" readonly>					
		<input name="vacaGroupCode" type="hidden" readonly>					
		<div class="jua-regular">Date</div>
		<div class="date-time-area">
			<div style="width: 40%;">
				<div>
					<input name="vacaStart" class="date-area jua-regular" type="date" readonly>
				</div>
			</div>
			<div style="place-self: center; font-size: xx-large;">~</div>
			<div style="width: 40%;">
				<div>
					<input name="vacaEnd" class="date-area jua-regular" type="date" readonly>
				</div>
			</div>
		</div>
		<br>
		<div class="jua-regular">Content</div>
		<div>
			<textarea class="content-text-area" name="vacaComment"
				style="resize: none; height: 200px;" readonly></textarea>
		</div>
		<br>
		<div class="download" style="overflow: hidden;"></div>
		<br>
		<div align="end">
			<button type="button" class="btn btn-outline-danger" onclick="delecteRequest(this);">삭제</button>
		</div>
	</form>
	<script>
		$('#retract_request').iziModal({
			subtitle : '결제가 철회 되었습니다.',
			headerColor : '#dc3545',
			theme : 'light',
			padding : '15px',
			radius : 10,
			zindex : 300,
			focusInput : true,
			restoreDefaultContent : false,
		});
		
		function codeName(code){
			let string = '';
			switch (code){
				case 'A': string = '연차'; break;
				case 'B': string = '반차'; break;
				case 'C': string = '병가'; break;
				case 'G': string = '소집일'; break;
				default : String = '기타'			
			}
			return string;
		}
		
		function updateRequest(button){
			
			$.ajax({
				url:'${path}/vacation/requestUpdate.ajax',
				type:'post',
				data: new FormData($(button).parents('form')[0]),
				processData:false,
				contentType:false,
				enctype: 'multipart/form-data',
				success:function(result){
					if(result>0){
						greenAlert('휴가 수정', '휴가 정정이 완료 되었습니다.');
						$('#standby_request').iziModal('close');
						$('#retract_request').iziModal('close');
						selectRequest()
					}else {
						redAlert('휴가 수정', '관리자를 호출 해 주세요');
					}
				},
				error:function(){}
			})
			
		}
		
		function delecteRequest(button){
			const $form = $(button).parents('form')[0];
			console.log($form);
			
			$.ajax({
				url:'${path}/vacation/deleteRequest.ajax',
				type:'post',
				data: new FormData($(button).parents('form')[0]),
				processData:false,
				contentType:false,
				enctype: 'multipart/form-data',
				success:function(result){
					if(result>0){
						greenAlert('휴가 삭제', '휴가 삭제가 완료 되었습니다.');
						$('#standby_request').iziModal('close');
						$('#retract_request').iziModal('close');
						selectRequest()
					}else {
						redAlert('휴가 삭제', '관리자를 호출 해 주세요');
					}
				},
				error:function(){}
			})
		}
		
		function selectRequest(){
			
			$('.standby *').remove();
			$('.retract *').remove();
			
			$.ajax({
				url:'${path}/vacation/request.ajax',
				type:'post',
				contentType : 'application/json',
				success:function(list){
					console.log(list);
					
					list.forEach((e) => {
						let ch = (e.approrvalStatus == 'N');
						let element = '';
						element	+='<div class="s-wrap radious10" onclick="onpening('+(ch ? 0:1)+', this);">'
										+ '<div class="info" data-start="'+e.vacaStart
																		 +'" data-end="'+e.vacaEnd
																		 +'" data-coment="'+e.retractComent
																		 +'" data-num="'+e.vacaNO
																		 +'" data-code="'+e.vacaGroupCode
																		 +'"></div>'
										+ '<div class="s-category line-border-square-sm">'+codeName(e.vacaGroupCode)+'</div>'
										+ '<div class="s-situation line-border-square-sm '+ ((ch) ? 'RedContext">철회' : 'gContext">대기') +'</div>'
						if(e.attach.length != 0){
							e.attach.forEach((arr) => {
								element +=  '<input class="attach-put" type="text" value="'+arr.attachPath+'">'
												+   '<input class="attach-put" type="text" value="'+arr.originName+'">'
												+		'<input class="attach-put" type="text" value="'+arr.modifyName+'">'
							})
						}
						if(e.vacaGroupCode != 'B'){
							element	+= '<div class="s-date line-border-square-sm">'
											+		e.vacaStart.slice(0,10) + ' ~ ' + e.vacaEnd.slice(0,10)
											+		'</div>'
						}else {
							element	+= '<div class="s-date line-border-square-sm">'+ e.vacaEnd +'</div>'
						}
						element	+= '</div>';	
						
						$( ch ? '.retract' :'.standby').append(element);

					})
				},
				error:function(){
					console.log('ajax request fail');
				}
			});
		}
		function currentTime(){
			const offset = new Date().getTimezoneOffset() * 60000;
			const today = new Date(Date.now() - offset);
			let dateData = today.toISOString().slice(0, 10);

			today.setDate(today.getDate() + 1);
			today.setTime(today.getTime() + 12 * 1000 * 60 * 60);

			let dateData0 = today.toISOString().slice(0, 10);
			
			let date = document.getElementsByClassName("currentDate1");
			let dare0 = document.getElementsByClassName("currentDate2");
			for (let i = 0; i < date.length; i++) {
				date[i].value = dateData;
			}
			for (let i = 0; i < dare0.length; i++) {
				dare0[i].value = dateData0;
			}
			
		}
		
		function onpening(num, event){
			let check_modal = (( num == 0) ?'#retract_request' :'#standby_request');

				$(document).on('opening', check_modal, function (e) {
					
					$(this).eq(0).find('input[name=vacaNO]').val(event.children[0].dataset.num);
					$(this).eq(0).find('input[name=vacaGroupCode]').val(event.children[0].dataset.code);
					let arr = $(this).eq(0).find('input.date-area').get();
					arr[0].value = event.children[0].dataset.start.slice(0,10);
					arr[1].value = event.children[0].dataset.end.slice(0,10);
					
					let coment = event.children[0].dataset.coment;
					let str = (coment == 'null') ? '내용이 없습니다.':coment;
					$(this).eq(0).find('textarea').val(str);
					
					const $download = $(event).children('.attach-put');
					$(".download *").remove();
					for(let i =0; i<$download.length; i +=3 ){
					$(".download").append('<a href="${path}'+ $download[i].value +"/"+ $download[i+2].value
																			+'" download="'+$download[i+1].value+'">'+$download[i+1].value+'</a><br>')
					}
				});
			
			$(check_modal).iziModal('setTitle', codeName(event.children[0].dataset.code) + (num == 0 ? ' 철회':' 대기중'));
			$(check_modal).iziModal('open');
			
		}

		$(document).ready(function() {
			currentTime();
			insertIcon();
			selectRequest();
		})
	</script>
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
</body>
</html>