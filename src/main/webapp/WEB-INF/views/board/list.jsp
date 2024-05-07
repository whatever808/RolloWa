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
	<link href="${ contextPath }/resources/css/board/list.css?after" rel="stylesheet" />
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebar.jsp" />
	
	<!-- content 추가 -->
  <div class="content p-5">

      <h1 class="page-title">게시글 목록</h1>

      <!-- board category start -->
      <select id="board-category" name="category" class="board-category form-select" onchange="ajaxSelectBoardListByCategory();" style="width:200px;">
          <option value="all">전체 게시글</option>
          <option value="normal">일반 게시글</option>
          <option value="department">부서 게시글</option>
      </select>
      <!-- board category end -->
      
      <!-- show when department board category was selected -->
      <select id="department" name="department" class="department-category form-select d-none" onchange="ajaxSelectBoardListByCategory();">
      	<c:forEach var="department" items="${ departmentList }">
      		<option value="${ department.groupCode }">${ department.codeName }</option>
      	</c:forEach>
      </select>
      
      <script>
      	$(document).ready(function(){
      		// 카테고리별 게시글 목록조회 요청했을 경우 (URL 직접요청)
      		if(${ not request.category eq null }){
      			// 카테고리 select 박스 선택값 지정
      			$("#board-category").children("option").each(function(){
      				$(this).val() == "${ request.category }" && $(this).attr("selected", true);
      			})
      			
      			// "부서게시글" 목록조회 요청했을 경우, 부서 select 박스 선택값 지정
      			if($("#board-category").val() == 'department' || ${ not request.department eq null }){
      				$("#department").removeClass("d-none");
      				$("#department").children("option").each(function(){
      					$(this).val() == "${ request.department }" && $(this).attr("selected", true);
      				})
      			}			// if end
      		}				// if end
      		
      	})				// ready() end
      	
      	// 카테고리별 게시글 목록조회 function (select 박스선택)
      	function ajaxSelectBoardListByCategory(){
      		// 카테고리 선택값
      		let $category = $("#board-category").val();
      		let $department = $("#department").val();			
      		
      		// "부서" select 박스 숨김여부 지정
      		$category == 'department' ? $(".department-category").removeClass("d-none")
																		: $(".department-category").addClass("d-none");
      		
      		// 카테고리별 게시글 목록조회 AJAX
      		$.ajax({
      			url:"${ contextPath }/board/ctgList.do",
      			method:"get",
      			data:$category == 'department' ? {category:$category,
      																				department:$department
      																			 }
      																		 : {category:$category}
      			,success:function(result){
      				// 조회결과 데이터
      				const boardList = result.boardList;
      				const pageInfo = result.pageInfo;
      				console.log(pageInfo);
      				
      				// URL값 변경
      				history.pushState(null, null, $category == 'department' ? ('?category=' + $category + '&department=' + $department + '&page=' + pageInfo.currentPage)
      												 																				: ('?category=' + $category + '&page=' + pageInfo.currentPage)
      												 						 
      													);
      				
      				// 조회결과 요소생성
      				let list = "";
      				let page = "";
      				if(boardList.length == 0){
      					list += "<tr>"
      							 + 		"<td colspan='6'>조회된 게시글이 없습니다.</td>"
      							 +	"</tr>";
      				}else{
      					// 게시글 리스트
      					for(let i=0 ; i<boardList.length ; i++){
      						list += "<tr>";
					 			 	list +=		"<td class='board-title'>" + boardList[i].boardTitle + "</td>";
					 			 	list += 	"<td>" + (boardList[i].boardCategory == null ? '일반' : boardList[i].boardCategory) + "</td>";
					 			 	list +=		"<td>";
					 			 	list += 		"<img alt='profile image' class='board-writer-profile' src='" + (boardList[i].profileURL != null ? '' : '${ contextPath }/resources/images/defaultProfile.png') + "'>";
      						list +=			"<span>" + boardList[i].modifyEmp + "</span>";
					 			 	list +=		"</td>";
      						list +=		"<td>" + boardList[i].modifyDate + "</td>";
      						list +=		"<td>" + boardList[i].readCount + "</td>";
      						list +=		"<td>" + (boardList[i].attachmentYN != 0 ? '🗂️' : ' ') + "</td>";
      						list +=	"</tr>";
      						console.log()
      					}	
      					
      					// 페이징바 
      					page += "<li class='page-item'>";
      					page += 	"<a class='page-link " + (pageInfo.currentPage == 1 ? "disabled" : "")  + "'" +
													  	"href='" + ($category == 'department') ? ('${ contextPath }/board/ctgList.do?category=' + $category + '&department=' + $department + '&page=' + (pageInfo.currentPage - 1))
																																     : ('${ contextPath }/board/ctgList.do?category=' + $category + '&page=' + (pageInfo.currentPage - 1)) + "'>Previous" +
													"</a>";
      					page +=	"</li>";
      					
      					for(let i=pageInfo.startPage ; i<=pageInfo.endPage ; i++){
      						page += "<li class='page-item'>";
      						page += 	"<a class='page-link " + (pageInfo.currentPage == i ? 'active' : '') + "'" +
      													"href=" + ($category == 'department') ? ('${ contextPath }/board/ctgList.do?category=' + $category + '&department=' + $department + '&page=' + i)
																	 																	  : ('${ contextPath }/board/ctgList.do?category=' + $category + '&page=' + i) + "'>" + i + 
														"</a>";
								 	page += "</li>";
      					}
      					
      					page += "<li class='page-item'>";
      					page += 	"<a class='page-link " + (pageInfo.currentPage == pageInfo.maxPage ? 'disabled' : '')  + "'" +
      											  "href='" + ($category == 'department') ? ('${ contextPath }/board/ctgList.do?category=' + $category + '&department=' + $department + '&page=' + (pageInfo.currentPage + 1))
      																														   : ('${ contextPath }/board/ctgList.do?category=' + $category + '&page=' + (pageInfo.currentPage + 1)) + "'>Next" +
      										"</a>";
      					page +=	"</li>";
      					
      					console.log(page);
      				}		// if-else end
      				
      				$("#boardList").html(list);
      				$(".board-list-pagination").children(".pagination").html(page);
      				
      			},error:function(){
      				console.log("카테고리별 게시글 목록조회 AJAX 실패");
      			}
      		})
      	}
      </script>

      <!-- search form start-->
      <div id="search-form">
          <form action="${ contextPath }/board/" method="get">
              <select name="condition" class="search-condition form-select">
                  <option value="title">제목</option>
                  <option value="content">내용</option>
                  <option value="writer">작성자</option>
              </select>
              <input type="text" id="search-keyword" name="keyword" class="form-control" placeholder="게시글 검색" required>
              <button type="submit" class="btn btn-secondary">검색</button>
          </form>
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
	                      <td>${ board.attachmentYN } != 0 ? "🗂️" : ""</td>
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
                <li class="page-item" id="page-previous">
                	<a class="page-link ${ pageInfo.listCount == 0 ? 'd-none' : '' } 
                											${ pageInfo.currentPage == 1 ? 'disabled' : '' }" 
                		 href="${ contextPath }/board/list.do?page=${ pageInfo.currentPage - 1 }">Previous
                	</a>
                </li>
                
                <!-- page -->
                <c:if test="${ pageInfo.listCount != 0 }">
                	<c:forEach var="page" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
                		<li class="page-item" class="page-page">
                			<a class="page-link ${ pageInfo.currentPage == page ? 'active' : '' }" 
                				 href="${ contextPath }/board/list.do?page=${ page }">${ page }
                			</a>
                		</li>
                	</c:forEach>
                </c:if>
                
                <!-- Next -->
                <li class="page-item" id="page-next">
                	<a class="page-link ${ pageInfo.listCount == 0 ? 'd-none' : '' } 
                											${ pageInfo.maxPage == pageInfo.currentPage ? 'disabled' : '' }" 
                		 href="${ contextPath }/board/list.do?page=${ pageInfo.currentPage + 1 }">Next
                	</a>
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

<!-- Axios 스크립트 CDN 연결 -->
<script src="https://cdn.jsdelivr.net/npm/axios/dist/axios.min.js"></script>

</html>