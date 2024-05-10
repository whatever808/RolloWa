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
</head>
<body>

	<!-- side bar -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />
	
	<script>
		// TinyMCE 에디터 환경설정
		tinymce.init({
	        selector: "#board-content", // TinyMCE를 적용할 textarea 요소의 선택자를 지정
	        plugins: "paste image imagetools", // 'paste', 'image', 'imagetools' 플러그인 추가
	        height: 500,
	        width: 900,
	        toolbar: "undo redo | styleselect | bold italic | alignleft aligncenter alignright alignjustify | outdent indent | image", // 'image' 버튼 툴바에 추가
	        paste_data_images: true, // 이미지 붙여넣기 설정 활성화
	        file_picker_types: 'image', // TinyMCE에서 이미지를 선택할 때, 이미지 파일만 선택 (옵션 : media, file 등)
	        images_upload_handler(blobInfo, success) { // 이미지를 업로드하는 핸들러 함수
	            // blobInfo : TinyMCE에서 이미지 업로드 시 사용되는 정보를 담고 있는 객체
	            const file = new File([blobInfo.blob()], blobInfo.filename());
	            const fileName = blobInfo.filename();
	 
	            if (fileName.includes("blobid")) {
	                success(URL.createObjectURL(file));
	            } else {
	                imageFiles.push(file);
	                success(URL.createObjectURL(file)); // Blob 객체의 임시 URL을 생성해 이미지 미리보기 적용
	            }
	        }
   		});
	</script>
	
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
                      <option value="${ loginUser.teamNo }">부서공지사항</option> <!-- 로그인 사용자가 속한 부서 -->
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
              
              <!-- board content -->
               <div class="field-group">
                  <label class="field-title" for="board-content">게시글 내용</label>
                  <textarea name="boardContent" class="form-control" id="board-content" required></textarea>
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

<script>
				
</script>

</html>