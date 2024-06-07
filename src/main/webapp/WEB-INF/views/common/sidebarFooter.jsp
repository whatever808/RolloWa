<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
  .iziModal-header-title{
  	font-size: 20px !important;
  }
</style>
</head>
<body>
		 <div class="msg_open_btn">
        <i class="fa-solid fa-comment fa-5x"></i>
     </div>
     <div class="msg_close_btn">
        <i class="fa-regular fa-circle-xmark fa-5x"></i>
     </div>
     <div class="chat_alram">
     </div>

     <!-- Modal structure -->
     <div id="people_list">
         <!-- Modal content -->
         <div class="m_content_style">
             <div class="people_list">
                 <!--<div class="search_bar form-outline" data-mdb-input-init style="margin-top: 15px;">
                     
                     <input type="text" id="name_search" class="form-control"/>
                     <label class="form-label" for="name_search">인물 검색</label>
                      
                 </div>-->
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
         <section style="height: 100%;">
             <div class="container" style="padding-top: 10px; height: 100%;">

                 <div class="row" style="height: 100%;">

                     <div class="col-md-6 col-lg-5 col-xl-4 mb-4 mb-md-0" style="height: 100%;">

                         <h5 class="font-weight-bold mb-3 text-center text-lg-start" style="margin-top: 10px; margin-left: 20px;">Messenger
                         </h5>
                         <div class="msg_btn_wrapper btn_wrapper">
                             <button data-izimodal-open="#people_list" class="btn1 forget_btn people_list_btn"><i
                                     class="fa-solid fa-comment"></i></button>
                         </div>

                         <div class="card" style="margin-top: 10px; overflow: auto;
                         height: 750px;">
                             <div class="card-body">

                                 <ul class="list-unstyled mb-0 chat_room_list">
                                 <!-- 채팅방 리스트 -->
                                 </ul>

                             </div>
                         </div>

                     </div>

                     <div class="col-md-6 col-lg-7 col-xl-8 chatting_box">
                         <div class="chatting_history scrollbar">
	                         	 <!--<div>
	                         		<i class="fa-solid fa-comment-slash fa-8x"></i><br>
	                         	 </div>
	                         	 <div class="chatting_history_comment">
	                         		<span>No Message</span>
	                         	 </div> -->
                             <ul class="list-unstyled chat_msg_list">
                                 <!-- 채팅 메세지 구역 -->              
                             </ul>
                         </div>

                         <div class="msg_send_box">
                             <!-- 채팅 메세지 보내기 구역 -->
                         </div>

                     </div>
                 </div>

             </div>
         </section>
     </div>
     
     <div id="mention">
     	<ul class="participant_list">
     	
     	</ul>
     	<div class="btn_wrapper mention_btn_wrapper" style="height: 40px;">
     	
     	</div>
     </div>
    </main>
    <script src="${ contextPath }/resources/js/common/bootstrap.bundle.min.js"></script>
    <script src="${ contextPath }/resources/js/common/sidebars.js"></script>
</body>
<script>
		// 채팅 메세지 구역
		const $chatMsgUl = $(".chat_msg_list");
		// 채팅방 목록 구역
		const $chatRoomUl = $(".chat_room_list");
		// 채팅방 메세지 보내기 버튼 구역
		const $chatSendBox = $(".msg_send_box");
		
    $(document).ready(function () {
        let chatRoomArr = [];

        for (let i = 0; i < $(".chat_room").length; i++) {
            chatRoomArr[i] = 0;
        }
        
      	// 채팅방 버튼 스타일
      	$(".msg_open_btn").on("mouseenter", function() {
      		$(".msg_open_btn>i").addClass("fa-beat");
      	})
      	$(".msg_open_btn").on("mouseleave", function() {
      		$(".msg_open_btn>i").removeClass("fa-beat");
      	})
      	
      	// 채팅방 버튼 스타일
		  	$(".msg_close_btn").on("mouseenter", function() {
		  		$(".msg_close_btn>i").addClass("fa-beat");
		  	})
		  	$(".msg_close_btn").on("mouseleave", function() {
		  		$(".msg_close_btn>i").removeClass("fa-beat");
		  	})

        // 채팅방 열기 버튼
        $(".msg_open_btn").on("click", function () {
        	// 스타일 조정
        	btnControl(".msg_open_btn", ".msg_close_btn", 1, 100);
          
          // 페이지 새로고침 시에만 채팅방 목록 조회
          if (subRoomNo == -1) {
        	  selectChatRoom();
          }
          
          
          // 메신저 열었음을 표시
          subRoomNo = 1;
          
          // 메신저 알림 표시 제거
          $(".chat_alram").children().empty();
        })
        
        // 채팅방 닫기 버튼
        $(".msg_close_btn").on("click", function () {
        	// 스타일 조정
        	btnControl(".msg_close_btn", ".msg_open_btn", 0, -1);
        	
        	// 채팅방 닫았을 경우 내가 열어놨던 채팅방의 채팅방 나간 시간 update
        	updateOutDate(subRoomNo);
        	
        	// 채팅방 선택 표시 초기화
					$(".chat_room").each(function(index, el) {
						$(el).removeClass("selected");
					})
        	
        	// 채팅 메세지 구역 초기화
        	$(".chat_msg_list").empty();
        	$(".sendBtn_ul").empty();
        	$(".sendBtn_ul").next().detach();
        	
        	// 메신저 닫았음을 표시
        	subRoomNo = 0;
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
	        loop: true,
	        arrowKeys: true,
	        navigateCaption: true,
	        navigateArrows: true,
	        zindex: 300, // zindex 모달의 화면 우선 순위 입니다. 
	        focusInput: true, // 가장 맨 위에 보이게 해주는 속성값
	        restoreDefaultContent: false, // 모달을 다시 키면 값을 초기화
	    });
      
      // 멘션 기능을 위한 모달
      $("#mention").iziModal({
    	  title: '<h6>채팅방 사원 목록</h6>',
        subtitle: '',
        headerColor: '#FEEFAD', // 헤더 색깔
        theme: 'light', //Theme of the modal, can be empty or "light".
        padding: '15px', // content안의 padding
        radius: 10, // 모달 외각의 선 둥글기
      })
     
    	 // 채팅 - 전체 사원 조회
			 // 사원 목록 구역
			 const $deptListWrapper = $(".dept_list_wrapper");
       $(".people_list_btn").on("click", function() {
	    	  $.ajax({
	       		url: '${contextPath}/member/select.do'
	       		, method: 'get'
	       		, success: function(map) {
	       			// 부서 영역 초기화
	       			$deptListWrapper.empty();
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
	   	   		  					// 로그인한 유저는 출력되지 않도록 수정
	   	   		  					if(map.memberList[k].userNo != ${loginMember.userNo}) {
		   	   		  					memberText += "<li class='list-group-item memberList'>";
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
       
       // 사원 이름으로 검색
       /*$("#name_search").keypress(function(e) {
    	   searchName($("#name_search").val());
    	   $("#name_search").val("");
       })*/    
    })
    
    /*==================================== 함수 구역 =======================================*/   
    // 채팅방 접속 시간 update
    function updateOutDate(roomNo) {
    	$.ajax({
    		url: "${contextPath}/chat/inDate"
    		, method: "post"
    		, data: {roomNo: roomNo, userNo: ${loginMember.userNo}}
    		, async:false
    		, success: function(result) {
    		}
    		,error: function() {
    			console.log("채팅방 접속 시간 수정 ajax 실패");
    		}
    	})
    }
    
    // 채팅방의 읽지 않은 메세지 갯수 조회
    function selectUnreadMsg(roomNo) {
    	var unreadMsg;
    	$.ajax({
    		url: "${contextPath}/chat/messages/unread"
    		, method: "get"
    		, async: false
    		, data: {roomNo: roomNo, userNo: ${loginMember.userNo}}
    		, success: function(unreadMsgCount) {
    			unreadMsg = unreadMsgCount;
    		}
    		, error: function() {
    			console.log("읽지 않은 메세지 조회 ajax 실패");
    		}
    	})
    	return unreadMsg;
    } 
    
    // 채팅방 목록 가져오기
		function selectChatRoom() {
		$chatRoomUl.empty();
	  $.ajax({
 		  url: "${contextPath}/chat/rooms"
 		  , method: "get"
 		  , success: function(chatRoomList) {
 			  for(var i = 0; i < chatRoomList.length; i++) {
	   	  var chatRoomNo = chatRoomList[i].chatRoomNo
	   	  // 채팅방 참여인원 조회
	   	  $.ajax({
	   		  url: "${contextPath}/chat/participants"
	   			, method: "get"
	   			, async: false
	   		  , data: {roomNo : chatRoomList[i].chatRoomNo}
	   		  , success: function(participantsList) {
	   			  if (participantsList.length > 0) {
	   				  if(chatRoomNo == subRoomNo) {
	   					  var chatRoomVal = "<li class='p-2 selected border-bottom chat_room chat_room_" + chatRoomList[i].chatRoomNo + "' onclick='selectChatMsg(event, " + chatRoomList[i].chatRoomNo + ", " + JSON.stringify(participantsList) + ")'";
	   				  } else {
	   					var chatRoomVal = "<li class='p-2 border-bottom chat_room chat_room_" + chatRoomList[i].chatRoomNo + "' onclick='selectChatMsg(event, " + chatRoomList[i].chatRoomNo + ", " + JSON.stringify(participantsList) + ")'";
	   				  }
		    			chatRoomVal += ">";
		       	  chatRoomVal += "<a href='#!' class='d-flex justify-content-between'>";
		       	  chatRoomVal += "<div class='d-flex flex-row'>";
		       	  chatRoomVal += "<img style='height: 70px;' src='${contextPath}" + participantsList[0].profileURL + "'";
		       	  chatRoomVal += "class='rounded-circle d-flex align-self-center me-3 shadow-1-strong'";
		       	  chatRoomVal += "width='60' style='height: 70px'>";
		       	  chatRoomVal += "<div class='pt-1'>";
		       	  chatRoomVal += "<p class='fw-bold mb-0'>";
		       	  for(var j = 0; j < (participantsList.length > 2 ? 2 : participantsList.length ); j++) {
		       		  chatRoomVal += participantsList[j].userName + (j == (participantsList.length - 1) ? "" : ",");
		       	  }
		       	  chatRoomVal += "</p>";
		       	  chatRoomVal += "<p class='small text-muted lastest_msg'></p>";
		       	  chatRoomVal += "</div>";
		       	  chatRoomVal += "</div>";
		       	  chatRoomVal += "<div class='pt-1' id='chat_room_info" + chatRoomNo + "'>";
		       	  chatRoomVal += "<p class='small text-muted mb-1'>" + participantsList.length + "명</p>";
		       	  
		       	  // 읽지 않은 메세지가 존재할 경우
		       	  if (selectUnreadMsg(chatRoomNo) > 0) {
		       		  
		       		  // 처음 페이지를 새로고침해서 메신저를 열지 않은 경우 or 메신저를 닫아놓은 경우만 실행
		       		  if(subRoomNo == -1 || subRoomNo == 0) {
		       			  // 기존 알림 제거
									$(".chat_alram").children().empty();
									// 메신저 아이콘에 알림 표시 추가
									$(".chat_alram").append("<span class='badge bg-danger float-end'>New</span>");
		       		  }
								
								// 채팅방에 읽지 않은 메세지 표시
		       			chatRoomVal += "<span class='badge bg-danger float-end'>" + selectUnreadMsg(chatRoomNo) + "</span>";
		       	  }
		       	  
		       	  chatRoomVal += "</div>";
		       	  chatRoomVal += "</a>";
		       	  chatRoomVal += "</li>";
		       	  $chatRoomUl.append(chatRoomVal);
		   			  }
	   		  }
	   		  , error: function(xhr, status, error){
	   			    console.log(status, error);
	   		  }
	   	  })
	     }
 		  }
 		  , error: function() {
 			  console.log("채팅방 조회 ajax 실패");
 		  }
 	  })
   	
    }
	
		// 채팅방 메세지 이력 가져오기
		function selectChatMsg(event, chatRoomNo, participantsList) {
			// 내가 선택한 채팅방 색깔 바꾸기
			$(".chat_room").each(function(index, el) {
				$(el).removeClass("selected");
			})
			$(".chat_room_" + chatRoomNo).addClass("selected");
			
			// 채팅방 알림 제거
			$("#chat_room_info" + chatRoomNo).children($("p")).next().empty();
			
			// 다른 채팅방을 열었을 경우 기존 채팅방의 나간 시간 업데이트
			if(subRoomNo != chatRoomNo) {
				// 채팅방 나간 시간 update
				updateOutDate(subRoomNo);
			}

			// 내가 어떤 채팅방을 열었는지 표시
			subRoomNo = chatRoomNo;
			
			$(".chatting_history").before
			
			// 채팅방 기능 버튼 초기화
			$(".chatting_box>.btn_wrapper").remove();
			
			// 채팅방 멘션, 파일전송 버튼 추가
			var functionBtn = "<div class='btn_wrapper' style='margin-top: 10px;''>";
			functionBtn += "<button type='button' class='btn1 forget_btn' onclick='sendFile(" + chatRoomNo + ");'>파일전송</button>";
			functionBtn += "<button type='button' class='btn1 forget_btn' onclick='mentionModal(" + chatRoomNo + ", " + JSON.stringify(participantsList) + ");'>@멘션</button>";
			functionBtn += "</div>";
			
			$(".chatting_history").before(functionBtn);
			
			$.ajax({
		 	url: "${contextPath}/chat/messages"
		 	, method: "get"
		 	, data: {roomNo: chatRoomNo}
		 	, async: false
		 	, success: function(chatList) {
		 		$chatMsgUl.html("");
		 		for(var i = 0; i < chatList.length; i++) {
		 			if(${ loginMember.userNo } != chatList[i].userNo ) {
		 				// 메세지를 보낸 사람이 내가 아닌 경우
						chatTextDisplay(2, chatList[i].userName, chatList[i].sendDate, chatList[i].msgContent, chatList[i].profileURL);
		 			} else if (${ loginMember.userNo } == chatList[i].userNo ) {
		 				// 메세지를 보낸 사람이 나일 경우 (1은 보낸 사람이 자신임을 의미)
		 				chatTextDisplay(1, chatList[i].userName, chatList[i].sendDate, chatList[i].msgContent, chatList[i].profileURL);
		 			}
		 		}
	 			// 채팅 메세지 보내기 영역 생성
	 			var sendBtn = "<ul class='list-unstyled sendBtn_ul'>";
	 			sendBtn += "<li class='bg-white mb-3 sendBtn_li'>";
	 			sendBtn += "<div data-mdb-input-init class='form-outline sendBtn_div'>";
	 			sendBtn += "<textarea class='form-control' class='chatArea' id='chat_area_" + chatRoomNo + "' rows='4' onkeyup='if( event.keyCode == 13 ){sendMsg(" + chatRoomNo + ");}'></textarea>";
	 			sendBtn += "<label class='form-label' for='chat_area_" + chatRoomNo + "'>Message</label>";
	 			sendBtn += "</div>";
	 			sendBtn += "</li>";
	 			sendBtn += "<button type='button' class='btn1 forget_btn btn-rounded float-end' onclick='sendMsg(" + chatRoomNo + ");'>Send</button>";
	 			sendBtn += "</ul>";
	 			sendBtn += "<button type='button' class='btn1 forget_btn' onclick='quitChat(" + chatRoomNo + ");'>quit</button>";
	 			
	 			$chatSendBox.html("");
	 			$chatSendBox.append(sendBtn);
		 	}
		 	, error: function() {
		 		console.log("채팅방 메세지 이력 조회 ajax 통신 실패");
		 	}
		 })
		 // 스크롤 맨 아래로 고정 (이후 스크롤 높이 구해서 10000 수정해야함)
		 $(".chatting_history").animate({scrollTop:'10000'}, '500');
		}
		
		// 채팅방 사원 멘션 기능
		function mentionModal(chatRoomNo, participantsList) {
			// 모달창 초기화
			$(".participant_list").empty();
			// 모달창 버튼 초기화
			$(".mention_btn_wrapper").empty();
			// 모달에 채팅방 사원 출력
			$("#mention").iziModal('open');
			
			var memberText = "";
			for(var i = 0; i < participantsList.length; i++) {
				memberText = "<li class='list-group-item partList'>";
				memberText += "<div class='pretty p-icon p-smooth'>";
				memberText += "<input type='checkbox' value='" + participantsList[i].userNo + "'/>";
				memberText += "<div class='state p-success'>";
				memberText += "<i class='icon fa fa-check'></i>"
				memberText += "<label>" + participantsList[i].position + " " + participantsList[i].userName + "</label>";
				memberText += "</div>";
				memberText += "</div>";
				memberText += "</li>";
			}
			
			$(".participant_list").append(memberText);
			// 모달창 버튼 생성
			var functionBtn = "<button type='button' class='btn1 forget_btn' onclick='mention(" + chatRoomNo + ");''>멘션하기</button>"
			$(".mention_btn_wrapper").append(functionBtn);
		}
		
		function mention(chatRoomNo) {			
			// 멘션하기 버튼 클릭 시 체크된 회원 확인
			var mentionList = new Array();
			$(".participant_list>.partList").each(function(index, el) {
				mentionList.push($(el).children().children("input[type=checkbox]").val());
			})
			
			// 체크된 회원에게 알림 전송
			stompClient.send("/app/alram/send", {}, JSON.stringify({sendUserNo: '${loginMember.userNo}'
																															, flag: '3'
																															, mentionList: mentionList
																															, chatRoomNo: chatRoomNo
																															, url: ""}));
			$("#mention").iziModal("close");
		}
		
		// 채팅방 파일 전송 기능
		function sendFile(chatRoomNo) {
			
		}
		
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
 			    	$(".memberList").each(function(index, el) {
 			    		var partUserNo = $(el).children().children().val();
 			    		if($(el).children().children().is(':checked')) {  
 			    			$(el).children().children().prop("checked", false);
 			    			// 1-2-1. 체크된 회원 채팅방 참여
 			    			$.ajax({
 			    				url: "${contextPath}/chat/participants"
 			    				, method: "post"
 			    				, data: {partUserNo: partUserNo
 			    									, chatRoomNo: roomNo}
 			    				, success: function(result) {
 			    					if(result == "SUCCESS") {
 			    						// 현재 열어놓은 채팅방이 있다면 해당 채팅방의 나간 시간 update
 			    						// 채팅방을 닫아놨거나, 아예 열지 않은 경우를 제외하고
						          if(subRoomNo != -1 && subRoomNo != 0) {
						        	  // 열어놓은 채팅방의 나간 시간 update
						        	  updateOutDate(subRoomNo);
						          }  		 			    				
 		 			    				// 1-2-2. 입장 메세지 발송
 		 			    				// 메세지 발송 시간
 		 			    				var sendDate = dateFormat(new Date());
 		 				     			stompClient.send("/app/chat/invite", {}, JSON.stringify({userName: '${loginMember.userName}'
 		 				     																							, roomNo: roomNo
 		 				     																							, partUserNo : partUserNo
 		 				     																							, sendDate: sendDate
		 				     																							, userNo: '${loginMember.userNo}'}));
 			    						// 모달창 닫기
 		 			    				$('#people_list').iziModal('close');
 			    						
 			    					}
 			    				}
 			    				, error: function() {
 			    					console.log("채팅방 참여인원 생성 ajax 통신 실패");
 			    				}
 			    			})
 			    			
 			    		}
 			    	})
						
						// 1-2-3. 채팅방 구독
    				stompClient.subscribe("/topic/chat/room/" + roomNo, function(msg) {
    					receiveMsg(msg);
    				}, { id: "room" + roomNo})
    				
    				// 1-2-4. 채팅방 목록 새로고침
						selectChatRoom();
   				}
   			}
   			, error: function() {
   				console.log("채팅방 생성 ajax 통신 실패");
   			}
    	})
    }
    
    function test() {
			stompClient.send("/app/chat/invite", {}, JSON.stringify({userName: '${loginMember.userName}'
					, userNo: '${loginMember.userNo}'}));
    }
    
    // 현재 접속한 채팅방 구독 주소로 메세지 발송
		function sendMsg(chatRoomNo) {
    	// 채팅 보낸 날짜
    	var sendDate = dateFormat(new Date());
    	
    	// 채팅 메세지 입력한 칸 선택
    	var $chatArea = $chatSendBox.children($(".sendBtn_ul"))
    																				.children($(".sendBtn_li"))
    																				.children($(".sendBtn_div"))
    																				.children($("textarea"));
    	
    	// 채팅 메세지를 입력하지 않았을 경우 메세지를 발송하지 않음
    	if($chatArea.val().trim().length == 0) {
    		return;
    	}

    	const msgContent = $chatArea.val();
    	
    	// @ 포함된 경우 사원 멘션 기능 (현재는 @ 포함일 경우 email 아니면 사원 호출이라고 가정)
    	if(msgContent.indexOf("@") != -1) {    		
    		// @위치 확인
    		const atIndex = msgContent.indexOf("@");
    		// @로부터 사원 이름 추출
    		const atUserName = msgContent.substring(atIndex + 1);
    		// 사원 이름인지 확인 (이름에는 영어가 올 수 없다고 가정) 한글 이름 2~5 글자
    		const regExp = /^[가-힣]{2,5}$/;
    		if(regExp.test(atUserName)) {
    			stompClient.send("/app/")
    			/*stompClient.send("/app/alram/send", {}, JSON.stringify({sendUserNo: '${loginMember.userNo}'
																																	, flag: '3'
																																	, chatRoomNo
																																	, atUserName}));*/
    		}
    	}
    	
			// 채팅 메세지 전송
    	stompClient.send("/app/chat/message/" + chatRoomNo, {}, JSON.stringify({userNo: '${loginMember.userNo}'
																												, roomNo: chatRoomNo
																												, msgContent: $chatArea.val()
																												, userName: '${loginMember.userName}'
																												, sendDate: sendDate
																												, profileURL: '${loginMember.profileURL}'}));
    	// 채팅 메세지 화면에 출력
    	chatTextDisplay(1, '${loginMember.userName}', sendDate , $chatArea.val(), '${loginMember.profileURL}')
    	
			// 채팅 메세지 보내고 스크롤 이동
			$(".chatting_history").animate({scrollTop:'10000'}, '500');
    	
    	$chatSendBox.children($chatArea.val(""));
		}
		
		// 채팅 메세지 출력
		function chatTextDisplay(flag, userName, sendDate, msgContent, profileURL) {
			// 데이터베이스로부터 가져온 메세지가 아닐 경우 월-일 시:분 추출
			if(sendDate.length > 18) {
				sendDate = sendDate.substring(5, 16);
			}
			
			// 사용자에게 보여질 요소
			var chatText = "";
			if (flag == 1) {
				// 보낸 사람이 나일 때
				chatText += "<li class='d-flex justify-content-between mb-4'>";
				chatText += "<div class='card w-100 fromMe'>";
				chatText += "<div class='card-header d-flex justify-content-between p-3'>";
				chatText += "<p class='fw-bold mb-0'>" + userName + "</p>";
				chatText += "<p class='text-muted small mb-0'><i class='far fa-clock'></i>" + sendDate + "</p>";
				chatText += "</div>";
				chatText += "<div class='card-body'>";
				chatText += "<p class='mb-0'>" + msgContent + "</p>";
				chatText += "</div>";
				chatText += "</div>";
				chatText += "<img src='${contextPath}" + profileURL + "' alt='avatar'";
				chatText += " class='rounded-circle d-flex align-self-start ms-3 shadow-1-strong'";
				chatText += "width='60' style='height: 70px'>";
				chatText += "</li>";
			} else if (flag == 2) {
				// 보낸 사람이 내가 아닐 때
				chatText += "<li class='d-flex justify-content-between mb-4'>";
 				chatText += "<img src='${contextPath}" + profileURL + "'";
 				chatText += "alt='profile image'";
 				chatText += "class='rounded-circle d-flex align-self-start me-3 shadow-1-strong'";
 				chatText += "width='60' style='height: 70px'>";
 				chatText += "<div class='card' style='width:100%;'>";
 				chatText += "<div class='card-header d-flex justify-content-between p-3'>";
 				chatText += "<p class='fw-bold mb-0'>" + userName + "</p>";
 				chatText += "<p class='text-muted small mb-0'><i class='far fa-clock'></i>" + sendDate + "</p>";
 				chatText += "</div>";
 				chatText += "<div class='card-body'>";
 				chatText += "<p class='mb-0'>" + msgContent + "</p>";
 				chatText += "</div>";
 				chatText += "</div>";
 				chatText += "</li>";
			}

			// 채팅 메세지 구역에 append
			$chatMsgUl.append(chatText);
		}
		
		// 구독 중인 채팅방에 메세지 수신 시 실행할 함수
		function receiveMsg(msg) {
			// 문자열 json으로 변환
			const chatBody = JSON.parse(msg.body);
			console.log(chatBody);
				
			// 알림 표시 구역
			const $chatRoomInfo = $(".chat_room_list").find($("#chat_room_info" + chatBody.roomNo)).children($("p"));
			
			if(subRoomNo == 0 || subRoomNo == -1) {
				// 메신저를 닫아놨거나 페이지 처음 로딩한 경우
				// 기존 알림 제거
				$(".chat_alram").children().empty();
				// 메신저 아이콘에 알림 표시 추가
				$(".chat_alram").append("<span class='badge bg-danger float-end'>New</span>");
			}
			
			// 현재 내가 메세지가 수신된 채팅방을 열어 놓은지 확인
			if(subRoomNo == chatBody.roomNo) {
				// 내가 메세지가 수신된 채팅방을 열어 놨을 때
				// 메세지 보낸 사람이 자신이 아닐 때만 실행
				if(chatBody.userNo != ${ loginMember.userNo }) {
					// 메세지 수신
   				chatTextDisplay(2, chatBody.userName, chatBody.sendDate, chatBody.msgContent, chatBody.profileURL)
					
   				// 채팅 메세지 수신하고 스크롤 이동
   				$(".chatting_history").animate({scrollTop:'10000'}, '500');
				}
			} else {
				// 메세지가 수신된 채팅방을 열어 놓지 않은 경우 채팅방 목록에 알림 표시
				// 만약 이미 알림이 표시되지 않은 경우에만 알림 표시
				if($chatRoomInfo.next().length == 0) {
					$chatRoomInfo.after(
						"<span class='badge bg-danger float-end'>" + selectUnreadMsg(chatBody.roomNo) + "</span>");
				} else if ($chatRoomInfo.next().length > 0) {
					// 이미 알림 표시가 된 경우 메세지 추가 도착함을 표시
					$chatRoomInfo.next().text(selectUnreadMsg(chatBody.roomNo));
				}
			}

		}
		
		// 채팅방 초대 알림 수신 시
		function receiveInviteMsg(msgBody) {
			selectChatRoom();
		}
		
		// 채팅방 나가기
		function quitChat(chatRoomNo) {
			// 메세지 전송 시간
	    var sendDate = dateFormat(new Date());
			
			// 채팅방 나가기 메세지 전송
			stompClient.send("/app/chat/quit", {}, JSON.stringify({userName: '${loginMember.userName}'
 		 				     																							, roomNo: chatRoomNo
 		 				     																							, sendDate: sendDate
		 				     																							, userNo: '${loginMember.userNo}'
		 				     																							, profileURL: '${loginMember.profileURL}'}));

			// 데이터베이스에서 사용자의 채팅방 참여 status를 'N'으로 변경
			$.ajax({
				url: "${contextPath}/chat/quit"
				, method: "post"
				, async: false
				, data: {userNo: ${loginMember.userNo}
									, roomNo: chatRoomNo}
				, success: function(result) {
					if (result > 0) {
						console.log("status update 성공");
					} else {
						console.log("status update 실패");
					}
					
				}
				, error: function() {
					console.log("채팅방 참여 status update ajax 실패");
				}
			})
			
			// 해당 채팅방 구독 끊기
			stompClient.unsubscribe("room" + chatRoomNo);
			
			// 채팅방 목록 다시 조회
			selectChatRoom();
			
			// 채팅 메세지 목록 초기화
     	$(".chat_msg_list").empty();
     	$(".sendBtn_ul").empty();
     	$(".sendBtn_ul").next().detach();

		}
		
		// 알림의 확인 날짜 update
		function updateCheckDate() {
			$.ajax({
				url: "${contextPath}/notification/checkDate"
				, method: "post"
				, data: {userNo: ${loginMember.userNo}}
				, async: false
				, success: function(result) {
					if(result > 0) {
						console.log("알림 조회 시간 update 성공");
					}
				}
				, error: function() {
					console.log("알림 조회 시간 update ajax 실패");
				}
			})
		}
		
		// 이름으로 사원 검색
		function searchName(keyword) {			
			$.ajax({
				url: "${contextPath}/member/search"
				, method: "get"
				, data: {keyword: keyword}
				, success: function(memberList) {					
					memberText += "</div>";
					$(".dept_list_wrapper").empty();
					var memberText = "<ul>";
					if(memberList.length != 0) {
  					// 조회된 사원이 있을 시		  			
 		  			for(let k = 0; k < memberList.length; k++) {
	  					memberText += "<li class='list-group-item memberList'>";
	  					memberText += "<div class='pretty p-icon p-smooth'>";
	  					memberText += "<input type='checkbox' value='" + memberList[k].userNo + "'/>";
	  					memberText += "<div class='state p-success'>";
	  					memberText += "<i class='icon fa fa-check'></i>"
	  					memberText += "<label>" + memberList[k].team + " " + memberList[k].position + " " + memberList[k].userName + "</label>";
	  					memberText += "</div>";
	  					memberText += "</div>";
	  					memberText += "</li>";
	  				}
  				} else {
  					// 조회된 사원이 없을 시
  					memberText += "<li class='list-group-item memberList'>";
  					memberText += "<label>조회된 사원이 없습니다.</label>";
  					memberText += "</li>";
  				}
	  			memberText += "</ul>";
					$(".dept_list_wrapper").append(memberText);
				}
				, error: function() {
					console.log("사원 검색 ajax 통신 실패");
				}
			})
		}
		
		// 채팅 구역 초기화
		function chattingHistoryInit() {
			$(".chatting_history").empty();
			var text = "<ul class='list-unstyled chat_msg_list'></ul>";
			$(".chatting_history").append(text);
			$(".chatting_history").removeClass("no_chatting_history");
		}

		// 날짜 형식 바꾸기
		function dateFormat(date) {
	        let month = date.getMonth() + 1;
	        let day = date.getDate();
	        let hour = date.getHours();
	        let minute = date.getMinutes();
	        let second = date.getSeconds();

	        month = month >= 10 ? month : '0' + month;
	        day = day >= 10 ? day : '0' + day;
	        hour = hour >= 10 ? hour : '0' + hour;
	        minute = minute >= 10 ? minute : '0' + minute;
	        second = second >= 10 ? second : '0' + second;

	        return date.getFullYear() + '-' + month + '-' + day + ' ' + hour + ':' + minute + ':' + second;
		}
		
		// 메신저 버튼 클릭 시 스타일 조정
    function btnControl(none, block, opacity, z) {
    	$(block).css("display", "block");
      $(none).css("display", "none");
      $(".msgbox").css("opacity", opacity);
      $(".msgbox").css("z-index", z);
    }
		
</script>
</html>