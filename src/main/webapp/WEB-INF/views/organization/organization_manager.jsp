<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>조직 관리</title>

    <!-- 조직도 참고 사이트
       https://www.cssscript.com/clean-tree-diagram/
    -->

	<!-- css -->
	<link rel="stylesheet" href="${contextPath}/resources/css/organization/organization.css">
	
	
	<style>
	.btn:disabled {
	    background-color: rgba(128, 128, 128, 0.5) !important;
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

	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	
	<!-- 메인 영역 start -->
	<div class="main_content">
        <h2>조직 관리</h2>
        <hr>
            
        <ul class="tree">
          <li>
            <span class="level1">대표이사</span>
            <button id="addDepartmentBtn" class="btn btn-success add_department">부서 추가</button>
            <ul id="departmentList">
                <c:set var="prevDept"/>
                <c:forEach var="d" items="${dept}">
                    <c:if test="${d.dept ne prevDept}">
                        <li>
                        	<input type="hidden" class="code" value="${d.code}">
                        	<button class="btn btn-danger delete_department" data-dept="${d.code}">부서 삭제</button>
	                        <button class="btn btn-success add_team">팀 추가</button>
                            <span class="level2">${d.dept}</span>
                            <ul>
                                <c:forEach var="team" items="${dept}">
								    <c:if test="${d.dept eq team.dept}">
								        <ul>
								            <c:if test="${not empty team.team}">
								                <li class="btn-container">
								                    <span class="level3">${team.team}</span>
								                    <input type="hidden" class="teamCode" value="${team.teamCode}">
								                    <button class="btn btn-danger delete_team" data-team="${team.team}" 
								                        <c:if test="${team.memberCount > 0}">
								                        disabled
								                        </c:if>
								                    >팀 삭제</button>
								                </li>
								            </c:if>
								        </ul>
								    </c:if>
								</c:forEach>
                            </ul>
                        </li>
                        <c:set var="prevDept" value="${d.dept}" />
                    </c:if>
                </c:forEach>
            </ul>
          </li>
        </ul>
        
        <script>
        document.addEventListener('DOMContentLoaded', function () {
            const deleteButtons = document.querySelectorAll('.delete_team[disabled]');

            deleteButtons.forEach(function (button) {
                const tooltip = button.nextElementSibling;

                button.addEventListener('mouseover', function () {
                    tooltip.style.display = 'block';
                });

                button.addEventListener('mouseout', function () {
                    tooltip.style.display = 'none';
                });
            });
        });
        
        $(document).ready(function() {
            var treeItems = $('.tree > li > ul > li').length;
            if (treeItems > 1) {
                $('.tree > li > ul').css('display', 'flex');
                $('.tree > li > ul').css('flex-wrap', 'wrap');
            }
            // 로그인한 사용자의 사번으로 모든 modify값 수정
            let userNo = ${ loginMember.userNo };
            
         	// 팀 사용자 인원수 카운트
             $.ajax({
		        url: '${contextPath}/organization/countMembers.do',
		        type: 'GET',
		        dataType: 'json',
		        success: function(response) {
		            var deptMemberCount = {};
		
		            response.forEach(function(item) {
		                if (!deptMemberCount[item.CODE]) {
		                    deptMemberCount[item.CODE] = 0;
		                }
		                deptMemberCount[item.CODE] += item.MEMBER_COUNT;
		
		                if (item.MEMBER_COUNT > 0) {
		                    // 팀 인원수 처리
		                    if (item.TEAM) {
		                        $('button[data-team="' + item.TEAM + '"]').prop('disabled', true);
		                    }
		                }
		            });
		
		            // 부서 인원수에 따른 부서 삭제 버튼 비활성화 및 출력
		            for (var code in deptMemberCount) {
		                if (deptMemberCount[code] > 0) {
		                    $('button[data-dept="' + code + '"]').prop('disabled', true);
		                }
		                // 부서 인원수를 해당 부서 이름 옆에 출력
		                $('span[data-dept="' + code + '"]').append(' (' + deptMemberCount[code] + '명)');
		            }
		        },
		        error: function(xhr, status, error) {
		            console.log("통신 실패", error);
		        }
		    });
            
          	// 부서 추가
			$('#addDepartmentBtn').click(function() {
		        var deptName = prompt('부서명을 입력하세요:');
		        console.log("deptName값 : ", deptName);
		        if (deptName) {
		            // 부서명 중복 체크
		            $.ajax({
		                url: '${contextPath}/organization/countDepartmentByName.do',
		                type: 'POST',
		                contentType: 'application/json',
		                data: JSON.stringify({ deptName: deptName }),
		                success: function(response) {
		                    if (response > 0) {
		                        alert('이미 존재하는 부서명입니다. 다른 이름을 사용해주세요.');
		                    } else {
		                        // 부서 추가 요청
		                        $.ajax({
		                            url: '${contextPath}/organization/insertDepartment.do',
		                            type: 'POST',
		                            contentType: 'application/json',
		                            data: JSON.stringify({
		                                dept: deptName,
		                                userNo: userNo
		                            }),
		                            success: function(response) {
		                                console.log("통신 성공");
		                                if (response) {
		                                    $('#departmentList').append(
		                                        '<li><span class="level2">' + deptName + '</span><ul></ul></li>'
		                                    );
		                                } else {
		                                    alert('부서 추가에 실패했습니다.');
		                                }
		                                location.reload();
		                            },
		                            error: function(xhr, status, error) {
		                                console.log("통신 실패");
		                            }
		                        });
		                    }
		                },
		                error: function(xhr, status, error) {
		                    console.log('중복 확인 통신 실패', error);
		                }
		            });
		        }
		    });
            
         	// 팀 추가
            $(document).on('click', '.add_team', function() {
		        var deptCode = $(this).siblings('.code').val();
		        var teamName = prompt('팀명을 입력하세요:');
		        console.log("teamName값 : ", teamName);
		        if (teamName) {
		            // 팀명 중복 체크
		            $.ajax({
		                url: '${contextPath}/organization/countTeamByNameAndDept.do',
		                type: 'POST',
		                contentType: 'application/json',
		                data: JSON.stringify({
		                    deptCode: deptCode,
		                    teamName: teamName
		                }),
		                success: function(response) {
		                    if (response > 0) {
		                        alert('해당 부서에 이미 존재하는 팀명입니다. 다른 이름을 사용해주세요.');
		                    } else {
		                        // 팀 추가 요청
		                        $.ajax({
		                            url: '${contextPath}/organization/insertTeam.do',
		                            type: 'POST',
		                            contentType: 'application/json',
		                            data: JSON.stringify({
		                                deptCode: deptCode,
		                                teamName: teamName,
		                                userNo: userNo
		                            }),
		                            success: function(response) {
		                                console.log("통신 성공");
		                                if (response) {
		                                    $('button[data-dept="' + deptCode + '"]').siblings('ul').append(
		                                        '<li><span class="level3">' + teamName + '</span></li>'
		                                    );
		                                } else {
		                                    alert('팀 추가에 실패했습니다.');
		                                }
		                                location.reload();
		                            },
		                            error: function(xhr, status, error) {
		                                console.log("통신 실패");
		                            }
		                        });
		                    }
		                },
		                error: function(xhr, status, error) {
		                    console.log('중복 확인 통신 실패', error);
		                }
		            });
		        }
		    });
            
         	// 부서 삭제
            $(document).on('click', '.delete_department', function() {
                var deptCode = $(this).siblings('.code').val();
                var deptName = $(this).siblings('.level2').text().trim();
                
                console.log("삭제할 부서명: ", deptName);
                console.log("부서 코드: ", deptCode);

                if (confirm('정말로 이 부서를 삭제하시겠습니까?')) {
                    $.ajax({
                        url: '${contextPath}/organization/deleteDepartment.do',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({ 
                            deptCode: deptCode,
                            userNo: userNo
                        }),
                        success: function(response) {
                            console.log("부서 삭제 통신 성공");
                            if (response) {
                                location.reload();
                            	alert("부서를 삭제했습니다.")
                            } else {
                                alert('부서 삭제에 실패했습니다.');
                            }
                        },
                        error: function(xhr, status, error) {
                            console.log("통신 실패");
                        }
                    });
                }
            });
         	
         	// 부서명 수정
            $(document).on('click', 'span.level2', function() {
		        var deptCode = $(this).siblings('.code').val();
		        var currentName = $(this).text().trim();
		        var newName = prompt('새로운 부서명을 입력하세요:', currentName);
		
		        if (newName && newName !== currentName) {
		            // 부서명 중복 체크
		            $.ajax({
		                url: '${contextPath}/organization/countDepartmentByName.do',
		                type: 'POST',
		                contentType: 'application/json',
		                data: JSON.stringify({ deptName: newName }),
		                success: function(response) {
		                    if (response > 0) {
		                        alert('이미 존재하는 부서명입니다. 다른 이름을 사용해주세요.');
		                    } else {
		                        // 부서명 수정 요청
		                        $.ajax({
		                            url: '${contextPath}/organization/updateDepartmentName.do',
		                            type: 'POST',
		                            contentType: 'application/json',
		                            data: JSON.stringify({
		                                deptCode: deptCode,
		                                newName: newName,
		                                userNo: userNo
		                            }),
		                            success: function(response) {
		                                if (response) {
		                                    location.reload();
		                                    alert('부서명이 수정되었습니다.');
		                                } else {
		                                    alert('부서명 수정에 실패했습니다.');
		                                }
		                            },
		                            error: function(xhr, status, error) {
		                                console.log('통신 실패', error);
		                            }
		                        });
		                    }
		                },
		                error: function(xhr, status, error) {
		                    console.log('중복 확인 통신 실패', error);
		                }
		            });
		        }
		    });
         	
         	// 팀명 수정
            $(document).on('click', 'span.level3', function() {
		        var teamCode = $(this).closest('li').find('input.teamCode').val();
		        var deptCode = $(this).closest('ul').closest('li').find('.code').val();
		        var currentName = $(this).text().trim();
		        var newName = prompt('새로운 팀명을 입력하세요:', currentName);
		        
		        if (newName && newName !== currentName) {
		            // 팀명 중복 체크
		            $.ajax({
		                url: '${contextPath}/organization/countTeamByNameAndDept.do',
		                type: 'POST',
		                contentType: 'application/json',
		                data: JSON.stringify({
		                    deptCode: deptCode,
		                    teamName: newName
		                }),
		                success: function(response) {
		                    if (response > 0) {
		                        alert('해당 부서에 이미 존재하는 팀명입니다. 다른 이름을 사용해주세요.');
		                    } else {
		                        // 팀명 수정 요청
		                        $.ajax({
		                            url: '${contextPath}/organization/updateTeamName.do',
		                            type: 'POST',
		                            contentType: 'application/json',
		                            data: JSON.stringify({
		                                teamCode: teamCode,
		                                newName: newName,
		                                userNo: userNo
		                            }),
		                            success: function(response) {
		                                if (response) {
		                                    location.reload();
		                                    alert('팀명이 수정되었습니다.');
		                                } else {
		                                    alert('팀명 수정에 실패했습니다.');
		                                }
		                            },
		                            error: function(xhr, status, error) {
		                                console.log('통신 실패', error);
		                            }
		                        });
		                    }
		                },
		                error: function(xhr, status, error) {
		                    console.log('중복 확인 통신 실패', error);
		                }
		            });
		        }
		    });
         	
         	// 팀 삭제
            $(document).on('click', '.delete_team', function() {
                var teamName = $(this).closest('li').find('.level3').text().trim();
                var deptCode = $(this).closest('ul').closest('li').find('.code').val();
                
                console.log("삭제할 팀명: ", teamName);
                console.log("부서 코드: ", deptCode);

                if (confirm('정말로 이 팀을 삭제하시겠습니까?')) {
                    $.ajax({
                        url: '${contextPath}/organization/deleteTeam.do',
                        type: 'POST',
                        contentType: 'application/json',
                        data: JSON.stringify({ 
                            deptCode: deptCode,
                            teamName: teamName,
                            userNo: userNo
                        }),
                        success: function(response) {
                            console.log("팀 삭제 통신 성공");
                            if (response) {
                                location.reload(); // 페이지 새로고침
                            	alert("팀을 삭제했습니다.")
                            } else {
                                alert('팀 삭제에 실패했습니다.');
                            }
                        },
                        error: function(xhr, status, error) {
                            console.log("통신 실패");
                        }
                    });
                }
            });
            
        });
        </script>
        
        <!-- ------------ -->
    
    </div>
	<!-- 메인 영역 end-->
	
	<!-- 사이드바 푸터 영역 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		
</body>
</html>