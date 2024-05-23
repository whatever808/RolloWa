<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>점포등록</title>
	
	<!-- 점포등록 스타일 -->
	<link href="${ contextPath }/resources/css/facility/store/store_regist.css" rel="stylesheet">
	
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />

	<!-- content 추가 -->
	<div class="content p-5">
	
	    <!-- regist form area start -->
	    <div class="registForm">
	
	        <h1 class="page-title">점포 등록</h1>
	
	        <!-- regist form start -->
	        <form action="" id="regist-form">
	            
	            <!-- shop name -->
	            <div class="field-group">
	                <label for="shop-name" class="field-title">점포명</label><br>
	                <input type="text" id="shop-name" placeholder="점포명을 입력하세요." required>
	            </div>
	            
	            <!-- shop category -->
	            <div class="field-group">
	                <label for="shop-catetory" class="field-title">유형</label><br>
	                <select class="shop-category form-select" id="shop-category">
	                    <option>레스토랑</option>
	                    <option>기프트샵</option>
	                </select>
	            </div>
	
	            <!-- shop location -->
	            <div class="field-group">
	                <label for="shop-location" class="field-title">위치</label><br>
	                <select class="shop-location form-select" id="shop-location">
	                    <option>A zone</option>
	                    <option>B zone</option>
	                    <option>C zone</option>
	                </select>
	            </div>
							
							<!-- manager -->
	            <div class="field-group">
	                <label for="manager" class="field-title">담당자</label><br>
	                <select class="shop-location form-select" id="manager" name="manageEmp">
	                    <option>A zone</option>
	                    <option>B zone</option>
	                    <option>C zone</option>
	                </select>
	            </div>
							
	            <!-- capacity limit -->
	            <div class="field-group">
	                <label for="capacity-limit" class="field-title">수용가능 인원</label><br>
	                <select class="capacity-limit form-select" id="capacity-limit">
	                    <option>1</option>
	                    <option>2</option>
	                    <option>3</option>
	                </select>
	            </div>
	            
	            <!-- status -->
							<div class="field-group">
	                <label for="store-status" class="field-title">운영상태</label><br>
	                <select class="store-status form-select" id="store-status">
	                    <option value="T">영업예정</option>
	                    <option value="Y">영업중</option>
	                    <option value="S">영업중지</option>
	                    <option value="C">영업종료</option>
	                </select>
	            </div>
							
							
	            <!-- working hour -->
	            <div class="field-group">
	                <label for="work-hour" class="field-title">영업시간</label><br>
	                <input type="time" id="work-hour">~<input type="time" id="work-hour-end">
	            </div>
	
	            <!-- holiday -->
	            <div class="field-group">
	                <label class="field-title">휴무일</label><br>
	
	                <input type="radio" name="shop_holiday" id="holiday-n">
	                <label for="holiday-n" style="margin-right: 50px;">없음</label>
	
	                <input type="radio" name="shop_holiday" id="holiday-y">
	                <label for="holiday-y">있음</label>
	
	                <!-- show when holiday-y checked -->
	                <div class="holiday-div">
	                    <select class="holiday-cycle form-select">
	                        <option>매주</option>
	                        <option>매달</option>
	                    </select>
	
	                    <!-- "매주"를 선택했을 경우 보여짐 -->
	                    <select class="day-of-week form-select">
	                        <option>월요일</option>
	                        <option>화요일</option>
	                        <option>수요일</option>
	                        <option>목요일</option>
	                        <option>금요일</option>
	                        <option>토요일</option>
	                        <option>일요일</option>
	                    </select>
	
	                    <!-- "매달"을 선택했을 경우 
	                    <select class="day-of-month form-select">
	                        <option>월요일</option>
	                        <option>화요일</option>
	                        <option>수요일</option>
	                        <option>목요일</option>
	                        <option>금요일</option>
	                        <option>토요일</option>
	                        <option>일요일</option>
	                    </select>
	                    -->
	                </div>
	
	            </div>
	            
	            <!-- contract -->
	            <div class="field-group">
	                <label for="contract-start" class="field-title">계약기간</label><br>
	                <input type="date" id="contract-start">~<input type="date" id="contract-end">
	            </div>
	            
	            <!-- store manager -->
	            <div class="field-group">
	                <label for="store-manager" class="field-title">대표자명</label><br>
	                <input type="text" id="store-manager">
	            </div>
							
							<!-- store phone -->
	            <div class="field-group">
	                <label for="store-phone" class="field-title">점포연락처</label><br>
	                <input type="text" id="store-phone">
	            </div>
							
	            <div class="button-group">
	                <button type="reset" class="btn btn-outline-warning">초기화</button>
	                <button type="submit" class="btn btn-outline-primary">등록하기</button>
	            </div>
	        
	        </form>
	        <!-- regist form end -->
	
	    </div>
	    <!-- regist form area end-->
	
	</div>
	<!-- content 끝 -->
	
	<!-- chat floating -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />

</body>

<script>
	$(document).ready(function(){
		// 전화번호 입력값 유효성 검사 =================================================================
		$("#store-phone").on("keyup", function(){
			const regExp = /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?[0-9]{3,4}-?[0-9]{4}$/;
			
			if(!regExp.test($(this).val())){
				alert("전화번호 형식이 유효하지 않습니다.");
				
			}
		})
		
		// "운영중지" or "운영종료" 선택시, 사유입력란 추가 -------------------------------------------------------------------
		$("#store-status").on("change", function(){
			console.log("영업중");
			if($(this).val() == 'S' || $(this).val() == 'C'){
				$(this).parent().append("<input type='text' name='statusReason' placeholder='사유를 입력해주세요.'>");
			}else{
				$("input[name=statusReason]").remove();
			}
		})
	})

</script>
</html>