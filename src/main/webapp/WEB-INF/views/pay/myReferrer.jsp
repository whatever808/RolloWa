<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap CSS -->
<link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
<!-- Bootstrap JS -->
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

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
        background-color: #e91e6387;
    }
    .completes {
        background-color: #F44336;
    }
    .progresses {
        background-color: #3F51B5;;
    }
    /* 추가적인 배지 상태에 대한 스타일 */
    .rejected {
        background-color: #FF9800;;
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
    .pagination li:hover {
			cursor: pointer;
		}
		/* 기본 스타일 설정 */
		.custom-select {
		    width: 84px; /* 원하는 너비로 설정 */
		    padding: 6px; /* 내측 여백 */
		    border: 1px solid #ccc; /* 테두리 색상 */
		    border-radius: 5px; /* 모서리 둥글게 */
		    background-color: #f9f9f9; /* 배경 색상 */
		    font-size: 16px; /* 글꼴 크기 */
		    color: #333; /* 글꼴 색상 */
		    -webkit-appearance: none; /* 기본 스타일 제거 (웹킷 브라우저) */
		    -moz-appearance: none; /* 기본 스타일 제거 (모질라 브라우저) */
		    appearance: none; /* 기본 스타일 제거 (기타 브라우저) */
		    cursor: pointer; /* 커서 스타일 */
		}
		
		/* 옵션 스타일 설정 */
		.custom-select option {
		    padding: 10px; /* 내측 여백 */
		    background-color: #fff; /* 배경 색상 */
		    color: #333; /* 글꼴 색상 */
		}
		
		/* 포커스 및 호버 스타일 설정 */
		.custom-select:focus {
		    border-color: #007bff; /* 포커스 시 테두리 색상 */
		    box-shadow: 0 0 5px rgba(0, 123, 255, 0.5); /* 포커스 시 그림자 */
		    outline: none; /* 포커스 시 외곽선 제거 */
		}
		
		.custom-select option:hover {
		    background-color: #007bff; /* 호버 시 배경 색상 */
		    color: #fff; /* 호버 시 글꼴 색상 */
		}
		
		/* 화살표 추가를 위한 스타일 설정 */
		.custom-select-wrapper {
		    position: relative;
		    display: inline-block;
		}
		
		.custom-select::after {
		    content: '▼'; /* 화살표 모양 (유니코드 화살표 사용) */
		    position: absolute;
		    top: 50%;
		    right: 10px;
		    transform: translateY(-50%);
		    pointer-events: none; /* 화살표 클릭 불가능하게 설정 */
		    color: #333; /* 화살표 색상 */
		}
		.search-container {
		    display: flex;
		    align-items: center;
		}
		
		.search-input {
		    width: 300px;
		    padding: 10px;
		    font-size: 16px;
		    border: 2px solid #ccc;
		    border-right: none;
		    border-radius: 4px 0 0 4px;
		    outline: none;
		}
		
		.search-input:focus {
		    border-color: #007BFF;
		}
		
		.search-button {
		    padding: 11px 20px;
		    font-size: 11px;
		    color: #fff;
		    background-color: #007BFF;
		    border: 2px solid #007BFF;
		    border-radius: 0 4px 4px 0;
		    cursor: pointer;
		    transition: background-color 0.3s ease, box-shadow 0.3s ease;
		}
		
		.search-button:hover {
		    background-color: #0056b3;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		}
		
		.search-button:active {
		    background-color: #003f7f;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		}
		.pagination li{padding: 6px 12px;}
		.pagination a : hover{
		background-color : #FEEFAD
		};
		
		.search-container {
		    display: flex;
		    align-items: center;
		}
		
		.search-input {
		    width: 300px;
		    padding: 10px;
		    font-size: 16px;
		    border: 2px solid #ccc;
		    border-right: none;
		    border-radius: 4px 0 0 4px;
		    outline: none;
		}
		#search{
		height: 63px;
		height: 63px;
    border-radius: 0px;
    }
		
		.search-input:focus {
		    border-color: #007BFF;
		}
		
		.search-button22 {
		    padding: 5px 14px;
		    font-size: 11px;
		    color: #fff;
		    background-color: #e5f186;
		    border: 2px solid #e5f186;
		    border-radius: 3px;
		    cursor: pointer;
		    transition: background-color 0.3s ease, box-shadow 0.3s ease;
		    height: 49px;
    		width: 61px;
		}
		
		.search-button22:hover {
		    background-color: #f186aa8a;
		    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
		    
		}
		
		.search-button22:active {
		    background-color: #f186aa8a;
		    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
		}
		
		.pagination li{padding: 6px 12px;}
		.pagination a : hover{
		background-color : #FEEFAD
		};
		
		body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f9;
    margin: 0;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
}

.search-container {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
    max-width: 600px;
    margin: 0 auto;
    padding: 20px;
    background: #fff;
    box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
    border-radius: 10px;
}

.search-form {
    display: flex;
    width: 100%;
    height: 63px;
}

.search-input {
    width: 100%;
    padding: 10px 20px;
    border: 2px solid #ddd;
    border-radius: 10px 0 0 10px;
    outline: none;
    font-size: 16px;
    transition: border-color 0.3s;
}

.search-input:focus {
    border-color: #007bff;
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
            $(this).addClass("completes");
        } else if(text == "진행"){
            $(this).addClass("progresses");
        } else if(text == "대기"){
            $(this).addClass("pending");
        } 
    });
});
</script>

<script>

$(document).on('keyup', '#searches', function(e) {
	
	if(e.key == "Enter"){
		loadPageMyReferrer(1);
	}

});


$(document).on('click', '#searchBtn', function(e) {

	loadPageMyReferrer(1);

});




$(document).on('click', '.page-links', function(e) {
e.preventDefault();
var page = parseInt($(this).data('page'));
if (page > 0) {
	loadPageMyReferrer(page);
}
});

function loadPageMyReferrer(page) {

$.ajax({
    url: "${contextPath}/pay/ajaxMyReferrer.do", 
    method: 'GET',
    data: { 
    	page: page,
    	keyword: $("#searches").val()
    },
    success: function(response) {
      console.log(response);

      var tbody = $('#tStatus');
      tbody.empty();
    
      if(Array.isArray(response.list) && response.list.length > 0){
	
			response.list.forEach(function(item) {
        console.log(item);
        
        var documentStatusClass = '';
			  if (item.DOCUMENT_STATUS === '반려') {
			      documentStatusClass = 'rejected';
			  } else if (item.DOCUMENT_STATUS === '완료') {
			      documentStatusClass = 'completes';
			  } else if (item.DOCUMENT_STATUS === '진행') {
			      documentStatusClass = 'progresses';
			  } else if (item.DOCUMENT_STATUS === '대기') {
			      documentStatusClass = 'pending';
			  }
		  
        var attachmentIcon = '';
        if (item.SALES_STATUS + item.DRAFT_STATUS + item.BUSINESSTRIP_STATUS > 0) {
            attachmentIcon = '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">' +
                             '<path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>' +
                             '</svg>';
        }

        var row = '<tr onclick=location.href="${contextPath}/pay/detail.do?approvalNo=' + item.APPROVAL_NO  + '&documentNo=' + item.DOCUMENT_NUMBER + '&documentType=' + item.DOCUMENT_TYPE + '&payWriter=' + item.PAYMENT_WRITER + '&payWriterNo=' + item.PAYMENT_WRITER_NO + '">' +
	                '<td><span class="badge '+ documentStatusClass +'">' + item.DOCUMENT_STATUS + '</span></td>' +
	                '<td>' + item.TITLE + attachmentIcon + '</td>' +
	                '<td>' + item.DOCUMENT_TYPE + '</td>' +
	                '<td>' + item.PAYMENT_WRITER + '</td>' +
	                '<td>' + item.DEPARTMENT + '</td>' +
	                '<td>' + item.REGIST_DATE + '</td>' +
	                '<td>' + (item.DOCUMENT_STATUS == '완료' ? item.FINAL_APPROVAL_DATE : "-") + '</td>' +
	                '</tr>';

  			 tbody.append(row);
        });
				var ul = $('.pagination');
				ul.empty(); 

				ul.append('<li class="page-item ' + (response.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-links" data-page="' + (response.pi.currentPage == 1 ? 0 : response.pi.currentPage - 1) + '">◁</a></li>');
				
				for (var p = response.pi.startPage; p <= response.pi.endPage; p++) {
				    ul.append('<li class="page-item ' + (response.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-links" data-page="' + p + '">' + p + '</a></li>');
				}

				ul.append('<li class="page-item ' + (response.pi.currentPage == response.pi.maxPage ? 'disabled' : '') + '"><a class="page-links" data-page="' + (response.pi.currentPage == response.pi.maxPage ? 0 : response.pi.currentPage + 1) + '">▷</a></li>');
				
				}else {
					 var row = '<tr>' +
                  '<td colspan="7">존재하는 게시글이 없습니다.</td>' +
                  '</tr>';
					 tbody.append(row);
					 var ul = $('.pagination');
					 ul.empty();
				}

     },
     error: function(xhr, status, error) {
         console.log("AJAX request failed");
     }
  });
        
      
     
      
}
</script>



		<main style="display: flex;">
				<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	        <!-- content 추가 -->
	        <div class="content p-4">
	          <!-- 프로필 영역 -->
	          <div class="informations" >
	            <!-- informations left area start -->
	            
							
							<div class="content2">
							   <h2>${ userName }님의 수신참조함</h2>
							    <div class="d-flex justify-content-between align-items-center mb-3">
											 <div class="search-container">
							            <input type="text" class="search-input" id="searches" placeholder="검색어를 입력하세요...">
							            <button type="button" class="search-button22" id="searchBtn">
							            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16">
													  <path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
													</svg>
							            </button>
									    </div>
									</div>
							    <table class="table table-striped task-table" id="data-table">
							        <thead>
							            <tr>
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
							        		<c:choose>
							        		<c:when test="${ list != null and !list.isEmpty() }">
							        		<c:forEach var="i" items="${ list }">							        		
								          	<tr onclick="location.href='${contextPath}/pay/detail.do?approvalNo=${ i.APPROVAL_NO  }&documentNo=${ i.DOCUMENT_NUMBER }&documentType=${ i.DOCUMENT_TYPE }&payWriter=${ i.PAYMENT_WRITER  }&payWriterNo=${ i.PAYMENT_WRITER_NO }';">
								                <td><span class="badge">${ i.DOCUMENT_STATUS }</span></td>
								                <td>${ i.TITLE }
								                		${ i.SALES_STATUS + i.DRAFT_STATUS + i.BUSINESSTRIP_STATUS == 1 ? '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">
					                             <path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>
					                             </svg>' : ""}
								                </td>
								                <td>${ i.DOCUMENT_TYPE }</td>
								                <td>${ i.PAYMENT_WRITER }</td>
								                <td>${ i.DEPARTMENT }</td>
								                <td>${ i.REGIST_DATE }</td>
								                <td>${ i.FINAL_APPROVAL_DATE == null ? "-" : i.FINAL_APPROVAL_DATE}</td>
								            </tr>
							            </c:forEach>
							            </c:when>
							            <c:otherwise>
							             	<tr>
			                      	<td colspan="7">존재하는 게시글이 없습니다.</td>
			                      </tr>
							            </c:otherwise>
							            </c:choose>
							        </tbody>
							    </table>
							    <div id="cen_bottom_pagging">
										<div id="pagin_form">
											<ul class="pagination">
			        					<c:if test="${ list != null && !list.isEmpty()}">
					               	<li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }"><a href="${ contextPath }/pay/myReferrer.page?page=${pi.currentPage-1}">◁</a></li>
					      
										      <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
										       	<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }"><a href="${ contextPath }/pay/myReferrer.page?page=${p}">${ p }</a></li>
										      </c:forEach>
					      
										      <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a href="${ contextPath }/pay/myReferrer.page?page=${pi.currentPage+1}">▷</a></li>
									   		</c:if>
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