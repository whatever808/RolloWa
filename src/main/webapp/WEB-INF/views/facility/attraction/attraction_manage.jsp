<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>어트랙션 관리</title>
	
	<!-- 놀이기구목록페이지 스타일 -->
  <link href="${ contextPath }/resources/css/facility/attraction/attraction_manage.css" rel="stylesheet">
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
	<!-- content 추가 -->
  	<div class="content m-5">

     <h1 class="page-title">어트랙션 관리</h1>

     <!-- about search start -->
	   <div id="filter-search">
	     	 <!-- search form start-->
		     <div id="search-form" class="input-group">
		       	
		      <!-- search keyword start -->
			    <span class="form-outline" data-mdb-input-init>
			        <input type="search" id="keyword" class="form-control"placeholder="어트랙션명 검색"/>
			    </span>
			    <!-- search keyword end -->
			    
			    <!-- search button start -->
			    <button id="search-btn" type="button" class="btn btn-secondary" onclick="searchValidation();" data-mdb-ripple-init>
			        <i class="fas fa-search"></i>
			    </button>
			    <!-- search button end -->
			    
			    <!-- reset search value start -->
			    <span id="reset-search" class="d-none">
			     	<span>
			   			<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-arrow-clockwise" viewBox="0 0 16 16">
							<path fill-rule="evenodd" d="M8 3a5 5 0 1 0 4.546 2.914.5.5 0 0 1 .908-.417A6 6 0 1 1 8 2z"/>
							<path d="M8 4.466V.534a.25.25 0 0 1 .41-.192l2.36 1.966c.12.1.12.284 0 .384L8.41 4.658A.25.25 0 0 1 8 4.466"/>
						</svg>
			     	</span>
			     	<span>검색 취소</span>
			    </span>
			    <!-- reset search value end -->
			    
		     </div>
		     <!-- search form end -->
	     </div>
	     <!-- about search end -->
	     
	   <!-- about location filtering start -->
	   <div id="map"></div>
	   <div class="search-location-list d-none"></div>
	   <!-- about location filtering end -->

       <!-- attraction list start -->
       <div class="attraction-list">
           <!-- attraction list table start-->
           <table class="table table-hover bg-white">
               <thead>
                 <tr class='text-center' style="align: center;">
                   <th class='attraction-name'>기구명</th>
                   <th class='attraction-location'>위치</th>
                   <th class='attraction-customer-limit'>최대수용인원</th>
                   <th class='attraction-age-limit'>연령제한</th>
                   <th class='attraction-height-limit'>키제한</th>
                   <th class='attraction-status'>
                   	 <!-- attraction status start -->
								     <select class="attraction-status-select form-select d-inline-block text-center">
								         <option value="">전체</option>
								         <option value="PENDING">운영예정</option>
								         <option value="OPERATING">운영중</option>
								         <option value="STOP">운영중지</option>
								         <option value="CLOSED">운영종료</option>
								     </select>
								     <!-- attraction status end -->
                   </th>
                   <th class='attraction-regist-emp'>등록자</th>
                   <th class='attraction-modify-emp'>수정자</th>
                   <th class='attraction-modify-button'></th>
                 </tr>
               </thead>
               <tbody id="attraction-list">
                 <c:choose>
                 	<c:when test="${ empty attractionList }">
                 		<tr>
                 			<td colspan="9">조회된 어트랙션이 없습니다.</td>
                 		</tr>
                 	</c:when>
                 	<c:otherwise>
                 		<c:forEach var="attraction" items="${ attractionList }">
                 			<tr class='attraction'>
			                   <td class="attraction-name">${ attraction.attractionName }</td>
			                   <td class='attraction-location'>${ attraction.locationName }</td>
			                   <td class='attraction-customer-limit'>${ attraction.customerLimit }</td>
			                   <td class='attraction-age-limit'>
			                     <c:out value="${ attraction.ageLimit }" />
			                   </td>
			                   <td class='attraction-height-limit'>
			                     <c:out value="${ attraction.heightLimit }" />
			                   </td>
			                   <td class='attraction-status'>
			                   	 <c:choose>
			                   	 	<c:when test="${ attraction.status.equals('PENDING') }">
				                      <span class="badge badge-secondary rounded-pill d-inline">운영예정</span>
			                   	 	</c:when>
			                   	 	<c:when test="${ attraction.status.equals('OPERATING') }">
				                      <span class="badge badge-success rounded-pill d-inline">운영중</span>
			                   	 	</c:when>
			                   	 	<c:when test="${ attraction.status.equals('STOP') }">
				                      <span class="badge badge-warning rounded-pill d-inline">운영중지</span>
			                   	 	</c:when>
			                   	 	<c:when test="${ attraction.status.equals('CLOSED') }">
				                      <span class="badge badge-danger rounded-pill d-inline">운영종료</span>
			                   	 	</c:when>
			                   	 </c:choose>
			                   </td>
			                   <td class='attraction-regist-emp'>${ attraction.registEmp }</td>
			                   <td class='attraction-modify-emp'>${ attraction.modifyEmp }</td>
			                   <td class='attraction-modify-button'>
			                   		<a href="${ contextPath }/attraction/modify.page?no=${ attraction.attractionNo }" class="btn btn-warning p-1">정보수정</a>
			                   </td>
			                 </tr>
                 		</c:forEach>
                 	</c:otherwise>
                 </c:choose>
               </tbody>
             </table>
           	 <!-- attraction list table end -->
		   
		   	 <!-- pagination start -->
	       	 <div class="attraction-list-pagination ${ pageInfo.listCount == 0 ? 'd-none' : '' }">
	           <ul class="pagination">
	             
	             	<!-- Previous -->
					      <li id="normal" class="page-item ${ pageInfo.listCount != 0 && pageInfo.currentPage != 1 ? '' : 'disabled' }"
							  				onclick="${ pageInfo.listCount != 0 && pageInfo.currentPage != 1 ? 'ajaxAttractionList();' : '' }">
					      	<span class="page-link" data-pageno="${ pageInfo.currentPage - 1 }">◁</span>
					      </li>
				    
						    <!-- Page -->
						    <c:forEach var="page" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
							    <li class="page-item ${ pageInfo.currentPage == page ? 'active' : '' }"
							    				onclick="${ pageInfo.currentPage != page ? 'ajaxAttractionList();' : '' }">
							    	<span class="page-link" data-pageno="${ page }">${ page }</span>
							    </li>
						    </c:forEach>
				    
						    <!-- Next -->
						    <li class="page-item ${ pageInfo.currentPage == pageInfo.maxPage ? 'disabled' : '' }"
						    		onclick="${ pageInfo.currentPage != pageInfo.maxPage ? 'ajaxAttractionList();' : ''}">
						      <span class="page-link" data-pageno="${ pageInfo.currentPage + 1 }">▷</span>
						    </li>
						    
				  		</ul>
	         </div>
	         <!-- pagination end -->

    </div>
    <!-- content 끝 -->
	
	<!-- chat floating -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
	
</body>

<!-- 어트랙션 조회 스크립트 -->
<!-- Googel Map 스크립트 -->
<script async defer src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCfeL19x8FxIk3SsSNFLKuL9N_1w9pAs24&callback=initMap"></script>
<script>
	// URL 페이지 요청시, 파라미터에 지정된 값이 있을경우, 해당값으로 선택값 및 입력값 지정
	$(document).ready(function(){
		const urlParams = new URLSearchParams(location.search);
		
		// "상태"값이 지정되었을 경우
		if(urlParams.get("status") != null && urlParams.get("status") != '') {
			$(".attraction-status-select").children().each(function(){
				$(this).val() == urlParams.get("status") && $(this).prop("selected", "true");
			});
		}
		
		// "키워드"값이 지정되었을 경우
		if(urlParams.get("keyword") != null && urlParams.get("keyword") != '') {
			$("#keyword").val(urlParams.get("keyword"));
		}
	})
	
	// 어트랙션 리스트조회 ============================================================================
	// "상태" 선택값 변경시
	$(".attraction-status-select").on("change", function(){
		ajaxAttractionList();
	})
	// 키워드값 입력후 "Enter"를 눌렀을 경우 =========================================================================================
	$("#keyword").on("keyup", function(){
		(event.key == 'Enter' || event.code == 'Enter') && searchValidation();
	})
	// 키워드검색 게시글 목록조회 요청시 입력값 유효성 체크 
	function searchValidation(){
		if($("#keyword").val().trim().length == 0){
			alertify.alert("어트랙션 조회서비스", "검색어를 입력해주세요.", $("#keyword").select());
		}else{
			// 1) 검색값 초기화 버튼 활성화
			showResetBtn();
			// 2) 검색어 앞뒤 공백 없애기
			$("#keyword").val($("#keyword").val().trim());
			// 3) 어트랙션 목록조회 요청
			ajaxAttractionList();
		}
	}
	// 검색값 설정값 초기화
	$("#reset-search").on("click", function(){
		// 1) 선택값 모두 초기화
		$("#keyword").val("");
		
		// 2) "검색 취소" 버튼 비활성화
		$(this).addClass("d-none");
		
		// 3) 게시글 목록조회 요청
		ajaxAttractionList();
	})
	// 검색 초기화 버튼 활성화
	function showResetBtn(){
		$("#reset-search").removeClass("d-none");
	}
	
	// 어트랙션 리스트조회 AJAX
	function ajaxAttractionList(){
		let page = $(event.target).data("pageno") == undefined ? 1 : $(event.target).data("pageno");
		let locationList = [];
		$(".search-location-list").children("input").each(function(){
			locationList.push($(this).val());
		});
		
		$.ajax({
			url:"${ contextPath }/attraction/manage/list.ajax",
			method:"get",
			data:{
				page: page,
				locations: locationList,
				status: $(".attraction-status-select").val(),
				keyword: $("#keyword").val().trim()
			},
			success:function(data){
				let attractionList = data.attractionList;	// 어트랙션 리스트
				let pageInfo = data.pageInfo;				// 페이징바 정보
				let list = "";			// 갱신 리스트 문자열 태그
				let pagination = "";	// 갱신할 페이징바 문자열 태그
				
				// 1) 어트랙션 리스트 갱신
				// 조회된 어트랙션이 없을 경우
				if(attractionList.length == 0){
					list += "<tr>";
					list += 	"<td colspan='9'>조회된 어트랙션이 없습니다.</td>";
					list += "</tr>";
				}
				// 조회된 어트랙션이 있을 경우
				else{
					// 생성할 리스트 태그 문자열
					for(let i=0 ; i<attractionList.length ; i++){
						list += "<tr class='attraction'>";
						list += 	"<td class='attraction-name'>" + attractionList[i].attractionName + "</td>";
						list += 	"<td class='attraction-location'>" + attractionList[i].locationName + "</td>";
						list += 	"<td class='attraction-customer-limit'>" + attractionList[i].customerLimit + "</td>";
						list += 	"<td class='attraction-age-limit'>" + (attractionList[i].ageLimit == null ? '' : attractionList[i].ageLimit) + "</td>";
						list += 	"<td class='attraction-height-limit'>" + (attractionList[i].heightLimit == null ? '' : attractionList[i].heightLimit) + "</td>";
						list += 	"<td class='attraction-status'>";
						switch(attractionList[i].status){
							case 'PENDING' :
								list += "<span class='badge badge-secondary rounded-pill d-inline'>운영예정</span>";
								break;
							case 'OPERATING' :
								list += "<span class='badge badge-success rounded-pill d-inline'>운영중</span>";
								break;
							case 'STOP' :
								list += "<span class='badge badge-warning rounded-pill d-inline'>운영중지</span>";
								break;
							case 'CLOSED' :
								list += "<span class='badge badge-danger rounded-pill d-inline'>운영종료</span>";
								break;
						}
						list += 	 "</td>";
						list += 	 "<td class='attraction-regist-emp'>" + attractionList[i].registEmp + "</td>";
						list += 	 "<td class='attraction-modify-emp'>" + attractionList[i].modifyEmp + "</td>";
						list += 	 "<td class='attraction-modify-button'>";
						list += 			"<a href='${ contextPath }/attraction/modify.page?no=" + attractionList[i].attractionNo + "' class='btn btn-warning p-1'>정보수정</a>";
						list += 	 "</td>";
						list +=  "</tr>";
					}
					
					// 생성할 페이징바 태그 문자열
					pagination += "<li id='ajax' class='page-item " + (pageInfo.currentPage == 1 ? 'disabled ' : ' ' ) + "'" +
												"onclick='" + (pageInfo.currentPage != 1 ? 'ajaxAttractionList();' : '') + "'>";
					pagination +=	   "<span class='page-link' data-pageno='" + (pageInfo.currentPage - 1) + "'>◁</span>";
					pagination += "</li>";
					
					for(let page=pageInfo.startPage ; page<=pageInfo.endPage ; page++){
						pagination += "<li class='page-item " + (pageInfo.currentPage == page ? 'active' : '') + "' " +
												 "onclick='" + (pageInfo.currentPage != page ? 'ajaxAttractionList();' : '') + "'>";
						pagination += 		"<span class='page-link' data-pageno='" + page + "'>" + page + "</span>";
						pagination += "</li>";
					}
					
					pagination += "<li class='page-item " + (pageInfo.currentPage == pageInfo.maxPage ? 'disabled' : '') + "' " +
											 "onclick='" + (pageInfo.currentPage != pageInfo.maxPage ? 'ajaxAttractionList();' : '') + "'>";
					pagination += 		"<span class='page-link' data-pageno='" + (pageInfo.currentPage + 1) + "'>▷</span>";
					pagination += "</li>";
				}
		
				$("#attraction-list").html(list);
				$(".attraction-list-pagination").children(".pagination").html(pagination);

			},error:function(){
				console.log("SELECT ATTRACTION LIST AJAX FAILED");
			}
		});
		
	}
	
  	 
	// 구글맵 관련 ====================================================================================
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
			
			let normalIcon = 'https://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Azure-icon.png';
 			let selectedIcon = 'https://icons.iconarchive.com/icons/icons-land/vista-map-markers/48/Map-Marker-Ball-Right-Pink-icon.png';
			
			// 마커생성 및 설정
			const marker = new google.maps.Marker({
				position: { lat: latitude, lng: longitude },
				label: locationName,
				map: map,
				icon: normalIcon,
			});
			bounds.extend(marker.position);	// 마커의 위치 정보를 넘겨줌
	
			// 마커클릭시, 보여질 정보성 메세지
			marker.addListener("click", function(){
				map.panTo(marker.position);				// 마커를 클릭했을 때, 마커가 있는 위치로 지도의 중심이 이동
				
				// 조회요청시 전달될 위치값 설정
				if(marker.getIcon() == selectedIcon){
					marker.setIcon(normalIcon);
					$(".search-location-list").children("input").each(function(){
						$(this).attr("location-name") == marker.label && $(this).remove();
					});
					ajaxAttractionList();
				} else{
					marker.setIcon(selectedIcon);
					$(".search-location-list").append("<input type='hidden' class='search-location' location-name='" + locationName + "' value='" + locationNo + "'>");
					ajaxAttractionList();
				}
			
			});
		});
		map.fitBounds(bounds);	// 지도 경계객체를 넘겨주면서 지도 경계조정하기
	}

</script>

</html>