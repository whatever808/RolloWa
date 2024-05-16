<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>어트랙션 조회</title>
	
	<!-- 놀이기구목록페이지 스타일 -->
   <link href="${ contextPath }/resources/css/facility/attraction/list.css" rel="stylesheet">
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
	<!-- content 추가 -->
  <div class="content m-5">

       <h1 class="page-title">어트랙션 조회</h1>

       <!-- attraction status start -->
       <select class="attraction-status form-select" style="width: 200px;">
           <option>전체</option>
           <option>운영중</option>
           <option>운영중지</option>
       </select>
       <!-- attraction status end -->

       <!-- search form start-->
       <div id="search-form">
           <form>
               <select class="search-condition form-select" >
                   <option>전체</option>
                   <option>기구명</option>
                   <option>위치</option>
               </select>
               <input type="text" id="search-keyword" class="form-control" placeholder="검색어를 입력해주세요." required>
               <button type="submit" class="btn btn-outline-secondary">검색</button>
           </form>
       </div>
       <!-- search form end -->

       <!-- attraction list start -->
       <div class="attraction-list">
           <!-- attraction list table start-->
           <table class="table align-middle mb-0 bg-white">
               <thead class="bg-light">
                 <tr>
                   <th>
                       <input type="checkbox" class="form-check">
                   </th>
                   <th>기구명</th>
                   <th>위치</th>
                   <th>운영상태</th>
                   <th>등록날짜</th>
                 </tr>
               </thead>
               <tbody>
                 <tr>
                   <td>
                     <input type="checkbox" class="form-check">
                   </td>
                   <td class="attraction-name-td">
                       <p class="attraction-name">
                           둘이 타서 한명이 날아가도 모르는 저세상 롤러코스터 하하하하하하하하하하하하하핳
                       </p>
                   </td>
                   <td>A zone</td>
                   <td>
                     <span class="badge badge-success rounded-pill d-inline">운영중</span>
                   </td>
                   <td>2024-04-24</td>
                 </tr>
                 
               </tbody>
             </table>
           <!-- board list table end -->

           
       </div>
       <!-- board list end-->

   </div>
   <!-- content 끝 -->
	
	<!-- chat floating -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
	
</body>
</html>