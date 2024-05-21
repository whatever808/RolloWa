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
 <div class="msg_open_btn">
            <i class="fa-solid fa-comment fa-5x"></i>
        </div>
        <div class="msg_close_btn">
            <i class="fa-regular fa-circle-xmark fa-5x"></i>
        </div>

        <!-- Modal structure -->
        <div id="people_list">
            <!-- Modal content -->
            <div class="m_content_style">
                <div class="people_list">
                    <div class="search_bar form-outline" data-mdb-input-init style="margin-top: 15px;">
                        <input type="text" id="form12" class="form-control" />
                        <label class="form-label" for="form12">인물 검색</label>
                    </div>
                    <div class="btn_wrapper">
                        <button type="button" class="btn1 forget_btn" onclick="createChatRoom();">채팅하기</button>
                    </div>
                    <div class="dept_list_wrapper">                       
										<!-- 부서 리스트 --> 
                    </div>
                </div>
            </div>
        </div>

        <div class="msgbox">
            <section style="background-color: #eee; height: 100%;">
                <div class="container" style="padding-top: 10px; height: 100%;">

                    <div class="row" style="height: 100%;">

                        <div class="col-md-6 col-lg-5 col-xl-4 mb-4 mb-md-0" style="height: 100%;">

                            <h5 class="font-weight-bold mb-3 text-center text-lg-start" style="margin-top: 10px;">Member
                            </h5>
                            <div class="msg_btn_wrapper btn_wrapper">
                                <button data-izimodal-open="#people_list" class="btn1 forget_btn"><i
                                        class="fa-solid fa-comment"></i></button>
                            </div>

                            <div class="card" style="margin-top: 10px; overflow: auto;
                            height: 750px;">
                                <div class="card-body">

                                    <ul class="list-unstyled mb-0">
                                        <li class="p-2 border-bottom chat_room">
                                            <a href="#!" class="d-flex justify-content-between">
                                                <div class="d-flex flex-row">
                                                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-8.webp"
                                                        alt="avatar"
                                                        class="rounded-circle d-flex align-self-center me-3 shadow-1-strong"
                                                        width="60">
                                                    <div class="pt-1">
                                                        <p class="fw-bold mb-0">John Doe</p>
                                                        <p class="small text-muted">Hello, Are you there?</p>
                                                    </div>
                                                </div>
                                                <div class="pt-1">
                                                    <p class="small text-muted mb-1">Just now</p>
                                                    <span class="badge bg-danger float-end">1</span>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="p-2 border-bottom chat_room">
                                            <a href="#!" class="d-flex justify-content-between">
                                                <div class="d-flex flex-row">
                                                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-1.webp"
                                                        alt="avatar"
                                                        class="rounded-circle d-flex align-self-center me-3 shadow-1-strong"
                                                        width="60">
                                                    <div class="pt-1">
                                                        <p class="fw-bold mb-0">Danny Smith</p>
                                                        <p class="small text-muted">Lorem ipsum dolor sit.</p>
                                                    </div>
                                                </div>
                                                <div class="pt-1">
                                                    <p class="small text-muted mb-1">5 mins ago</p>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="p-2 border-bottom chat_room">
                                            <a href="#!" class="d-flex justify-content-between">
                                                <div class="d-flex flex-row">
                                                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-2.webp"
                                                        alt="avatar"
                                                        class="rounded-circle d-flex align-self-center me-3 shadow-1-strong"
                                                        width="60">
                                                    <div class="pt-1">
                                                        <p class="fw-bold mb-0">Alex Steward</p>
                                                        <p class="small text-muted">Lorem ipsum dolor sit.</p>
                                                    </div>
                                                </div>
                                                <div class="pt-1">
                                                    <p class="small text-muted mb-1">Yesterday</p>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="p-2 border-bottom chat_room">
                                            <a href="#!" class="d-flex justify-content-between">
                                                <div class="d-flex flex-row">
                                                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-3.webp"
                                                        alt="avatar"
                                                        class="rounded-circle d-flex align-self-center me-3 shadow-1-strong"
                                                        width="60">
                                                    <div class="pt-1">
                                                        <p class="fw-bold mb-0">Ashley Olsen</p>
                                                        <p class="small text-muted">Lorem ipsum dolor sit.</p>
                                                    </div>
                                                </div>
                                                <div class="pt-1">
                                                    <p class="small text-muted mb-1">Yesterday</p>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="p-2 border-bottom chat_room">
                                            <a href="#!" class="d-flex justify-content-between">
                                                <div class="d-flex flex-row">
                                                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-4.webp"
                                                        alt="avatar"
                                                        class="rounded-circle d-flex align-self-center me-3 shadow-1-strong"
                                                        width="60">
                                                    <div class="pt-1">
                                                        <p class="fw-bold mb-0">Kate Moss</p>
                                                        <p class="small text-muted">Lorem ipsum dolor sit.</p>
                                                    </div>
                                                </div>
                                                <div class="pt-1">
                                                    <p class="small text-muted mb-1">Yesterday</p>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="p-2 border-bottom chat_room">
                                            <a href="#!" class="d-flex justify-content-between">
                                                <div class="d-flex flex-row">
                                                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-5.webp"
                                                        alt="avatar"
                                                        class="rounded-circle d-flex align-self-center me-3 shadow-1-strong"
                                                        width="60">
                                                    <div class="pt-1">
                                                        <p class="fw-bold mb-0">Lara Croft</p>
                                                        <p class="small text-muted">Lorem ipsum dolor sit.</p>
                                                    </div>
                                                </div>
                                                <div class="pt-1">
                                                    <p class="small text-muted mb-1">Yesterday</p>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="p-2 border-bottom  chat_room">
                                            <a href="#!" class="d-flex justify-content-between">
                                                <div class="d-flex flex-row">
                                                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-6.webp"
                                                        alt="avatar"
                                                        class="rounded-circle d-flex align-self-center me-3 shadow-1-strong"
                                                        width="60">
                                                    <div class="pt-1">
                                                        <p class="fw-bold mb-0">Brad Pitt</p>
                                                        <p class="small text-muted">Lorem ipsum dolor sit.</p>
                                                    </div>
                                                </div>
                                                <div class="pt-1">
                                                    <p class="small text-muted mb-1">5 mins ago</p>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="p-2 border-bottom  chat_room">
                                            <a href="#!" class="d-flex justify-content-between">
                                                <div class="d-flex flex-row">
                                                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-6.webp"
                                                        alt="avatar"
                                                        class="rounded-circle d-flex align-self-center me-3 shadow-1-strong"
                                                        width="60">
                                                    <div class="pt-1">
                                                        <p class="fw-bold mb-0">Brad Pitt</p>
                                                        <p class="small text-muted">Lorem ipsum dolor sit.</p>
                                                    </div>
                                                </div>
                                                <div class="pt-1">
                                                    <p class="small text-muted mb-1">5 mins ago</p>
                                                </div>
                                            </a>
                                        </li>
                                        <li class="p-2 border-bottom  chat_room">
                                            <a href="#!" class="d-flex justify-content-between">
                                                <div class="d-flex flex-row">
                                                    <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-6.webp"
                                                        alt="avatar"
                                                        class="rounded-circle d-flex align-self-center me-3 shadow-1-strong"
                                                        width="60">
                                                    <div class="pt-1">
                                                        <p class="fw-bold mb-0">Brad Pitt</p>
                                                        <p class="small text-muted">Lorem ipsum dolor sit.</p>
                                                    </div>
                                                </div>
                                                <div class="pt-1">
                                                    <p class="small text-muted mb-1">5 mins ago</p>
                                                </div>
                                            </a>
                                        </li>
                                    </ul>

                                </div>
                            </div>

                        </div>

                        <div class="col-md-6 col-lg-7 col-xl-8 chatting_box">

                            <div class="chatting_history">
                                <ul class="list-unstyled">
                                    <li class="d-flex justify-content-between mb-4">
                                        <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-6.webp"
                                            alt="avatar"
                                            class="rounded-circle d-flex align-self-start me-3 shadow-1-strong"
                                            width="60">
                                        <div class="card">
                                            <div class="card-header d-flex justify-content-between p-3">
                                                <p class="fw-bold mb-0">Brad Pitt</p>
                                                <p class="text-muted small mb-0"><i class="far fa-clock"></i> 12 mins
                                                    ago
                                                </p>
                                            </div>
                                            <div class="card-body">
                                                <p class="mb-0">
                                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
                                                    eiusmod
                                                    tempor incididunt ut
                                                    labore et dolore magna aliqua.
                                                </p>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="d-flex justify-content-between mb-4">
                                        <div class="card w-100">
                                            <div class="card-header d-flex justify-content-between p-3">
                                                <p class="fw-bold mb-0">Lara Croft</p>
                                                <p class="text-muted small mb-0"><i class="far fa-clock"></i> 13 mins
                                                    ago
                                                </p>
                                            </div>
                                            <div class="card-body">
                                                <p class="mb-0">
                                                    Sed ut perspiciatis unde omnis iste natus error sit voluptatem
                                                    accusantium doloremque
                                                    laudantium.
                                                </p>
                                            </div>
                                        </div>
                                        <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-5.webp"
                                            alt="avatar"
                                            class="rounded-circle d-flex align-self-start ms-3 shadow-1-strong"
                                            width="60">
                                    </li>
                                    <li class="d-flex justify-content-between mb-4">
                                        <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-6.webp"
                                            alt="avatar"
                                            class="rounded-circle d-flex align-self-start me-3 shadow-1-strong"
                                            width="60">
                                        <div class="card">
                                            <div class="card-header d-flex justify-content-between p-3">
                                                <p class="fw-bold mb-0">Brad Pitt</p>
                                                <p class="text-muted small mb-0"><i class="far fa-clock"></i> 10 mins
                                                    ago
                                                </p>
                                            </div>
                                            <div class="card-body">
                                                <p class="mb-0">
                                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
                                                    eiusmod
                                                    tempor incididunt ut
                                                    labore et dolore magna aliqua.
                                                </p>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="d-flex justify-content-between mb-4">
                                        <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-6.webp"
                                            alt="avatar"
                                            class="rounded-circle d-flex align-self-start me-3 shadow-1-strong"
                                            width="60">
                                        <div class="card">
                                            <div class="card-header d-flex justify-content-between p-3">
                                                <p class="fw-bold mb-0">Brad Pitt</p>
                                                <p class="text-muted small mb-0"><i class="far fa-clock"></i> 10 mins
                                                    ago
                                                </p>
                                            </div>
                                            <div class="card-body">
                                                <p class="mb-0">
                                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
                                                    eiusmod
                                                    tempor incididunt ut
                                                    labore et dolore magna aliqua.
                                                </p>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="d-flex justify-content-between mb-4">
                                        <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-6.webp"
                                            alt="avatar"
                                            class="rounded-circle d-flex align-self-start me-3 shadow-1-strong"
                                            width="60">
                                        <div class="card">
                                            <div class="card-header d-flex justify-content-between p-3">
                                                <p class="fw-bold mb-0">Brad Pitt</p>
                                                <p class="text-muted small mb-0"><i class="far fa-clock"></i> 10 mins
                                                    ago
                                                </p>
                                            </div>
                                            <div class="card-body">
                                                <p class="mb-0">
                                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
                                                    eiusmod
                                                    tempor incididunt ut
                                                    labore et dolore magna aliqua.
                                                </p>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="d-flex justify-content-between mb-4">
                                        <img src="https://mdbcdn.b-cdn.net/img/Photos/Avatars/avatar-6.webp"
                                            alt="avatar"
                                            class="rounded-circle d-flex align-self-start me-3 shadow-1-strong"
                                            width="60">
                                        <div class="card">
                                            <div class="card-header d-flex justify-content-between p-3">
                                                <p class="fw-bold mb-0">Brad Pitt</p>
                                                <p class="text-muted small mb-0"><i class="far fa-clock"></i> 10 mins
                                                    ago
                                                </p>
                                            </div>
                                            <div class="card-body">
                                                <p class="mb-0">
                                                    Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do
                                                    eiusmod
                                                    tempor incididunt ut
                                                    labore et dolore magna aliqua.
                                                </p>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>

                            <div class="msg_send_box">
                                <ul class="list-unstyled">
                                    <li class="bg-white mb-3">
                                        <div data-mdb-input-init class="form-outline">
                                            <textarea class="form-control" id="textAreaExample2" rows="4"></textarea>
                                            <label class="form-label" for="textAreaExample2">Message</label>
                                        </div>
                                    </li>
                                    <button type="button" class="btn1 forget_btn btn-rounded float-end">Send</button>

                                </ul>
                                <button type="button" class="btn1 forget_btn">quit</button>
                            </div>

                        </div>
                    </div>

                </div>
            </section>
        </div>
		<div>
			<button type="button" onclick="sendMsg();">메세지 보내기</button>
		</div>
    </main>
    <script src="${ contextPath }/resources/js/common/bootstrap.bundle.min.js"></script>
    <script src="${ contextPath }/resources/js/common/sidebars.js"></script>
</body>
<script>
    $(document).ready(function () {
        let chatRoomArr = [];

        for (let i = 0; i < $(".chat_room").length; i++) {
            chatRoomArr[i] = 0;
        }

        $(".msg_open_btn").on("click", function () {
            $(".msg_close_btn").css("display", "block");
            $(".msg_open_btn").css("display", "none");
            $(".msgbox").css("display", "flex");
        })

        $(".msg_close_btn").on("click", function () {
            $(".msg_open_btn").css("display", "block");
            $(".msg_close_btn").css("display", "none");
            $(".msgbox").css("display", "none");
        })

        $(".pl_btn").on("click", function () {
            $(".people_list").css("display", "flex");
            $(".chatrooms").css("display", "none");
        })

        $(".cr_btn").on("click", function () {
            $(".chatrooms").css("display", "flex");
            $(".people_list").css("display", "none");
        })

        $(".chat_room").each(function (index, el) {
            $(el).on("click", function () {


                $(".chat_room").each(function (index, el) {
                    if (chatRoomArr[index] == 1) {
                        $(el).removeClass("chat_room_active");
                        chatRoomArr[index] = 0;
                    }
                })

                $(el).addClass("chat_room_active");
                chatRoomArr[index] = 1;

            })
        })
	    $('#people_list').iziModal({
	        title: '사원 목록',
	        subtitle: '',
	        headerColor: '#FEEFAD', // 헤더 색깔
	        theme: 'light', //Theme of the modal, can be empty or "light".
	        padding: '15px', // content안의 padding
	        radius: 10, // 모달 외각의 선 둥글기
	        group: 'name111',
	        loop: true,
	        arrowKeys: true,
	        navigateCaption: true,
	        navigateArrows: true,
	        zindex: 300, // zindex 모달의 화면 우선 순위 입니다. 
	        focusInput: true, // 가장 맨 위에 보이게 해주는 속성값
	        restoreDefaultContent: false, // 모달을 다시 키면 값을 초기화
	    });
    	 // 채팅 - 전체 사원 조회    
       const $deptListWrapper = $(".dept_list_wrapper");
       $(".msg_btn_wrapper").on("click", function() {
       	
       	$.ajax({
       		url: '${contextPath}/member/select.do'
       		, method: 'get'
       		, success: function(map) {
       			for(let i = 0; i < map.deptList.length; i++) {
       				var deptText = "<div class='d-inline-flex gap-1 dept_list'>";
      		          deptText += "<button class='btn1 forget_btn dept' type='button' data-bs-toggle='collapse'";   			
      		       		deptText += "data-bs-target='#" + map.deptList[i].codeName + "' aria-expanded='false' data-mdb-ripple-init>";
      		       		//deptText += "data-uppercode='" + map.deptList[i].code + "' data-counti='" + i + "'>";
      		       		deptText += map.deptList[i].codeName;
      		     			deptText += "</button>";
      		  				deptText += "</div>";
      		  				
      		  		var teamText = "<div class='collapse multi-collapse' id='" + map.deptList[i].codeName + "'>"
      		  		for(let j = 0; j < map.teamList.length; j++) {
      		  			// 부서에 해당하는 팀
      		  			if(map.deptList[i].code == map.teamList[j].upperCode) {
      		  				teamText += "<div class='card card-body team'>";
   								teamText += "<button class='btn btn-outline-info team' type='button' data-bs-toggle='collapse'";
   								teamText += "data-bs-target='#team_" + map.teamList[j].code + "' aria-expanded='false' data-mdb-ripple-init>";
   								teamText += map.teamList[j].codeName;
   								teamText += "</button>";
   								teamText += "</div>";  	

   	   		  			var memberText = "<div class='collapse multi-collapse team_list' id='team_" + map.teamList[j].code + "'>";
   	   		  			memberText += "<ul>";
   	   		  			for(let k = 0; k < map.memberList.length; k++) {
   	   		  				// 팀에 해당하는 팀원
   	   		  				if(map.teamList[j].code == map.memberList[k].teamCode) {
   	   		  					memberText += "<li class='list-group-item'>";
   	   		  					memberText += "<div class='pretty p-icon p-smooth'>";
   	   		  					memberText += "<input type='checkbox' value='" + map.memberList[k].userNo + "'/>";
   	   		  					memberText += "<div class='state p-success'>";
   	   		  					memberText += "<i class='icon fa fa-check'></i>"
   	   		  					memberText += "<label>" + map.memberList[k].position + " " + map.memberList[k].userName + "</label>";
   	   		  					memberText += "</div>";
   	   		  					memberText += "</div>";
   	   		  					memberText += "</li>";
   	   		  				}
   	   		  			}
   	   		  			memberText += "</ul>";
   	   		  			memberText += "</div>";
   	   		  			
   	   		  			teamText += memberText;
      		  			}
      		  		}
   			  		teamText += "</div>"

       		    $deptListWrapper.append(deptText + teamText);    		    						
             }
       			 			
       		}
       		, error: function() {
       			console.log("부서 조회 ajax 통신 실패")
       		}
       	})
       })
       
       
    })

    // 채팅하기 버튼 클릭 시 체크된 회원들과 채팅방 생성
    function createChatRoom() {
    	// 1. 채팅방 데이터 생성 => Chatting Room 데이터 추가, Chatting Participation 데이터 추가
    	var roomNo;
    	// 1-1. 채팅방 생성
    	$.ajax({
   			url: "${contextPath}/chat/room"
   			, method: "post"
   			, success: function(result) {
   				if(result > 0) {
   					roomNo = result;
   					// 1-2. 채팅방 참여인원 생성
 			    	$(".list-group-item").each(function(index, el) {
 			    		if($(el).children().children().is(':checked')) {    			
 			    			// 1-2-1. 체크된 회원 채팅방 참여
 			    			$.ajax({
 			    				url: "${contextPath}/chat/parti"
 			    				, method: "post"
 			    				, data: {partUserNo: $(el).children().children().val()
 			    									, chatRoomNo: roomNo}
 			    				, success: function(result) {
 			    					if(result == "SUCCESS") {
 			    						// 1-2-2. 채팅방 구독
	 		 			    			stompClient.connect({}, function(frame) {
	 		 			    				stompClient.subscribe("/topic/room/" + roomNo, function(msg) {
	 		 			    					console.log(msg);
	 		 			    				})
	 		 			    				// 1-2-3. 입장 메세지 발송
	 		 				     			stompClient.send("/app/chat/enter/" + roomNo, {}, JSON.stringify({name : '${loginMember.userName}'
	 		 				     																																				, roomNo: roomNo}));
	 		 			    			})
 			    					}
 			    				}
 			    				, error: function() {
 			    					console.log("채팅방 참여인원 생성 ajax 통신 실패");
 			    				}
 			    			})
 			    			
 			    		}
 			    		// 채팅용 웹소켓 연결
 			    		/*
 							chatting = new SockJS("${contextPath}/chatting");
 							stompClient = Stomp.over(chatting);
 							stompClient.connect({}, function(frame) {
 								console.log("Connected : " + frame);
 								stompClient.subscribe("/topic/a", function(msg) {
 									console.log(msg);
 								})
 							})
 							*/
 			    	})
   				}
   			}
   			, error: function() {
   				console.log("채팅방 생성 ajax 통신 실패");
   			}
    	})
    }
    
    // 구독 중인 채팅방 목록 조회
    $.ajax({
    	url: "${contextPath}/chat/rooms"
    	, method: "get"
    	, success: function(result) {
    		console.log(result)
    		// 참여중인 채팅방 구독
    		for(var i = 0; i < result.length; i++) {
    			stompClient.connect({}, function(frame) {
	    			stompClient.subscribe("/topic/chat/room/" + result[i].chatRoomNo, function(msg) {
	    				console.log(msg);
	    			})
	    		})
    		}
    	}
    	, error: function() {
    		console.log("채팅방 목록 조회 ajax 통신 실패");
    	}
    })
    
    // 현재 접속한 채팅방 구독 주소로 메세지 발송
		function sendMsg() {
			//stompClient.send("/app/user", {}, JSON.stringify({name: '${loginMember.userId}'
			//																									, roomNo: roomNo}));
		}
</script>
</html>