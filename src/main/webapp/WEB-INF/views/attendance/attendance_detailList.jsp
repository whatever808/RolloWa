<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>구성원 조회</title>

<!-- css -->
<link rel="stylesheet"
	href="${contextPath}/resources/css/attendance/account.css">

<style>
	.main_content {
		width: 1200px !important;
		padding: 20px;
	}
	
	/* css 추가 */
	.sortable {
		cursor: pointer;
	}
	
	.sortable:after {
		content: ' \25B2'; /* 기본 오름차순 화살표 */
	}
	
	.sortable.desc:after {
		content: ' \25BC'; /* 내림차순 화살표 */
	}
	#department{
		width: 150px;
	}
	#position {
		width: 150px;
	}
	/* Scrollable employee info table */
    .employee_info_container {
        max-height: 700px;
        width: 1335px;
        overflow-y: auto;
        border: 1px solid #ddd;
    }
    .employee_info thead th {
        position: sticky;
        top: 0;
        background: #f1f1f1;
        z-index: 1;
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
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp" />

	<!-- 메인 영역 start -->
	<div class="main_content">
		<h2>구성원 조회</h2>
		<hr>

		<!-- ---------------------------- -->

		<!-- 직원 정보 검색 키워드 start -->
		<form id="search_Form" action="#" method="GET">
			<table class="table table_search">
				<tr class="search_menu">
					<!-- 전체 인원수 -->
					<td>
						<h5 class="employee_count">전체 명</h5>
					</td>
					<td>
						<select name="department" id="department"class="form-select"></select>
					</td>

					<td>
						<select name="team" id="team" class="form-select"></select>
					</td>
					
					<td>
						<select name="position" id="position" class="form-select"></select>
					</td>

					<td class="td_search">
						<input type="text" id="name" placeholder="이름 입력" class="form-control input_name" onsubmit="return false">
						<button type="button" class="btn btn-outline-primary" onclick="resetForm();">초기화</button>
					</td>
				</tr>
			</table>
		</form>

		<!-- 검색 기능 : 부서, 팀 조회하기-->
		<script>
		let departmentSelect = $("#department");
		let teamSelect = $("#team");
		let positionSelect = $("#position");
		let nameSelect = $("#name");
 		
		$(document).ready(function(){
			// 부서 조회 이동
			selectDepartmentList();
			// 팀 조회 이동
			selectTeamList();
			// 직급 조회 이동
			selectPositionList();
			
			searchMember();
 		})
 		
 		// 바로 검색해서 출력하기
 		function searchMember(){
			$.ajax({
				url:"${ contextPath }/attendance/detailSearch.do",
				type:"GET",
				data:{ 
					department: departmentSelect.val(),
					team: teamSelect.val(),
					position: positionSelect.val(),
					name: nameSelect.val()
				},
				success: function(data){
					//console.log("통신 성공");

					// 통신 성공 시 값 바꿔주기
					$(".employee_info tbody").html($(data).find(".employee_info tbody").html());
					
					// 검색한 사용자 수
					let totalRows = $(data).find(".employee_info tbody > tr").length;
				    if (totalRows > 0) {
				        let isEmptyMessage = $(data).find(".employee_info tbody > tr td[colspan='9']").text();
				        if (isEmptyMessage == "조회된 직원이 없습니다.") {
					        totalRows -= 1;
					    } else {
					        totalRows;
					    }
				    } else {
					    totalRows = 0;
					}
				    $(".employee_count").text("전체 " + totalRows + "명");
				    bindRowClickEvent();
				}, error: function(){
					//console.log("통신 실패");
				}
			})
		}
	 		
 		// 부서조회
 		function selectDepartmentList(){
			departmentSelect.empty();
			departmentSelect.append($('<option>', {
				value: "전체 부서",
				text: "전체 부서"
			}));
			
			$.ajax({
		 		url:"${contextPath}/attendance/department.do",
		 		type:"GET",
		 		async:"false",
		 		success: function(data){
		 			
		 			$.each(data, function(index, organizationDto) {
		 			    $.each(organizationDto.groupList, function(index, groupDto) {
		 			        departmentSelect.append($('<option>', {
		 			            value: groupDto.codeName,
		 			            text: groupDto.codeName
					        	}));
					    	});
					    });
		 			
		 				if(${ not empty search }){
		 					$("#search_Form #department").children("option").each(function(){
					        	$(this).val() == "${ search.department }" && $(this).attr("selected", true);
					        })
		 				} 
		 				
		 		},
		 		error: function(){
		 			console.log("ajax 부서 조회 실패 입니다.")
		 		}
			});
		}
 		
 		// 팀조회
 		function selectTeamList(){
 			
 			teamSelect.empty();
			 	teamSelect.append($('<option>', {
	 	        value: "전체 팀",
	 	        text: "전체 팀"
	 	    }));
 			
	 	    $.ajax({
	 	        url:"${contextPath}/attendance/team.do?selectedDepartment=" + departmentSelect.val(),
	 	        type:"GET",
	 	        async:"false",
	 	        success: function(data){
	 	        	
	 	            $.each(data, function(index, organizationDto) {
	 	                $.each(organizationDto.groupList, function(index, groupDto) {
	 	                    teamSelect.append($('<option>', {
	 	                        value: groupDto.codeName,
	 	                        text: groupDto.codeName
	 	                    }));
	 	                });
	 	            });
					if(${ not empty search }){
	 					$("#search_Form #team").children("option").each(function(){
				        	$(this).val() == "${ search.team }" && $(this).attr("selected", true);
				        })
	 				}
	 	        },
	 	        error: function(){
	 	            console.log("ajax 팀 조회 실패 입니다.")
	 	        }
	 	    });
		}
 		
 		// 직급 조회
 		function selectPositionList(){
 			positionSelect.empty();
 			positionSelect.append($('<option>', {
	 	        value: "전체 직급",
	 	        text: "전체 직급"
	 	    }));
 			
	 	    $.ajax({
	 	        url:"${contextPath}/attendance/position.do?selectedPosition=" + positionSelect.val(),
	 	        type:"GET",
	 	        async:"false",
	 	        success: function(data){
	 	            $.each(data, function(index, organizationDto) {
	 	                $.each(organizationDto.groupList, function(index, groupDto) {
	 	                    positionSelect.append($('<option>', {
	 	                        value: groupDto.codeName,
	 	                        text: groupDto.codeName
	 	                    }));
	 	                });
	 	            });
					if(${ not empty search }){
	 					$("#search_Form #position").children("option").each(function(){
				        	$(this).val() == "${ search.position }" && $(this).attr("selected", true);
				        })
	 				}
	 	        },
	 	        error: function(){
	 	            console.log("ajax 직급 조회 실패 입니다.")
	 	        }
	 	    });
		}
 		
 		
 		// 부서를 선택했을 경우 실행될 function
 		departmentSelect.on("change", function() {
 			let selectedDepartment = $(this).val();
			selectTeamList(selectedDepartment);
			searchMember();
 		});
 		// 팀를 선택했을 경우 실행될 function
 		teamSelect.on("change", function() {
 			searchMember();
 		});
 		// 직급를 선택했을 경우 실행될 function
 		positionSelect.on("change", function() {
 			searchMember();
 		});
	 	// 이름을 작성할때 마다 실행될 function( 3개를 써야 정상적으로 검색이되고 깜빡임이 있음)
 		nameSelect.on("input change blur", function() {
 			searchMember();
 		});
	 	
 		<!-- input text에서 엔터눌러도 페이지 안바뀌게 -->
		document.addEventListener('keydown', function(event) {
		  if (event.keyCode == 13) {
		    event.preventDefault();
		  };
		}, true);
		
		<!-- 초기화 버튼 함수 -->
 		function resetForm() {
            document.getElementById('department').selectedIndex = 0;
            document.getElementById('team').selectedIndex = 0;
            document.getElementById('position').selectedIndex = 0;
            document.getElementById('name').value = '';
            searchMember();
 		}
 		
	    </script>

		<script>
        // 이름 : 한글만 입력되고 나머지 글자는 공백으로 변환
        $("#search_Form input[name=name]").on("keyup", function(){
            let regExp = $(this).val().replace(/[^가-힣ㄱ-ㅎ]+/g, '');
            $(this).val(regExp);
        })
	    </script>

		<!-- 직원 정보 -->
		<div class="employee_info_container">
		<table class="table table-bordered line-shadow employee_info">
			<thead>
				<tr>
					<th>프로필사진</th>
					<th class="sortable" data-column="1">이름</th>
					<th class="sortable" data-column="2">아이디</th>
					<th class="sortable" data-column="3">부서명</th>
					<th class="sortable" data-column="4">팀명</th>
					<th class="sortable" data-column="5">직급</th>
					<th class="sortable" data-column="6">전화번호</th>
					<th class="sortable" data-column="7">이메일</th>
					<th class="sortable" data-column="8">주소</th>
				</tr>
			</thead>
			<c:choose>
				<c:when test="${ not empty list }">
					<c:forEach var="m" items="${ list }">

						<form id="form_${m.userNo}"
							action="${contextPath}/attendance/memberDetail.do" method="POST">
							<tr class="tr_1"
								onclick="document.getElementById('form_${m.userNo}').submit()">
								<input type="hidden" name="userNo" value="${m.userNo}">
								<td>
									<c:choose>
							            <c:when test="${ not empty m.profileURL }">
							                <img src="${contextPath}/${m.profileURL}" class="profile_img">
							            </c:when>
							            <c:otherwise>
							                <img src="${ contextPath }/resources/images/defaultProfile.png" class="profile_img">
							            </c:otherwise>
							        </c:choose>
									
								</td>
								<td>${ m.userName }</td>
								<td>${ m.userId }</td>
								<td>${ m.department }</td>
								<td>${ m.team }</td>
								<td>${ m.position }</td>
								<td>${ m.phone }</td>
								<td>${ m.email }</td>
								<td>${ m.address }</td>
							</tr>
						</form>
					</c:forEach>
				</c:when>

				<c:otherwise>
					<tr>
						<td colspan="9">조회된 직원이 없습니다.</td>
					</tr>
				</c:otherwise>
			</c:choose>
		</table>
		</div>
		
		<!-- 정렬 기능 -->
		<script>     	
		// 동적으로 생성된 tr 요소에 클릭 이벤트 (상세페이지 이동)
	    function bindRowClickEvent() {
	    	$(".employee_info tbody tr").click(function() {
	            let userNo = $(this).find("input[name=userNo]").val();
	            if (userNo) {
	                window.location.href = "${contextPath}/attendance/memberDetail.do?userNo=" + userNo;
	            }
	        });
	    }
     	
	 	// 정렬 기능
	    $(document).ready(function() {
	        //let sortDirection = 1; // 1: 오름차순, -1: 내림차순

	        $(".sortable").click(function() {
	            let columnIndex = parseInt($(this).data("column"));
	            let isDescending = $(this).hasClass("desc");

	            // 모든 정렬 가능한 열의 클래스에서 desc 클래스를 제거
	            $(".sortable").removeClass("desc");

	            // 클릭한 열에 desc 클래스를 추가하여 현재 정렬 상태를 표시
	            $(this).toggleClass("desc", !isDescending);

	            // 테이블 정렬 함수 호출
	            sortTable(columnIndex, isDescending ? 1 : -1);
	        });
	    });
	 	
	    function sortTable(columnIndex, direction) {
	        let $table = $(".employee_info tbody");
	        let $rows = $table.find("tr").get();

	        $rows.sort(function(a, b) {
	            let A = getColumnValue(a, columnIndex);
	            let B = getColumnValue(b, columnIndex);

	            // 숫자 값을 비교하여 정렬
	            if ($.isNumeric(A) && $.isNumeric(B)) {
	                return (parseFloat(A) - parseFloat(B)) * direction;
	            } else {
	                // A 또는 B가 숫자가 아닌 경우 문자열로 비교하여 정렬
	                return A.localeCompare(B) * direction;
	            }
	        });

	        // 정렬된 행을 테이블에 다시 추가
	        $.each($rows, function(index, row) {
	            $table.append(row);
	        });
	    }
	    
	    function getColumnValue(row, columnIndex) {
	    	let value = $(row).children("td").eq(columnIndex).text().trim();
	    	if (columnIndex == 5) { // 직급 열의 인덱스
	            // 직급을 숫자로 매핑하여 반환
	            switch (value) {
	                case "사장":
	                    return 6;
	                case "부장":
	                    return 5;
	                case "차장":
	                    return 4;
	                case "과장":
	                    return 3;
	                case "대리":
	                    return 2;
	                case "사원":
	                    return 1;
	                default:
	                    return 0;
	            }
	        } else {
	            return value;
	        }
	    }
		</script>

		<!-- ------------ -->

		<!-- 사이드바 푸터 영역 -->
		<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp" />
</body>
</html>