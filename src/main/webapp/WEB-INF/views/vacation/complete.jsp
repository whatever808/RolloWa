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
						<c:forEach var="c" items="${vactList}">
							<option value="${c.code}">${c.codeName}</option>							
						</c:forEach>
						</select>
					</div>
					
					<div class="font-size25 jua-regular spaceNO">날짜</div>
					<div class="size-fit">
						<input type="date" id="currentDate1" class="date-area jua-regular">
					</div>
					<div><button type="button" onclick="searchOld();" class="jua-regular btn btn-outline-secondary"> 검색 </button></div>
				</form>
				<div>
					<table class="search-list table table-hover">
						<thead>
							<tr>
								<th class="font-size20 jua-regular spaceNO">No</th>
								<th class="font-size20 jua-regular spaceNO">카테고리</th>
								<th class="font-size20 jua-regular spaceNO">날짜</th>
								<th class="font-size20 jua-regular spaceNO">사용 일수</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td>1</td>
								<td class="spaceNO">연차</td>
								<td class="spaceNO">2024-04-24 ~ 2024-04-27</td>
								<td><div class="fontRed">-3</div></td>
							</tr>
						</tbody>
					</table>
				</div>
				<div align="end">
					<button class="btn btn-outline-danger">철회</button>
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
		
		function ajaxSearchOld(){
			
		}
		
		$(document).ready(function(){
			current();
			ajaxSearchOld();
		})
	</script>
<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
</body>
</html>