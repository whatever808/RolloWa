<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>어트랙션 등록</title>
	
	<!-- 놀이기구등록페이지 스타일 -->
    <link href="${ contextPath }/resources/css/facility/attraction/regist.css" rel="stylesheet">
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />

	<!-- content 추가 -->
	<div class="content p-5">
	
	    <div class="registForm">
	
	        <h1 class="page-title">놀이기구 등록</h1>
	
	        <!-- regist form start -->
	        <form action="" id="regist-form">
	            
	            <div class="field-group">
	                <label for="attraction-name" class="field-title">기구명</label><br>
	                <input type="text" id="attraction-name" placeholder="기구명을 입력하세요." required name="attractionName">
	            </div>
	            
	            <div class="field-group">
	                <label for="attraction-location" class="field-title">위치</label><br>
	                <select class="attraction-location form-select" id="attraction-location" name="location">
	                    <c:forEach var="location" items="${ locationList }">
	                    	<option value="${ location.locationNo }">${ location.locationName }</option>
	                    </c:forEach>
	                </select>
	            </div>
	
	            <div class="field-group">
	                <label for="capacity-limit" class="field-title">수용가능 인원</label><br>
	                <select class="capacity-limit form-select" id="capacity-limit" name="customerLimit">
	                    <option>1</option>
	                    <option>2</option>
	                    <option>3</option>
	                </select>
	            </div>
	
	            <div class="field-group">
	                <label class="field-title">연령제한</label><br>
	                
	                <input type="radio" name="ageLimit" id="age-limit-n">
	                <label class="form-check-label" for="age-limit-n">없음</label>
	
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	                <input type="radio" name="ageLimit" id="age-limit-y">
	                <label class="form-check-label" for="age-limit-y">있음</label>
	
	                <!-- if age-limit-y checked start -->
	                <div class="age-limit d-none">
	                    <input type="text" class="form-input" id="age-limit" placeholder="나이를 입력하세요.(숫자만)">
	                    <select class="form-select">
	                        <option>이상</option>
	                        <option>이하</option>
	                    </select>
	                </div>
	                <!-- if age-limit-y checked end -->
	            </div>
	
	            <div class="field-group">
	                <label class="field-title">키제한</label><br>
	                
	                <input type="radio" name="heightLimit" id="height-limit-n">
	                <label class="form-check-label" for="height-limit-n">없음</label>
	
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	                <input type="radio" name="heightLimit" id="height-limit-y">
	                <label class="form-check-label" for="height-limit-y">있음</label>
	
	                <!-- if height-limit-y checked start -->
	                <div class="height-limit d-none">
	                    <input type="text" class="form-input" id="height-limit" placeholder="키를 입력하세요.(숫자만)">
	                    <select class="form-select">
	                        <option>이상</option>
	                        <option>이하</option>
	                    </select>
	                </div>
	                <!-- if height-limit-y checked end -->
	            </div>
	
	            <div class="field-group">
	                <label for="attraction-intro" class="field-title">기구소개</label><br>
	                <textarea name="" id="attraction-intro" cols="30" rows="10" placeholder="기구를 소개해주세요." required></textarea>
	            </div>
	
	            <div class="button-group">
	                <button type="reset" class="btn btn-outline-warning">초기화</button>
	                <button type="submit" class="btn btn-outline-primary">등록하기</button>
	                <button type="button" class="btn btn-outline-secondary">임시저장</button>
	            </div>
	        
	        </form>
	        <!-- regist form end -->
	
	
	    </div>
	
	</div>
	<!-- content 끝 -->
	
	<!-- chat floating -->
  	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />

</body>

<!-- 어트랙션 등록페이지 스크립트 -->
<script>
	$(document).ready(function(){
	
	    // 연령 or 신장 제한이 있을경우 실행될 function ---------------------------------------------------------------------
	    $("input[name$=Limit]").on("change", function(){
	    	let $radioEl = $(this).attr("name") == 'ageLimit' ? $("#age-limit-y") : $("#height-limit-y");
	    	let $inputEl = $(this).attr("name") == 'ageLimit' ? $(".age-limit") : $(".height-limit");
	    	console.log($inputEl);
	    	
	        $radioEl.prop("checked") ? $inputEl.removeClass("d-none")
	                                 : $inputEl.addClass("d-none");
	    	
	    })
	    
	    // 연령제한 나이입력 or 키제한 키입력시 input 요소 유효성 검사용 function -------------------------------------------------------
	    $("#age-limit, #height-limit").on("keyup", function(){
	        const regExp = /^([1-9]{1}[0-9]{0,2})$/;
	
	        if(!regExp.test($(this).val())){
	            $(this).val("");
	            alert("유효한 나이값을 입력해주세요.");
	        }
	    })
	
	})
</script>
</html>