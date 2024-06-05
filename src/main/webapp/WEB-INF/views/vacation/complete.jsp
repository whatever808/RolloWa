<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>휴가 결재</title>
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
	max-width: 1500px;
	padding: 30px;
}

.radious10 {
	border-radius: 10px;
}

.line-show {
	box-shadow: 3px 3px 5px 2px rgb(166, 166, 166);
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

.date-area {
	width: 30%;
	text-align: center;
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
.collapse_font{
	    font-size: 15px;
	    font-style: italic;
    	text-align: start;
}
.greenCol{
	 color: green;
}
.redCol{
	    color: red;
}
.collaps_detail{
	
}
</style>
<!-- 부트스트랩 js 파일 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<div class="out-line">
		<!-- 메뉴판 -->
		<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
		<!-- 컨텐츠 영역 -->
		<div class="content-area">
			<fieldset class="line-shadow radious10 inner-line">
				<legend>
					<h1 class="jua-regular">휴가 결재</h1>
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
								<th class="font-size20 jua-regular spaceNO">Check</th>
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
				반려 하시겠습니까? 이유를 적어 주세요.
				</div>
				<br>
				<div class="jua-regular">반려 사유</div>
				<textarea name="RetractComent" style="width: -webkit-fill-available;"></textarea>
				<input type="hidden" name="vacaNO">
			</div>
		</div>
		<div style="text-align: end;"><button type="button" class="btn btn-outline-danger" onclick="RRequest(this);">확인</button></div>
	</form>
	
	<form id="sing_confirm">
	<div style="display:flex">
		<div>
			<br>
			<div style="text-align: center;" class="font-size20 jua-regular">
			결재를 승인 하시겠습니까?
			</div>
			<input type="hidden" name="vacaNO">
			<input type="hidden" name="member.userNo">
			<input type="hidden" name="status">
			<input type="hidden" name="vacaStart">
			<input type="hidden" name="vacaEnd">
		</div>
	</div>
	<div style="text-align: end;"><button type="button" class="btn btn-outline-success" onclick="singConfirm(this);">확인</button></div>
</form>
	
	
	<script>
		$('#RR_modal').iziModal({
			headerColor : '#dc3545',
			theme : 'light',
			padding : '15px',
			radius : 10,
			zindex : 300,
			focusInput : true,
		});
		
		$('#sing_confirm').iziModal({
			headerColor : '#28a745',
			theme : 'light',
			padding : '15px',
			radius : 10,
			zindex : 300,
			focusInput : true,
		});
		
		function ajaxSearchOld(page){
			$.ajax({
				url:'${path}/vacation/vacationRequest.ajax',
				type:'post',
				data:'vacaGroupCode='+$('select').val()
							+ '&page=' + page,
				success:function(map){
					console.log(map);
					creatTable(map.list);
					creatPaging(map.paging);
				},
				error:function(){
					console.log('list select fail');
				}
			})
		}
		
		function singModal(vacaNO, userNO, status, start, end){
			$(document).on('opening', '#sing_confirm', function (e) {
			   $(this).find('input[name="vacaNO"]').val(vacaNO);
			   $(this).find('input[name="member.userNo"]').val(userNO);
			   $(this).find('input[name="status"]').val(status);
			   $(this).find('input[name="vacaStart"]').val(start);
			   $(this).find('input[name="vacaEnd"]').val(end);
			});
			$('#sing_confirm').iziModal('setTitle', vacaNO);
			$('#sing_confirm').iziModal('open');
		}
		
		function deleteCheck(vacaNO){
			$(document).on('opening', '#RR_modal', function (e) {
			   $(this).find('input[name="vacaNO"]').val(vacaNO);
			});
			$('#RR_modal').iziModal('setTitle', vacaNO);
			$('#RR_modal').iziModal('open');
		}
		
		function RRequest(t){
			$.ajax({
				url:'${path}/vacation/singRefuse.ajax',
				type:'post',
				data:'vacaNO='+$('#RR_modal').find('input[name="vacaNO"]').val()
							+'&RetractComent='+$('#RR_modal').find('textarea').val(),
				success:function(e){
					if(e > 0){
						greenAlert('반려 요청', '반려 되었습니다.');
						$('#RR_modal').iziModal('close');
						ajaxSearchOld(1);
					}else{
						redAlert('반려 요청 실패', '관리자를 호출 해 주세요');
					}
				}
			})
			
		}
		
		function singConfirm(t){
			$.ajax({
				url:'${path}/vacation/singConfirm.ajax',
				type:'post',
				data:$('#sing_confirm').serialize(),
				success:function(e){
					if(e > 0){
						greenAlert('승인 요청', '승인이 완료 되었습니다.');
						$('#sing_confirm').iziModal('close');
						ajaxSearchOld(1);
					}else{
						redAlert('승인 요청 실패', '관리자를 호출 해 주세요');
					}
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
				let count = 0;
				list.forEach((e) => {
					let checkRe = (e.rrequestComent == null);
					tableEl += '<tr data-toggle="collapse" data-target="#collapse'+ count +'"><td>'
									+ e.vacaNO
									+ '</td>'
									+ '<td class="spaceNO"><input type="color" value="' + e.vacaColor + '" id="color-style" style="width: 35px; height: 35px; cursor: auto;" onclick="return false"></td>'
									+ '<td class="spaceNO">'
									+ codeName(e.vacaGroupCode)
									+ '</td>'
									+ '<td class="spaceNO" style="font-size: larger;">'
									+ e.vacaStart.slice(0,10) +' ~ '+ e.vacaEnd.slice(0,10)
									+ '</td>'
									+ '<td><div style="display: flex;gap: 5px;justify-content: center;">'
									+ '<button style="white-space: nowrap;" class="btn btn-outline-success" onclick="singModal('+ e.vacaNO +','+ e.member.userNo +','+ checkRe +','+"'"+ e.vacaStart.slice(0, 10) +"'"+','+"'"+ e.vacaEnd.slice(0, 10)+"'" +');">승인</button>'
									+ '<button style="white-space: nowrap;" class="btn btn-outline-danger" onclick="deleteCheck('+ e.vacaNO +');">반려</button></td></div>'
									+ '</tr>'
									+ '<tr id="collapse'+ count +'" class="collapse">'
									+ '<td colspan="5"><div class="collaps_detail" style="display: grid; grid-template-columns: 50% 50%;">'
									+ '<div>'
									+ '<div class="collapse_font '+ (checkRe ? 'greenCol' : 'redCol') +'">'+ (checkRe ? '<b>휴가 신청</b>': '철회 신청 사유 : <b>' + e.rrequestComent) + '</div>'
									+ '<div class="collapse_font">신청자 : ' + e.member.userName + '</div>'
									+'</div>';
									if(e.attach.length != 0){
										tableEl += '<div class="collapse_font">';
										e.attach.forEach((arr) => {
											tableEl += '<a href="${path}'+ arr.attachPath+"/"+ arr.modifyName+ '" download="'+ arr.originName+'">'+ arr.originName+'</a><br>'
										})
										tableEl +='</div>';
									}
									tableEl += '</div></td></tr>';
									count++;			
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
<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
</body>
</html>