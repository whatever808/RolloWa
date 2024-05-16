<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 		<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
 
    <!-- 메인페이지스타일 -->
    <link href="${ contextPath }/resources/css/pay/paymain.css" rel="stylesheet">
    <style>
    	.input-group-append{border: 1px solid white; background-color: white;}
    
    
    </style>

</head>
<body>
    <c:if test="${not empty paymain or not empty params}">
			<script>
        function typeSelect() {
            location.href = "${contextPath}/pay/selectList.do?conditions=" + $("#selects").val() + "&status=" + $("#statusSelect").val();
        };

        $(document).ready(function () {
            $("#selects").change(function () {
                typeSelect();
            });
            $("#statusSelect").change(function () {
                typeSelect();
            });
        });
			</script>
    </c:if>
  
  
  <c:if test="${ not  empty userAllList or not empty userAllListSelect or not empty userSearchList}">
  	<script>
	  	function typeSelect(){
				location.href="${contextPath}/pay/userSelectList.do?conditions=" + $("#selects").val() + "&status=" + $("#statusSelect").val();
			
			};
			
				$(document).ready(function(){
					$("#selects").change(function(){
						typeSelect();
						});
					$("#statusSelect").change(function(){
						typeSelect();
					});
					
				});
		</script>
  </c:if>
  
  
  
                               
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
        <!-- content 추가 -->
        <div class="content p-4">
            <!-- 프로필 영역 -->
            <div>
            <div class="informations" >
                <!-- informations left area start -->
                <div class="left_con">
                    <div id="cen_top">
                        <a href="${contextPath}/pay/allUserlist.do" method="get">
                            <div class="di_top" id="di_t_1">
                                <div class="di_top_left">
                                    <div><label>${userName}님의 <br>전체수신결재함</label></div>
                                    <div><b>${ ulistCount.length() == 1 ? "0" + ulistCount 
                                    				 														: ulistCount == "0" ? "0" : ulistCount}건</b></div>
                                </div>
                                <div class="di_top_rigth">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-clipboard2-x-fill" viewBox="0 0 16 16">
                                        <path d="M10 .5a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5.5.5 0 0 1-.5.5.5.5 0 0 0-.5.5V2a.5.5 0 0 0 .5.5h5A.5.5 0 0 0 11 2v-.5a.5.5 0 0 0-.5-.5.5.5 0 0 1-.5-.5"/>
                                        <path d="M4.085 1H3.5A1.5 1.5 0 0 0 2 2.5v12A1.5 1.5 0 0 0 3.5 16h9a1.5 1.5 0 0 0 1.5-1.5v-12A1.5 1.5 0 0 0 12.5 1h-.585q.084.236.085.5V2a1.5 1.5 0 0 1-1.5 1.5h-5A1.5 1.5 0 0 1 4 2v-.5q.001-.264.085-.5M8 8.293l1.146-1.147a.5.5 0 1 1 .708.708L8.707 9l1.147 1.146a.5.5 0 0 1-.708.708L8 9.707l-1.146 1.147a.5.5 0 0 1-.708-.708L7.293 9 6.146 7.854a.5.5 0 1 1 .708-.708z"/>
                                    </svg>
                                </div>
                            </div>
                        </a>
                        <a href="${contextPath}/pay/approvedList.do" method="get">
                            <div class="di_top" id="di_t_2">
                                <div class="di_top_left">                         
                                    <div><label>${userName}님의 <br> 승인완료한 수신결재함</label></div>
                                    <div><b>${ slistCount.length() == 1 ? "0" + slistCount 
                                    				 														: slistCount == "0" ? "0" : slistCount}건</b></div>
                                 </div>
                                <div class="di_top_rigth">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-clipboard-check-fill" viewBox="0 0 16 16">
                                        <path d="M6.5 0A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0zm3 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5z"/>
                                        <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1A2.5 2.5 0 0 1 9.5 5h-3A2.5 2.5 0 0 1 4 2.5zm6.854 7.354-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 0 1 .708-.708L7.5 10.793l2.646-2.647a.5.5 0 0 1 .708.708"/>
                                      </svg>
                                </div>
                            </div>
                        </a>
                        <a href="">
                            <div class="di_top" id="di_t_3">
                                <div class="di_top_left">
                                   <div><label>${ userName }님의 일주일 이상 <br>  지연 된 수신결재함</label></div>
                                    <div><b>${ mdCount.length() == 1 ? "0" + mdCount 
                                    				 														: mdCount == "0" ? "0" : mdCount}건</b></div>
                                </div>
                                <div class="di_top_rigth">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-clipboard-minus-fill" viewBox="0 0 16 16">
                                        <path d="M6.5 0A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0zm3 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5z"/>
                                        <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1A2.5 2.5 0 0 1 9.5 5h-3A2.5 2.5 0 0 1 4 2.5zM6 9h4a.5.5 0 0 1 0 1H6a.5.5 0 0 1 0-1"/>
                                      </svg>
                                </div>
                            </div>
                        </a>
                        <a href="${contextPath}/pay/paymain.page">
                            <div class="di_top" id="di_t_4">
                                <div class="di_top_left">
                                    <div><label>전체결재내역보기</label></div>
                                    <div class="biv_b"><b>${ listCount.length() == 1 ? "0" + listCount 
                                    				 														: listCount == "0" ? "0" : listCount}건</b></div>
                                </div>
                                <div class="di_top_rigth">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="35" height="35" fill="currentColor" class="bi bi-clipboard2-fill" viewBox="0 0 16 16">
                                        <path d="M9.5 0a.5.5 0 0 1 .5.5.5.5 0 0 0 .5.5.5.5 0 0 1 .5.5V2a.5.5 0 0 1-.5.5h-5A.5.5 0 0 1 5 2v-.5a.5.5 0 0 1 .5-.5.5.5 0 0 0 .5-.5.5.5 0 0 1 .5-.5z"/>
                                        <path d="M3.5 1h.585A1.5 1.5 0 0 0 4 1.5V2a1.5 1.5 0 0 0 1.5 1.5h5A1.5 1.5 0 0 0 12 2v-.5q-.001-.264-.085-.5h.585A1.5 1.5 0 0 1 14 2.5v12a1.5 1.5 0 0 1-1.5 1.5h-9A1.5 1.5 0 0 1 2 14.5v-12A1.5 1.5 0 0 1 3.5 1"/>
                                      </svg>
                                </div>
                            </div>
                        </a>
                         
                    </div>

                    <div id="cen_bottom">
                        <div id="cen_bottom_left">
                            <a href="">
                                <div class="cen_bottom_left_div">
                                    <div>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-pencil-square" viewBox="0 0 16 16" style="color: black;">
                                            <path d="M15.502 1.94a.5.5 0 0 1 0 .706L14.459 3.69l-2-2L13.502.646a.5.5 0 0 1 .707 0l1.293 1.293zm-1.75 2.456-2-2L4.939 9.21a.5.5 0 0 0-.121.196l-.805 2.414a.25.25 0 0 0 .316.316l2.414-.805a.5.5 0 0 0 .196-.12l6.813-6.814z"/>
                                            <path fill-rule="evenodd" d="M1 13.5A1.5 1.5 0 0 0 2.5 15h11a1.5 1.5 0 0 0 1.5-1.5v-6a.5.5 0 0 0-1 0v6a.5.5 0 0 1-.5.5h-11a.5.5 0 0 1-.5-.5v-11a.5.5 0 0 1 .5-.5H9a.5.5 0 0 0 0-1H2.5A1.5 1.5 0 0 0 1 2.5z"/>
                                        </svg>
                                    </div>
                                    <div><b>퇴직신청서</b></div>
                                </div>
                            </a>
                            <a href="${contextPath}/pay/writerForm.page?writer=b">
                                <div class="cen_bottom_left_div">
                                    <div>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-inboxes" viewBox="0 0 16 16" style="color: black;">
                                            <path d="M4.98 1a.5.5 0 0 0-.39.188L1.54 5H6a.5.5 0 0 1 .5.5 1.5 1.5 0 0 0 3 0A.5.5 0 0 1 10 5h4.46l-3.05-3.812A.5.5 0 0 0 11.02 1zm9.954 5H10.45a2.5 2.5 0 0 1-4.9 0H1.066l.32 2.562A.5.5 0 0 0 1.884 9h12.234a.5.5 0 0 0 .496-.438zM3.809.563A1.5 1.5 0 0 1 4.981 0h6.038a1.5 1.5 0 0 1 1.172.563l3.7 4.625a.5.5 0 0 1 .105.374l-.39 3.124A1.5 1.5 0 0 1 14.117 10H1.883A1.5 1.5 0 0 1 .394 8.686l-.39-3.124a.5.5 0 0 1 .106-.374zM.125 11.17A.5.5 0 0 1 .5 11H6a.5.5 0 0 1 .5.5 1.5 1.5 0 0 0 3 0 .5.5 0 0 1 .5-.5h5.5a.5.5 0 0 1 .496.562l-.39 3.124A1.5 1.5 0 0 1 14.117 16H1.883a1.5 1.5 0 0 1-1.489-1.314l-.39-3.124a.5.5 0 0 1 .121-.393zm.941.83.32 2.562a.5.5 0 0 0 .497.438h12.234a.5.5 0 0 0 .496-.438l.32-2.562H10.45a2.5 2.5 0 0 1-4.9 0z"/>
                                        </svg>
                                    </div>
                                    <div><b>비품신청서</b></div>
                                </div>
                            </a>
                           <a href="${contextPath}/pay/writerForm.page?writer=m">
                            <div class="cen_bottom_left_div">
                                <div>
                                    <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-clipboard-data" viewBox="0 0 16 16" style="color: black;">
                                        <path d="M4 11a1 1 0 1 1 2 0v1a1 1 0 1 1-2 0zm6-4a1 1 0 1 1 2 0v5a1 1 0 1 1-2 0zM7 9a1 1 0 0 1 2 0v3a1 1 0 1 1-2 0z"/>
                                        <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1z"/>
                                        <path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0z"/>
                                      </svg>
                                </div>
                                <div><b>매출보고서</b></div>
                            </div>
                           </a>
                            <a href="${ contextPath }/pay/writerForm.page?writer=j">
                                <div class="cen_bottom_left_div">
                                    <div>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-journals" viewBox="0 0 16 16" style="color: black;">
                                            <path d="M5 0h8a2 2 0 0 1 2 2v10a2 2 0 0 1-2 2 2 2 0 0 1-2 2H3a2 2 0 0 1-2-2h1a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V4a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1H1a2 2 0 0 1 2-2h8a2 2 0 0 1 2 2v9a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H5a1 1 0 0 0-1 1H3a2 2 0 0 1 2-2"/>
                                            <path d="M1 6v-.5a.5.5 0 0 1 1 0V6h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0V9h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 2.5v.5H.5a.5.5 0 0 0 0 1h2a.5.5 0 0 0 0-1H2v-.5a.5.5 0 0 0-1 0"/>
                                        </svg>
                                    </div>
                                    <div><b>지출결의서</b></div>
                                </div>
                            </a>
                            <a href="${ contextPath }/pay/writerForm.page?writer=g">
                                <div class="cen_bottom_left_div">
                                    <div>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-journal-bookmark" viewBox="0 0 16 16" style="color: black;">
                                        <path fill-rule="evenodd" d="M6 8V1h1v6.117L8.743 6.07a.5.5 0 0 1 .514 0L11 7.117V1h1v7a.5.5 0 0 1-.757.429L9 7.083 6.757 8.43A.5.5 0 0 1 6 8"/>
                                        <path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2"/>
                                        <path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1z"/>
                                      </svg>
                                    </div>
                                    <div><b>기안서</b></div>
                                </div>
                            </a>
                            <a href="${ contextPath }/pay/writerForm.page?writer=h">
                                <div class="cen_bottom_left_div">
                                    <div>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-journal-richtext" viewBox="0 0 16 16" style="color: black;">
                                            <path d="M7.5 3.75a.75.75 0 1 1-1.5 0 .75.75 0 0 1 1.5 0m-.861 1.542 1.33.886 1.854-1.855a.25.25 0 0 1 .289-.047L11 4.75V7a.5.5 0 0 1-.5.5h-5A.5.5 0 0 1 5 7v-.5s1.54-1.274 1.639-1.208M5 9.5a.5.5 0 0 1 .5-.5h5a.5.5 0 0 1 0 1h-5a.5.5 0 0 1-.5-.5m0 2a.5.5 0 0 1 .5-.5h2a.5.5 0 0 1 0 1h-2a.5.5 0 0 1-.5-.5"/>
                                            <path d="M3 0h10a2 2 0 0 1 2 2v12a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2v-1h1v1a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V2a1 1 0 0 0-1-1H3a1 1 0 0 0-1 1v1H1V2a2 2 0 0 1 2-2"/>
                                            <path d="M1 5v-.5a.5.5 0 0 1 1 0V5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0V8h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1zm0 3v-.5a.5.5 0 0 1 1 0v.5h.5a.5.5 0 0 1 0 1h-2a.5.5 0 0 1 0-1z"/>
                                        </svg>
                                    </div>
                                    <div><b>휴직신청서</b></div>
                                </div>
                            </a>
                            <a href="">
                                <div class="cen_bottom_left_div">
                                    <div>
                                        <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-clipboard-heart" viewBox="0 0 16 16" style="color: black;">
                                            <path fill-rule="evenodd" d="M5 1.5A1.5 1.5 0 0 1 6.5 0h3A1.5 1.5 0 0 1 11 1.5v1A1.5 1.5 0 0 1 9.5 4h-3A1.5 1.5 0 0 1 5 2.5zm5 0a.5.5 0 0 0-.5-.5h-3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h3a.5.5 0 0 0 .5-.5z"/>
                                            <path d="M3 1.5h1v1H3a1 1 0 0 0-1 1V14a1 1 0 0 0 1 1h10a1 1 0 0 0 1-1V3.5a1 1 0 0 0-1-1h-1v-1h1a2 2 0 0 1 2 2V14a2 2 0 0 1-2 2H3a2 2 0 0 1-2-2V3.5a2 2 0 0 1 2-2"/>
                                            <path d="M8 6.982C9.664 5.309 13.825 8.236 8 12 2.175 8.236 6.336 5.31 8 6.982"/>
                                        </svg>
                                    </div>
                                    <div><b>휴가신청서</b></div>
                                </div>
                            </a>
                        </div>
                        <div id="cen_bottom_rigth">
                            <div id="cen_bottom_search">
                                <div id="cen_bottom_search_next">
                                    <div>
                                        <select name="status" id="statusSelect">
                                        		<option value="전체">전체</option>
                                            <option value="보통">보통</option>
                                            <option value="긴급">긴급</option>
                                        </select>
                                    </div>
                                    <div style="margin-left: 30px;">
                                        <select name="conditions" id="selects">
                                            <option value="전체">전체</option>
                                            <option value="T">퇴직신청서</option>
                                            <option value="C">출장보고서</option>
                                            <option value="B">비품신청서</option>
                                            <option value="M">매출보고서</option>
                                            <option value="J">지출결의서</option>
                                            <option value="G">기안서</option>
                                            <option value="H">휴직신청서</option>
                                            <option value="V">휴가신청서</option>
                                        </select>
                                    </div>    
                                </div>
                                <div id="cen_bottom_search_center">
                                			<c:choose>
                                				<c:when test="${ not empty userAllList or not empty userSearchList}">
                                					 <form action="${contextPath}/pay/userSearch.do" method="get">
                                				</c:when>
                                				<c:otherwise>
                                     			<form action="${contextPath}/pay/search.do" method="get">
                                				</c:otherwise>
                                			</c:choose>
                                			
                                     		<input type="hidden" name="page" value="1">
                                    		<div class="input-group mb-3">
                                        <select name="condition" id="select_search">
                                            <option value="PAYMENT_WRITER">기안자</option>
                                            <option value="DEPARTMENT">부서</option>
                                        </select>
                                        <input type="text" name="keyword" value="${ search.keyword }"  id="search_input" class="form-control" placeholder="검색어를 입력하세요" style="width: 400px;">
                                       
                                        <c:choose>
                                        	<c:when test="${ not empty userAllList or not empty userSearchList }">
                                        	 <div class="input-group-append">
                                        		<button type="submit" id="user_mybutton">
                                           	<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" style=" color: rgb(0, 0, 0);">
                                           	<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                                           	</svg>
                                         		</button>
                                         		</div>
                                        	</c:when>
                                       		<c:otherwise>
                                       		 <div class="input-group-append">
                                       			<button type="submit" id="my_button">
                                           	<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-search" viewBox="0 0 16 16" style=" color: rgb(0, 0, 0);">
                                           	<path d="M11.742 10.344a6.5 6.5 0 1 0-1.397 1.398h-.001q.044.06.098.115l3.85 3.85a1 1 0 0 0 1.415-1.414l-3.85-3.85a1 1 0 0 0-.115-.1zM12 6.5a5.5 5.5 0 1 1-11 0 5.5 5.5 0 0 1 11 0"/>
                                           	</svg>
                                         		</button>
                                         		</div>
                                        	</c:otherwise>
                                        </c:choose>
                                        
                                     </form>
                                        
                                    </div>
                                </div>
                            </div>
                            <div id="cen_bot_table">
                                <table e class="table table-hover">
                                    <thead>
                                      <tr>
                                        <th>번호</th>
                                            <th>문서</th>
                                            <th>기안자</th>
                                            <th>부서</th>
                                            <th>기안일</th>
                                            <th>승인여부</th>
                                            <th>승인날짜</th>
                                            <th>상태</th>
                                      </tr>
                                    </thead>
                                    <tbody>
                                    <c:choose>
                                    <c:when test="${ not empty list }">
                                      <c:forEach var="l" items="${ list }">
                                     		<tr onclick="location.href='${contextPath}/pay/detail.do?approvalNo=${ l.approvalNo }&documentNo=${ l.documentNo }&documentType=${ l.documentType }&payWriter=${ l.payWriter }&payWriterNo=${ l.payWriterNo }';">
                                            <td>${ l.approvalNo }</td>
                                            <td>${ l.documentType } 
                                            		${ l.salesStatus + l.draftStatus + l.businessStatus == 1 ? '<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">
				                                        <path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>
				                                        </svg>' : ""}</td>
                                            <td>${ l.payWriter }</td>
                                            <td>${ l.department }</td>
                                            <td>${ l.registDt }</td>
                                            <td class="ing">${ l.documentStatus }</td>
                                            <td>${ l.finalApproDt == null ?  "-" : l.finalApproDt }</td>
                                    				<td class="status">${ l.payStatus }</td>
                                        </tr>
                                    	</c:forEach>
                                    </c:when>
                                    <c:otherwise>
	                                    <tr>
	                                    	<td colspan="8"><b>검색한 결과가 없습니다.</b></td>
	                                    </tr>
                                    </c:otherwise>
                                    </c:choose>
                                  
                                    </tbody>
                                  </table>
                                
                                
                            </div>
                            <div id="cen_bottom_pagging">
                                <div id="pagin_form">
                                   <c:choose>
                                   	<c:when test="${ not empty params }">
                                   		<ul class="pagination">
		                                    <li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/selectList.do?page=${pi.currentPage-1}&conditions=${params.conditions}&status=${params.status}">Previous</a></li>
													                
													                <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
													                 	<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/selectList.do?page=${p}&conditions=${params.conditions}&status=${params.status}">${ p }</a></li>
													                </c:forEach>
													                
													                <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/selectList.do?page=${pi.currentPage+1}&conditions=${params.conditions}&status=${params.status}">Next</a></li>
													             </ul>
                                   	</c:when>
                                   	<c:when test="${ not empty paymain }">
                                   		<ul class="pagination">
		                                    <li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/paymain.page?page=${pi.currentPage-1}">Previous</a></li>
													                
													                <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
													                 	<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/paymain.page?page=${p}">${ p }</a></li>
													                </c:forEach>
													                
													                <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/paymain.page?page=${pi.currentPage+1}">Next</a></li>
													             </ul>
                                   	</c:when>
                                   	<c:when test="${not empty userAllList}">
                                   		<ul class="pagination">
		                                    <li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/allUserlist.do?page=${pi.currentPage-1}">Previous</a></li>
													                
													                <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
													                 	<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/allUserlist.do?page=${p}">${ p }</a></li>
													                </c:forEach>
													                
													                <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/allUserlist.do?page=${pi.currentPage+1}">Next</a></li>
													             </ul>
                                   	</c:when>
                                   	<c:when test="${not empty userAllListSelect }">
                                			<ul class="pagination">
		                                    <li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/userSelectList.do?page=${pi.currentPage-1}&conditions=${map.conditions}&status=${map.status}">Previous</a></li>
													                
													                <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
													                 	<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/userSelectList.do?page=${p}&conditions=${map.conditions}&status=${map.status}">${ p }</a></li>
													                </c:forEach>
													                
													                <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/userSelectList.do?page=${pi.currentPage+1}&conditions=${map.conditions}&status=${map.status}">Next</a></li>
													             </ul>
                                   	</c:when>
                                   		<c:when test="${not empty userSearchList }">
                                			<ul class="pagination">
		                                    <li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/userSearch.do?page=${pi.currentPage-1}&condition=${map.condition}&keyword=${map.keyword}">Previous</a></li>
													                
													                <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
													                 	<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/userSearch.do?page=${p}&condition=${map.condition}&keyword=${map.keyword}">${ p }</a></li>
													                </c:forEach>
													                
													                <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/userSearch.do?page=${pi.currentPage+1}&condition=${map.condition}&keyword=${map.keyword}">Next</a></li>
													             </ul>
                                   	</c:when>
                                   	<c:when test="${ not empty userSuccessList }">
                                   		<ul class="pagination">
		                                    <li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/approvedList.do?page=${pi.currentPage-1}">Previous</a></li>
													                
													                <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
													                 	<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/approvedList.do?page=${p}">${ p }</a></li>
													                </c:forEach>
													                
													                <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/approvedList.do?page=${pi.currentPage+1}">Next</a></li>
													             </ul>
                                   	</c:when>
                                   	<c:otherwise>
                                   		<ul class="pagination">
		                                    <li class="page-item ${ pi.currentPage == 1 ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/search.do?page=${pi.currentPage-1}&condition=${search.condition}&keyword=${search.keyword}">Previous</a></li>
													                
													                <c:forEach var="p" begin="${ pi.startPage }" end="${ pi.endPage }">
													                 	<li class="page-item ${ pi.currentPage == p ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/search.do?page=${p}&condition=${search.condition}&keyword=${search.keyword}">${ p }</a></li>
													                </c:forEach>
													                
													                <li class="page-item ${ pi.currentPage == pi.maxPage ? 'disabled' : '' }"><a class="page-link" href="${ contextPath }/pay/search.do?page=${pi.currentPage+1}&condition=${search.condition}&keyword=${search.keyword}">Next</a></li>
													             </ul>
                                   	</c:otherwise>
                                   </c:choose>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </div>
        <!-- content 끝 -->
        <jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
    </main>
    
    <script>
    $(document).ready(function(){
        $("#cen_bot_table .ing").each(function(){
            var text = $(this).text();
            if(text == '진행중'){
                $(this).css("color", "green");
            } else if(text == '반려'){
                $(this).css("color", "orange");
            } else if(text == '승인완료'){
                $(this).css("color", "red");
            }
        });

        $("#cen_bot_table .status").each(function(){
            var text = $(this).text();
            if(text == '긴급'){
                $(this).css("color", "red");
            } else if(text == '보통'){
                $(this).css("color", "rgb(49, 106, 153)");
            } 
        });
    });
	</script>
	
	<!-- search가 비워져있지않을때 실행되는 스크립트구문 -->
	
	
	<!-- clistCount 값이 있을때 실행되는 스크립트 구문 -->

	
	<c:choose>
		<c:when test="${ not empty params }">
			<script>
				$(document).ready(function(){
					$("#selects").val("${params.conditions}");
					$("#statusSelect").val("${params.status}");
					
					
				})
			</script>
		</c:when>
		<c:when test="${ not empty search }">
			<script>
				$(document).ready(function(){
					//카테고리 고정시키기
					$("#select_search").val("${search.condition}");
					 
					
				})
			
			</script>
		</c:when>
		<c:when test="${not empty userAllListSelect}">
				<script>
					$(document).ready(function(){
						//카테고리고정
						$("#selects").val("${map.conditions}");
						$("#statusSelect").val("${map.status}");
					})
				</script>
		</c:when>
	</c:choose>
	
	<script>
		$("#my_button").on("click", function(){
			
			if($("#search_input").val().trim().length == 0){
				alert("다시입력해주세요.");
				return false;
			}
			
		})
		
		$("#user_mybutton").on("click", function(){
				
			if($("#search_input").val().trim().length == 0){
				alert("다시입력해주세요.");
				return false;
			}
			
		})
	</script>
	
	
	
	
	
	 <script>
    /* ajax 카테고리..xx
    	$(document).ready(function(){
    		
    			$("#selects").change(function(){
    				
    				
    				
    				$.ajax({
        				url:"${contextPath}/pay/selects.do",
        				type:"get",
        				data:{conditions:$("#selects").val()},
        				success:function(result){
        					
        					console.log(result.list);
        					
        					
        					let td = "";
        					for (let i = 0; i < result.list.length; i++) {
        					    let attachment = (result.list[i].salesStatus + result.list[i].draftStatus + result.list[i].businessStatus == 1) ?
        					                     `<svg xmlns="http://www.w3.org/2000/svg" width="19" height="19" fill="currentColor" class="bi bi-paperclip" viewBox="0 0 16 16" style="color: black;">
        					                      <path d="M4.5 3a2.5 2.5 0 0 1 5 0v9a1.5 1.5 0 0 1-3 0V5a.5.5 0 0 1 1 0v7a.5.5 0 0 0 1 0V3a1.5 1.5 0 1 0-3 0v9a2.5 2.5 0 0 0 5 0V5a.5.5 0 0 1 1 0v7a3.5 3.5 0 1 1-7 0z"/>
        					                      </svg>` : "";

        					    let td = "<tr>";
        					    td += "<td>" + result.list[i].approvalNo + "</td>";  
        					    td += "<td>" + result.list[i].documentType + attachment + "</td>";
        					    td += "<td>" + result.list[i].payWriter + "</td>";
        					    td += "<td>" + result.list[i].department + "</td>";
        					    td += "<td>" + result.list[i].registDt + "</td>";
        					    td += '<td class="ing">' + result.list[i].documentStatus + "</td>";
        					    td += "<td>" +  (result.list[i].finalApproDt == null ? "-" : result.list[i].finalApproDt) + "</td>";
        					    td += '<td class="status">' + result.list[i].payStatus + "</td>";
        					    td += "</tr>";
        					}
        					$("#cen_bot_table tbody").empty();
        					$("#cen_bot_table tbody").html(td);
        					
        					
        					let li = "";
        			        li += '<li class="page-item ' + (result.pi.currentPage == 1 ? 'disabled' : '') + '"><a class="page-link" href="${contextPath}/pay/selects.do?page=' + (result.pi.currentPage - 1) + '&conditions=' + (result.conditions) + '">Previous</a></li>';
        			        for (let p = result.pi.startPage; p <= result.pi.endPage; p++) {
        			            li += '<li class="page-item ' + (result.pi.currentPage == p ? 'disabled' : '') + '"><a class="page-link" href="${contextPath}/pay/selects.do?page=' + p + '&conditions=' + (result.conditions) + '">' + p + '</a></li>';
        			        }
        			        li += '<li class="page-item ' + (result.pi.currentPage == result.pi.maxPage ? 'disabled' : '') + '"><a class="page-link" href="${contextPath}/pay/selects.do?page=' + (result.pi.currentPage + 1) + '&conditions=' + (result.conditions) + '">Next</a></li>';
        					
        			    $(".pagination ul").empty(); //자식요소 삭제
        					$(".pagination ul").html(li); //html로 만들어서 ul
        					
        				},
        				error:function(){
        					console.log("데이터 ajax 통신 실패");
        				}
        			})
    			
    			})
    					
    	})
    	*/
    </script>

	
	
	
</body>
</html>