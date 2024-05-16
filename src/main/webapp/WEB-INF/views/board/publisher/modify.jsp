<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>공지사항 수정</title>
	
	<!-- 게시글수정페이지 스타일 -->
    <link href="${ contextPath }/resources/css/board/modify.css" rel="stylesheet">

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
	
	    <!-- modify form area start -->
	    <div class="modify-form">
	
	        <h1 class="page-title">공지사항 수정</h1>
	
	        <!-- board modify form start -->
	        <form action="${ contextPath }/board/publisher/modify.do" method="post" id="modify-form" enctype="multipart/form-data">
				
				<!-- board no -->
				<input type="hidden" name="boardNo" value="${ board.boardNo }">
				
				<!-- board category -->
	            <div class="field-group">
	                <label for="board-category" class="field-title">게시판</label><br>
	                <!-- board category -->
	                <select class="board-category form-select" id="board-category" name="category">
	                    <option value="" ${ empty board.category ? 'selected' : '' }>일반공지사항</option>
	                    <option value="${ department.code }" ${ not empty board.category ? 'selected' : '' }>부서공지사항</option>
	                </select>
	            </div>
	
	            <!-- board title -->
                <div class="field-group">
                    <label for="board-title" class="field-title">글제목</label><br>
                    <input type="text" id="board-title" placeholder="제목을 입력하세요." name="title" required value="${ board.title }">
                </div>
	
	            <!-- board attachment -->
	            <div class="field-group">
	                <label class="field-title" for="board-attachment">첨부파일</label>
	                <small class="text-secondary ms-3">파일 당 최대 10MB씩, 최대 10개까지만 업로드 가능합니다.</small>
              	    <input type="file" name="uploadFiles" id="uploadFiles" class="form-control board-attachment mb-3" multiple>
              	    
              	    <!-- original attachment list start -->
              	    <c:if test="${ not empty board.attachmentList }">
              	    	<div class="attachment-list">
	            	    	<table class="table table-sm table-borderless">
	              	    		
	              	    		<thead>
	              	    			<tr class="border-bottom">
		              	    			<th class="fw-bold" colspan="2">기존 첨부파일</th>
	              	    			</tr>
	              	    		</thead>
	              	    		
	              	    		<tbody>
	              	    			<c:forEach var="attachment" items="${ board.attachmentList }">
	              	    				<!-- one attachment -->
		              	    			<tr>
		              	    				<td class="delete-area">
		              	    					<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="red" class="delete" data-fileno="${ attachment.fileNo }" viewBox="0 0 16 16">
														 <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
														 <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708"/>
													</svg>
		              	    				</td>
		              	    				<td>
		              	    					<a download="${ attachment.originName }" href="${ contextPath }${ attachment.attachPath }/${ modifyName }">${ attachment.originName }</a>
		              	    				</td>
		              	    			</tr>
		              	    			<!-- one attachment -->
	             	    				</c:forEach>
	              	    		</tbody>
	              	    		
	              	    	</table>
              	    	</div>
              	    <!-- original attachment list end -->
              	    </c:if>
              	    
              	    <!-- delete attachment input list -->
              	    <div id="delete-attachment-list" class="d-none"></div>
	            </div>

	
	            <!-- board content -->
               <div class="field-group">
                   <label class="field-title" for="editor">글내용</label>
                   <textarea class="form-control" name="content" id="editor">
                   	  <c:out value="${ board.content }" escapeXml="false" />
                   </textarea>
               </div>
	
	            <div class="button-group">
              	   <input type="hidden" name="status">
                  <button type="reset" class="btn btn-outline-warning">초기화</button>
                  <button type="button" class="btn btn-outline-primary" onclick="setBoardStatus('Y');">수정하기</button>
                  <button type="button" class="btn btn-outline-secondary" onclick="setBoardStatus('T');">임시저장</button>
              	</div>
	
	        </form>
	        <!-- board modify form end-->
	
	    </div>
	    <!-- modify form end -->
	
	</div>
	<!-- content 끝 -->
	
	<!-- chat floating -->
  	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />

</body>

<!-- 공지사항 수정하기 페이지 스크립트 -->
<script>
	// 업로드가능 파일용량 및 갯수 제한 =================================================================
	$("#uploadFiles").on("change", function(event){
		const fileList = event.target.files;
		
		// 최대 업로드가능 파일갯수 제한
		if(fileList.length > 10){
			alertify.alert("첨부파일 업로드서비스", "최대 업로드가능 파일은 10개입니다.", $(event.target).val(""));
		}
		
		// 파일당 최대 업로드용량 제한
		for(let i=0 ; i<fileList.length ; i++){
			if(fileList[i].size > (1024 * 1024 * 10)){
				alertify.alert("첨부파일 업로드서비스", "첨부파일 최대 크기는 10MB를 초과할 수 없습니다.");
				event.target.value = "";
				return;
			}
		}
	})
		
	// 기존파일 삭제요청 ============================================================================
	$(".attachment-list").on("click", ".delete", function(event){
		let deleteFileNo = $(this).data("fileno");
		// 1) 삭제할 파일번호 파라미터값으로 넘기기
		$("#delete-attachment-list").append("<input type='hidden' name='delFileNoArr' value='" + deleteFileNo + "'>");
		
		// 2) 삭제할 파일요소 화면에서 지우기
		$(this).parents("tr").remove();
		
		// 3) 기존파일을 모두 삭제했을 경우, 해당 목록 영역 지우기
		$(".attachment-list").find(".delete").length == 0 && $(".attachment-list").remove();
	})
	
	// 공지사항 저장형태값 지정 ========================================================================
	function setBoardStatus(status){
		$("input[name=status]").val(status);
		formSubmit();
	}
	
	// 공지사항 수정 요청 ====================================================================================================
	function formSubmit(){
		// 에디터에 작성된 내용을 [name=content]로 함께 전달
		$("textarea#editor").val(tinymce.activeEditor.getContent("editor"));
		$("#modify-form").submit();
		
		if($("#editor").val().trim().length == 0 || $("#editor").val().trim() == ''){
			console.log("내용 미작성");
		}else{
			console.log("내용 작성");
		}
	}
	
	
	
</script>
</html>