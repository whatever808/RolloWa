<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>어트랙션 등록</title>
	
	<!-- 어트랙션 등록페이지 스타일 -->
  	<link href="${ contextPath }/resources/css/facility/attraction/attraction_regist.css" rel="stylesheet">
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />

	<!-- content 추가 -->
	<div class="content p-5">
	
	    <div class="registForm">
	
	        <h1 class="page-title">어트랙션 등록</h1>
	
	        <!-- regist form start -->
	        <form action="${ contextPath }/attraction/regist.do" method="post" enctype="multipart/form-data" id="regist-form">
	            
	            <div class="field-group">
	                <label for="attraction-name" class="field-title">어트랙션명</label><br>
	                <input type="text" id="attraction-name" placeholder="어트랙션명을 입력하세요." name="attractionName">
	            </div>
	            
	            <div class="field-group">
	                <label for="attraction-thumbnail" class="field-title">대표이미지</label><br>
	                <input type="file" id="attraction-thumbnail" class="d-none" name="thumbnail" accept="image/*">
	                <img id="thumbnail-preview">
	            </div>
	            
	            <div class="field-group">
	                <label for="attraction-location" class="field-title">위치</label>
	                <input type="text" class="map text-center text-primary ms-3 mb-2" placeholder="지도에서 위치를 선택해주세요.">
	                <input type="hidden" name="location"><br>
	                <div id="map"></div>
	            </div>
	            
	            <script>
					$("input.map").on("keyup", function(){
						yellowAlert("지도에서 위치를 선택해주세요.", "");
						$(this).val("");
					})
				</script>
	            
	            <div class="field-group">
	                <label for="attraction-status" class="field-title">운영상태</label><br>
	                <select class="attraction-status form-select" id="attraction-status" name="status">
	                    <option value="PENDING">운영예정</option>
	                    <option value="OPERATING">운영중</option>
	                    <option value="STOP" class="show-reason">운영중지</option>
	                    <option value="CLOSED" class="show-reason">운영종료</option>
	                </select>
	            </div>
	
	            <div class="field-group">
	                <label for="capacity-limit" class="field-title">수용가능 인원</label><br>
	                <select class="capacity-limit form-select" id="capacity-limit" name="customerLimit">
	                    <c:forEach var="num" begin="0" end="1000">
	                    	<option>${ num }</option>
	                    </c:forEach>
	                </select>
	            </div>
	
	            <div class="field-group">
	                <label class="field-title">연령제한</label><br>
	                
	                <input type="radio" id="age-limit-n" name="ageLimit" value="N" checked>
	                <label class="form-check-label" for="age-limit-n">없음</label>
	
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	                <input type="radio" id="age-limit-y" name="ageLimit">
	                <label class="form-check-label" for="age-limit-y">있음</label>
	
	                <!-- if age-limit-y checked start -->
	                <div class="age-limit d-none">
	                    <input type="text" class="form-input text-center" id="age-limit" name="ageLimit" value="Y" placeholder="나이를 입력하세요.(숫자만)">
	                    <select class="form-select" name="ageLimitRange">
	                        <option>이상</option>
	                        <option>이하</option>
	                        <option>초과</option>
	                        <option>미만</option>
	                    </select>
	                </div>
	                <!-- if age-limit-y checked end -->
	            </div>
	
	            <div class="field-group">
	                <label class="field-title">키제한</label><br>
	                
	                <input type="radio" id="height-limit-n" name="heightLimit" value="N" checked>
	                <label class="form-check-label" for="height-limit-n">없음</label>
	
	                &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
	
	                <input type="radio" id="height-limit-y" name="heightLimit" value="Y">
	                <label class="form-check-label" for="height-limit-y">있음</label>
	
	                <!-- if height-limit-y checked start -->
	                <div class="height-limit d-none">
	                    <input type="text" class="form-input text-center" id="height-limit" name="heightLimit" placeholder="키를 입력하세요.(cm단위, 숫자만)">
	                    <select class="form-select" name="heightLimitRange">
	                        <option>이상</option>
	                        <option>이하</option>
	                        <option>초과</option>
	                        <option>미만</option>
	                    </select>
	                </div>
	                <!-- if height-limit-y checked end -->
	            </div>
	            
	            <div class="field-group">
	                <label for="attraction-intro" class="field-title">어트랙션 소개</label><br>
	                <textarea type="text" class="mh-5" id="attraction-intro" name="attractionIntro"></textarea>
	            </div>
	
	            <div class="button-group">
	                <button type="reset" class="btn btn-outline-warning">초기화</button>
	                <button type="submit" class="btn btn-outline-primary">등록하기</button>
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
<!-- Googel Map 스크립트 -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCfeL19x8FxIk3SsSNFLKuL9N_1w9pAs24&callback=initMap"></script>
<script>
	$(document).ready(function(){
		
		// 대표이미지 미리보기 관련 =======================================================================================
		$("#thumbnail-preview").on("click", function(){
       		$("#attraction-thumbnail").click();
       	})
       	
       	$("#attraction-thumbnail").on("change", function(){
       		var fileReg =  /(.*?)\.(jpg|jpeg|png|gif|bmp)$/i; // 이미지 정규식
       		const file = event.target.files[0];
       		const reader = new FileReader();
       		const $preview = $("#thumbnail-preview");
       		
       		if(fileReg.test(file.name)){
       			reader.onload = function(){
        			$preview.attr("src", reader.result);	
        		}
        		reader.readAsDataURL(file);	
       		}else{
       			yellowAlert("파일 업로드 서비스", "이미지 파일만 업로드가능합니다.");
       		}
       		
       	})
		
		// "운영중지" or "운영종료" 선택시, 사유입력란 추가 -------------------------------------------------------------------
		$("#attraction-status").on("change", function(){
			if($(this).val() == 'STOP' || $(this).val() == 'CLOSED'){
				$("input[name=statusReason]").remove();
				$(this).parent().append("<input type='text' name='statusReason' placeholder='사유를 입력해주세요.'>");
			}else{
				$("input[name=statusReason]").remove();
			}
		})
		
	    // 연령 or 신장 제한이 있을경우 실행될 function ---------------------------------------------------------------------
	    $("[id*=-limit-]").on("change", function(){
	    	let $radioEl = $(this).attr("name") == 'ageLimitYN' ? $("#age-limit-y") : $("#height-limit-y");
	    	let $inputEl = $(this).attr("name") == 'ageLimitYN' ? $(".age-limit") : $(".height-limit");
	    	
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
	    
	    // 등록요청전, 유효성검사 ------------------------------------------------------------------------------------------------
	    $("#regist-form").on("submit", function(){
	    	// 등록폼 입력값 유효성검사
	    	if(($("input[name=attractionName]").val()).trim().length == 0){
	    		yellowAlert("어트랙션명을 입력해주세요.", "");
	    		return false;
	    	}else if((document.getElementById("attraction-thumbnail")).files.length == 0){
	    		yellowAlert("대표이미지를 첨부해주세요.", "");
	    		return false;
	    	}else if(($("input[name=location]").val()).length == 0){
	    		yellowAlert("위치를 선택해주세요.", "");
	    		return false;
	    	}else if(($("input[name=status]").val() == 'STOP' || $("input[name=status]").val() == 'CLOSED')&&($("input[name=statusReason]").val()).length == 0){
	    		yellowAlert($("input[name=status]").text() + " 사유를 작성해주세요.", "");
	    		return false;
	    	}else if(!($(".age-limit").hasClass("d-none")) && ($("input[name=ageLimit]").val()).length == 0){
	    		yellowAlert("제한 나이를 입력해주세요.", "");
	    		return false;
	    	}else if(!($(".height-limit").hasClass("d-none")) && ($("input[name=heightLimit]").val()).length == 0){
	    		yellowAlert("제한 키를 입력해주세요.", "");
	    		return false;
	    	}else if(($("textarea[name=attractionIntro]").val()).length == 0){
	    		yellowAlert("어트랙션 소개를 작성해주세요.", "");
	    		return false;
	    	}
	    	return true;
	    })
	    
	})
	
	// 구글맵 관련 ============================================================================================================
	function initMap (){
		// 지도생성 및 설정
		const map = new google.maps.Map(document.getElementById("map"), {
			center: {lat: 35.636033359, lng: 139.878632426 },	// 초기값의 위도, 경도 설정
			zoom: 12,	// 지도 가까운 정도
		});
		
		// 어트랙션 위치 리스트조회
		$.ajax({
			url:"${ contextPath }/attraction/location/list.ajax",
			method:"get",
			async:false,
			success:function(locationList){
				locations = locationList;	// 놀이공원 위치목록
			},error:function(){
				console.log("SELECT LOCATION LIST AJAX FAILED");
			}
		});
		
		const bounds = new google.maps.LatLngBounds();		// 마커 위치표시를 위한 객체
		const infoWindow = new google.maps.InfoWindow();	// 마커 클릭시 보여질 정보창 객체
		
		locations.forEach(function(location){
			let locationNo = location.locationNo;
			let locationName = location.locationName;
			let latitude = parseFloat(location.latitude);
			let longitude = parseFloat(location.longitude);
			let mapMark = location.mapMark;
			
			// 마커생성 및 설정
			const marker = new google.maps.Marker({
				position: { lat: latitude, lng: longitude },
				label: mapMark,
				map: map,
			});
			bounds.extend(marker.position);	// 마커의 위치 정보를 넘겨줌
		
			// 마커클릭시, 보여질 정보성 메세지
			marker.addListener("click", function(){
				map.panTo(marker.position);				// 마커를 클릭했을 때, 마커가 있는 위치로 지도의 중심이 이동
				infoWindow.setContent(locationName);	// 마커를 클릭했을때, 보여질 내용
				infoWindow.open({
					anchor: marker,
					map: map,
				});
			
				// 등록시, 데이터베이스에 기록할 위치정보값 설정
				$("input.map").val(locationName);
				$("input[name=location]").val(locationNo);
			
			});
		});
		map.fitBounds(bounds);	// 지도 경계객체를 넘겨주면서 지도 경계조정하기
	}
</script>

</html>