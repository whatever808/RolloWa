<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
		<div class="content">
			<th:block th:replace="~{/layout/basic :: setContent(~{this :: content})}">
		    <th:block th:fragment="content">
		        <div class="container">
		            <div>
		                <ul th:each="room : ${list}">
		                    <li><a th:href="@{${contextPath}/chat/room(roomId=${room.roomId})}">[[${room.name}]]</a></li>
		                </ul>
		            </div>
		        </div>
		        <form th:action="@{${contextPath}/chat/room}" method="post">
		            <input type="text" name="name" class="form-control">
		            <button class="btn btn-secondary">개설하기</button>
		        </form>
		    </th:block>
			</th:block>
		</div>
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
	<script th:inline="javascript">
       $(document).ready(function(){

           var roomName = [[${roomName}]];

           if(roomName != null)
               alert(roomName + "방이 개설되었습니다.");

           $(".btn-create").on("click", function (e){
               e.preventDefault();

               var name = $("input[name='name']").val();

               if(name == "")
                   alert("Please write the name.")
               else
                   $("form").submit();
           });

       });
   </script>

</body>
</html>