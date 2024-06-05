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
.content-area {
	width: 75%;
	max-width: 1120px;
	padding: 30px;
}
.vacation-request>.line-border-square:hover {
	cursor: pointer;
  background-color: rgb(246 239 201 / 50%);
}

.vacation-area, .vacation-request{
   display: grid;
   grid-template-columns: 1fr 1fr 1fr 1fr 1fr;
   gap: 35px;
}

.s-wrap {
	display:grid;
	grid-template-columns: 50px 50px 50px 50px 1fr;
	align-items: center;
	column-gap: 10px;
	padding: 10px;
	border-bottom: 2px solid rgb(160, 160, 160);
  font-size: large;
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
	background-color: rgb(246 239 201 / 50%);
}

.RedContext {
	color: #dc3545;
	font-weight: bolder;
  font-size: larger;
}

.gContext {
	color: #28a745;
	font-weight: bolder;
  font-size: larger;
}

.content-area {
	max-width: 1500px;
}

.Category{
    display: flex;
    justify-content: space-between;
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

.line-border-square {
  border-radius: 10px;
  width: -webkit-fill-available;
  text-align: center;
  padding: 25px;
  font-size: larger;
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
  white-space: nowrap;
  overflow: hidden;
}
.info{
	display: none;
}
.attach-put{
	display:none;
}
.fa-plane:before{
	color: skyblue;
}
.fa-bolt:before, .fa-zap:before{
	color: #ffe200;
}
.fa-pills:before{
	color: purple;
}
.fa-street-view:before{
	color: coral;
}
.fa-earth-america:before, .fa-earth-americas:before, .fa-earth:before, .fa-globe-americas:before{
	color: green;
}

.size-fit {
	display: contents;
}

.search-date {
	display: flex;
	gap: 30px;
	align-items
}

.search-list {
	width: 100%;
	padding: 10px;
}

.search-list * {
	padding: 5px;
	text-align: center;
}

.inner-line {
	padding: 30px;
}

.inner-line>div {
	margin: 10px;
}

.fontRed {
	color: red;
}

.jua_font {
	font-family: "Jua", sans-serif;
}
.spaceNO{
    white-space: nowrap;
}
#RR_modal{
   height: fit-content;
}
i{
	font-size: xx-large;
}
</style>
</head>
<body>
	<div class="out-line">
		<!-- 메뉴판 -->
		<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
		<!-- 컨텐츠 영역 -->
		<div class="content-area">
		<!-- 휴가 신청 영역 -->
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
						연차<br><b>${member.vacationCount}</b>일
					</div>
					<div class="line-border-square line-shadow">
						사용<br><span class="RedContext">${member.vaUsingDate}일</span>
					</div>
					<div class="line-border-square line-shadow">
						지급일<br><span class="gContext">${loginMember.vaGivenDate}일</span>
					</div>
					<div class="line-border-square line-shadow">
						근무 년수<br><b>${loginMember.vaYearLabor }</b>년
					</div>
					
				</div>
				
				<br>
				<div class="font-size25 jua-regular">휴가 신청</div>
				<br>
				<div class="vacation-request">
					<c:forEach var="va" items="${vactList}">
					<div class="line-border-square line-shadow">
						<a href="#" onclick="selectModal('${va.code}')">
							<div class="vaCode" data-code="${va.code}">${va.codeName}<br></div>
						</a>
					</div>
					</c:forEach>
				</div>
				
				<br>
				<div class="font-size25 jua-regular">결재 대기</div>
				<div class="standby">
				</div>
				<br>
				<div class="font-size25 jua-regular">반려</div>
				<div class="retract">
				</div>
			</fieldset>
			<!-- 휴가 신청 영역 -->
			<br>
			<br>
			<br>
			<!-- 지난 휴가 영역 -->
			<fieldset class="line-shadow radious10 inner-line">
				<legend>
					<h1 class="jua-regular">지난휴가</h1>
				</legend>
				<br>
				<br>
				<form class="search-date">
					<div class="font-size25 jua-regular spaceNO">검색</div>
					<div>
						<select style="border: 0px;" class="jua-regular" name="code">
							<option value="all">All</option>
						<c:forEach var="c" items="${vactList}">
							<option value="${c.code}">${c.codeName}</option>							
						</c:forEach>
						</select>
					</div>
				
					<div><button style="box-shadow: 1px 1px 1px 1px #8888887a;" type="button" onclick="ajaxSearchOld(1);" class="jua-regular btn btn-outline-dark"> 검색 </button></div>
				</form>
				<div>
					<table class="search-list table table-hover">
						<thead>
							<tr>
								<th class="font-size20 jua-regular spaceNO">No</th>
								<th class="font-size20 jua-regular spaceNO">Color</th>
								<th class="font-size20 jua-regular spaceNO">Category</th>
								<th class="font-size20 jua-regular spaceNO">Date</th>
								<th class="font-size20 jua-regular spaceNO">Using</th>
								<th class="font-size20 jua-regular spaceNO">Refusal</th>
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
				<div align="end">
					<ul class="pagination"></ul>
				</div>
			</fieldset>
			
		</div>
	</div>
	
	<form id="RR_modal">
		<div style="display:flex">
			<div>
				<br>
				<div style="text-align: center;" class="font-size20 jua-regular">
				정말로 삭제 하시겠습니까? 삭제 후 첨부파일 data를 복구 할 수 없습니다.
				</div>
				<br>
				<div class="jua-regular">철회 사유</div>
				<textarea name="RRequestComent" style="width: -webkit-fill-available;"></textarea>
				<input type="hidden" name="vacaNO">
			</div>
		</div>
		<div style="text-align: end;"><button type="button" class="btn btn-outline-danger" onclick="RRequest(this);">신청</button></div>
	</form>
	
	<!-- 지난 휴가 -->
		<script>
		$('#RR_modal').iziModal({
			headerColor : '#dc3545',
			theme : 'light',
			padding : '15px',
			radius : 10,
			zindex : 300,
			focusInput : true,
		});
		
		function ajaxSearchOld(page){
			$.ajax({
				url:'${path}/vacation/searchOld.ajax',
				type:'post',
				data:'vacaGroupCode='+$('select').val()
							+ '&page='+ page,
				success:function(map){
					//console.log(map);
					
					creatTable(map.list);
					creatPaging(map.paging);
				},
				error:function(){
					console.log('list select fail');
				}
			})
		}
		
		function deleteCheck(num){
			$(document).on('opening', '#RR_modal', function (e) {
			   $(this).find('input[name="vacaNO"]').val(num);
			});
			$('#RR_modal').iziModal('setTitle', num);
			$('#RR_modal').iziModal('open');
		}
		
		function RRequest(t){
			$.ajax({
				url:'${path}/vacation/RRequest.ajax',
				type:'post',
				data:'vacaNO='+$('#RR_modal').find('input[name="vacaNO"]').val()
							+'&RRequestComent='+$('#RR_modal').find('textarea').val(),
				success:function(e){
					if(e > 0){
						greenAlert('철회 요청', '철회가 신청 되었습니다.');
						$('#RR_modal').iziModal('close');
					}else{
						redAlert('철회 요청', '관리자를 호출 해 주세요');
					}
					ajaxSearchOld(1);
					selectRequest();
				}
			})
			
		}
		
		function codeName(code){
			let string = '';
			switch (code){
				case 'A': string = '연차'; break;
				case 'B': string = '반차'; break;
				case 'C': string = '병가'; break;
				case 'G': string = '소집일'; break;
				default: string = '기타';			
			}
			return string;
		}
		
		function creatTable(list) {
			$('tbody>tr').remove();
			let tableEl = '';
			if (list.length != 0) {
				list.forEach((e) => {
					tableEl += '<tr><td>'
									+ e.vacaNO
									+ '</td>'
									+ '<td class="spaceNO"><input type="color" value="' + e.vacaColor + '" id="color-style" style="width: 35px; height: 35px; cursor: auto;" onclick="return false"></td>'
									+ '<td class="spaceNO">'
									+ codeName(e.vacaGroupCode)
									+ '</td>'
									+ '<td class="spaceNO" style="font-size: larger;">'
									+ e.vacaStart.slice(0,10) +' ~ '+ e.vacaEnd.slice(0,10)
									+ '</td>'
									+ '<td><div class="fontRed">- '
									+ ((new Date(e.vacaEnd.slice(0,10)) - new Date(e.vacaStart.slice(0,10))) / (1000 * 60 * 60 * 24) +1)
									+ '</div></td>'
									+ '<td><button class="btn btn-outline-danger" style="white-space: nowrap;" onclick="deleteCheck('+ e.vacaNO +');">철회</button></td>'
									+ '</tr>'
				})
			} else {
				tableEl += '<tr><td colspan="6">조회 되는 일정이 없습니다.</td>'
			}
			$('tbody').append(tableEl);
		};
		
		function creatPaging(paging) {
			$('.pagination>li').remove();
			let page = '';

			if (paging.currentPage == 1) {
				page += '<li class="page-item disabled"><a class="page-link">◁</a></li>';
			} else {
				page += '<li class="page-item"><a class="page-link" onclick="ajaxSearchOld('
						+ (paging.currentPage - 1) + ');">◁</a></li>';
			}

			for (let i = paging.startPage; i <= paging.endPage; i++) {
				if (paging.currentPage == i) {
					page += '<li class="page-item active"><a class="page-link">'
							+ i + '</a></li>';
				} else if (i <= paging.maxPage) {
					page += '<li class="page-item"><a class="page-link" onclick="ajaxSearchOld('
							+ i + ');">' + i + '</a></li>';
				} else {
					page += '<li class="page-item disabled"><a class="page-link">'
							+ i + '</a></li>';
				}
			}

			if (paging.currentPage >= paging.maxPage) {
				page += '<li class="page-item disabled"><a class="page-link">▷</a></li>';
			} else {
				page += '<li class="page-item"><a class="page-link" onclick="ajaxSearchOld('
						+ (Number(paging.currentPage) + 1)
						+ ');">▷</a></li>';
			}
			$('.pagination').append(page);
		};
		
		$(document).ready(function(){
			ajaxSearchOld(1);
			
		})
	</script>
	
	
	<!-- 휴가 신청  -->
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
				//enctype: 'multipart/form-data',
				success:function(r){
					if(r > 0){
						greenAlert('휴가신청', '신청 되었습니다.');
					}else {
						redAlert('휴가신청', '정상적으로 처리 되지않습니다. 관리자를 호출 해 주세요.');
					}
					
					let modal_select = '#'+$(e).parents()[3].id;
					$(document).on('closing', modal_select , function (e) {
					    $(modal_select).find('textarea').val('');
					});
					
					$(modal_select).iziModal('close');
					
					selectRequest();
					ajaxSearchOld();
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
		<div class="myfile"></div>
		<br>
		<div class="download" style="overflow: hidden;"></div>
		<div align="end" style="margin-top: 10px;">
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
		<div align="end" style="margin-top: 10px;">
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
						
						$('#standby_request').find('input[name="files"]').val('');
						$('#standby_request').iziModal('close');
						$('#retract_request').iziModal('close');
						selectRequest();
						ajaxSearchOld();
					}else {
						redAlert('휴가 수정', '관리자를 호출 해 주세요');
					}
				},
				error:function(){}
			})
			
		}
		
		function delecteRequest(button){
			const $form = $(button).parents('form')[0];
			//console.log($form);
			
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
						selectRequest();
						ajaxSearchOld();
					}else {
						redAlert('휴가 삭제', '관리자를 호출 해 주세요');
					}
				},
				error:function(){}
			})
		}
		
		function selectRequest(){
			
			$('.standby').empty();
			$('.retract').empty();
			
			$.ajax({
				url:'${path}/vacation/request.ajax',
				type:'post',
				contentType : 'application/json',
				success:function(list){
					console.log(list);
					
					list.forEach((e) => {
						let ch = (e.retractComent != null); // true : 철회가 된거임
						let checkRe = (e.rrequestComent == null); // 철회 요청인지
						let element = '';+ (checkRe ? '': '반려' ) 
						element	+='<div class="s-wrap radious10" onclick="onpening('+(ch ? 0:1)+', this);">'
										+ '<div class="s-situation line-border-square-sm"><b>'+ e.vacaNO +'</b></div>'
										+ '<div class="info" data-start="'+e.vacaStart
																		 +'" data-end="'+e.vacaEnd
																		 +'" data-coment="'+e.retractComent
																		 +'" data-num="'+e.vacaNO
																		 +'" data-code="'+e.vacaGroupCode
																		 +'" data-color="'+e.vacaColor
																		 +'"></div>'
										+ '<div class="s-category line-border-square-sm">'+codeName(e.vacaGroupCode)+'</div>'
										+ '<div class="s-situation line-border-square-sm '+ ((ch) ? 'RedContext">반려' : 'gContext">'+'대기') +'</div>'
										+ '<div class="s-situation line-border-square-sm">'+ ((checkRe) ? '' : '철회') +'</div>'
						if(e.attach.length != 0){
							e.attach.forEach((arr) => {
								element +=  '<input class="attach-put" type="text" value="'+arr.attachPath+'">'
												+   '<input class="attach-put" type="text" value="'+arr.originName+'">'
												+		'<input class="attach-put" type="text" value="'+arr.modifyName+'">'
							})
						}
						if(e.vacaGroupCode != 'B'){
							element	+= '<div class="s-date line-border-square-sm" style="white-space: nowrap;">'
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

				$(this).eq(0).find('input[name=vacaNO]').val(event.children[1].dataset.num);
				$(this).eq(0).find('input[name=vacaGroupCode]').val(event.children[1].dataset.code);
				$(this).eq(0).find('input[name=vacaColor]').val(event.children[1].dataset.color);
				let arr = $(this).eq(0).find('input.date-area').get();
				arr[0].value = event.children[1].dataset.start.slice(0,10);
				arr[1].value = event.children[1].dataset.end.slice(0,10);
				
				let coment = event.children[1].dataset.coment;
				let str = (coment == 'null') ? '내용이 없습니다.':coment;
				$(this).eq(0).find('textarea').val(str);
				
				const $download = $(event).children('.attach-put');
				$(".download *").remove();
				for(let i =0; i<$download.length; i +=3 ){
				$(".download").append('<a href="${path}'+ $download[i].value +"/"+ $download[i+2].value
																		+'" download="'+$download[i+1].value+'">'+$download[i+1].value+'</a><br>');
				}
			})
			
			if(event.children[1].dataset.code != 'A' && event.children[1].dataset.code != 'B'){
				let fileHtml = '<div class="jua-regular">Submit</div><input type="file" style="width: 70%;" name="files" accept="image/*" multiple>';
				$('#standby_request').find('.myfile').append(fileHtml);
			}
			
			$(check_modal).iziModal('setTitle', codeName(event.children[1].dataset.code) + (num == 0 ? ' 반려 ' + event.children[1].dataset.num:' 대기중 ' + event.children[1].dataset.num));
			$(check_modal).iziModal('open');
			
		}
		
		
		$(document).on('closing', '#standby_request', function (e) {
			$('#standby_request').find('.myfile').empty()	;
		})
		
		$(document).ready(function() {
			currentTime();
			insertIcon();
			selectRequest();
		})
	</script>
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
</body>
</html>