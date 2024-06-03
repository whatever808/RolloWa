<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>등록공지보관함</title>
	
	<!-- 게시글 목록페이지 스타일 -->
	<link href="${ contextPath }/resources/css/board/publisher/list.css" rel="stylesheet" />
</head>
<body>

	 <!-- side bar -->
	 <jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
	 <!-- content 추가 -->
	 <div class="content p-5">
	
	     <h1 class="page-title">등록공지보관함</h1>
	
		 <!-- about category start  -->
	     <div id="filter-category">
	     	 <!-- board category start -->
		     <select id="category" name="category" class="board-category form-select" onchange="ajaxBoardList();" style="width:200px;">
		         <option value="normal">일반공지사항</option>
		         <option value="department" data-department="${ filter.department }">부서공지사항</option>
		     </select>
		     <!-- board category end -->
	     </div>
		 <!-- about category end -->
		 
	     <!-- about search start -->
	     <div id="filter-search">
	     	 <!-- search form start-->
		     <div id="search-form" class="input-group">
		     	<!-- search condition start -->
			    <select id="condition" class="search-condition form-select">
			       <option value="">전체</option>
			       <option value="title">제목</option>
			       <option value="content">내용</option>
			       <option value="writer">작성자</option>
		        </select>
		       	<!-- search condition end -->
		       	
		        <!-- search keyword start -->
			    <span class="form-outline" data-mdb-input-init>
			        <input type="search" id="keyword" class="form-control" placeholder="게시글 검색" aria-label="게시글 검색"/>
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
	     
	     <!-- board list start -->
	     <div class="board-list">
	         <!-- board list table start-->
	         <table class="table table-hover">
	             <thead class="table-light">
	                 <tr>
                 		 <th>
               		 		<input type="checkbox" id="del-all-boards">
                 		 </th>
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
	                			<td colspan="7">조회된 게시글이 없습니다.</td>
	                		</tr>
	                	</c:when>
	                	<c:otherwise>
	                		<c:forEach var="board" items="${ boardList }">
		                 		<tr>
		                 		  <td>
		                 			<input type="checkbox" name="delBoardNoArr" value="${ board.boardNo }">
		                 		  </td>
			                      <td>${ board.category eq null ? "일반" : board.category }</td>
			                      <td class="board-title" onclick="showDetail('${ board.boardNo }', '${ board.modifyEmp }');">${ board.title }</td>
			                      <td>
			                     		<c:choose>
			                     			<c:when test="${ not empty board.profileURL }">
			                     				<img src="${ board.profileURL }" alt="profile image" class="board-writer-profile">
			                     			</c:when>
			                     			<c:otherwise>
			                     				<img src="${ contextPath }/resources/images/defaultProfile.png" alt="profile image" class="board-writer-profile">
			                     			</c:otherwise>
			                     		</c:choose>
			                        <span>${ board.writerName }</span>
			                      </td>
			                      <td>${ board.modifyDate }</td>
			                      <td>${ board.readCount }</td>
			                      <td class="attachment-yn">${ board.attachmentYN != 0 ? "🗂️" : "" }</td>
		                  		</tr>
	                		</c:forEach>
	                	</c:otherwise>
	                </c:choose>
	             </tbody>
	             <tfoot>
             		<tr class="border-white">
             			<td class="trashcan-icon">
             				<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="red" class="trash-icon" viewBox="0 0 16 16">
							  <path d="M5.5 5.5A.5.5 0 0 1 6 6v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m2.5 0a.5.5 0 0 1 .5.5v6a.5.5 0 0 1-1 0V6a.5.5 0 0 1 .5-.5m3 .5a.5.5 0 0 0-1 0v6a.5.5 0 0 0 1 0z"/>
							  <path d="M14.5 3a1 1 0 0 1-1 1H13v9a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V4h-.5a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1H6a1 1 0 0 1 1-1h2a1 1 0 0 1 1 1h3.5a1 1 0 0 1 1 1zM4.118 4 4 4.059V13a1 1 0 0 0 1 1h6a1 1 0 0 0 1-1V4.059L11.882 4zM2.5 3h11V2h-11z"/>
							</svg>
             			</td>
             		</tr>
	             </tfoot>
	         </table>
	         <!-- board list table end -->
	
	         <!-- pagination start -->
	         <div class="board-list-pagination ${ pageInfo.listCount == 0 ? 'd-none' : '' }">
	             <ul class="pagination">
	             
            <!-- Previous -->
			      <li id="normal" class="page-item ${ pageInfo.listCount != 0 && pageInfo.currentPage != 1 ? '' : 'disabled' }"
					    onclick="${ pageInfo.listCount != 0 && pageInfo.currentPage != 1 ? 'ajaxBoardList();' : '' }">
			      	<span class="page-link" data-pageno="${ pageInfo.currentPage - 1 }">◁</span>
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
				    	  onclick="${ pageInfo.currentPage != pageInfo.maxPage ? 'ajaxBoardList();' : ''}">
				      <span class="page-link" data-pageno="${ pageInfo.currentPage + 1 }">▷</span>
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

<script>
	//페이지 로드 즉시 실행되어야할 functions ===========================================================================
	$(document).ready(function(){
		// "카테고리별" 게시글 목록조회 요청했을 경우, 카테고리 선택값 지정
		$("#category").children("option").each(function(){
			$(this).val() == "${ filter.category }" && $(this).attr("selected", true);
		})
		
		// "키워드검색" 게시글 목록조회 요청했을 경우, 검색값 지정
		if("${ filter.condition }".length != 0 && "${ filter.keyword != ''}".length != 0){
			$("#condition").children("option").first().val("all");
			
			// 1) 검색값 노출
			$("#condition").children("option").each(function(){
				if($(this).val() == "${ filter.condition }"){
					$(this).attr("selected", true);
				} 	
			})
			$("#keyword").val("${ filter.keyword }");
			
			// 2) "검색 취소" 버튼 활성화
			$("#reset-search").removeClass("d-none");
		}	
	})	
	
	// 키워드값 입력후 "Enter"를 눌렀을 경우 =========================================================================================
	$("#keyword").on("keyup", function(){
		(event.key == 'Enter' || event.code == 'Enter') && searchValidation();
	})
	// 키워드검색 게시글 목록조회 요청시 입력값 유효성 체크 
	function searchValidation(){
		if($("#keyword").val().trim().length == 0){
			yellowAlert("게시글 목록조회 서비스", "검색어를 입력해주세요.");
		}else{
			// 1) 키워드 검색요청시 "전체" 검색 value값 변경설정
			$("#condition").children().each(function(){
				$(this).val() == '' && $(this).val("all");
			})
			
			// 2) 검색값 초기화 버튼 활성화
			showResetBtn();
			
			// 3) 게시글 목록조회 요청
			ajaxBoardList();
		}
	}
	// 검색값 설정값 초기화
	$("#reset-search").on("click", function(){
		// 1) 선택값 모두 초기화
		$("#category").children().eq(0).prop("selected", "true");
		$("#condition").children().eq(0).val("").prop("selected", "true");
		$("#keyword").val("");
		
		// 2) "검색 취소" 버튼 비활성화
		$(this).addClass("d-none");
		
		// 3) 게시글 목록조회 요청
		ajaxBoardList();
		
	})
	
	// 검색 초기화 버튼 활성화
	function showResetBtn(){
		$("#reset-search").removeClass("d-none");
	}
	
	// 검색조건 값이 바뀌었을 경우
	$("#condition").on("change", function(){
		$("#keyword").val().trim().length != 0 && ajaxBoardList();
	})
	
	// 게시글 목록조회 (비동기식) ================================================================================================
	function ajaxBoardList(){
		// 1) 요청 페이지값 설정
		let page = $(event.target).data("pageno") == undefined ? 1 : $(event.target).data("pageno");
		
		// 2) 게시글 목록조회 AJAX
		$.ajax({
			url:"${ contextPath }/board/publisher/list.ajax",
			method:"get",
			data:{
				page:page,
				category:$("#category").val(),
				department:$("#category").children("[value=department]").data("department"),
				condition:$("#condition").val(),
				keyword:$("#keyword").val()
			},
			success:function(response){
				let boardList = response.boardList;	// 게시글 목록
				let pageInfo = response.pageInfo;	// 페이징바 정보
				let list = "";	// 갱신 리스트 문자열 태그
				let pagination = "";	// 갱신할 페이징바 문자열 태그
				
				// 1) 게시글 목록 리스트 갱신
				// 조회된 게시글이 없을 경우
				if(boardList.length == 0){
					list += "<tr>";
					list += 	"<td colspan='7'>조회된 게시글이 없습니다.</td>";
					list += "</tr>";
				}
				// 조회된 게시글이 있을 경우
				else{
					// 생성할 리스트 태그 문자열
					for(let i=0 ; i<boardList.length ; i++){
						list += "<tr>";
						list += 	"<td>";
						list += 		"<input type='checkbox' name='delBoardNoArr' value='" + boardList[i].boardNo + "'>";
						list += 	"</td>";
						list += 	"<td>" + (boardList[i].category == null ? "일반" : boardList[i].category) + "</td>";
						list += 	"<td class='board-title' onclick='showDetail(" + boardList[i].boardNo + ", " + boardList[i].modifyEmp + ")'>" + boardList[i].title + "</td>";
						list += 	"<td>";
						list += 		"<img src='" + (boardList[i].profileURL == null ? "${ contextPath }/resources/images/defaultProfile.png"
																					 					: boardList[i].profileURL) + "' alt ='profile image' class='board-writer-profile'>" 
						list += 		"<span>" + boardList[i].writerName + "</span>";
						list += 	"</td>";
						list += 	"<td>" + boardList[i].modifyDate + "</td>";
						list += 	"<td>" + boardList[i].readCount + "</td>";
						list += 	"<td class='attachment-yn'>" + (boardList[i].attachmentYN != 0 ? "🗂️" : "") + "</td>";
						list += "</tr>";
					}
					
					// 생성할 페이징바 태그 문자열
					pagination += "<li id='ajax' class='page-item " + (pageInfo.currentPage == 1 ? 'disabled ' : ' ' ) + "'" +
												"onclick='" + (pageInfo.currentPage != 1 ? 'ajaxBoardList();' : '') + "'>";
					pagination +=	   "<span class='page-link' data-pageno='" + (pageInfo.currentPage - 1) + "'>Previous</span>";
					pagination += "</li>";
					
					for(let page=pageInfo.startPage ; page<=pageInfo.endPage ; page++){
						pagination += "<li class='page-item " + (pageInfo.currentPage == page ? 'active' : '') + "' " +
												"onclick='" + (pageInfo.currentPage != page ? 'ajaxBoardList();' : '') + "'>";
						pagination += 		"<span class='page-link' data-pageno='" + page + "'>" + page + "</span>";
						pagination += "</li>";
					}
					
					pagination += "<li class='page-item " + (pageInfo.currentPage == pageInfo.maxPage ? 'disabled' : '') + "' " +
											"onclick='" + (pageInfo.currentPage != pageInfo.maxPage ? 'ajaxBoardList();' : '') + "'>";
					pagination += 		"<span class='page-link' data-pageno='" + (pageInfo.currentPage + 1) + "'>Next</span>";
					pagination += "</li>";
				}
		
				$("#boardList").html(list);
				$(".board-list-pagination").children(".pagination").html(pagination);
				
				
				// 2) URL 주소값 변경
				history.pushState(null, null, "${ contextPath }/board/publisher/list.do?page=" + page +
																											 "&category=" + $("#category").val() +
																											 "&department=" + $("#category").children("[value=department]").data("department") +
																											 "&condition=" + $("#condition").val() +
																											 "&keyword=" + $("#keyword").val());
			},
			error:function(){
				console.log("SELECT BOARD LIST AJAX ERROR");
			}
		})
		
	}
	
	// 게시글 상세페이지 이동 ============================================================================================================
	function showDetail(boardNo, writerNo){
		let params = "category=" + $("#category").val() + "&"
				     + "department=" +$("#category").children("[value=department]").data("department") +"&"
				     + "condition=" + $("#condition").val() + "&"
				     + "keyword=" + $("#keyword").val() + "&"
				     + "no=" + boardNo;
		
		location.href = "${ contextPath }/board/publisher/detail.do?" + params;
		
	}
	
	// 체크박스를 이용한 다수 공지사항 일괄 삭제요청 ==============================================================================================
	$("#del-all-boards").on("change", function(){	// 전체 공지사항 선택 | 해제
		if($(this).prop("checked")){
			$("#boardList").find("input[name=delBoardNoArr]").prop("checked", true);			
		}else{
			$("#boardList").find("input[name=delBoardNoArr]").prop("checked", false);
		}	
	})
	
	$(".trashcan-icon").on("click", function(){	// 
		if($("#boardList").find(":checked").length == 0){
			yellowAlert("공지사항 삭제서비스", "선택된 공지사항이 없습니다.");
		}else{
			if(confirm("선택된 공지사항을 정말삭제하시겠습니까?")){
				// 삭제할 공지사항 번호 배열추가
				let delBoardNoArr = [];
				$("#boardList").find("input[name=delBoardNoArr]").each(function(){
					$(this).prop("checked") && delBoardNoArr.push($(this).val());
				})
				
				// 공지사항 일괄삭제 요청
				$.ajax({
					url:"${ contextPath }/board/publisher/delete.ajax",
					method:"get",
					data:{delBoardNoArr: delBoardNoArr},
					success:function(result){
						if(result == 'SUCCESS'){
							greenAlert("공지사항 삭제서비스", "공지사항이 삭제되었습니다.");
							$(".page-item").each(function(){
								console.log($(this));
								$(this).hasClass("active") && console.log($(this));
							})
						}else if(result == 'FAIL'){
							redAlert("공지사항 삭제서비스", "공지사항 삭제에 실패했습니다.");
						}
						ajaxBoardList();
					},error:function(){
						redAlert("공지사항 삭제서비스", "공지사항 삭제요청에 실패했습니다.");
						console.log("DELETE BOARDS AJAX FAILED");
					}
				})
			}
		}
	})

</script>

</html>