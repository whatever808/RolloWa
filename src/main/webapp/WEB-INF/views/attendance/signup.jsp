<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>2.4 구성원 추가</title>

    <!-- animate -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />

	<!-- bootstrap -->
	<link href="${contextPath}/resources/css/common/bootstrap.min.css" rel="stylesheet">
	
	<!-- fontawesome -->
	<script src="https://kit.fontawesome.com/12ec987af7.js" crossorigin="anonymous"></script>
	
	<!-- Google Fonts Roboto -->
	<link rel="stylesheet"
	    href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap" />
	
	<!-- Google Fonts Jua -->
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
	<link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">
	
	<!-- jQuery -->
	<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
	
	<!-- css -->
	<link href="${contextPath}/resources/css/common/sidebars.css" rel="stylesheet">
	<link rel="stylesheet" href="${contextPath}/resources/css/common.css">
	<link rel="stylesheet" href="${contextPath}/resources/css/common/mdb.min.css" />
  
	<style>
    .main_content{
    	width: 1200px !important;
        padding: 20px;
    }
    
    /* 구성원 추가 css */
    .div_form{
        margin: 0 100px;
    }
    .div_form h4{
        /* background-color: yellow; */
        margin-left: 100px;
    }

    /* 테이블 공통 css */
    th{
        background-color: antiquewhite !important;
        width: 200px;
        vertical-align: middle;
        margin-left: 20px;
    }
    .usable {
         color: green;
         text-align: center;
    }
    .nocheck {
        color: red;
        width: 300px !important;
    }
    
    /* 테이블 공통 영역 */
    .td_common {
        display: flex;
    }
    .td_common input {
        width: 250px !important;
    }
    .div_common{
        display: flex;
    }
    .h5_margin {
        margin-top: 20px;
    }
    select {
        width: 300px !important;
    }

    /* 비밀번호 영역 */

    .td_1 select{
        width: 300px;
    }
    .checkbox_flex{
        display: flex;
    }
    .checkbox_flex input {
        margin: 0 10px;
        width: 20px;
    }
    .btn_center{
        text-align: center;
    }
    

    </style>
</head>
<body>

	<!-- 사이드바 해더 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
	    <h2>구성원 추가</h2>
	    <hr>
	    
		<!-- ------------ -->
	
		<form action="" method="post" id="signup_form">
		    <div class="div_form form-group">
		        <table class="table table-bordered">
		
		            <!-- 이름 입력 영역 -->
		            <tr>
		                <th>
		                    <lable for="userName"><h5>이름</h5></lable>
		                </th>
		                <td class="td_common">
		                    <div>
		                        <input type="text" class="form-control" id="userName" name="userName" placeholder="이름을 입력하세요." required>
		                    </div>
		                    <h4>
		                        <div id="nameCheck_result" class="nocheck"></div>
		                    </h4>
		                </td>
		            </tr>
		
		            <!-- 아이디 입력 영역 -->
		            <tr>
		                <th>
		                    <label for="userId"><h5>아이디</h5></label>
		                </th>
		                <td class="td_common">
		                    <div>
		                        <div class="div_common">
		                            <input type="text" class="form-control" id="userId" name="userId" placeholder="아이디을 입력하세요." required>
		                            <h4>
		                                <div id="idCheck_result" class="nocheck"></div>
		                            </h4>
		                        </div>
		                        <h5 class="h5_margin">영문, 숫자 조합 5~20자로 입력해주세요.</h5>
		                    </div>
		                </td>
		            </tr>
		
		            <!-- 비밀번호 입력 -->
		            <tr>
		                <th>
		                    <label for="userPwd"><h5>비밀번호</h5></label>
		                </th>
		                <td class="td_common">
		                    <div>
		                        <div class="div_common">
		                            <input type="password" class="form-control" id="userPwd" name="userPwd" placeholder="비밀번호을 입력하세요." required>
		                            <h4>
		                                <div id="pwd_result" class="nocheck"></div>
		                            </h4>
		                        </div>
		                        <h5 class="h5_margin">영문, 숫자, 특수문자 조합 5~20자로 입력해주세요.</h5>
		                    </div>
		                </td>
		            </tr>
		
		            <!-- 비밀번호 확인 입력 -->
		            <tr>
		                <th>
		                    <label for="userPwdck"><h5>비밀번호 확인</h5></label>
		                </th>
		                <td class="td_common">
		                    <div>
		                        <div class="div_common">
		                            <input type="password" class="form-control" id="userPwdck" name="userPwdck" placeholder="확인 비밀번호를 입력하세요." required>
		                            <h4>
		                                <div id="pwdck_result" class="nocheck"></div>
		                            </h4>
		                        </div>
		                        <h5 class="h5_margin">비밀번호를 한번 더 입력해주세요.</h5>
		                    </div>
		                </td>
		            </tr>
		
		            <!-- 부서 입력 -->
		            <tr>
		                <th>
		                    <label for="department"><h5>부서명</h5></label>
		                </td>
	                    <td>
	                        <select name="department" id="department" class="form-control">
	                        	<option value="부서 선택">부서 선택</option>
	                    	</select>
	                	</td>
		            </tr>
		            
		            <!-- 팀명 입력 -->
		            <tr>
		                <th>
		                    <label for="team"><h5>팀명</h5></td></label>
		                <td class="td_1">
		                    <select name="team" id="team" class="form-control">
		                    	<option value="팀 선택">팀 선택</option>
	                    	</select>
		                </td>
		            </tr>
		            
		            <!-- 직급 입력 -->
		            <tr>
		                <th>
		                    <h5>직급</h5>
		                </th>
		                <td class="td_1">
		                    <select name="position" id="position" class="form-control">
		                    	<option value="직급 선택">직급 선택</option>
	                    	</select>
		                </td>
		            </tr>
		            
		            
		            <!-- 값 가져오기 : 부서, 팀, 직급-->
		            <script>
		            	$(document).ready(function(){
	            			let departmentSelect = $("#department");
	            			let teamSelect = $("#team");
	            			let positionSelect = $("#position");
	            			
	            			departmentSelect.empty();
		           			departmentSelect.append($('<option>', {
		           				value: "",
		           				text: "부서 선택"
		           			}));
	            			
			            	$.ajax({
			            		url:"${contextPath}/attendance/department.do",
			            		type:"GET",
			            		success: function(data){
			            			$.each(data, function(index, attendanceDto) {
			            			    $.each(attendanceDto.groupList, function(index, groupDto) {
			            			        departmentSelect.append($('<option>', {
			            			            value: groupDto.codeName,
			            			            text: groupDto.codeName
		            			        	}));
		            			    	});
		            			    });
			            		},
			            		error: function(){
			            			console.log("ajax 부서 조회 실패 입니다.")
			            		}
		            		});
			            	
			            	departmentSelect.change(function() {
			            	    // 선택한 부서 콘솔 출력
			            	    let selectedDepartment = departmentSelect.val();
			            	    console.log("선택한 부서 : ", selectedDepartment);
			            	    
			            	    // 팀 선택 옵션 초기화
			            	    teamSelect.empty();
			            	    teamSelect.append($('<option>', {
			            	        value: "",
			            	        text: "팀 선택"
			            	    }));
			            	    
			            	    $.ajax({
			            	        url:"${contextPath}/attendance/team.do?selectedDepartment=" + selectedDepartment,
			            	        type:"GET",
			            	        success: function(data){
			            	            $.each(data, function(index, attendanceDto) {
			            	                $.each(attendanceDto.groupList, function(index, groupDto) {
			            	                    teamSelect.append($('<option>', {
			            	                        value: groupDto.codeName,
			            	                        text: groupDto.codeName
			            	                    }));
			            	                });
			            	            });
			            	        },
			            	        error: function(){
			            	            console.log("ajax 팀 조회 실패 입니다.")
			            	        }
			            	    });
			            	});
			            	
		            	    teamSelect.change(function(){
			            	 	// 선택한 팀 콘솔 출력
			            	    let selectedTeam = teamSelect.val();
			            	    console.log("선택한 팀 : ", selectedTeam);
		            	    })
		            	    
		            	    // 직급 조회
		            	    $.ajax({
			            		url:"${contextPath}/attendance/position.do",
			            		type:"GET",
			            		success: function(data){
			            			$.each(data, function(index, attendanceDto) {
			            			    $.each(attendanceDto.groupList, function(index, groupDto) {
			            			        positionSelect.append($('<option>', {
			            			            value: groupDto.codeName,
			            			            text: groupDto.codeName
		            			        	}));
		            			    	});
		            			    });
			            		},
			            		error: function(){
			            			console.log("ajax 직급 조회 실패 입니다.")
			            		}
		            		});
		            	    
		            	    positionSelect.change(function(){
			            	 	// 선택한 팀 콘솔 출력
			            	    let selectedPosition = positionSelect.val();
			            	    console.log("선택한 직급 : ", selectedPosition);
		            	    })
		            	    
		            	    
	            		});
		            </script>
		            
		            
		            
		            <!-- 관리자 계정 설정 -->
		            <tr>
		                <th>
		                    <h5>관리자 설정</h5>
		                </th>
		                <td class="checkbox_flex">
		                    <input type="checkbox" id="checkAdmin" name="checkAdmin" class="form-check-input">
		                    <label for="checkAdmin">
		                        <h5>관리자로 계정을 생성합니다.</h5>
		                    </label>
		                </td>
		            </tr>
		
		        </table>
		    </div>
		    
		    <div class="btn_center">
		        <button class="btn btn-outline-primary"><h6>뒤로가기</h6></button>
		        <button type="submit" class="btn btn-primary"><h6>구성원 추가</h6></button>
		    </div>
		</form>
		<!-- 메인 영역 end -->
		
		
		<!-- 회원가입 js -->
		<script>
		      let nameResult = false;
		      let idResult = false;
		      let pwdResult = false;
		      let pwdckResult = false;
		      
		      /* 이름 : 한글만 입력되고 나머지 글자(숫자,영문,특문)는 공백으로 변환 */
		      $("#signup_form input[name=userName]").on("keyup", function(){
		          let regExp = $(this).val().replace(/[^가-힣ㄱ-ㅎ]+/g, '');
		          $(this).val(regExp);
		
		          if( regExp.trim().length == 0 ){
		              nameResult = checkPrint("#nameCheck_result", "usable unusable", "nocheck", "다시 입력해주세요.");
		          } else {
		              if( regExp ){
		                  nameResult = checkPrint("#nameCheck_result", "nocheck unusable", "usable", "사용가능한 이름입니다.");
		              }
		          }
		          validate();
		      })
		
		      /* 아이디 : 영문,숫자 조합 5~20자 */
		      $("#signup_form input[name=userId]").on("keyup", function(){
		          let regExp = $(this).val().replace(/[^A-Za-z0-9]+/g, "");
		          $(this).val(regExp);
		
		          if( regExp.trim().length < 5 || regExp.trim().length > 20 ){
		              idResult = checkPrint("#idCheck_result", "usable unusable", "nocheck", "다시 입력해주세요.");
		          } else {
		              if( regExp ){
		                  idResult = checkPrint("#idCheck_result", "nocheck unusable", "usable", "사용가능한 아이디입니다.");
		              }
		          }
		          validate();
		      })
		      
		      /* 비밀번호 : 영문, 숫자, 특수문자를 포함한 조합 5~20자 */
		      $("#signup_form input[name=userPwd]").on("keyup", function(){
		          let regExp = $(this).val().replace(/[^A-Za-z0-9!@#$%^&*]+/g, "");
		          $(this).val(regExp);
		
		          if( regExp.trim().length < 5 || regExp.trim().length > 20 ){
		              pwdResult = checkPrint("#pwd_result", "usable unusable", "nocheck", "다시 입력해주세요.");
		          } else {
		              if( regExp ){
		                  pwdResult = checkPrint("#pwd_result", "nocheck unusable", "usable", "사용가능한 비밀번호입니다.");
		              }
		          }
		          pwdResult = regExp;
		          validate();
		      })
		
		      /* 비밀번호 확인 */
		      $("#signup_form input[name=userPwdck]").on("keyup", function(){
		          let regExp = $(this).val().replace(/[^A-Za-z0-9!@#$%^&*]+/g, "");
		          $(this).val(regExp);
		
		          console.log("pwdResult :", pwdResult);
		          console.log("regExp :", regExp);
		          if( pwdResult !=  regExp ){
		              pwdckResult = checkPrint("#pwdck_result", "usable unusable", "nocheck", "비밀번호가 일치하지 않습니다.");
		          } else {
		              if( regExp ){
		                  pwdckResult = checkPrint("#pwdck_result", "nocheck unusable", "usable", "비밀번호가 일치합니다.");
		              }
		          }
		          validate();
		      })
		
			function checkPrint(selector, rmClassNm, addClassNm, msg){
				$(selector).removeClass(rmClassNm).addClass(addClassNm).text(msg);
				return addClassNm == "usable" ? true : false;
			}
				
			function validate(){
			    if(nameResult, idResult) {
			        $("#signup_form :submit").attr("disabled", false);
			    } else {
			        $("#signup_form :submit").attr("disabled", true);
			    }
			}
			</script>
	
	
		<!-- ------------ -->
	
	</div>
	<!-- 메인 영역 end-->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
	
		
</body>
</html>