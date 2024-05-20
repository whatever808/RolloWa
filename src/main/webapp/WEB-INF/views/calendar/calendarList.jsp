<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List 일정 관리</title>
<style>
.out-line {
	min-height: 800px;
	width: 100%;
	box-sizing: border-box;
	display: flex;
}

.search-date {
	display: flex;
	justify-content: space-evenly;
	align-items: baseline;
	gap: 5%;
}

.size-fit {
	display: contents;
}

.search-list {
	width: 100%;
	padding: 10px;
}

.search-list * {
	/* padding: 5px; */
	text-align: center;
}

.inner-line {
	padding: 30px;
}

.inner-line>div {
	margin-left: 10px;
}

.date-area {
	width: 30%;
	text-align: center;
}

.over {
	text-overflow: ellipsis;
	overflow: hidden;
	white-space: nowrap;
}
.del_input{
	width: inherit;
	
}
</style>
</head>
<body>
	<div class="out-line">
		<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
		<!-- 삭제 모달 -->
		<div id="checkDelCalendar"></div>
		
		<script>
			$('#checkDelCalendar').iziModal({
	      title: '일정 삭제 확인',
	      subtitle: '정말로 삭제 합니까?',
	      headerColor: '#dc3545',
	      padding: '15px',
	      radius: 10,
	      scrollHeight: 'auto',
	      onOpening: function(){
	    	  const $num = $('input[name=check]:checked');
					let del_arr = new Array();
					
					$num.get().forEach((e) => {
						del_arr.push(e.value);
					})
					$('#checkDelCalendar .iziModal-content').append('<input type="text" class="del_input" readonly>')
																									.append('<div align="end"><button onclick="deleteCal();" class=" mt-3 btn btn-outline-danger jua-regular">삭제</button></div>');
					$('#checkDelCalendar .del_input').val(del_arr);

	      },
	      onClosing: function(){
	    	  $('#checkDelCalendar .iziModal-content *').remove();
	      }
	      
			});
			
			function checkDelCal(){
				$('#checkDelCalendar').iziModal('open');
			}
			
			function deleteCal() {
				$.ajax({
					url : '${path}/calendar/deletedCheck.do',
					type : 'post',
					data : $('input[name=check]:checked').serialize(),
					success : function(result) {
						if (result > 0) {
							$('#checkDelCalendar').iziModal('close');
							greenAlert("일정 삭제", "성공적으로 삭제 되었습니다.");
							importList($('.page-item.active>a').text())
						} else {
							redAlert("일정 삭제", "다시 시도 해주세요. 관리자를 호출 해 주세요.");
						}
					},
					error : function() {
						console.log('삭제ajax 실패');
					}
				})
			};
			
			function currentDate() {
				const offset = new Date().getTimezoneOffset() * 60000;
				const today = new Date(Date.now() - offset);

				let dateData = today.toISOString().slice(0, 10);
				document.getElementById('currentDate1').value = dateData;

				today.setDate(today.getDate() + 1);

				dateData = today.toISOString().slice(0, 10);
				document.getElementById('currentDate2').value = dateData;
			};

			function importList(page) {
				$.ajax({
					url : '${path}/calendar/calendarControllor.ajax',
					type : 'post',
					async : false,
					data : {
						'page' : page,
						'dataStart' : $('#currentDate1').val(),
						'dataEnd' : $('#currentDate2').val(),
						'calSort' : $('select :selected').val()
					},
					success : function(result) {
						//console.log(result);
						creatTable(result.list);
						creatPaging(result.paging)
					},
					error : function() {
						console.log('paging error');
					}
				})
			};

			function creatTable(list) {
				$('tbody>tr').remove();
				let tableEl = '';
				if (list.length != 0) {
					for (let i = 0; i < list.length; i++) {
						tableEl += '<tr><td>'
								+ list[i].calNO
								+ '</td>'
								+ '<td><input type="color" value="' + list[i].color + '" id="color-style" style="width: 35px; height: 15px;" onclick="return false"></td>'
								+ '<td>'
								+ list[i].group.codeName
								+ '</td>'
								+ '<td class="over">'
								+ list[i].calTitle
								+ '</td>'
								+ '<td class="over">'
								+ list[i].duraDate
								+ '</td>'
								+ '<td><div class="pretty p-icon p-curve p-thick p-jelly">'
								+ '<input type="checkbox" required name="check" value="'+ list[i].calNO +'" />'
								+ '<div class="state p-danger"><label></label></div></div></td></tr>'
					}
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
					page += '<li class="page-item"><a class="page-link" onclick="importList('
							+ (paging.currentPage - 1) + ');">◁</a></li>';
				}

				for (let i = paging.startPage; i <= paging.endPage; i++) {
					if (paging.currentPage == i) {
						page += '<li class="page-item active"><a class="page-link">'
								+ i + '</a></li>';
					} else if (i <= paging.maxPage) {
						page += '<li class="page-item"><a class="page-link" onclick="importList('
								+ i + ');">' + i + '</a></li>';
					} else {
						page += '<li class="page-item disabled"><a class="page-link">'
								+ i + '</a></li>';
					}
				}

				if (paging.currentPage >= paging.maxPage) {
					page += '<li class="page-item disabled"><a class="page-link">▷</a></li>';
				} else {
					page += '<li class="page-item"><a class="page-link" onclick="importList('
							+ (Number(paging.currentPage) + 1)
							+ ');">▷</a></li>';
				}
				$('.pagination').append(page);
			};
			
			$(document).ready(function() {
				currentDate();
				importList();
			});
		</script>
		<!-- 컨텐츠 영역 -->
		
		<script></script>
		
		<div class="content" style="max-width: 1120px; padding: 30px;">
			<fieldset class="radious10 inner-line line-shadow">
				<legend>
					<h1 class="jua-regular">List 일정 관리</h1>
				</legend>
				<br>
				<br>
				<div class="search-date">
				  <select name="calSort" class="form-select" style="width: fit-content;">
				    <option value="C" selected>Company</option>
				    <option value="D">Department</option>

				  </select>
					<div class="font-size25 jua-regular" style="white-space: nowrap;">날짜</div>
					<div class="size-fit">
						<input type="date" id="currentDate1" class="date-area jua-regular">
					</div>
					<div style="font-size: x-large;">~</div>
					<div class="size-fit">
						<input type="date" id="currentDate2" class="date-area jua-regular">
					</div>
					<div style="white-space: nowrap;">
						<button class="btn btn-outline-dark jua-regular"
							onclick="importList();">검색</button>
					</div>
				</div>
				<br>
				<div>
					<table class="search-list table table table-hover">
						<thead>
							<tr>
								<th class="font-size20 jua-regular" style="width: 10px;">No</th>
								<th class="font-size20 jua-regular" style="width: 10px;">Color</th>
								<th class="font-size20 jua-regular">Category</th>
								<th class="font-size20 jua-regular">Title</th>
								<th class="font-size20 jua-regular">Date</th>
								<th class="font-size20 jua-regular" style="width: 10px;">Check</th>
							</tr>
						</thead>
						<tbody></tbody>
					</table>
				</div>
				<br>
				<div style="display: flex; justify-content: space-between;">
					<div>
						<ul class="pagination"></ul>
					</div>
					<div>
						<button class="btn btn-outline-danger jua-regular"
							onclick="checkDelCal();">삭제</button>
					</div>
				</div>
			</fieldset>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
</body>
</html>