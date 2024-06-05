<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>구성원 상세 조회</title>

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
	    border: none; /* 테두리 제거 */
	    padding: 0; /* 패딩 제거 */
	    margin: 0; /* 마진 제거 */
	    align-items: center; /* 내용 수직 정렬 */
	}
	.table.table-bordered th, .table.table-bordered td {
	    border-right: none; /* 테두리 제거 */
	}
    .td_common input {
        width: 250px !important;
    }
    .div_common{
        display: flex;
    }
    .div_common img{
    	width: 300px;
    }
    .h5_margin {
        margin-top: 20px;
    }
    select {
        width: 300px !important;
    }
    #sample6_address, #sample6_detailAddress{
    	width: 600px !important;
    }
    .btn_post{
    	width: 100px !important;
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

	<!-- 로그인 체크 -->
	<c:if test="${empty loginMember}">
	    <script>
	        alert("로그인 후 이용가능합니다.");
	        window.location.href = "${pageContext.request.contextPath}/";
	    </script>
	</c:if>

	<!-- 사이드바 해더 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
	    <h2>구성원 상세 조회</h2>
	    <hr>
	    
		<!-- ------------ -->
	
		<form id="signup_form" method="post">
		    <div class="div_form form-group">
		        <table class="table table-bordered">
				
					<!-- 프로필 사진 영역 -->
		            <tr>
		                <th>
		                	<input type="hidden" id="userNo" value="${ m.userNo }">
		                    <label for="userId"><h5>프로필 사진</h5></label>
		                </th>
		                <td class="td_common">
		                    <div>
		                        <div class="div_common">
		                        	<c:choose>
						            	<c:when test="${ not empty m.profileURL }">
							                <img src="${contextPath}/${m.profileURL}" class="profile_img">
						            	</c:when>
						            	<c:otherwise>
							                <img src="${ contextPath }/resources/images/defaultProfile.png" class="profile_img">
						            	</c:otherwise>
						            </c:choose>
		                        </div>
		                    </div>
		                </td>
		            </tr>
			
		            <!-- 이름 입력 영역 -->
		            <tr>
		                <th>
		                    <label for="userId"><h5>이름</h5></label>
		                </th>
		                <td class="td_common">
		                    <div>
		                        <div class="div_common">
		                            <h5>
		                            	<input type="text" id="userName" placeholder="이름 입력" value="${ m.userName }" oninput="checkForm()">
		                            </h5>
		                        </div>
		                    </div>
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
		                            <h5>${ m.userId }</h5>
		                        </div>
		                    </div>
		                </td>
		            </tr>
					
		            <!-- 주소 -->
		            <tr>
		                <th>
		                    <label for="userPwd"><h5>주소</h5></label>
		                </th>
		                <td class="td_common">
		                	<h5>
								<input type="text" id="sample6_postcode" placeholder="우편번호 입력" value="${ m.postCode }">
								<input onclick="sample6_execDaumPostcode()" class="btn btn-warning btn_post" value="우편번호 검색">
							</h5>
	                	</td>
	                	<td class="td_common">
		                	<h5>
								<input type="text" id="sample6_address" placeholder="주소 입력" value="${ m.address }">
								<input type="text" id="sample6_extraAddress" placeholder="참고항목" hidden>
							</h5>
	                	</td>
	                	<td class="td_common">
		                	<h5>
								<input type="text" id="sample6_detailAddress" placeholder="상세주소 입력" value="${ m.detailAddress }">
							</h5>
	                	</td>
		            </tr>
		            
		            <!-- 이메일 입력 -->
		            <tr>
		                <th>
		                    <label for="department"><h5>이메일</h5></label>
		                </th>
		                <td class="td_common">
		                    <h5>
								<input type="text" id="email" placeholder="이메일 입력" value="${ m.email }">
							</h5>
						</td>
		            </tr>
		            
		            <!-- 전화번호 입력 -->
		            <tr>
		                <th>
		                    <label for="department"><h5>전화번호</h5></label>
		                </th>
		                <td class="td_common">
		                    <h5>
								<input type="text" id="phone" placeholder="전화번호 입력" value="${ m.phone }">
							</h5>
						</td>
		            </tr>
		
		            <!-- 부서 입력 -->
		            <tr>
		                <th>
		                    <label for="department"><h5>부서명</h5></label>
		                </td>
	                    <td>
	                        <select name="department" id="department" class="form-select" onchange="checkForm()">
	                        <option value="부서 선택">부서 선택</option>
	                        ${ m.department }</select>
	                	</td>
		            </tr>
		            
		            <!-- 팀명 입력 -->
		            <tr>
		                <th>
		                    <label for="teamCode"><h5>팀명</h5></td></label>
		                <td class="td_1">
		                    <select name="teamCode" id="teamCode" class="form-select" onchange="checkForm()">
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
		                    <select name="positionCode" id="positionCode" class="form-select" required onchange="checkForm()">
		                    	<option value="직급 선택" disabled selected hidden>직급 선택</option>
	                    	</select>
		                </td>
		            </tr>
		            
		            <script>
		            <!---------------------------- 값 가져오기 : 부서, 팀, 직급 ---------------------------->
		    		$(document).ready(function(){
		    			let departmentSelect = $("#department");
		    			let teamSelect = $("#teamCode");
		    			let positionSelect = $("#positionCode");
		    			
		    			let selectedDepartment = "${ m.department }";
		    		    let selectedTeam = "${ m.team }";
		    		    let selectedPosition = "${ m.position }";
		    		    
		    		    
		    			departmentSelect.empty();
		    			departmentSelect.append($('<option>', {
		    				value: "",
		    				text: "부서 선택"
		    			}));
		    			
		    			$.ajax({
		    		        url: "${contextPath}/attendance/department.do",
		    		        type: "GET",
		    		        success: function(data) {
		    		            $.each(data, function(index, attendanceDto) {
		    		                $.each(attendanceDto.groupList, function(index, groupDto) {
		    		                    let option = $('<option>', {
		    		                        value: groupDto.codeName,
		    		                        text: groupDto.codeName
		    		                    });
		    		                    if (groupDto.codeName == selectedDepartment) {
		    		                        option.attr('selected', true);
		    		                    }
		    		                    departmentSelect.append(option);
		    		                });
		    		            });
		    		         	// 부서가 선택되었을 때 팀 목록을 불러옵니다.
		    	                departmentSelect.trigger('change');
		    		        },
		    		        error: function() {
		    		            console.log("ajax 부서 조회 실패 입니다.");
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
		    			        url: "${contextPath}/attendance/team.do",
		    			        type: "GET",
		    			        data: { selectedDepartment: selectedDepartment },
		    			        success: function(data) {
		    			            $.each(data, function(index, attendanceDto) {
		    			                $.each(attendanceDto.groupList, function(index, groupDto) {
		    			                    let option = $('<option>', {
		    			                        value: groupDto.codeName,
		    			                        text: groupDto.codeName
		    			                    });
		    			                    teamSelect.append(option);
		    			                });
		    			            });
		    			            // 선택된 팀을 설정합니다.
		    			            let initialTeamExists = teamSelect.find('option').filter(function() {
						                return $(this).val() == selectedTeam;
						            }).length > 0;
						
						            if (initialTeamExists) {
						                teamSelect.val(selectedTeam);
						            }
		    			        },
		    			        error: function() {
		    			            console.log("ajax 팀 조회 실패 입니다.");
		    			        }
		    			    });
		    			});

		    			teamSelect.change(function(){
		    	       	 	// 선택한 팀 콘솔 출력
		    	       	    let selectedTeam = teamSelect.val();
		    	       	    console.log("선택한 팀 : ", selectedTeam);
		          	    })
		    	      	    
		          	    // 직급 조회
		          	   	positionSelect.empty();
		    			positionSelect.append($('<option>', {
		    				value: "",
		    				text: "직급 선택"
		    			}));
		          	    
		    			$.ajax({
		    		        url: "${contextPath}/attendance/position.do",
		    		        type: "GET",
		    		        success: function(data) {
		    		            $.each(data, function(index, attendanceDto) {
		    		                $.each(attendanceDto.groupList, function(index, groupDto) {
		    		                    let option = $('<option>', {
		    		                        value: groupDto.codeName,
		    		                        text: groupDto.codeName
		    		                    });
		    		                    if (groupDto.codeName == selectedPosition) {
		    		                        option.attr('selected', true);
		    		                    }
		    		                    positionSelect.append(option);
		    		                });
		    		            });
		    		        },
		    		        error: function() {
		    		            console.log("ajax 직급 조회 실패 입니다.");
		    		        }
		    		    });
		    			positionSelect.change(function() {
		    		        let selectedPosition = positionSelect.val();
		    		        console.log("선택한 직급 : ", selectedPosition);
		    		    });
		    		});
		            </script>
		            
		            <!-- 관리자 계정 설정 -->
		            <tr>
		                <th>
		                    <label for="authLevel"><h5>관리자 설정</h5></label>
		                </th>
		                <td class="checkbox_flex">
		                    <input type="checkbox" id="authLevelCheckbox" name="authLevel" class="form-check-input">
							<input type="hidden" name="authLevel" id="authLevel" value="3">
	                        <h5>관리자로 설정합니다.</h5>
		                </td>
		            </tr>
		            
		            <script>
				    $(document).ready(function() {
				        // 관리자 설정 체크박스 변경 이벤트
				        $("#authLevelCheckbox").change(function() {
				            if ($(this).is(":checked")) {
				                // 체크된 경우
				                $("#authLevel").val(2); // 관리자로 설정 (2)
				            } else {
				                // 체크 해제된 경우
				                $("#authLevel").val(3); // 일반 사용자로 설정 (3)
				            }
				        });
				    });
					</script>
		            
		
		        </table>
		    </div>
		    
		    <div class="btn_center">
		        <button type="reset" class="btn btn-outline-primary" onclick="location.href='${contextPath}/attendance/detailList.do'"><h6>뒤로가기</h6></button>
		        <button type="button" class="btn btn-danger" onclick="deleteMember(event);"><h6>회원 탈퇴</h6></button>
		        <button type="button" class="btn btn-primary" onclick="updateMember(event);"><h6>구성원 수정</h6></button>
		    </div>
		</form>
			
		
	
		<script>
		// 구성원 수정 체크
		function checkForm() {
		    const userName = document.getElementById('userName').value.trim();
		    const department = document.getElementById('department').value;
		    const teamCode = document.getElementById('teamCode').value;
		    const positionCode = document.getElementById('positionCode').value;
		    
		    const isFormValid = userName !== "" &&
		                        department !== "부서 선택" &&
		                        teamCode !== "팀 선택" &&
		                        positionCode !== "직급 선택";
		
		    document.getElementById('updateBtn').disabled = !isFormValid;
		}
		
		<!-- 회원 탈퇴하기-->
		function deleteMember(event) {
		    event.preventDefault(); // 기본 폼 제출 방지
		    
		    let userNo = $("#userNo").val();
		    let modifyUserNo = "${ loginMember.userNo }";
		    let actualName = $("#userName").val();
		    
		    // Prompt user for their name
		    let enteredName = prompt("회원탈퇴를 하시려면 해당 사용자의 이름을 입력하세요:");
		    
		    if (enteredName == null) {
		        // User pressed cancel
		        return;
		    }
		    
		    if (enteredName != actualName) {
		        alert("입력한 이름이 일치하지 않습니다.");
		        return;
		    }
		    
		    $.ajax({
		        url: "${contextPath}/attendance/deleteMemberAttendance.do",
		        type: "POST",
		        data: {
		            userNo: userNo,
		            modifyUserNo: modifyUserNo
		        },
		        success: function(result) {
		            console.log("회원 탈퇴 통신 성공!!!");
		            alert("회원탈퇴를 하였습니다.");
		            window.location.href = "${ contextPath }/attendance/detailList.do";
		        },
		        error: function() {
		            console.log("회원 탈퇴 통신 실패!!!");
		        }
		    });
		}
		
		
		<!-- 회원 정보 수정하기 -->
		function updateMember(event) {
			event.preventDefault(); // 기본 폼 제출 방지
			
			let userNo = $("#userNo").val();
			let modifyUserNo = "${ loginMember.userNo }";
			let userName = $("#userName").val();
			let postCode = $("#sample6_postcode").val();
			let address = $("#sample6_address").val();
			let detailAddress = $("#sample6_detailAddress").val();
			let email = $("#email").val();
			let phone = $("#phone").val();
			let department = $("#department").val();
			let team = $("#teamCode").val();
			let position = $("#positionCode").val();
			let authLevel =  $("#authLevel").val();
			
		    // 콘솔에 출력
		    /*
		    console.log("userNo:", userNo);
		    console.log("modifyUserNo:", modifyUserNo);
		    console.log("userName:", userName);
		    console.log("postCode:", postCode);
		    console.log("address:", address);
		    console.log("detailAddress:", detailAddress);
		    console.log("email:", email);
		    console.log("phone:", phone);
		    console.log("department:", department);
		    console.log("team:", team);
		    console.log("position:", position);
		    console.log("authLevel:", authLevel);
			*/
			
			$.ajax({
		        url: "${contextPath}/attendance/updateMemberAttendance.do",
		        type: "POST",
		        data: {
		        	userNo: userNo,
		        	modifyUserNo: modifyUserNo,
		        	userName: userName,
		        	postCode: postCode,
		        	address: address,
		        	detailAddress: detailAddress,
		        	email: email,
		        	phone: phone,
		        	department: department,
		        	team: team,
		        	position: position,
		        	authLevel: authLevel
		        },
		        success: function(result) {
		            //console.log("회원 정보수정 통신 성공!!!");
		            alert("회원 정보를 수정하였습니다.");
		            window.location.href = "${ contextPath }/attendance/detailList.do";
		        },
		        error: function() {
		            console.log("회원 정보수정 통신 실패!!!");
		            //alert("회원 정보수정 통신 실패!!!");
		        }
		    });
		}
		
		
		
		
		</script>
	
	
		<!-- ------------ -->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<style>
	.wrong_text{font-size:1rem;color:#f44e38;letter-spacing:-.2px;font-weight:300;margin:8px 0 2px;line-height:1em;display:none}
</style>

<script>
function sample6_execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

            // 각 주소의 노출 규칙에 따라 주소를 조합한다.
            // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
            var addr = ''; // 주소 변수
            var extraAddr = ''; // 참고항목 변수

            //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
            if (data.userSelectedType == 'R') { // 사용자가 도로명 주소를 선택했을 경우
                addr = data.roadAddress;
            } else { // 사용자가 지번 주소를 선택했을 경우(J)
                addr = data.jibunAddress;
            }

            // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
            if(data.userSelectedType == 'R'){
                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                if(data.bname != '' && /[동|로|가]$/g.test(data.bname)){
                    extraAddr += data.bname;
                }
                // 건물명이 있고, 공동주택일 경우 추가한다.
                if(data.buildingName != '' && data.apartment == 'Y'){
                    extraAddr += (extraAddr != '' ? ', ' + data.buildingName : data.buildingName);
                }
                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                if(extraAddr != ''){
                    extraAddr = ' (' + extraAddr + ')';
                }
                // 조합된 참고항목을 해당 필드에 넣는다.
                document.getElementById("sample6_extraAddress").value = extraAddr;
            
            } else {
                document.getElementById("sample6_extraAddress").value = '';
            }

            // 우편번호와 주소 정보를 해당 필드에 넣는다.
            document.getElementById('sample6_postcode').value = data.zonecode;
            document.getElementById("sample6_address").value = addr;
            // 커서를 상세주소 필드로 이동한다.
            document.getElementById("sample6_detailAddress").focus();
        }
    }).open();
}
</script>

</html>