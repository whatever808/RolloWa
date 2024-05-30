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
											<img src="${ m.profileURL }" class="profile_img"
												onerror="this.onerror=null; this.src='${contextPath}/resources/images/defaultProfile.png';">
										</c:when>
										<c:otherwise>
											<img
												src="${ contextPath }/resources/images/defaultProfile.png"
												class="profile_img">
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
		                            <h5>${ m.userName }</h5>
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
					
		            <!-- 비밀번호 초기화 -->
		            <tr>
		                <th>
		                    <label for="userPwd"><h5>비밀번호 초기화</h5></label>
		                </th>
		                <td class="td_common">
		                	<h5>
                               생각해보기
							</h5>
	                	</td>
		            </tr>
		            
		            <!-- 주소 -->
		            <tr>
		                <th>
		                    <label for="userPwd"><h5>주소</h5></label>
		                </th>
		                <td class="td_common">
		                	<h5>
								<input type="text" placeholder="우편번호 입력" value="${ m.postCode }">
								<button class="btn btn-warning">우편번호 검색</button>
							</h5>
	                	</td>
	                	<td class="td_common">
		                	<h5>
								<input type="text" placeholder="주소 입력" value="${ m.address }">
							</h5>
	                	</td>
	                	<td class="td_common">
		                	<h5>
								<input type="text" placeholder="상세주소 입력" value="${ m.detailAddress }">
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
								<input type="text" placeholder="이메일 입력" value="${ m.email }">
							</h5>
						<td>
		            </tr>
		
		            <!-- 부서 입력 -->
		            <tr>
		                <th>
		                    <label for="department"><h5>부서명</h5></label>
		                </td>
	                    <td>
	                        <select name="department" id="department" class="form-select">${ m.department }</select>
	                	</td>
		            </tr>
		            
		            <!-- 팀명 입력 -->
		            <tr>
		                <th>
		                    <label for="teamCode"><h5>팀명</h5></td></label>
		                <td class="td_1">
		                    <select name="teamCode" id="teamCode" class="form-select">
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
		                    <select name="positionCode" id="positionCode" class="form-select" required>
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
		                    <input type="checkbox" id="authLevel" name="authLevel" class="form-check-input">
	                        <h5>계정을 관리자로 설정합니다.</h5>
							<input type="hidden" name="authLevel" id="authLevel" value="3">
		                </td>
		            </tr>
		            
		            <script>
				    $(document).ready(function() {
				        // 관리자 설정 체크박스 변경 이벤트
				        $("#authLevel").change(function() {
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
		        <button type="submit" class="btn btn-danger"><h6>회원 탈퇴</h6></button>
		        <button type="submit" class="btn btn-primary" onclick="updateMember();"><h6>구성원 수정</h6></button>
		    </div>
		</form>
	
		<!-- 회원 정보 수정하기 -->
		<script>
		function updateMember() {
			let userNo = $("#userNo").val();
			/*
			let modifyUserNo = "${ loginMember.userNo }";
			let postCode = $("#postCode");
			let address = $("#address");
			let addressDetail = $("#addressDetail");
			let email = $("#email");
			let department = $("#department");
			let team = $("#teamCode");
			let position = $("#positionCode");
			let authLevel =  $("#authLevel");
			*/
			$.ajax({
		        url: "${contextPath}/attendance/updateMemberAttendance.do",
		        type: "POST",
		        data: {
		        	userNo: userNo/*,
		        	
		        	modifyUserNo: modifyUserNo,
		        	postCode: postCode,
		        	address: address,
		        	addressDetail: addressDetail,
		        	email: email,
		        	department: department,
		        	team: team,
		        	position: position,
		        	authLevel: authLevel
		        	*/
		        },
		        success: function(result) {
		            console.log("회원 정보수정 통신 성공!!!");
		            alert("회원 정보수정 통신 성공!!!");
		        },
		        error: function() {
		            console.log("회원 정보수정 통신 실패!!!");
		            alert("회원 정보수정 통신 실패!!!");
		        }
		    });
						
		}
		</script>
	
	
		<!-- ------------ -->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>