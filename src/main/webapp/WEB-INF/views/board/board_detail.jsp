<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지사항 상세</title>
	
	<!-- 게시글상세페이지 스타일 -->
  <link href="${ contextPath }/resources/css/board/detail.css" rel="stylesheet"> 
</head>
<body>
	
	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
	<!-- content 추가 -->
	<div class="content p-5">
	
	    <!-- board detail area start -->
	    <div class="board-detail">
	
	        <h1 class="page-title">공지사항 상세</h1>
	
	        <!-- board header area start -->
	        <div class="board-header">
					
				<!-- header left area start -->
	            <div class="board-header-left">
	            	<!-- board title -->
	            	<div class="title">${ board.title }</div>
						
					<!-- board info area start  -->
	                <div class="board-info">
	                    <div class="info-first">
	                    	<c:choose>
	                    		<c:when test='${ empty board.profileURL }'>
		                    		<img src="${ contextPath }/resources/images/defaultProfile.png" alt="profile image" class="writer-profile-image">
	                    		</c:when>
	                    		<c:otherwise>
	                    			<img src="${ contextPath }${ board.profileURL }" alt="profile image" class="writer-profile-image">
	                    		</c:otherwise>
	                    	</c:choose>
                    		<label class="ms-2">${ board.writerName }</label>
	                    </div>
	                    <div class="info-middle">
	                    	<c:out value="${ board.category }" default="일반" />
	                    </div>
	                    <div class="info-last">조회수 ${ board.readCount }</div>
	                </div>
	                <!-- board info area end  -->
	            </div>
	            <!-- header left area end -->
	            
	            <!-- header right area start -->
	            <div class="board-header-right">
	            	 <!-- regist date  -->
	            	 <span class="board-regist-date">${ board.modifyDate }</span>
	            	 
	            	 <!-- edit area (로그인 사용자 == 게시글 작성자일 경우에만 보여짐) -->
	            	 <c:if test="${ loginMember.userNo == board.modifyEmp }">
	            	   <c:choose>
	            	   	 <c:when test='${ pageType.equals("list") }'>
	            	   	   <!-- from 공지목록페이지 -->
					       <div class="edit-area">
					         <a href="${ contextPath }/board/modify.page?no=${ board.boardNo }" class="text-primary">수정하기</a>
					         <a href="${ contextPath }/board/status/modify.do?no=${ board.boardNo }&fyn=${ empty board.attachmentList ? 'N' : 'Y' }" class="text-warning temp">임시저장으로 변경</a>
					         <a href="${ contextPath }/board/delete.do?no=${ board.boardNo }&fyn=${ empty board.attachmentList ? 'N' : 'Y'}" class="text-danger delete">삭제하기</a>
					       </div>
	            	   	 </c:when>
	            	   	 <c:when test='${ pageType.equals("publisher") }'>
	            	   	   <!-- from 등록공지보관함 -->
					       <div class="edit-area">
					         <a href="${ contextPath }/board/publisher/modify.page?no=${ board.boardNo }" class="text-primary">수정하기</a>
					         <a href="${ contextPath }/board/publisher/status/modify.do?no=${ board.boardNo }&fyn=${ empty board.attachmentList ? 'N' : 'Y' }" class="text-warning temp">임시저장으로 변경</a>
					         <a href="${ contextPath }/board/publisher/delete.do?no=${ board.boardNo }&fyn=${ empty board.attachmentList ? 'N' : 'Y'}" class="text-danger delete">삭제하기</a>
						   </div>
	            	   	 </c:when>
	            	   	 <c:when test='${ pageType.equals("temp") }'>
	            	   	   <!-- from 임시공지보관함 -->
					       <div class="edit-area">
				             <a href="${ contextPath }/board/temp/modify.page?no=${ board.boardNo }" class="text-primary">수정하기</a>
				             <a href="${ contextPath }/board/temp/post.do?no=${ board.boardNo }" class="text-warning post" id="post-from-temp">등록하기</a>
				             <a href="${ contextPath }/board/temp/delete.do?no=${ board.boardNo }&fyn=${ empty board.attachmentList ? 'N' : 'Y'}" class="text-danger delete">삭제하기</a>
				           </div>
	            	   	 </c:when>
	            	   </c:choose>
				     </c:if>
	            </div>
	            <!-- header right area end -->	             
	            
	        </div>
	        <!-- board header area end -->
	
	        <!-- board attachment area start (display when the board has attachments) -->
	        <c:if test="${ not empty board.attachmentList }">
		        <div class="board-attachment-list">
		
		            <div class="attachment-list-info">
		                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi show-hide show" viewBox="0 0 16 16">
		                    <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
		                </svg>
		                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi show-hide hide d-none" viewBox="0 0 16 16">
		                    <path d="m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z"/>
		                </svg>
		
		                <span class="about-attachment-list">첨부파일 : 파일 ${ board.attachmentList.size() }개</span>
		            </div>
						
		            <div class="attachment-list d-none">
		              <ul class="list">
		                <c:forEach var="attachment" items="${ board.attachmentList }">
			              <li>
			                <a download="${ attachment.originName }" href="${ contextPath }${ attachment.attachPath }/${ attachment.modifyName }" class="file-link">
			                  <span class="file-name">${ attachment.originName }</span>
			                </a>
			              </li>
		                </c:forEach>
		              </ul>
		            </div>
		        </div>
	        </c:if>
	        <!-- board attachment area end -->
	
	        <!-- board content area start -->
	        <div class="board-content-area">
	            <div class="board-content" id="board-content">
	                <c:out value="${ board.content }" escapeXml="false" />
	            </div>
	        </div>
	        <!-- board content area end -->
	        
	        <!-- board change button area start -->
	        <div class="change-board">
	
	            <!-- move to previous board -->
	            <a id="prev-board" class="list list-group list-group-item-action list-group-item-light d-inline-block text-truncate text-center"></a>
	            
	            <!-- move to board list page -->
	            <a id="list-board" class="list list-group list-group-item-action list-group-item-warning">목록</a>
	
	            <!-- move to next board -->
				<a id="next-board" class="list list-group list-group-item-action list-group-item-light d-inline-block text-truncate text-center"></a>
	
	        </div>
	        <!-- board change button area end -->
	        
	    </div>
	    <!-- board detail area end -->
	
	</div>
	<!-- content 끝 -->
	
	<!-- chat floating -->
  	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />

</body>

<script>
	const urlParams = new URLSearchParams(location.search); // 현재 공지사항의 URL 파라미터값 스트링 객체
	let pageType = "${ pageType }";
	let ajaxURL = "";
	let changeStatusUrlPrefix = "";
	let listPageURL = "";
	$(document).ready(function(){	 
	    if(pageType == "list"){
	    	ajaxURL = "${ contextPath }/board/detail/list.ajax";
	    	listPageURL = "${ contextPath }/board/list.do?" + urlParams.toString();
	    	changeStatusUrlPrefix = "${ contextPath }/board";
	    }else if(pageType == "publisher"){
	    	ajaxURL = "${ contextPath }/board/publisher/detail/list.ajax";
	    	listPageURL = "${ contextPath }/board/publisher/list.do?" + urlParams.toString();
	    	changeStatusUrlPrefix = "${ contextPath }/board/publisher/detail.do?";
	    }else if(pageType == "temp"){
	    	ajaxURL = "${ contextPath }/board/temp/detail/list.ajax";
	    	listPageURL = "${ contextPath }/board/temp/list.do?" + urlParams.toString();
	    	changeStatusUrlPrefix = "${ contextPath }/board/temp/detail.do?";
	    }
	    
	 	// 공지사항 목록조회 AJAX ------------------------------------------------------------------------------------------------------	
	    $.ajax({
	    	url: ajaxURL,
	    	method: "get",
	    	data: urlParams.toString(),
	    	success: function(boardList){
	    		// 조회한 공지사항 목록중 상세조회한 현재 게시글의 인덱스 번호
	    		let boardIndex = boardList.findIndex(function(board){
	    			return board.boardNo == ${ board.boardNo };
	    		});
	    		
	    		let $nextBoardBtn = $("#next-board");
	    		// 다음 공지사항 이동버튼
	    		if(boardIndex != 0){
	    			// 현재 공지사항 조회한 공지사항 목록의 첫번째 공지사항(최신공지)이 아닐경우
	    			$nextBoardBtn.text(boardList[boardIndex - 1].title);
	    			moveBoard($nextBoardBtn, boardList[boardIndex - 1].boardNo, boardList[boardIndex - 1].modifyEmp);
	    		}else{
	    			// 현재 공지사항이 조회한 공지사항 목록의 첫번째 공지사항(최신공지)일 경우
	    			$nextBoardBtn.text("다음 글이 없습니다.").css("pointer-events", "none");
	    		}
				
	    		let $prevBoardBtn = $("#prev-board");
	    		// 이전 공지사항 이동버튼
	    		if(boardIndex != (boardList.length - 1)){
	    			// 현재 공지사항이 조회한 공지사항 목록의 마지막 공지사항(최초공지)이 아닐 경우
	    			$prevBoardBtn.text(boardList[boardIndex + 1].title);
	    			moveBoard($prevBoardBtn, boardList[boardIndex + 1].boardNo,boardList[boardIndex + 1].modifyEmp);
	    		}else{
	    			// 현재 공지사항이 조회한 공지사항 목록의 마지막 공지사항(최초공지)일 경우
	    			$prevBoardBtn.text("이전 글이 없습니다.").css("pointer-events", "none");
	    		}

	    		// 공지사항 목록 이동
	    		urlParams.delete("no");
	    		$("#list-board").attr("href", listPageURL);
	    		
	    	},error: function(){
	    		console.log("SELECT BOARD LIST AJAX FAILED");
	    	}
	    });
	    
	    // 공지사항 상태변경 요청시 재확인용 ----------------------------------------------------------------------------------------------
	    $(".temp, .delete, .post").on("click", function(){
	    	let request = $(this).hasClass('temp') ? '임시저장' : ($(this).hasClass('delete') ? '삭제' : '등록');
				if(confirm("공지사항을 " + request + " 하시겠습니까?")){
					return true;
				}
				return false;
	    });
	    
	 	// 첨부파일 목록 숨김 or 노출 --------------------------------------------------------------------------------------------------
	    $(".show-hide").on("click", function(){
	    	let $attachmentList = $(".attachment-list");
	    	let $this = $(this);
	        if($(this).hasClass("show")){       // 리스트 노출요청
	            // 첨부파일 리스트 보여주기
	            $attachmentList.removeClass("d-none");
	
	            // 기존 아이콘(show 아이콘) 숨기기
	            $this.addClass("d-none");
	
	            // "숨김(위화살표)" 아이콘 노출
	            $this.siblings(".hide").removeClass("d-none");
	
	        }else if($(this).hasClass("hide")){ // 리스트 숨김요청
	            // 첨부파일 리스트 숨김처리
	            $attachmentList.addClass("d-none");
	
	            // 기존 아이콘(hide 아이콘) 숨기기
	            $this.addClass("d-none");
	
	            // "열기(아래화살표)" 아이콘 노출
	            $this.siblings(".show").removeClass("d-none");
	        }
	    });
	    
	});
	
	// ======================================== functions ======================================== 
	// 이전 | 다음 공지사항 페이지 이동
    function moveBoard(element, boardNo, requestBoardWriter){
		urlParams.set("no", boardNo);	// 글번호 파라미터값 변경
		
		if(changeStatusUrlPrefix == "${ contextPath }/board"){
			changeStatusUrlPrefix += (${ loginMember.userNo } != requestBoardWriter) ? "/reader/detail.do?" // 로그인 사용자가 이전 공지사항의 작성자가 아닐경우
																					 : "/detail.do?";		// 로그인 사용자가 이전 공지사항의 작성자일 경우
		}
  		element.attr("href",  changeStatusUrlPrefix + urlParams.toString());
    }
	
</script>

</html>