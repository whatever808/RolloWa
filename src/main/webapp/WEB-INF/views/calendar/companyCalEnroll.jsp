<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회사 일정 등록</title>
<style>
/* *{border: 1px solid black;} */
.out-line {
	min-height: 800px;
	width: 100%;
	box-sizing: border-box;
}

.clander-add-area {
	display: flex;
	flex-direction: column;
	gap: 15px;
	padding: 10px;
}

.clander-add-area>div {
	margin-left: 30px;
}

.line-cirecle-sm {
	border-radius: 100%;
	height: fit-content;
	margin-left: 30px;
	margin-bottom: 10px;
	padding: 5px;
	text-align: center;
	cursor: pointer;
}

.display-item-center {
	justify-content: center;
	align-items: center;
}

.Category, .Co-worker {
	display: -webkit-box;
	overflow-y: hidden;
}

.date-time-area {
	display: flex;
	justify-content: space-evenly;
	text-align: center;
	width: 80%;
}

.date-area, .time-area {
	width: 80%;
	text-align: center;
}

.date-area {
	height: 30px;
}

.time-area {
	height: 50px;
}

.Title>input, .Place>input {
	width: 80%;
	height: 25px;
	padding: 10px;
}

.enroll {
	text-align: end;
}

.content-text-area {
	width: 80%;
	min-height: 150px;
}

.inner-line {
	padding: 30px;
}

.inner-line>div, .inner-line>label {
	margin-left: 30px;
}
</style>

</head>
<body>
	<div class="out-line">
		<!-- 메뉴판 -->
		<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
		<!-- 컨텐츠 영역 -->
		<div class="content" style="max-width: 1000px; padding: 30px;">
			<fieldset class="clander-add-area radious10 inner-line line-shadow">
				<form action="${path}/calendar/insertCompanyCal.do" method="post">
					<legend>
						<h1 class="jua-regular">일정 추가</h1>
					</legend>
					<div
						style="display: flex; justify-content: space-between; align-items: center;">
						<div class="font-size25 jua-regular" id="categoryName">Category</div>
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

					<div style="display: flex; gap: 20px;">
						<label class="font-size25 jua-regular" for="color-style">Color</label>
						<input type="color" id="color-style" name="color">
					</div>
					<br> 
					<label class="font-size25 jua-regular" for="title">Title</label>
					<div class="Title">
						<input class="font-size20" type="text" id="title" name="calTitle">
					</div>
					<br>
					<div
						style="width: 80%; display: flex; justify-content: space-between;">
						<div class="font-size25 jua-regular" id="all_day">All Day</div>

						<div class="pretty p-switch all_day">
							<input type="checkbox" />
							<div class="state p-success">
								<label>종일</label>
							</div>
						</div>

					</div>

					<div class="date-time-area">
						<div style="width: 40%;">
							<div>
								<input class="date-area jua-regular" type="date"
									id="currentDate1" name="date">
							</div>
							<br>
							<div>
								<input class="time-area jua-regular" type="time"
									id="currentTime1" name="time">
							</div>
						</div>
						<div style="place-self: center; font-size: xx-large;">~</div>
						<div style="width: 40%;">
							<div>
								<input class="date-area jua-regular" type="date"
									id="currentDate2" name="date">
							</div>
							<br>
							<div>
								<input class="time-area jua-regular" type="time"
									id="currentTime2" name="time">
							</div>
						</div>
					</div>
					<br>
					<div class="font-size25 jua-regular">Content</div>
					<div>
						<textarea class="content-text-area" style="resize: none;"
							name="calContent"></textarea>
					</div>

					<div class="font-size25 jua-regular" id="placeName">Place</div>
					<div class="Place">
						<input class="font-size20" type="text" name="place">
					</div>

					<div class="enroll marginR30">
						<button type="submit" class="btn btn-outline-primary"
							onclick="return checkDate();">등록</button>
					</div>
				</form>
			</fieldset>
			<script>
				function checkDate() {

					let date2 = $('#currentDate2').val() + " "
							+ $('#currentTime2').val();
					let date1 = $('#currentDate1').val() + " "
							+ $('#currentTime1').val();
					let checkDate = new Date(date2) >= new Date(date1);
					let checkTime = (new Date(date2).getTime() - new Date(date1)
							.getTime()) / 60000 >= 30;
					console.log(checkDate);
					console.log(checkTime);
					if (checkDate && checkTime) {
						return true;
					} else {
						 alertify.alert('일정 등록','날짜 및 시간을 확인 해 주세요.');
						return false;
					}
				};
			</script>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
	<script>
		const offset = new Date().getTimezoneOffset() * 60000;
		const today = new Date(Date.now() - offset);
		let dateData = today.toISOString().slice(0, 10);
		let timeData = today.toISOString().slice(11, 16);
		document.getElementById('currentDate1').value = dateData;
		document.getElementById('currentTime1').value = timeData;

		today.setDate(today.getDate() + 1);
		today.setTime(today.getTime() + 12 * 1000 * 60 * 60);

		dateData = today.toISOString().slice(0, 10);
		timeData = today.toISOString().slice(11, 16);
		document.getElementById('currentDate2').value = dateData;
		document.getElementById('currentTime2').value = timeData;
	</script>
</body>
</html>