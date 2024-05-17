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
		            <div class="col-6">
		                <h1>[[${room.name}]]</h1>
		            </div>
		            <div>
		                <div id="msgArea" class="col"></div>
		                <div class="col-6">
		                    <div class="input-group mb-3">
		                        <input type="text" id="msg" class="form-control">
		                        <div class="input-group-append">
		                            <button class="btn btn-outline-secondary" type="button" id="button-send">전송</button>
		                        </div>
		                    </div>
		                </div>
		            </div>
		            <div class="col-6"></div>
		        </div>
		
		
		        <script src="https://cdn.jsdelivr.net/npm/sockjs-client@1/dist/sockjs.min.js"></script>
		        <script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
		        
		    </th:block>
		</th:block>
	</div>
<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
		<script th:inline="javascript">
        $(document).ready(function(){

            var roomName = [[${room.name}]];
            var roomId = [[${room.roomId}]];
            var username = [[${loginMember.userName}]];

            console.log(roomName + ", " + roomId + ", " + username);

            var sockJs = new SockJS("${contextPath}/chatting");
            //1. SockJS를 내부에 들고있는 stomp를 내어줌
            var stomp = Stomp.over(sockJs);

            //2. connection이 맺어지면 실행
            stomp.connect({}, function (){
               console.log("STOMP Connection")

               //4. subscribe(path, callback)으로 메세지를 받을 수 있음
               stomp.subscribe("${contextPath}/sub/chat/room/" + roomId, function (chat) {
                   var content = JSON.parse(chat.body);

                   var writer = content.writer;
                   var str = '';

                   if(writer === username){
                       str = "<div class='col-6'>";
                       str += "<div class='alert alert-secondary'>";
                       str += "<b>" + writer + " : " + message + "</b>";
                       str += "</div></div>";
                       $("#msgArea").append(str);
                   }
                   else{
                       str = "<div class='col-6'>";
                       str += "<div class='alert alert-warning'>";
                       str += "<b>" + writer + " : " + message + "</b>";
                       str += "</div></div>";
                       $("#msgArea").append(str);
                   }

                   $("#msgArea").append(str);
               });

               //3. send(path, header, message)로 메세지를 보낼 수 있음
               stomp.send('${contextPath}/pub/chat/enter', {}, JSON.stringify({roomId: roomId, writer: username}))
            });

            $("#button-send").on("click", function(e){
                var msg = document.getElementById("msg");

                console.log(username + ":" + msg.value);
                stomp.send('${contextPath}/pub/chat/message', {}, JSON.stringify({roomId: roomId, message: msg.value, writer: username}));
                msg.value = '';
            });
        });
    </script>

</body>
</html>