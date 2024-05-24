<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
    body {
        font-family: Arial, sans-serif;
        background-color: #f4f6f8;
    }
    
    .content2 {
       padding: 20px;
    	 height: 1073px;
    	 margin: auto;;
    }
    .task-table th, .task-table td {
        text-align: center;
        vertical-align: middle;
    }
    .badge {
        padding: 5px 10px;
        border-radius: 12px;
    }
    
   
    
   .filter-buttons button {
          margin-right: 10px;
          border: none;
          background-color: #f8f9fa;
          color: #007bff;
          border-radius: 20px;
          padding: 5px 10px;
    }
    
    .filter-buttons button.active {
        background-color: #007bff;
        color: white;
    }
    
    .filter-buttons button:hover {
        background-color: #007bff;
        color: white;
    }
    .search-bar {
        border: none;
        background-color: #f8f9fa;
        border-radius: 20px;
        padding: 5px 15px;
    }
    .btn-task {
        background-color: #007bff;
        color: white;
        border: none;
        border-radius: 20px;
        padding: 5px 15px;
    }
    .btn-task:hover {
        background-color: #0056b3;
    }
    
    .pending {
        background-color: #ffc107;
    }
    .completed {
        background-color: #28a745;
    }
    .progress {
        background-color: #007bff;
    }
    /* 추가적인 배지 상태에 대한 스타일 */
    .rejected {
        background-color: #dc3545;
    }
    
    #cen_bottom_pagging{
    	display: flex;
    	justify-content: center;
    	margin: 52px
    }
    #svg{
      width: 49px;
    	color: #007bff;
    	height: 21px;
    }
    #tStatus td:hover{cursor: pointer;}
</style>
</head>
<body>


<script>
$(document).ready(function(){
    $(".badge").each(function(){
        var text = $(this).text().trim();
        if(text == "반려"){
            $(this).addClass("rejected");
        } else if(text == "완료"){ 
            $(this).addClass("completed");
        } else if(text == "진행"){
            $(this).addClass("progress");
        } else if(text == "대기"){
            $(this).addClass("pending");
        } 
    });
});

$(document).on("click", "#all",function(){

	 $(this).addClass("active");
	    $(this).siblings().removeClass("active");
    
	location.href="${contextPath}/pay/myAllApproval.page";
	
});

</script>


<script>
$(document).ready(function(){
	$(document).on("click", "#wait", function(){
		$.ajax({
	     url: "${contextPath}/pay/myAllApproval.page",
	     method: 'GET',
	     data: { page: 1 },
	     success: function(response) {
	    	 console.log(response);
	       updateTable(response.list);
	       updatePagination(response.pi);
	     }
	  });
	})
})
</script>


<script>
$(document).ready(function(){
    function updateTable(data) {
        var tbody = $('#data-table tbody');
        tbody.empty(); // 기존 데이터를 제거합니다.

        data.forEach(function(item) {
            var documentStatusClass = '';
            if (item.DOCUMENT_STATUS === '반려') {
                documentStatusClass = 'badge-pending';
            } else if (item.DOCUMENT_STATUS === '완료') {
                documentStatusClass = 'badge-completed';
            } else if (item.DOCUMENT_STATUS === '진행') {
                documentStatusClass = 'badge-in-progress';
            } else if (item.DOCUMENT_STATUS === '대기') {
                documentStatusClass = 'badge-pending';
            }

            var row = '<tr>' +
                      '<td><input type="checkbox"></td>' +
                      '<td><span class="badge ' + documentStatusClass + '">' + item.DOCUMENT_STATUS + '</span></td>' +
                      '<td>' + item.TITLE +
                      ((item.SALES_STATUS + item.DRAFT_STATUS + item.BUSINESSTRIP_STATUS == 1) ?
                      '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                      '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                      '</svg>' : '') +
                      '</td>' +
                      '<td>' + item.DOCUMENT_TYPE + '</td>' +
                      '<td>' + item.PAYMENT_WRITER + '</td>' +
                      '<td>' + item.DEPARTMENT + '</td>' +
                      '<td>' + item.REGIST_DATE + '</td>' +
                      '<td>' + (item.FINAL_APPROVAL_DATE === "" ? "-" : item.FINAL_APPROVAL_DATE) + '</td>' +
                      '</tr>';

            tbody.append(row);
        });
    }

    function updatePagination(pagination) {
        var ul = $('.pagination');
        ul.empty(); // 기존 페이지네이션을 제거합니다.

        ul.append('<li class="page-item ' + (pagination.currentPage == 1 ? 'disabled' : '') + '"><a class="pages-link" href="#" data-page="' + (pagination.currentPage - 1) + '">Previous</a></li>');

        for (var p = pagination.startPage; p <= pagination.endPage; p++) {
            ul.append('<li class="page-item ' + (pagination.currentPage == p ? 'disabled' : '') + '"><a class="pages-link" href="#" data-page="' + p + '">' + p + '</a></li>');
        }

        ul.append('<li class="page-item ' + (pagination.currentPage == pagination.maxPage ? 'disabled' : '') + '"><a class="pages-link" href="#" data-page="' + (pagination.currentPage - 1) + '">Next</a></li>');
    }

    $(document).on('click', '.pages-link', function() {
        location.href= "${contextPath}/pay/myAllApproval.page";
    });

    loadPage(1);
    
});
</script>

		<main style="display: flex;">
				<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	        <!-- content 추가 -->
	        <div class="content p-4">
	          <!-- 프로필 영역 -->
	          <div class="informations" >
	            <!-- informations left area start -->
	            
							
							<div class="content2">
							   <h2>나의 결재함</h2>
							    <div class="d-flex justify-content-between align-items-center mb-3">
							        <div class="filter-buttons d-flex" style="margin: 16px;">
							            <button id="wait" type="button">대기</button>
							             	<svg xmlns="http://www.w3.org/2000/svg" id="svg" fill="currentColor" class="bi bi-reception-0" viewBox="0 0 16 16">
															<path d="M0 13.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m4 0a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m4 0a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m4 0a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5"/>
														</svg>
							            <button id="progress" type="button">진행</button>
							              <svg xmlns="http://www.w3.org/2000/svg" id="svg" fill="currentColor" class="bi bi-reception-0" viewBox="0 0 16 16">
															<path d="M0 13.5a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m4 0a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m4 0a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5m4 0a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5"/>
														</svg>
							            <button id="complete" type="button">완료</button>
							        </div>
							        <div class="filter-buttons d-flex">	
												<button id="all" type="button">전체</button>
							        </div>
							        <div class="filter-buttons d-flex">	
							        	<button id="reject" type="button">반려</button>
							        </div>
							        <div class="d-flex align-items-center">
							            <input type="text" class="form-control search-bar" placeholder="검색하세요.">
							            <button class="btn btn-task ml-2">
							            <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" style=" color: rgb(0, 0, 0);">
                         	<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                         	</svg>
							            </button>
							        </div>
							    </div>
							    
							    <table class="table table-striped task-table">
							        <thead>
							            <tr>
							            		<th><input type="checkbox"></th>
							                <th>상태</th>
							                <th>제목</th>
							                <th>문서</th>
							                <th>기안자</th>
							                <th>부서</th>
							                <th>기안날짜</th>
							                <th>승인날짜</th>
							            </tr>
							        </thead>
							        <tbody id="tStatus">
							        		<c:forEach var="i" items="${ list }">
							            <tr>
							            		<td><input type="checkbox"></td>
							                <td><span class="badge">${ list.get(0).DOCUMENT_STATUS }</span></td>
							                <td>${ i.TITLE }
							                		${ i.SALES_STATUS + i.DRAFT_STATUS + i.BUSINESSTRIP_STATUS == 1 ? '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">
				                             <path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>
				                             </svg>' : ""}
							                </td>
							                <td>${ i.DOCUMENT_TYPE }</td>
							                <td>${ i.PAYMENT_WRITER }</td>
							                <td>${ i.DEPARTMENT }</td>
							                <td>${ i.REGIST_DATE }</td>
							                <td>${ i.FINAL_APPROVAL_DATE == "" ? "-" : i.FINAL_APPROVAL_DATE}</td>
							            </tr>
							            </c:forEach>
							        </tbody>
							    </table>
							    
							    <div id="cen_bottom_pagging">
											<div id="pagin_form">
												<ul class="pagination">
					               <li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/myAllApproval.page?page=${pi.currentPage-1}">Previous</a></li>
					      
										      <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
										       	<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/myAllApproval.page?page=${p}">${ p }</a></li>
										      </c:forEach>
					      
										      <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/myAllApproval.page?page=${pi.currentPage+1}">Next</a></li>
										   </ul>
						          </div>
					        </div>
					        
							</div>
						</div>
					</div>
	        <!-- content 끝 -->
        <jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
    </main>
</body>
</html>