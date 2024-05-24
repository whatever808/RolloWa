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
        margin-left: 220px;
        padding: 20px;
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

$("#all").on("click", function(){

	$(this).addClass("active");
  $(this).siblings().removeClass("active");
    
	location.href="${contextPath}/pay/myAllApproval.page";
	
})

$("#wait").on("click", function(){

	$(this).addClass("active");
  $(this).siblings().removeClass("active");

	$.ajax({
		url:"${contextPath}/pay/myWaitApproval.page",
		success:function(){
			
		}
	})
	
})

$("#progress").on("click", function(){

	$(this).addClass("active");
  $(this).siblings().removeClass("active");
	
	$.ajax({
		url:"${contextPath}/pay/myProgressApproval.page",
		success:function(){
			
		}
	})
	
})
</script>
		<main>
				<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	        <!-- content 추가 -->
	        <div class="content p-4">
	          <!-- 프로필 영역 -->
	          <div class="informations" >
	            <!-- informations left area start -->
	            
							
							<div class="content2">
							   <h2>나의 결재함</h2>
							    <div class="d-flex justify-content-between align-items-center mb-3">
							        <div class="filter-buttons d-flex">
							            <button id="all" type="button">전체</button>
							            <button id="wait" type="button">대기</button>
							            <button id="progress" type="button">진행</button>
							            <button id="complete" type="button">완료</button>
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
							            		<th><input type="checkbox"></th>
							                <td><span class="badge">${ list.get(0).DOCUMENT_STATUS }</span></td>
							                <td>${ i.TITLE }</td>
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