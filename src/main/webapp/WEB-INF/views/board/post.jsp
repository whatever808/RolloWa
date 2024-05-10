<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />

<%@ page import="java.util.*" %>
<%
	Map loginUser = new HashMap();
	loginUser.put("userNo", 1);
	loginUser.put("userName", "신짱구");
	loginUser.put("userId", "zg0505");
	loginUser.put("userPwd", "zg0505");
	loginUser.put("phone", "010-1234-5678");
	loginUser.put("address", "부산광역시 강서구");
	loginUser.put("accountNo", "594125-65-154796");
	loginUser.put("bank", "신한은행");
	loginUser.put("email", "zg0505@gmail.com");
	loginUser.put("profileUrl", null);
	loginUser.put("countFail", 0);
	loginUser.put("enrollDate", "2024-05-01");
	loginUser.put("enrollUserNo", 2);
	loginUser.put("modifyDate", "2024-05-01");
	loginUser.put("modifyUserNo", 1);
	loginUser.put("status", "Y");
	loginUser.put("vacationCount", 0);
	loginUser.put("authLevel", 1);
	loginUser.put("salary", "10000");
	loginUser.put("teamNo", "건축");
	loginUser.put("positionNo", null);
	pageContext.setAttribute("loginUser", loginUser);
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>게시글 등록</title>
	
	<!-- 게시글등록페이지 스타일 -->
  <link href="${ contextPath }/resources/css/board/post.css" rel="stylesheet">
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
	<!-- content 추가 -->
  <div class="content p-5">

      <!-- post form area start -->
      <div class="post-form">

          <h1 class="page-title">게시글 작성</h1>

          <!-- ckeditor script -->
          <script type="text/javascript" src="${ contextPath }/resources/ckeditor/ckeditor.js"></script>

          <!-- board post form start -->
          <form action="${ contextPath }/board/post.do" method="post" encType="multipart/form-data" id="post-form" >
							
							<!-- board category -->
              <div class="field-group">
                  <label for="board-category" class="field-title">게시판</label><br>              
                  <select name="category" class="board-category form-select" id="board-category">
                      <option value="">일반게시판</option>
                      <option value="${ loginUser.teamNo }">부서게시판</option> <!-- 로그인 사용자가 속한 부서 -->
                  </select>
              </div>

              <!-- board title -->
              <div class="field-group">
                  <label for="board-title" class="field-title">게시글 제목</label><br>
                  <input type="text" id="board-title" placeholder="제목을 입력하세요." name="title" required>
              </div>

              <!-- board attachment -->
              <div class="field-group">
                  <label class="field-title" for="board-attachment">첨부파일</label>
                  <input type="file" name="uploadFiles" class="form-control" id="board-attachment" multiple>
              </div>
              
              <!-- board content 
               <div class="field-group">
                  <label class="field-title" for="board-content">게시글 내용</label>
                  <textarea name="boardContent" class="form-control" id="boardContent" required></textarea>
              </div>
              -->
              
              <!--  CKEditor 적용 -->
              <script>
		              $(document).ready(function(){
		            		CKEDITOR.replace("board-content", {
		            			filebrowserUploadUrl:"${ contextPath }/upload/img.do"
		            		});
		            	})
              </script>
              
              
              <div class="field-group">
                  <label class="field-title" for="board-content">게시글 내용</label>
                  <textarea name="content" class="form-control" id="board-content"></textarea>
              </div>
							
							
              <div class="button-group">
                  <button type="reset" class="btn btn-outline-warning" onclick="resetForm();">초기화</button>
                  <button type="submit" class="btn btn-outline-primary">등록하기</button>
                  <button type="button" class="btn btn-outline-secondary">임시저장</button>
              </div>

          </form>
          <!-- board post form end-->

      </div>
      <!-- post form end -->

  </div>
  <!-- content 끝 -->
  
  <!-- chat floating -->
  <jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
	

</body>

<!-- 게시글등록페이지 스크립트 -->
<script src="${ contextPath }/resources/js/board/postForm.js"></script>

<script>
	$("#post-form").on("submit", function(){
		
	})  			
</script>

</html>