<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
	/* 알림 스타일 추가 */
	 .title_wrapper {
	     height: 10%;
	 }
	
	 .table_wrapper {
	     height: 80%;
	 }
	
	 .paging_wrapper {
	     margin-top: 10px;
	     display: flex;
	     flex-direction: row;
	     justify-content: center;
	 }
	
	 /* 알림 테이블 스타일 */
	 .use {
	 	color: rgb(49, 106, 153);
	 }
	 .delete {
	 	color: rgb(255, 0, 0)
	 }
	 /* 알림 테이블 스타일 끝 */
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
		 
		 <!-- content 추가 -->
     <div class="content">
         <!-- Modal structure -->
         <div id="insert_noti">
             <!-- Modal content -->
             <div class="m_content_style">
                 <form action="${ contextPath }/notification/insert.do" method="post">
                     알람 내용 : <input style="width: 100%;" name="content" type="text">
                     <div class="btn_wrapper">
                         <input type="submit" value="생성" class="btn1 forget_btn" style="margin-top: 10px;">
                     </div>
                 </form>
             </div>
         </div>
         <div class="title-wrapper">
             <h3>알림 목록</h3>
         </div>
         <div id="cen_bottom_rigth table_wrapper">
             <div id="cen_bottom_table">
                 <!-- Trigger to open Modal -->
                 <div class="btn_wrapper" style="margin-bottom: 10px;">
                     <button data-izimodal-open="#insert_noti" class="btn1 forget_btn">
                         알람 생성
                     </button>
                 </div>

                 <table class="table">
                     <thead>
                         <tr>
                             <th>알림 번호</th>
                             <th>알림 내용</th>
                             <th>작성자</th>
                             <th>작성일</th>
                             <th>사용 여부</th>
                             <th>삭제</th>
                         </tr>
                     </thead>
                     <tbody>
                     		<c:forEach var="notification" items="${ notiList }">
                     			<tr>
													    <td>${ notification.notiNo }</td>
													    <td>${ notification.notiContent }</td>
													    <td></td>
													    <td>${ notification.enrollDate }</td>
													    <td class="${ notification.status == 'Y' ? 'use' : 'delete' }">${ notification.status == 'Y' ? '사용' : '삭제' }</td>
													    <td>
														    <form action="${ contextPath }/notification/delete.do" method="post">
														    	<input type="hidden" name="notiNo" value="${ notification.notiNo }">
														    	<button type="submit" class="btn1 delete_btn delete_noti_btn">삭제</button>
														    </form>
													    </td>
													</tr>
                     		</c:forEach>
                     </tbody>
                 </table>
             </div>
             <div class="paging_wrapper">
               <ul class="pagination">
                   <li class="page-item ${ pageInfo.currentPage == 1 ? 'disabled' : ''}"><a class="page-link" href="${ contextPath }/notification/list.page?page=${ pageInfo.currentPage - 1 }">Previous</a></li>
                   <c:forEach var="p" begin="${ pageInfo.startPage }" end="${ pageInfo.endPage }">
                   	<li class="page-item ${ pageInfo.currentPage == p ? 'disabled' : ''}"><a class="page-link" href="${ contextPath }/notification/list.page?page=${ p }">${ p }</a></li>
                   </c:forEach>
                   <li class="page-item ${ pageInfo.currentPage == pageInfo.maxPage ? 'disabled' : ''}"><a class="page-link" href="${ contextPath }/notification/list.page?page=${ pageInfo.currentPage + 1 }">Next</a></li>
               </ul>
             </div>
         </div>
     </div>
		<!-- content 끝 -->
		<script>
			$('#insert_noti').iziModal({
			    title: '알람 생성',
			    // subtitle: '',
			    headerColor: 'rgb(255,247,208)', // 헤더 색깔
			    theme: 'light', //Theme of the modal, can be empty or "light".
			    padding: '15px', // content안의 padding
			    radius: 10, // 모달 외각의 선 둥글기
			    group: 'name111',
			    loop: true,
			    arrowKeys: true,
			    navigateCaption: true,
			    navigateArrows: true,
			    zindex: 300, // zindex 모달의 화면 우선 순위 입니다. 
			    focusInput: true, // 가장 맨 위에 보이게 해주는 속성값
			    restoreDefaultContent: false, // 모달을 다시 키면 값을 초기화
			});		
		</script>
        
        
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
</body>
</html>