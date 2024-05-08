<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mypage</title>
<style>
	/* mypage 추가 */
     .content {
         height: 1200px;
         width: 1000px;
         margin: auto;
         display: flex;
         flex-direction: column;
         justify-content: space-around;
         border: 1px solid lightgray;
         border-radius: 10px;
     }

     .profile {
         height: 30%;
         display: flex;
         justify-content: center;
     }

     .info {
         height: 60%;
         display: flex;
         flex-direction: column;
         justify-content: center;
     }

     .profile_box {
         width: 80%;
         display: flex;
         justify-content: space-around;
     }

     .profile_img {
         width: 40%;
         display: flex;
         flex-direction: column;
         justify-content: center;
     }

     .user_info {
         width: 40%;
         display: flex;
         flex-direction: column;
         justify-content: space-around;
     }

     .dp_info,
     .sd_info,
     .co_info {
         height: 35%;
         display: flex;
         flex-direction: column;
         justify-content: center;
     }

     .img_wrapper {
         height: 70%;
     }

     #profileImg {
         height: 280px;
         width: 280px;
         border: 1px solid lightgray;
         border-radius: 50%;
     }

     .info_wrapper {
         height: 20%;
     }

     .btn {
         font-size: 13px;
         margin: 3px;
     }
</style>
</head>
<body>
			<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
				<div class="content">
	         <div class="profile">
	             <div class="profile_box">
	                 <div class="profile_img">
	                     <div class="img_wrapper">
	                         <img id="profileImg" src="${ contextPath }<c:out value='${ loginMember.profileURL }' default='/resources/images/defaultProfile.png'/>" onclick="$('#profileImgFile').click();">
	                         <input type="file" id="profileImgFile" class="file" style="display:none;" accept="image/*">
	                     </div>
	                 </div>
	                 <div class="user_info">
	                     <div class="dp_info">
	                         <div class="info_wrapper">
	                             <span>직급</span>
	                             <span>소속부서</span>
	                         </div>
	                     </div>
	                     <div class="sd_info">
	                         <div class="info_wrapper">
	                             <span>근속일수</span>
	                         </div>
	                     </div>
	                     <div class="co_info">
	                         <div class="info_wrapper">
	                             <span>출근시간</span> | <span>퇴근시간</span>
	                         </div>
	                     </div>
	                 </div>
	             </div>
	         </div>
	         <div class="info">
	             <form action="">
	                 <table class="table table-striped">
	                     <tr>
	                         <th>아이디 : </th>
	                         <td colspan="2"><input type="text" value="${ loginMember.userId }" placeholder="기존 아이디" readonly></td>
	                     </tr>
	                     <tr>
	                         <th>이름 : </th>
	                         <td colspan="2"><input type="text" name="" value="${ loginMember.userName }" placeholder="이름" required></td>
	                     </tr>
	                     <tr>
	                         <th>핸드폰 번호 : </th>
	                         <td><input type="text" name="" value="${ loginMember.phone }" placeholder="전화번호"></td>
	                         <td><button type="button" class="btn btn-sm btn-outline-primary">인증</button></td>
	                     </tr>
	                     <tr>
	                         <th>우편번호 : </th>
	                         <td><input class="form-control" type="text" name="" value=""></td>
	                         <td><button type="button" class="btn btn-sm btn-outline-primary">주소 찾기</button></td>
	
	                     </tr>
	                     <tr>
	                         <th>주소 : </th>
	                         <td colspan="2"><input type="text" name="" value=""></td>
	                     </tr>
	                     <tr>
	                         <th>상세주소 : </th>
	                         <td colspan="2"><input type="text" name="" value=""></td>
	                     </tr>
	                     <tr>
	                         <th>이메일 : </th>
	                         <td colspan="2"><input type="text" name="" value="${ loginMember.email }"></td>
	                     </tr>
	                     <tr>
	                         <th>
	                             월급 수령계좌 :
	                         </th>
	                         <td>
	                             <select class="form-select" aria-label="Default select example">
	                                 <option selected>은행</option>
	                                 <option value="1">국민은행</option>
	                                 <option value="2">신한은행</option>
	                                 <option value="3">우리은행</option>
	                             </select>
	                         </td>
	                         <td>
	                             <input type="text" name="" value="${ loginMember.accountNo }" placeholder="계좌번호">
	                         </td>
	                     </tr>
	                 </table>
	                 <div class="btn_wrapper">
	                     <button type="reset" class="btn btn-outline-success">초기화</button>
	                     <button type="submit" class="btn btn-outline-primary">개인정보 변경</button>
	                     <button type="button" class="btn btn-outline-warning" data-izimodal-open="#modify_pwd">비밀번호
	                         변경</button>
	                 </div>
	             </form>
	         </div>
	     </div>
	     <!-- Modal structure -->
	     <div id="modify_pwd">
	         <!-- Modal content -->
	         <div class="m_content_style">
	             <form action="" class="form-control">
	                 현재 비밀번호 : <input class="form-control" type="password" name=""> <br>
	                 변경 비밀번호 : <input class="form-control" type="password" name=""> <br>
	                 비밀번호 확인 : <input class="form-control" type="password" name="">
	                 <div class="btn_wrapper" style="margin-top: 10px;">
	                     <input type="submit" value="변경하기" class="btn1 forget_btn">
	                 </div>
	             </form>
	         </div>
	     </div>
	     <!-- content 끝 -->
			<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
</body>
<script>
	$('#modify_pwd').iziModal({
	    title: '비밀번호 변경',
	    subtitle: '',
	    headerColor: '#FEEFAD', // 헤더 색깔
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
	$("#profileImgFile").on("change", function(evt) {
			if(this.files.length != 0) {
				// 현재 선택된 파일이 있을 경우
				let formData = new FormData();
				formData.append("uploadFile", this.files[0]);
				console.log(this.files[0]);
				
				$.ajax({
						 url: "${contextPath}/member/modifyProfile.do"
						, type: "post"
						, data: formData
						, processData: false
						, contentType: false
						, success: function(result) {
							if (result == "SUCCESS") {
								alertify.alert("프로필 사진 변경","프로필 변경에 성공했습니다.");
								// 현재 위치 새로고침
								location.reload();
							} else if (result == "FAIL") {
								alertify.alert("프로필 사진 변경","프로필 변경에 실패했습니다.");
							}
						}
					 	, error: function() {
					 		console.log("프로필 이미지 변경용 ajax 통신 실패")
					 	}
				})
			} else {
				// 선택된 파일이 없을 경우
				
			}
	})
</script>
</html>