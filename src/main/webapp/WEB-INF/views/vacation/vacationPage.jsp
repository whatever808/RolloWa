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
</head>
<body>
	<div class="out-line">
	<!-- 메뉴판 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
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
					연차<br>
					<br>15일
				</div>
				<div class="line-border-square line-shadow">
					소실<br>
					<br>
					<span class="RedContext">1일</span>
				</div>
				<div class="line-border-square line-shadow">
					사용<br>
					<br>
					<span class="RedContext">33일</span>
				</div>
				<div class="line-border-square line-shadow">
					지급일<br>
					<br>
					<span class="gContext">3일</span>
				</div>
				<div class="line-border-square line-shadow">
					근무 연수<br>
					<br>3년
				</div>
			</div>
			<br>
			<div class="font-size25 jua-regular">휴가 신청</div>
			<br>
			<div class="vacation-request">
				<div class="line-border-square line-shadow">
					<a href="#" data-izimodal-open="#annual">
						<div>
							연차<br> <i class="fa-solid fa-plane"></i>
						</div>
					</a>
				</div>
				<div class="line-border-square line-shadow">
					<a href="#" data-izimodal-open="#half_vacation">
						<div>
							반차 <br> <i class="fa-solid fa-bolt"></i>
						</div>
					</a>
				</div>
				<div class="line-border-square line-shadow">
					<a href="#" data-izimodal-open="#ailment">
						<div>
							병가 <br> <i class="fa-solid fa-pills"></i>
						</div>
					</a>
				</div>
				<div class="line-border-square line-shadow">
					<a href="#" data-izimodal-open="#draft">
						<div>
							소집일<br> <i class="fa-solid fa-street-view"></i>
						</div>
					</a>
				</div>
				<div class="line-border-square line-shadow">
					<a href="#" data-izimodal-open="#other_vacation">
						<div>
							기타<br> <i class="fa-solid fa-earth-americas"></i>
						</div>
					</a>
				</div>
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

	<!-- 휴가신청 모달 영역 -->
	<!-- 연차 -->
	<div id="annual">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm">
				<i class="fa-solid fa-plane"></i>
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
		<div align="end">
			<button class="btn btn-outline-primary">신청</button>
		</div>
	</div>
	<script>
		$('#annual').iziModal({
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
	<div id="draft">
		<div class="Category">
			<div class="jua-regular">Category</div>
			<div class="line-cirecle-sm">
				<i class="fa-solid fa-street-view"></i>
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
			<button class="btn btn-outline-primary">신청</button>
		</div>
	</div>
	<script>
		$('#draft').iziModal({
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
	<div id="ailment">
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
			<button class="btn btn-outline-primary">신청</button>
		</div>
	</div>
	<script>
		$('#ailment').iziModal({
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
	<div id="half_vacation">
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
			<button class="btn btn-outline-primary">신청</button>
		</div>
	</div>
	<script>
		$('#half_vacation').iziModal({
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
	<div id="other_vacation">
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
			<button class="btn btn-outline-primary">신청</button>
		</div>
	</div>
	<script>
		$('#other_vacation').iziModal({
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
			<button class="btn btn-outline-warning">수정</button>
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
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
</body>
</html>