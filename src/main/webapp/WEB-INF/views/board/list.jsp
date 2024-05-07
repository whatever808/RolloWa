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
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	
	<!-- content 추가 -->
  <div class="content p-5">

      <h1 class="page-title">게시글 목록</h1>

      <!-- board category start -->
      <select id="category" name="category" class="board-category form-select" onchange="boardList();" style="width:200px;">
          <option value="all">전체게시글</option>
          <option value="normal">일반게시글</option>
          <option value="department">부서게시글</option>
      </select>
      <!-- board category end -->
      
      <script>
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
     			}			// if end
      	})	// ready() end
      	
      	// 게시글 목록조회 function
      	function boardList(){
      		// 요청 페이지
      		let page = "";
      		if(event.target.innerText == "Previous"){
      			page = ${ pageInfo.currentPage - 1};
      		}else if(event.target.innerText >= ${ pageInfo.startPage } && event.target.innerText <= ${ pageInfo.endPage }){
      			page = event.target.innerText;
      		}else if(event.target.innerText == "Next"){
      			page = ${ pageInfo.currentPage + 1};
      		}else{
      			page = 1;
      		}
      		
      		// URL 페이지요청
      		location.href = "${ contextPath }/board/list.do?" + "category=" + $("#category").val() + "&"
      																											+ "department=" + $("#department").val() + "&"
      																											+ "condition=" + $("#condition").val() + "&"
      																											+ "keyword=" + $("#keyword").val().trim() + "&"
      																											+ "page=" + page
      		
      	}
      </script>
      
      <!-- show when department board category was selected -->
      <select id="department" name="department" class="department-category form-select d-none" onchange="boardList();">
      	<option value="all">전체</option>
      	<c:forEach var="department" items="${ departmentList }">
      		<option value="${ department.groupCode }">${ department.codeName }</option>
      	</c:forEach>
      </select>

      <!-- search form start-->
      <div id="search-form">
	      <select id="condition" class="search-condition form-select">
	      		<option value="">선택</option>
	      		<option value="all">전체</option>
	          <option value="title">제목</option>
	          <option value="content">내용</option>
	          <option value="writer">작성자</option>
	      </select>
	      <input type="text" id="keyword" class="form-control" placeholder="게시글 검색">
	      <button type="button" class="btn btn-secondary" onclick="boardList();">검색</button>
      </div>
      <!-- search form end -->
      
      <!-- board list start -->
      <div class="board-list">
          <!-- board list table start-->
          <table class="table table-hover">
              <thead class="table-light">
                  <tr>
                      <th>제목</th>
                      <th>부서</th>
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
	                      <td class="board-title">${ board.boardTitle }</td>
	                      <td>${ board.boardCategory eq null ? "일반" : board.boardCategory }</td>
	                      <td>
	                     		<c:choose>
	                     			<c:when test="${ not empty board.profileURL }">
	                     				<img src="" alt="profile image" class="board-writer-profile">
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
              <ul class="pagination justify-content-center">
              	<!-- Previous -->
                <li class="page-item" onclick=${ pageInfo.listCount != 0 && pageInfo.currentPage != 1 ? "boardList();"
                																																											: ""}>
                	<span class="page-link ${ pageInfo.listCount == 0 ? 'd-none' : '' } 
                												 ${ pageInfo.currentPage == 1 ? 'disabled' : '' }">Previous</span>
                </li>
                
                <!-- page -->
                <c:if test="${ pageInfo.listCount != 0 }">
                	<c:forEach var="page" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
                		<li class="page-item" class="page-page" onclick=${ pageInfo.currentPage != page ? "boardList();"
                																																										: "" }>
                			<span class="page-link ${ pageInfo.currentPage == page ? 'active' : '' }">${ page }</span>
                		</li>
                	</c:forEach>
                </c:if>
                
                <!-- Next -->
                <li class="page-item" onclick=${ pageInfo.listCount != 0 && pageInfo.currentPage != pageInfo.maxPage ? "boardList();"
                																																																		 : "" }>
                	<span class="page-link ${ pageInfo.listCount == 0 ? 'd-none' : '' } 
                												 ${ pageInfo.maxPage == pageInfo.currentPage ? 'disabled' : '' }">Next</span>
                </li>
              </ul>
          </div>
          <!-- pagination end -->
      </div>
      <!-- board list end-->

  </div>
  <!-- content 끝 -->
	
	<!-- chat floating -->
	<jsp:include page="/WEB-INF/views/common/chatFloating.jsp" />


</body>

<!-- 게시글 목록페이지 스크립트 -->
<script src="${ contextPath }/resources/js/board/list.js"></script>

</html>