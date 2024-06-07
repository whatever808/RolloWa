<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>비품 관리</title>
  
    <style>
        .main_content {
            width: 1200px !important;
            padding: 20px;
        }
        
        /* 비품 관리 css */
        .div_btn {
            margin-top: 50px;
            text-align: right;
        }
        .div_1 {
            margin: 10px;
        }
        .div_btn .btn {
            width: 170px;
            font-size: 20px !important;
        }
        table {
            margin: 10px;
            font-size: 15px !important;
            text-align: center;
        }
        th {
            background-color: gainsboro !important;
        }
        /*
        tr:hover {
            cursor: pointer;
        }
        */
        .th_1 {
            width: 150px;
        }

        /* 체크박스 크기 조정 */
        input[type="checkbox"] {
            width: 20px;
            height: 20px;
            cursor: pointer;
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
        <h2>비품 관리</h2>
        <hr>
        
        <!-- ------------ -->
    
        <div class="div_1">
            <div class="div_btn">
                <h3>
                	<!-- 
                    <button class="btn btn-success" onclick="insertEquipment()" >비품 추가</button>
                    <button class="btn btn-danger" onclick="deleteEquipment()">비품 삭제</button>
                     -->
                     
                    <button class="btn btn-success" onclick="location.href='${ contextPath }/pay/writerForm.page?writer=b'">비품 추가 신청</button>
                    <button class="btn btn-danger" onclick="location.href='${ contextPath }/pay/writerForm.page?writer=g'">비품 삭제 신청</button>
                </h3>
            </div>
            <h4>전체 ${list.size()}개</h4>
        </div>

        <table class="table table-bordered line-shadow">
            <tr>
                <%-- <th class="th_1">    
                    <input type="hidden" value="${ code }">
                    <input type="checkbox" id="selectAll" onclick="toggle(this);">
                    <label for="selectAll" style="cursor: pointer;">전체 선택</label>
                </th> --%>
                <th>번호</th>
                <th>비품명</th>
                <th>등록일</th>
            </tr>
            
            <c:choose>
                <c:when test="${not empty list}">
                    <c:forEach var="item" items="${list}" varStatus="status">
                        <tr data-id="${item.code}">
                            <!-- <td onclick="toggleCheckbox(this);">
                                <input type="checkbox" class="equipment-checkbox" onclick="event.stopPropagation(); checkToggle();">
                            </td> -->
                            <td>${status.index + 1}</td>
                            <td>${item.equipmentName}</td>
                            <td>
                                <fmt:formatDate value="${item.registDate}" pattern="yyyy년 MM월 dd일" />
                            </td>
                        </tr>
                    </c:forEach>
                </c:when>
                <c:otherwise>
                    <tr>
                        <td colspan="4">조회된 비품이 없습니다.</td>
                    </tr>
                </c:otherwise>
            </c:choose>
        </table>
        
        <script>
	    function toggle(source) {
	        checkboxes = document.querySelectorAll('.equipment-checkbox');
	        for (var i = 0; i < checkboxes.length; i++) {
	            checkboxes[i].checked = source.checked;
	        }
	    }
	
	    function checkToggle() {
	        var selectAll = document.getElementById('selectAll');
	        var checkboxes = document.querySelectorAll('.equipment-checkbox');
	        var allChecked = true;
	        for (var i = 0; i < checkboxes.length; i++) {
	            if (!checkboxes[i].checked) {
	                allChecked = false;
	                break;
	            }
	        }
	        selectAll.checked = allChecked;
	    }
	
	    function toggleCheckbox(tr) {
	        var checkbox = tr.querySelector('.equipment-checkbox');
	        checkbox.checked = !checkbox.checked;
	        checkToggle();
	    }
	
	    // 비품 추가, 수정, 삭제
	    function insertEquipment() {
	        var equipmentName = prompt("추가할 비품명을 입력하세요:");
	        if (equipmentName) {
	            fetch('${contextPath}/reservation/insert.do', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/x-www-form-urlencoded'
	                },
	                body: new URLSearchParams({
	                    'equipmentName': equipmentName,
	                    'registEmp': '${loginMember.userNo}'
	                })
	            }).then(response => {
	                if (response.ok) {
	                    alert(equipmentName + ' 비품을 추가 하였습니다.');
	                    location.reload();
	                } else {
	                    alert('비품 추가에 실패했습니다.');
	                }
	            });
	        }
	    }
	
	    function deleteEquipment() {
	        var selectedIds = [];
	        document.querySelectorAll('.equipment-checkbox:checked').forEach(function(checkbox) {
	            selectedIds.push(checkbox.closest('tr').dataset.id);
	        });
	
	        if (selectedIds.length > 0) {
	            fetch('${contextPath}/reservation/delete.do', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/x-www-form-urlencoded'
	                },
	                body: new URLSearchParams({
	                    'ids': selectedIds.join(',')
	                })
	            }).then(response => {
	                if (response.ok) {
	                    alert('비품을 삭제 하였습니다.');
	                    location.reload();
	                } else {
	                    alert('비품 삭제에 실패했습니다.');
	                }
	            });
	        } else {
	            alert('삭제할 비품을 선택하세요.');
	        }
	    }
	
	    // 비품명 수정
	    /*
	    function editEquipment(tr) {
	        var equipmentName = prompt("수정할 비품명을 입력하세요:", tr.cells[2].textContent);
	        if (equipmentName) {
	            var equipmentId = tr.dataset.id;
	            fetch('${contextPath}/reservation/update.do', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/x-www-form-urlencoded'
	                },
	                body: new URLSearchParams({
	                    'id': equipmentId,
	                    'equipmentName': equipmentName,
	                    'modifyEmp': ${loginMember.userNo}
	                })
	            }).then(response => {
	                if (response.ok) {
	                    alert('비품명을 수정 하였습니다.');
	                    location.reload();
	                } else {
	                    alert('비품명 수정에 실패했습니다.');
	                }
	            });
	        }
	    }
	    */
	
	    document.querySelectorAll('tr[data-id]').forEach(function(tr) {
	        tr.addEventListener('click', function(event) {
	            if (event.target.tagName.toLowerCase() !== 'input') {
	                editEquipment(tr);
	            }
	        });
	    });
	</script>



        <!-- ------------ -->
    
    <!-- 사이드바 푸터 영역 -->
    <jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
        
    </div>
</body>
</html>
