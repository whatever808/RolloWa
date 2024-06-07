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
          <form id="post-form" method="post" enctype="multipart/form-data">
							
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
                 <small class="text-secondary ms-3">파일 당 최대 10MB씩, 최대 10개까지만 업로드 가능합니다.</small>
					  <input type="file" name="uploadFiles" id="uploadFiles" class="form-control board-attachment mb-3" multiple>
              </div>
              
              <!-- board content -->
               <div class="field-group">
                  <label class="field-title" for="editor">글내용</label>
                  <textarea class="form-control" name="content" id="editor"></textarea>
              	  <input type="hidden" name="textContent">
              </div>
							
              <div class="button-group">
              	  <input type="hidden" name="status">
                  <button type="reset" class="btn btn-outline-warning">초기화</button>
                  <button type="button" class="btn btn-outline-primary" id="post-board" onclick="ajaxFormSubmit('Y');">등록하기</button>
                  <button type="button" class="btn btn-outline-secondary" id="temp-board" onclick="ajaxFormSubmit('T');">임시저장</button>
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
	//업로드가능 파일용량 및 갯수 제한 =================================================================
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
	
	// 공지사항 제출요청 =====================================================================================================
	function ajaxFormSubmit(status){
		let contentVal = $.trim(tinyMCE.get("editor").getContent({format: 'text'}));	// 내용값(앞뒤 공백제거)
		let titleVal = $("input[name=title]").val().trim();	// 제목값(앞뒤 공백제거)
		
		// 필수입력 항목 유효성 검사
		if(contentVal.length != 0 && titleVal.length != 0){
			// 등록할 공지사항 내용값 파라미터 추가
			$("textarea[name=content]").val(tinymce.activeEditor.getContent("editor"));
			// 등록할 공지사항 상태값 파라미터 추가
			$("input[name=status]").val(status);
			// HTML 태그가 없는 순수 내용값
			$("input[name=textContent]").val(contentVal);
			
			// 공지사항 등록 or 저장 요청
			$.ajax({
				url:"${ contextPath }/board/post.do",
				method:"post",
				data:new FormData($("#post-form")[0]),
				contentType:false,
				processData:false,
				success:function(result){
					let msg = "";
					if(result.result == 'SUCCESS'){
						if(status == 'Y'){
							// [기웅] 부서 공지사항 등록 시 알림 전송
							if($("select[name=category]").val() != "") {
															stompClient.send("/app/alram/send", {}, JSON.stringify({sendUserNo: '${loginMember.userNo}'
																																		, flag: '1'
																																		, teamCode: '${loginMember.teamCode}'
																																		, url: "${contextPath}/board/detail.do?category=&department=&condition=&keyword=&no=" + result.boardNo}));
							}
							// [기웅]
							msg = "공지사항이 " + (status == 'Y' ? '등록' : '저장') + " 되었습니다.";
							alert(msg);
							location.href = "${ contextPath }/board/detail.do?no=" + result.boardNo;						
						}else if(status == 'T'){
							location.href = "${ contextPath }/board/temp/detail.do?no=" + result.boardNo;						
						}
					}else{
						redAlert("공지사항 " + (status == 'Y' ? '등록' : '저장') + "이 실패되었습니다.", '');
					}
				},error:function(){
					redAlert("공지사항 " + (status == 'Y' ? '등록' : '저장') + "요청에 실패했습니다.", '');
				}
			})
		}else{
			if(titleVal.length == 0){
				alert("공지사항 제목을 입력해주세요.");
				$("input[name=title]").select();
			}else if(contentVal.length == 0){
				alert("공지사항 내용을 입력해주세요.");
				tinymce.activeEditor.focus();
			}
		}
		
	}
	
	// 공지사항 제출요청(origin) ====================================================================================================
	/*
		function formSubmit(){
		// 에디터에 작성된 내용을 [name=content]로 함께 전달
		$("textarea#editor").val(tinymce.activeEditor.getContent("editor"));
		$("#post-form").submit();
		
		if($("#editor").val().trim().length == 0 || $("#editor").val().trim() == ''){
			console.log("내용 미작성");
		}else{
			console.log("내용 작성");
		}
		
		// [기웅] 부서 공지사항 등록 시 부서원들에게 알림 전송
		if($("input[name=status]").val() == 'Y') {
			if($("select[name=category]").val() != "") {
				alram.send(JSON.stringify({ teamCode : '${loginMember.teamCode}' }));
			}
		}
	}
	*/
</script>

</html>