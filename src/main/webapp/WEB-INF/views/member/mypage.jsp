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
         display: grid;
         padding: 25px;
     }
     .inner_line{
     		padding: 10px;
     		border: 1.5px solid rgb(0 0 0 / 31%);
 		    display: grid;
    		align-content: space-evenly;
     }
     .profile {
     }

     .info {
       padding: 20px;
     }

     .profile_box {
				width: 100%;
		    display: grid;
		    grid-template-columns: 35% 50%;;
		    justify-items: center;
		    align-items: center;
     }

     .profile_img {
		    align-content: center;
     }

     .user_info {
		    display: grid;
		    align-items: center;
		    gap: 30px;
     }
     
     .img_wrapper {

     }

     #profileImg {
         height: 280px;
         width: 280px;
         border-radius: 50%;
     }

     .info_wrapper {
         height: 20%;
     }

     .btn {
         font-size: 13px;
         margin: 3px;
     }
     
     .validation {
     	font-size: 10px;
     	color: gray;
     }
     
     .disable {
     	color: red;
     }
     
     .able {
     	color: green;
     }
</style>
</head>
<body>
			<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
				<div class="content">
					<div class="inner_line line-shadow radious10">
	         <div class="profile">
	             <div class="profile_box">
	                 <div class="profile_img">
	                     <div class="img_wrapper">
	                         <img id="profileImg" src="${ contextPath }<c:out value='${ memberInfo.profileURL }' default='/resources/images/defaultProfile.png'/>" onclick="$('#profileImgFile').click();">
	                         <input type="file" id="profileImgFile" class="file" style="display:none;" accept="image/*">
	                     </div>
	                 </div>
	                 <div class="user_info">
	                     <div class="dp_info">
	                         <div class="info_wrapper">
	                             <div class="jua-regular font-size20"> 직급 : ${ memberInfo.position }</div>
	                             <div class="jua-regular font-size20"> 팀 : ${ memberInfo.team }</div>
	                         </div>
	                     </div>
	                     <div class="sd_info">
	                         <div class="info_wrapper">
	                             <div class="jua-regular font-size20"> 근속일수 : ${ memberInfo.serviceDate }</div>
	                         </div>
	                     </div>
	                     <div class="co_info">
	                         <div class="info_wrapper">
	                             <div class="jua-regular font-size20"> 출근시간 : ${ memberInfo.clockIn != '00:00:00' ? memberInfo.clockIn : '' }</div>
	                             <div class="jua-regular font-size20"> 퇴근시간 : ${ memberInfo.clockOut != '00:00:00' ? memberInfo.clockOut : '' }</div>
	                         </div>
	                     </div>
	                 </div>
	             </div>
	         </div>
	         <div class="info">
	             <form action="${ contextPath }/member/updateInfo.do" method="post">
	                 <table class="table table-striped">
	                     <tr>
	                         <th class="jua-regular font-size20" style="width: 180px;">아이디 : </th>
	                         <td colspan="2"><input type="text" value="${ memberInfo.userId }" placeholder="기존 아이디" readonly></td>
	                     </tr>
	                     <tr>
	                         <th class="jua-regular font-size20">이름 : </th>
	                         <td colspan="2"><input type="text" name="userName" value="${ memberInfo.userName }" placeholder="이름" required></td>
	                     </tr>
	                     <tr>
	                         <th class="jua-regular font-size20">핸드폰 번호 : </th>
	                         <td><input type="text" name="phone" value="${ memberInfo.phone }" placeholder="전화번호" readonly></td>
	                         <td><button type="button" class="btn btn-sm btn-outline-primary" onclick="phoneCertify();">인증</button></td>
	                     </tr>
	                     <tr>
	                         <th class="jua-regular font-size20">우편번호 : </th>
	                         <td><input class="form-control" type="text" id="postCode" name="postNumber" value="${ memberInfo.postCode }" style="border-radius: 0;" readonly></td>
	                         <td><button type="button" class="btn btn-sm btn-outline-primary" onclick="findAddress();">주소 찾기</button></td>
	
	                     </tr>
	                     <tr>
	                         <th class="jua-regular font-size20">주소 : </th>
	                         <td colspan="2"><input type="text" id="address" name="address" value="${ memberInfo.address }" style="width: 50%;" readonly></td>
	                     </tr>
	                     <tr>
	                         <th class="jua-regular font-size20">상세주소 : </th>
	                         <td colspan="2"><input type="text" id="detailAddress" name="detailAddress" value="${ memberInfo.detailAddress }" style="width: 50%;"></td>
	                     </tr>
	                     <tr>
	                         <th class="jua-regular font-size20">이메일 : </th>
	                         <td colspan="2"><input type="text" name="email" value="${ memberInfo.email }" style="width: 50%;"></td>
	                     </tr>
	                     <tr>
	                         <th class="jua-regular font-size20">
	                             월급 수령계좌 :
	                         </th>
	                         <td colspan=2>
		                         <div style="display: flex; gap: 50px;">
		                             <select class="jua-regular font-size20" name="bank" class="form-select" aria-label="Default select example" id="bank_select">
		                                 <option value="농협은행">농협은행</option>
		                                 <option value="국민은행">국민은행</option>
		                                 <option value="신한은행">신한은행</option>
		                                 <option value="우리은행">우리은행</option>
		                             </select>
		                             <input type="text" name="bankAccount" value="${ memberInfo.bankAccount }" placeholder="계좌번호" style="width: 30%;">
		                         </div>
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
	     </div>
	     <!-- Modal structure -->
	     <div id="modify_pwd">
	         <!-- Modal content -->
	         <div class="m_content_style">
	             <form id="modify_pwd_form" action="${ contextPath }/member/modifyPwd.do" method="post" class="form-control">
	                 현재 비밀번호 : <input class="form-control" type="password" name="userPwd"> <br>
	                 변경 비밀번호 : <input class="form-control" type="password" name="updatePwd">
	                 <label class="validation">유효한 형식(숫자, 영문자 포함 8~15자)의 비밀번호를 입력해주세요.</label> <br>
	                 비밀번호 확인 : <input class="form-control" type="password" name="checkPwd">
	                 <label class="validation"></label>
	                 <div class="btn_wrapper" style="margin-top: 10px;">
	                     <input type="submit" value="변경하기" class="btn1 forget_btn" id="modify_pwd_btn">
	                 </div>
	             </form>
	         </div>
	     </div>
	     <!-- 휴대번호 인증 모달 -->
	     <div id="phoneCertify">
	     	전화번호 : <input type="text" id="phone" placeholder="01012345678"> 
				<button type="button" class="btn1 forget_btn phone_vali_btn" onclick="takeTarget();">인증번호 발송</button> <br>
				인증번호 : <input type="text" id="certNo" name="certNo" maxlength="6" placeholder="123456">
				<span class="target__time">
					<span id="remaining__min">3</span> :
					<span id="remaining__sec">00</span>
				</span>
	     	<div class="btn_wrapper">
					<button type="button" class="btn1 forget_btn" id="complete" onclick="certificate();">인증하기</button>
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
    loop: true,
    arrowKeys: true,
    navigateCaption: true,
    navigateArrows: true,
    zindex: 300, // zindex 모달의 화면 우선 순위 입니다. 
    focusInput: true, // 가장 맨 위에 보이게 해주는 속성값
    restoreDefaultContent: true, // 모달을 다시 키면 값을 초기화
	});
	
	$('#phoneCertify').iziModal({ 
		title: '전화번호 인증',
    subtitle: '',
    headerColor: '#FEEFAD', // 헤더 색깔
    theme: 'light', //Theme of the modal, can be empty or "light".
    padding: '15px', // content안의 padding
    radius: 10, // 모달 외각의 선 둥글기
    loop: true,
    arrowKeys: true,
    navigateCaption: true,
    navigateArrows: true,
    zindex: 300, // zindex 모달의 화면 우선 순위 입니다. 
    focusInput: true, // 가장 맨 위에 보이게 해주는 속성값
    restoreDefaultContent: true, // 모달을 다시 키면 값을 초기화
	})
	
	/*===== 전화번호 변경을 위한 인증 ======*/
	function phoneCertify() {
		$('#phoneCertify').iziModal('open');
	}
  const remainingMin = document.getElementById("remaining__min");
	const remainingSec = document.getElementById("remaining__sec");
	const completeBtn = document.getElementById("complete");
	var certificationNumber = 0;
	var timer;
		
	let time = 180;
	// 인증번호 발송
	const takeTarget = () => {
		// 휴대전화 정규표현식
		const regExp = /^010[0-9]{8}$/;
		if (regExp.test($("#phone").val())) {
			timer = setInterval(function () {							  
			    if (time > 0) {
				      time = time - 1; // 2:59로 시작
				      let min = Math.floor(time / 60);
				      let sec = String(time % 60).padStart(2, "0");
				      remainingMin.innerText = min;
				      remainingSec.innerText = sec;
				    } else {
				      completeBtn.disabled = true;
				      clearInterval(timer);
				    }
				  }, 1000);	
			$.ajax({
				  url: "${contextPath}/member/sendMsg.do"
					, method: "post"
					, data: {phone: $("#phone").val()}
				  , success: function(rand) {
						certificationNumber = rand;
					}
			  	, error: function() {
			  		console.log("AJAX 통신 실패");
			  	}
			  })
		} else {
			alertify.alert("전화번호", "전화번호가 유효하지 않습니다. 다시 확인해주세요.");
		}		  
	};

	// 인증번호 검사
	function certificate() {
		if (certificationNumber == $("#certNo").val()) {
			$("input[name=phone]").val($("#phone").val());
			$("input[name=phone]").attr("readonly", true);
			$("#phoneCertify").iziModal('close');
		} else {
			alertify.alert("전화번호 인증", "인증번호를 다시 확인해주세요");
		}
	}
	/*===== 전화번호 변경을 위한 인증 ======*/
	
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
			if($(el).val() == '${memberInfo.bank}') {
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
	
	// 비밀번호 변경
	const $updatePwd = $("#modify_pwd_form>input[name=updatePwd]");
	const $updatePwdLabel = $("#modify_pwd_form>input[name=updatePwd]+label");
	const $checkPwd = $("#modify_pwd_form>input[name=checkPwd]")
	const $checkPwdLabel = $("#modify_pwd_form>input[name=checkPwd]+label");
	const $modifyBtn = $("#modify_pwd_btn");
	const regExp = /^[a-zA-Z0-9]{8,15}$/;
	var pwdVald = false;
	var pwdCheck = false;
	
	$updatePwd.on("keyup", function() {
		// 비밀번호 유효성 검사
		pwdValidationCheck();
		
		// 비밀번호 일치 검사
		pwdEqualCheck();
	})
	
	$checkPwd.on("keyup", function() {
		// 비밀번호 일치 검사
		pwdEqualCheck();
	})
	
	$("#modify_pwd_form").on("submit", function() {
		if(pwdVald && pwdCheck) {
			this.submit;
		} else {
			alert("비밀번호 변경 서비스", "변경할 비밀번호를 다시 확인해주세요");
			return false;
		}
	})
	
	function validation(select, remove, add, text) {
		select.removeClass(remove).addClass(add).text(text);
		
		return add == "able" ? true : false;
	}
	
	function pwdValidationCheck() {
		if($updatePwd.val().trim().length == 0) {
			pwdVald = validation($updatePwdLabel, "able", "disable", "유효한 형식(숫자, 영문자 포함 8~15자)의 비밀번호를 입력해주세요.");
		} else {
			if(regExp.test($updatePwd.val())) {
				pwdVald = validation($updatePwdLabel, "disable", "able", "사용 가능한 비밀번호입니다.");
			} else {
				pwdVald = validation($updatePwdLabel, "able", "disable", "유효한 형식(숫자, 영문자 포함 8~15자)의 비밀번호를 입력해주세요.");
			}
		}
	}
	
	function pwdEqualCheck() {
		if($checkPwd.val().trim().length == 0) {
			pwdCheck = validation($checkPwdLabel, "able", "disable", "비밀번호가 일치하지 않습니다.");
		} else {
			if($checkPwd.val() == $updatePwd.val()) {
				pwdCheck = validation($checkPwdLabel, "disable", "able", "비밀번호가 일치합니다.");
			} else {
				pwdCheck = validation($checkPwdLabel, "able", "disable", "비밀번호가 일치하지 않습니다.");
			}
		}
	}
</script>
</html>