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
                    		<img src="${ contextPath }/resources/images/defaultProfile.png" alt="profile image" class="writer-profile-image">
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
					       <div class="edit-area">
					           <a href="${ contextPath }/board/modify.page?no=${ board.boardNo }" class="text-primary">수정하기</a>
					           <a href="${ contextPath }/board/status/modify.do?boardNo=${ board.boardNo }&fyn=${ empty board.attachmentList ? 'N' : 'Y' }" class="text-warning temp">임시저장으로 변경</a>
					           <a href="${ contextPath }/board/delete.do?boardNo=${ board.boardNo }&fyn=${ empty board.attachmentList ? 'N' : 'Y'}" class="text-danger delete">삭제하기</a>
					       </div>
				       </c:if>
	            </div>
	            <!-- header right area end -->
	             
	            
	        </div>
	        <!-- board header area end -->
	
	        <!-- board attachment area start (display when the board has attachments) -->
	        <c:if test="${ not empty board.attachmentList }">
		        <div class="board-attachment-list">
		
		            <div class="attachment-list-info">
		                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi show-hide show d-none" viewBox="0 0 16 16">
		                    <path d="M7.247 11.14 2.451 5.658C1.885 5.013 2.345 4 3.204 4h9.592a1 1 0 0 1 .753 1.659l-4.796 5.48a1 1 0 0 1-1.506 0z"/>
		                </svg>
		                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi show-hide hide" viewBox="0 0 16 16">
		                    <path d="m7.247 4.86-4.796 5.481c-.566.647-.106 1.659.753 1.659h9.592a1 1 0 0 0 .753-1.659l-4.796-5.48a1 1 0 0 0-1.506 0z"/>
		                </svg>
		
		                <span class="about-attachment-list">첨부파일 : 파일 ${ board.attachmentList.size() }개</span>
		            </div>
						
						
		            <div class="attachment-list d-none">
		                <ul class="list">
		                    <c:forEach var="attachment" items="${ board.attachmentList }">
			                    <li>
			                        <a href="${ contextPath }${ attachment.attachPath }/${ attachment.modifyName }" class="file-link">
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
	                <!--<c:out value="${ board.content }" escapeXml="false" />-->
	            </div>
	        </div>
	        <!-- board content area end -->
	        
	        <!-- board change button area start -->
	        <div class="change-board">
	
	            <!-- move to previous board -->
	            <a id="prev-board" class="list list-group list-group-item-action list-group-item-light">
	            	<svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
					  <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0"/>
					</svg>
					<span id="prev-board-title"></span>
	            </a>
	            
	            <!-- move to board list page -->
	            <a id="list-board" class="list list-group list-group-item-action list-group-item-warning">목록</a>
	
	            <!-- move to next board -->

				<a id="next-board" class="list list-group list-group-item-action list-group-item-light">다음 게시글 제목</a>

	
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
	$(document).ready(function(){
		var data = '${ board.content }';
		
		$("#board-content").html(data);
		
	    // attachment list show or hide function start ------------------------------------------------------------------------
	    $(".show-hide").on("click", function(){
	        if($(this).hasClass("show")){       // 리스트 노출요청
	            // 첨부파일 리스트 보여주기
	            $(".attachment-list").removeClass("d-none");
	
	            // 기존 아이콘(show 아이콘) 숨기기
	            $(this).addClass("d-none");
	
	            // "숨김(위화살표)" 아이콘 노출
	            $(this).siblings(".hide").removeClass("d-none");
	
	        }else if($(this).hasClass("hide")){ // 리스트 숨김요청
	            // 첨부파일 리스트 숨김처리
	            $(".attachment-list").addClass("d-none");
	
	            // 기존 아이콘(hide 아이콘) 숨기기
	            $(this).addClass("d-none");
	
	            // "열기(아래화살표)" 아이콘 노출
	            $(this).siblings(".show").removeClass("d-none");
	        }
	    })
	    // attachment list show or hide function end ------------------------------------------------------------------------
		
	    // 공지사항 목록조회 ======================================================================================================		 
	    $.ajax({
	    	url:"${ contextPath }/board/detail/list.ajax",
	    	method:"get",
	    	data:urlParams.toString(),
	    	success:function(boardList){
	    		// 조회한 공지사항 목록중 상세조회한 현재 게시글의 인덱스 번호
	    		let boardIndex = boardList.findIndex(function(board){
	    			return board.boardNo == ${ board.boardNo }
	    		});
	    		
	    		// 다음 공지사항 이동버튼
	    		if(boardIndex != 0){
	    			// 현재 공지사항 조회한 공지사항 목록의 첫번째 공지사항(최신공지)이 아닐경우
	    			$("#next-board").text(boardList[boardIndex - 1].title);
	    			moveBoard($("#next-board"), boardList[boardIndex - 1].boardNo, boardList[boardIndex - 1].modifyEmp);
	    		}else{
	    			// 현재 공지사항이 조회한 공지사항 목록의 첫번째 공지사항(최신공지)일 경우
	    			$("#next-board").text("다음 글이 없습니다.")
	    								 .css("pointer-events", "none");
	    		}

	    		// 이전 공지사항 이동버튼
	    		if(boardIndex != (boardList.length - 1)){
	    			// 현재 공지사항이 조회한 공지사항 목록의 마지막 공지사항(최초공지)이 아닐 경우
	    			$("#prev-board").text(boardList[boardIndex + 1].title);
	    			moveBoard($("#prev-board"), boardList[boardIndex + 1].boardNo,boardList[boardIndex + 1].modifyEmp);
	    		}else{
	    			// 현재 공지사항이 조회한 공지사항 목록의 마지막 공지사항(최초공지)일 경우
	    			$("#prev-board").text("이전 글이 없습니다.")
					 					 .css("pointer-events", "none");
	    		}


	    		// 공지사항 목록 이동
	    		urlParams.delete("no");
	    		$("#list-board").attr("href", "${ contextPath }/board/list.do?" + urlParams.toString());
	    		
	    	},error:function(){
	    		console.log("공지사항 목록조회 AJAX 실패");
	    	}
	    })
	    
	 	 // 이전 | 다음 공지사항 페이지 이동
	    function moveBoard(element, boardNo, boardWriter){
			// 글번호 파라미터값 변경
			urlParams.set("no", boardNo);
	   	if(${ loginMember.userNo } != boardWriter){
	  			// 로그인 사용자가 이전 or 다음 공지사항의 작성자가 아닐경우
	  			element.attr("href",  "${ contextPath }/board/reader/detail.do?" + urlParams.toString());
	  		}else{
	  			// 로그인 사용자가 이전 or 다음 공지사항의 작성자일 경우
	  			element.attr("href", "${ contextPath }/board/detail.do?" + urlParams.toString());
	  		}
	    }
	    
	    // 임시저장으로 변경 or 공지사항 삭제요청시 요청사항 확인용 function ============================================================================
	    $(".temp, .delete").on("click", function(){
	    	let request = $(this).hasClass("delete") ? '삭제' : '임시저장';
			if(confirm("공지사항을 " + request + " 하시겠습니까?")){
				return true;
			}
			return false;
	    })
	    
	})
	
    // 현재 공지사항의 URL 파라미터값 스트링 객체
	const urlParams = new URLSearchParams(location.search);
	
	// 이전 | 다음 공지사항 페이지 이동
    function moveBoard(element, boardNo, requestBoardWriter){
		// 글번호 파라미터값 변경
		urlParams.set("no", boardNo);
		
   		if(${ loginMember.userNo } != requestBoardWriter){
  			// 로그인 사용자가 이전 공지사항의 작성자가 아닐경우
  			element.attr("href",  "${ contextPath }/board/reader/detail.do?" + urlParams.toString());
  		}else{
  			// 로그인 사용자가 이전 공지사항의 작성자일 경우
  			element.attr("href", "${ contextPath }/board/detail.do?" + urlParams.toString());
  		}
		
    }
	
</script>

</html>