<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Mypage</title>
<!-- 카카오 주소찾기 api -->
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
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
	             <form action="${ contextPath }/member/updateInfo.do" method="post">
	                 <table class="table table-striped">
	                     <tr>
	                         <th>아이디 : </th>
	                         <td colspan="2"><input type="text" value="${ loginMember.userId }" placeholder="기존 아이디" readonly></td>
	                     </tr>
	                     <tr>
	                         <th>이름 : </th>
	                         <td colspan="2"><input type="text" name="userName" value="${ loginMember.userName }" placeholder="이름" required></td>
	                     </tr>
	                     <tr>
	                         <th>핸드폰 번호 : </th>
	                         <td><input type="text" name="phone" value="${ loginMember.phone }" placeholder="전화번호"></td>
	                         <td><button type="button" class="btn btn-sm btn-outline-primary">인증</button></td>
	                     </tr>
	                     <tr>
	                         <th>우편번호 : </th>
	                         <td><input class="form-control" type="text" id="postCode" name="postNumber" value="${ loginMember.postCode }"></td>
	                         <td><button type="button" class="btn btn-sm btn-outline-primary" onclick="findAddress();">주소 찾기</button></td>
	
	                     </tr>
	                     <tr>
	                         <th>주소 : </th>
	                         <td colspan="2"><input type="text" id="address" name="address" value="${ loginMember.address }"></td>
	                     </tr>
	                     <tr>
	                         <th>상세주소 : </th>
	                         <td colspan="2"><input type="text" id="detailAddress" name="detailAddress" value="${ loginMember.detailAddress }"></td>
	                     </tr>
	                     <tr>
	                         <th>이메일 : </th>
	                         <td colspan="2"><input type="text" name="email" value="${ loginMember.email }"></td>
	                     </tr>
	                     <tr>
	                         <th>
	                             월급 수령계좌 :
	                         </th>
	                         <td>
	                             <select name="bank" class="form-select" aria-label="Default select example" id="bank_select">
	                                 <option value="농협은행">농협은행</option>
	                                 <option value="국민은행">국민은행</option>
	                                 <option value="신한은행">신한은행</option>
	                                 <option value="우리은행">우리은행</option>
	                             </select>
	                         </td>
	                         <td>
	                             <input type="text" name="bankAccount" value="${ loginMember.bankAccount }" placeholder="계좌번호">
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
	
	// 프로필 이미지 변경
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
				
			}
	})
	
	// 은행정보
	$(document).ready(function() {
		$("#bank_select").children().each(function(index, el) {
			if($(el).val() == '${loginMember.bank}') {
				$(el).attr("selected", true);
			}
		})
	})
	
	// 주소찾기
	function findAddress() {
		new daum.Postcode({
			oncomplete: function(data) {
				// 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

        // 각 주소의 노출 규칙에 따라 주소를 조합한다.
        // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
        var addr = ''; // 주소 변수
        var extraAddr = ''; // 참고항목 변수

        //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
        if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
            addr = data.roadAddress;
        } else { // 사용자가 지번 주소를 선택했을 경우(J)
            addr = data.jibunAddress;
        }

        // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
        if(data.userSelectedType === 'R'){
            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                extraAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if(data.buildingName !== '' && data.apartment === 'Y'){
                extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if(extraAddr !== ''){
                extraAddr = ' (' + extraAddr + ')';
            }
            // 조합된 참고항목을 해당 필드에 넣는다.
            //document.getElementById("sample6_extraAddress").value = extraAddr;
        
        } else {
            //document.getElementById("sample6_extraAddress").value = '';
        }

        // 우편번호와 주소 정보를 해당 필드에 넣는다.
        document.getElementById('postCode').value = data.zonecode;
        document.getElementById("address").value = addr;
        // 커서를 상세주소 필드로 이동한다.
        document.getElementById("detailAddress").focus();
			}
		}).open();
	}
</script>
</html>