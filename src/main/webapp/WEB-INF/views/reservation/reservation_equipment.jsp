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
            width: 150px;
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
        tr:hover {
            cursor: pointer;
        }
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
    </script>
</head>
<body>

    <!-- 사이드바 해더 영역 -->
    <jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
    
    <!-- 메인 영역 start -->
    <div class="main_content">
        <h2>비품 관리</h2>
        <hr>
        
        <!-- ------------ -->
    
        <div class="div_1">
            <div class="div_btn">
                <h2>
                    <button class="btn btn-warning">되돌리기</button>
                    <button class="btn btn-success" onclick="insertEquipment()">비품 추가</button>
                    <button class="btn btn-danger" onclick="deleteEquipment()">비품 삭제</button>
                    <button class="btn btn-primary btn_save" onclick="updateEquipment()">저장</button>
                </h2>
            </div>
            <h4>전체 ${list.size()}개</h4>
        </div>

        <table class="table table-bordered line-shadow">
            <tr>
                <th class="th_1">    
                    <input type="checkbox" id="selectAll" onclick="toggle(this);">
                    <label for="selectAll" style="cursor: pointer;">전체 선택</label>
                </th>
                <th>번호</th>
                <th>비품명</th>
                <th>등록일</th>
            </tr>
            
            <c:choose>
                <c:when test="${not empty list}">
                    <c:forEach var="item" items="${list}" varStatus="status">
                        <tr onclick="toggleCheckbox(this);">
                            <td>
                                <input type="checkbox" class="equipment-checkbox" onclick="event.stopPropagation(); checkToggle();">
                            </td>
                            <td>${status.index + 1}</td>
                            <td><input type="text" value="${item.equipmentName}"></td>
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
	    // Function to insert equipment
	    function insertEquipment() {
	        var equipmentName = prompt("비품명을 입력하세요:");
	        if (equipmentName) {
	            var data = { equipmentName: equipmentName };
	            fetch('${contextPath}/equipment', {
	                method: 'POST',
	                headers: {
	                    'Content-Type': 'application/json'
	                },
	                body: JSON.stringify(data)
	            })
	            .then(response => response.json())
	            .then(result => {
	                if (result.success) {
	                    alert('비품이 추가되었습니다.');
	                    location.reload();
	                } else {
	                    alert('비품 추가에 실패했습니다.');
	                }
	            })
	            .catch(error => console.error('Error:', error));
	        }
	    }
	
	    // Function to delete equipment
	    function deleteEquipment() {
	        var selected = [];
	        document.querySelectorAll('.equipment-checkbox:checked').forEach(checkbox => {
	            var row = checkbox.closest('tr');
	            var id = row.querySelector('td:nth-child(2)').innerText;
	            selected.push(id);
	        });
	
	        if (selected.length > 0) {
	            var data = { ids: selected };
	            fetch('${contextPath}/equipment', {
	                method: 'DELETE',
	                headers: {
	                    'Content-Type': 'application/json'
	                },
	                body: JSON.stringify(data)
	            })
	            .then(response => response.json())
	            .then(result => {
	                if (result.success) {
	                    alert('비품이 삭제되었습니다.');
	                    location.reload();
	                } else {
	                    alert('비품 삭제에 실패했습니다.');
	                }
	            })
	            .catch(error => console.error('Error:', error));
	        } else {
	            alert('삭제할 비품을 선택하세요.');
	        }
	    }
	
	    // Function to undo changes
	    function undoChanges() {
	        // Implement your logic for undoing changes here
	        alert('되돌리기 기능은 아직 구현되지 않았습니다.');
	    }
	
	    // Function to update equipment
	    function updateEquipment() {
	        var equipmentList = [];
	        document.querySelectorAll('tr').forEach(tr => {
	            var checkbox = tr.querySelector('.equipment-checkbox');
	            if (checkbox) {
	                var id = tr.querySelector('td:nth-child(2)').innerText;
	                var name = tr.querySelector('td:nth-child(3) input').value;
	                equipmentList.push({ id: id, equipmentName: name });
	            }
	        });
	
	        var data = { equipmentList: equipmentList };
	        fetch('${contextPath}/equipment', {
	            method: 'PUT',
	            headers: {
	                'Content-Type': 'application/json'
	            },
	            body: JSON.stringify(data)
	        })
	        .then(response => response.json())
	        .then(result => {
	            if (result.success) {
	                alert('비품이 저장되었습니다.');
	                location.reload();
	            } else {
	                alert('비품 저장에 실패했습니다.');
	            }
	        })
	        .catch(error => console.error('Error:', error));
	    }
		</script>
		


        <!-- ------------ -->
    
    <!-- 사이드바 푸터 영역 -->
    <jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
        
    </div>
</body>
</html>
