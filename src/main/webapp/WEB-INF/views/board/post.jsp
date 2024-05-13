<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지사항등록</title>
	
	<!-- 게시글등록페이지 스타일 -->
  	<link href="${ contextPath }/resources/css/board/post.css" rel="stylesheet">

	<!-- TinyMCE 에디터 CDN 연결 -->
	<script src="https://cdn.tiny.cloud/1/kv8msifnng66ha7xgul5sc6cehyxcp480zm27swyti7b7u38/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
	<!-- TinyMCE 관련 스크립트 -->
	<script src="${ contextPath }/resources/js/board/editor.js"></script>
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
	<!-- content 추가 -->
  	<div class="content p-5">

      <!-- post form area start -->
      <div class="post-form">

          <h1 class="page-title">공지사항 등록</h1>

          <!-- board post form start -->
          <form action="${ contextPath }/board/post.do" method="post" encType="multipart/form-data" id="post-form" >
							
			  <!-- board category -->
              <div class="field-group">
                  <label for="board-category" class="field-title">게시판</label><br>              
                  <select name="category" class="board-category form-select" id="board-category">
                      <option value="">일반공지사항</option>
                      <option value="${ loginMember.teamCode }">부서공지사항</option> <!-- 로그인 사용자가 속한 부서 -->
                  </select>
              </div>

              <!-- board title -->
              <div class="field-group">
                  <label for="board-title" class="field-title">글제목</label><br>
                  <input type="text" id="board-title" placeholder="제목을 입력하세요." name="title" required>
              </div>

              <!-- board attachment -->
              <div class="field-group">
                  <label class="field-title" for="board-attachment">첨부파일</label>
	              <div id="add-attachment" onclick="addFileInput();">
            		  <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="#909090" viewBox="0 0 16 16">
					     <path d="M8 6.5a.5.5 0 0 1 .5.5v1.5H10a.5.5 0 0 1 0 1H8.5V11a.5.5 0 0 1-1 0V9.5H6a.5.5 0 0 1 0-1h1.5V7a.5.5 0 0 1 .5-.5"/>
					     <path d="M14 4.5V14a2 2 0 0 1-2 2H4a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h5.5zm-3 0A1.5 1.5 0 0 1 9.5 3V1H4a1 1 0 0 0-1 1v12a1 1 0 0 0 1 1h8a1 1 0 0 0 1-1V4.5z"/>
					  </svg>
					  <small>첨부파일 추가</small>
	              </div>
                  <div id="attachment-div">
                  	<input type="file" name="uploadFiles" class="form-control board-attachment">
                  	
                  </div>
              </div>
              
              <!-- board content -->
               <div class="field-group">
                  <label class="field-title" for="editor">글내용</label>
                  <textarea class="form-control" name="content" id="editor"></textarea>
              </div>
							
              <div class="button-group">
              	  <input type="hidden" name="status">
                  <button type="reset" class="btn btn-outline-warning">초기화</button>
                  <button type="button" class="btn btn-outline-primary" onclick="setBoardStatus('Y');">등록하기</button>
                  <button type="button" class="btn btn-outline-secondary" onclick="setBoardStatus('T');">임시저장</button>
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

<script>
	// 업로드 첨부파일 추가 =================================================================================================
	function addFileInput(){
		if($("#attachment-div").children().length < 10){
			// 추가한 첨부파일 업로드 요소가 10개 이하일 경우 첨부파일 요소 추가
			$("#attachment-div").append("<input type='file' name='uploadFiles' class='form-control board-attachment'>");	
		}else{
			// 추가한 첨부파일 업로드 요소가 10개 초과일 경우 알림창
			alertify.alert("업로드 가능 첨부파일 갯수는 최대 10개 까지입니다.");
		}
	}
	
	// 공지사항 저장형태값 지정 =================================================================================================
	function setBoardStatus(status){
		$("input[name=status]").val(status);
		formSubmit();
	}
	
	// 공지사항 수정 요청 ====================================================================================================
	function formSubmit(){
		// 에디터에 작성된 내용을 [name=content]로 함께 전달
		$("textarea#editor").val(tinymce.activeEditor.getContent("editor"));
		$("#post-form").submit();
		
		if($("#editor").val().trim().length == 0 || $("#editor").val().trim() == ''){
			console.log("내용 미작성");
		}else{
			console.log("내용 작성");
		}
	}
	
</script>

</html>