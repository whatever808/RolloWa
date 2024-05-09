<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 목록</title>
	
	<!-- 게시글 목록페이지 스타일 -->
	<link href="${ contextPath }/resources/css/board/list.css" rel="stylesheet" />
</head>
<body>

	 <!-- side bar -->
	 <jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
	 <!-- content 추가 -->
	 <div class="content p-5">
	
	     <h1 class="page-title">게시글 목록</h1>
	
	     <!-- board category start -->
	     <select id="category" name="category" class="board-category form-select" onchange="categoryChange(this);" style="width:200px;">
	         <option value="">전체게시글</option>
	         <option value="normal">일반게시글</option>
	         <option value="department">부서게시글</option>
	     </select>
	     <!-- board category end -->
	     
	     <!-- show when department board category was selected -->
	     <select id="department" name="department" class="department-category form-select d-none" onchange="ajaxBoardList();">
	     	<option value="">전체</option>
	     	<c:forEach var="department" items="${ departmentList }">
	     		<option value="${ department.code }">${ department.codeName }</option>
	     	</c:forEach>
	     </select>
	
	     <!-- search form start-->
	     <div id="search-form">
	      <select id="condition" class="search-condition form-select">
	      	  <option value="">전체</option>
	          <option value="title">제목</option>
	          <option value="content">내용</option>
	          <option value="writer">작성자</option>
	      </select>
	      <input type="text" id="keyword" class="form-control" placeholder="게시글 검색">
	      <button type="button" class="btn btn-secondary" onclick="searchValidation();">검색</button>
	     </div>
	     <!-- search form end -->
	     
	     <!-- board list start -->
	     <div class="board-list">
	         <!-- board list table start-->
	         <table class="table table-hover">
	             <thead class="table-light">
	                 <tr>
	                     <th>부서</th>
	                     <th>제목</th>
	                     <th>작성자</th>
	                     <th>작성일</th>
	                     <th>조회수</th>
	                     <th>첨부파일</th>
	                 </tr>
	             </thead>
	             <tbody id="boardList">
	                <c:choose>
	                	<c:when test="${ empty boardList }">
	                		<tr>
	                			<td colspan="6">조회된 게시글이 없습니다.</td>
	                		</tr>
	                	</c:when>
	                	<c:otherwise>
	                		<c:forEach var="board" items="${ boardList }">
	                 		<tr>
	                      <td>${ board.category eq null ? "일반" : board.category }</td>
	                      <td class="board-title">${ board.title }</td>
	                      <td>
	                     		<c:choose>
	                     			<c:when test="${ not empty board.profileURL }">
	                     				<img src="${ board.profileURL }" alt="profile image" class="board-writer-profile">
	                     			</c:when>
	                     			<c:otherwise>
	                     				<img src="${ contextPath }/resources/images/defaultProfile.png" alt="profile image" class="board-writer-profile">
	                     			</c:otherwise>
	                     		</c:choose>
	                        <span>${ board.modifyEmp }</span>
	                      </td>
	                      <td>${ board.modifyDate }</td>
	                      <td>${ board.readCount }</td>
	                      <td>${ board.attachmentYN != 0 ? "🗂️" : "" }</td>
	                  	</tr>
	                		</c:forEach>
	                	</c:otherwise>
	                </c:choose>
	             </tbody>
	         </table>
	         <!-- board list table end -->
	
	         <!-- pagination start -->
	         <div class="board-list-pagination">
	             <ul class="pagination">
	             
	             	<!-- Previous -->
				      <li class="page-item ${ pageInfo.listCount != 0 && pageInfo.currentPage != 1 ? '' : 'disabled' }"
						    onclick="${ pageInfo.listCount != 0 && pageInfo.currentPage != 1 ? 'ajaxBoardList();' : '' }">
				      	<span class="page-link" data-pageno="${ pageInfo.currentPage - 1 }">Previous</span>
				      </li>
				    
				    <!-- Page -->
				    <c:forEach var="page" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
					    <li class="page-item ${ pageInfo.currentPage == page ? 'active' : '' }"
					    	  onclick="${ pageInfo.currentPage != page ? 'ajaxBoardList();' : '' }">
					    	<span class="page-link" data-pageno="${ page }">${ page }</span>
					    </li>
				    </c:forEach>
				    
				    <!-- Next -->
				    <li class="page-item ${ pageInfo.currentPage == pageInfo.maxPage ? 'disabled' : '' }"
				    	  onclick="${ pageInfo.currentPage != pageImfo.maxPage ? 'ajaxBoardList();' : ''}">
				      <span class="page-link" data-pageno="${ pageInfo.currentPage + 1 }">Next</span>
				    </li>
				    
				  </ul>
	         </div>
	         <!-- pagination end -->
	     </div>
	     <!-- board list end-->
	
	 </div>
	 <!-- content 끝 -->
	
	<!-- chat floating -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />


</body>

<!-- 게시글 목록페이지 스크립트 -->
<script src="${ contextPath }/resources/js/board/list.js"></script>

<script>
	// 게시글 카테고리값 변경(== 카테고리별 게시글 조회요청) ==============================================================================
	function categoryChange(option){
		// 1) 부서 선택 <select> 요소 숨김여부 처리
		$(option).val() == 'department' ? $("#department").removeClass("d-none")
										: $("#department").addClass("d-none")
														  .children("[value=all]").select();
		// 2) 게시글 목록조회 요청
		ajaxBoardList();
	}
	
	// 키워드검색 게시글 목록조회 요청시 입력값 유효성 체크 ================================================================================
	function searchValidation(){
		if($("#keyword").val().trim().length == 0){
			alertify.alert("게시글 목록조회 서비스", "검색어를 입력해주세요.", $("#keyword").select());
		}else{
			// 1) 키워드 검색요청시 "전체" 검색 value값 변경설정
			$("#keyword").children().each(function(){
				$(this).val() == '' && $(this).val("all");
			})
			
			// 2) 게시글 목록조회 요청
			ajaxBoardList();
		}
	}
	
	// 게시글 목록조회 (비동기식) ================================================================================================
	function ajaxBoardList(){
		// 1) 요청 페이지값 설정
		let page = event.target.dataset.pageno == undefined ? 1
																			 :event.target.dataset.pageno;
		
		// 2) 게시글 목록조회 AJAX
		$.ajax({
			url:"${ contextPath }/board/list.ajax",
			method:"get",
			data:{
				page:page,
				category:$("#category").val(),
				department:$("#department").val(),
				condition:$("#condition").val(),
				keyword:$("#keyword").val()
			},
			success:function(response){
				let boardList = response.boardList;	// 게시글 목록
				let pageInfo = response.pageInfo;	// 페이징바 정보
				let list = "";	// 갱신 리스트 문자열 태그
				let pagination = "";	// 갱신할 페이징바 문자열 태그
				
				console.log(response);
				
				// 1) 게시글 목록 리스트 갱신
				// 조회된 게시글이 없을 경우
				if(boardList.length == 0){
					list += "<tr>";
					list += 	"<td colspan='6'>조회된 게시글이 없습니다.</td>";
					list += "</tr>";
				}
				// 조회된 게시글이 있을 경우
				else{
					// 생성할 리스트 태그 문자열
					for(let i=0 ; i<boardList.length ; i++){
						list += "<tr>";
						list += 	"<td>" + (boardList[i].category == null ? "일반" : boardList[i].category) + "</td>";
						list += 	"<td class='board-title'>" + boardList[i].title + "</td>";
						list += 	"<td>";
						list += 		"<img src='" + (boardList[i].profileURL == null ? "${ contextPath }/resources/images/defaultProfile.png"
																					 	: boardList[i].profileURL) + "' alt ='profile image' class='board-writer-profile'>" 
						list += 		"<span>" + boardList[i].modifyEmp + "</span>";
						list += 	"</td>";
						list += 	"<td>" + boardList[i].modifyDate + "</td>";
						list += 	"<td>" + boardList[i].readCount + "</td>";
						list += 	"<td>" + (boardList[i].attachmentYN != 0 ? "🗂️" : "") + "</td>";
					}
					
					// 생성할 페이징바 태그 문자열
					pagination += "<li class='page-item >" + (pageInfo.listCount != 0 && pageInfo.currentPage != 1 ? 'disabled' : '' ) + "'" +
											"onclick='" + (pageInfo.listCount != 0 && pageInfo.currentPage != 1 ? 'ajaxBoardList();' : '') + "'>";
					pagination +=	   "<span class='page-link' data-pageno='" + (pageInfo.getCurrentPage - 1) + "'>Previous</span>";
					pagination += "</li>";
					
					for(let page=pageInfo.startPage ; page<=pageInfo.endPage ; page++){
						pagination += "<li class='page-item " + (pageInfo.currentPage == page ? 'active' : '') + "' " +
												"onclick='" + (pageInfo.currentPage != page ? 'ajaxBoardList();' : '') + "'";
						pagination += 		"<span class='page-link' data-pageno='" + page + "'>" + page + "</span>";
						pagination += "</li>";
					}
					
					pagination += "<li class='page-item " + (pageInfo.currentPage == pageInfo.maxPage ? 'disabled' : '') + "' " +
											"onclick='" + (pageInfo.currentPage != pageInfo.maxPage ? 'ajaxPageInfo();' : '') + "'>";
					pagination += 		"<span class='page-link' data-pageno='" + (pageInfo.currentPage + 1) + "'>Next</span>";
					pagination += "</li>";
				}
		
				$("#boardList").html(list);
				$("#board-list-pagination>.pagination").html(pagination);
				
				
				// 2) URL 주소값 변경
				history.pushState(null, null, "${ contextPath }/board/list.do?page=" + page +
																			"&category=" + $("#category").val() +
																			"&department=" + $("#department").val() +
																			"&condition=" + $("#condition").val() +
																			"&keyword=" + $("#keyword").val());
			},
			error:function(){
				console.log("SELECT BOARD LIST AJAX ERROR");
			}
		})
		
	}

	//페이지 로드 즉시 실행되어야할 functions ===========================================================================
	$(document).ready(function(){
		// 카테고리 select 박스 선택값 지정
		$("#category").children("option").each(function(){
			$(this).val() == "${ filter.category }" && $(this).attr("selected", true);
		})
		
		// "부서게시글" 목록조회 요청했을 경우, 부서 select 박스 선택값 지정 
		if($("#category").val() == 'department'){
			$("#department").removeClass("d-none");
			$("#department").children("option").each(function(){
				$(this).val() == "${ filter.department }" && $(this).attr("selected", true);
			})	
		}	
		
		// "키워드검색" 게시글 목록조회 요청했을 경우, 검색값 지정
		if(${ filter.condition != ''} && ${ filter.keyword != ''}){
			$("#condition").children("option").each(function(){
				if($(this).val() == '${ filter.condition }'){
					$(this).attr("selected", true);
					$("#keyword").val("${ filter.keyword }");
				} 	
			})	
		}	
	})	

</script>

</html>