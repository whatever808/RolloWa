<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>지난 휴가</title>
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
</style>
</head>
<body>
	<div class="out-line">
		<!-- 메뉴판 -->
		<!-- 메뉴판 -->
		<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
		<!-- 컨텐츠 영역 -->
		<div class="content-area">
			<fieldset class="line-show radious10 inner-line">
				<legend>
					<h1 class="jua-regular animate__animated animate__bounce">지난
						휴가</h1>
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
					
					<div class="font-size25 jua-regular spaceNO">날짜</div>
					<div class="size-fit">
						<input type="date" id="currentDate1" class="date-area jua-regular">
						<input type="date" id="currentDate2" class="date-area jua-regular">
					</div>
					<div><button type="button" onclick="ajaxSearchOld(1);" class="jua-regular btn btn-outline-secondary"> 검색 </button></div>
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
							</tr>
						</thead>
						<tbody>
						</tbody>
					</table>
				</div>
				<div align="end">
					<!-- <button class="btn btn-outline-danger">철회</button> -->
					<ul class="pagination"></ul>
				</div>
			</fieldset>
		</div>
	</div>
	<script>
	
		function current(){
			const offset = new Date().getTimezoneOffset() * 60000;
			const today = new Date(Date.now() - offset);
			let dateData = today.toISOString().slice(0, 10);
			document.getElementById('currentDate1').value = dateData;
		}
		
		function ajaxSearchOld(page){
			$.ajax({
				url:'${path}/vacation/searchOld.ajax',
				type:'post',
				data:'vacaGroupCode='+$('select').val()
							+'&vacaStart=' + document.getElementById('currentDate1').value 
							+'&vacaEnd='+ document.getElementById('currentDate2').value 
							+ '&page='+ page,
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
		
		function creatTable(list) {
			$('tbody>tr').remove();
			let tableEl = '';
			if (list.length != 0) {
				list.forEach((e) => {
					tableEl += '<tr><td>'
									+ e.vacaNO
									+ '</td>'
									+ '<td class="spaceNO"><input type="color" value="' + e.vacaColor + '" id="color-style" style="width: 35px; height: 15px;" onclick="return false"></td>'
									+ '<td class="spaceNO">'
									+ codeName(e.vacaGroupCode)
									+ '</td>'
									+ '<td class="spaceNO">'
									+ e.vacaStart.slice(0,10) +' ~ '+ e.vacaEnd.slice(0,10)
									+ '</td>'
									+ '<td><div class="fontRed">- '
									+ ((new Date(e.vacaEnd.slice(0,10)) - new Date(e.vacaStart.slice(0,10))) / (1000 * 60 * 60 * 24) +1)
									+ '</div></td></tr>'
				})
			} else {
				tableEl += '<tr><td colspan="5">조회 되는 일정이 없습니다.</td>'
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
			current();
			ajaxSearchOld(1);
			
		})
	</script>
<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
</body>
</html>