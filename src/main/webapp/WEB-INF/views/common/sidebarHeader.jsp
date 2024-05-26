<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SideBar</title>
    <!-- bootstrap -->
    <link href="${ contextPath }/resources/css/common/bootstrap.min.css" rel="stylesheet">

    <!-- fontawesome -->
    <script src="https://kit.fontawesome.com/12ec987af7.js" crossorigin="anonymous"></script>

    <!-- Google Fonts Roboto -->
    <link rel="stylesheet"
        href="https://fonts.googleapis.com/css2?family=Roboto:wght@300;400;500;700;900&display=swap" />

    <!-- Google Fonts Jua -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Jua&display=swap" rel="stylesheet">

 		<!-- socket 통신을 위한 js -->
    <script src="https://cdn.jsdelivr.net/sockjs/1/sockjs.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js" integrity="sha512-iKDtgDyTHjAitUDdLljGhenhPwrbBfqTKWO1mkhSFH3A7blITC9MhYon6SjnMhp4o0rADGw9yAC6EW4t5a4K3g==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>

    <!-- jQuery -->
    <script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

    <!-- 모달 관련 -->
    <script src="${ contextPath }/resources/js/iziModal.min.js"></script>
    <link rel="stylesheet" href="${ contextPath }/resources/css/iziModal.min.css">

    <!-- 체크박스 관련 스타일 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretty-checkbox@3.0/dist/pretty-checkbox.min.css">
    
    <!-- alertify -->
     <script src="${ contextPath }/resources/alertify/js/alertify.min.js"></script>
		 <link href="${contextPath}/resources/alertify/css/alertify.min.css" rel="stylesheet">
		 <link href="${contextPath}/resources/alertify/css/default.min.css" rel="stylesheet">
		 <link href="${contextPath}/resources/alertify/css/semantic.min.css" rel="stylesheet">

    <!-- css -->
    <link href="${ contextPath }/resources/css/common/sidebars.css" rel="stylesheet">
    <link rel="stylesheet" href="${ contextPath }/resources/css/common.css">
    <link rel="stylesheet" href="${ contextPath }/resources/css/common/mdb.min.css" />
    <style>
        .b-example-divider {
            width: 100%;
            height: 3rem;
            background: rgb(255, 247, 208);
            /* background: linear-gradient(90deg, rgba(255, 247, 208, 1) 0%, rgba(254, 239, 173, 1) 46%, rgba(248, 255, 140, 1) 100%); */
            border: solid rgba(0, 0, 0, .15);
            border-width: 1px 0;
            box-shadow: inset 0 .5em 1.5em rgba(0, 0, 0, .1), inset 0 .125em .5em rgba(0, 0, 0, .15);
        }

        .bi {
            vertical-align: -.125em;
            fill: currentColor;
        }

        .nav-scroller {
            position: relative;
            z-index: 2;
            height: 2.75rem;
            overflow-y: hidden;
        }

        .nav-scroller .nav {
            display: flex;
            flex-wrap: nowrap;
            padding-bottom: 1rem;
            margin-top: -1px;
            overflow-x: auto;
            text-align: center;
            white-space: nowrap;
            -webkit-overflow-scrolling: touch;
        }

        .active .bi {
            display: block !important;
        }

        .msg_open_btn,
        .msg_close_btn {
            position: fixed;
            right: 30px;
            bottom: 30px;
            cursor: pointer;
            color: #FEEFAD;
            z-index: 10;
        }
        
        .chat_alram {
        	position: fixed;
       		bottom: 90px;
    			right: 20px;
    			cursor: pointer;
    			z-index: 10;
        }

        .msg_open_btn:hover,
        .msg_close_btn:hover {
            color: #ffe367;
        }

        .msg_close_btn {
            display: none;
        }

        .msg_open_btn>a,
        .msg_close_btn>a {
            color: black;
        }

        .mb-1>button {
            box-shadow: none;
        }

        /* content의 height와 height 값을 동일하게 */
        .b-example-vr {
            flex-shrink: 0;
            width: 1.5rem;
            height: 1200px;
        }

        .content {
            height: 1200px;
            width: 1500px;
        }


        /* 채팅 스타일 */
        .msgbox {
            height: 900px;
            width: 1000px;
            border-radius: 10px;
            position: fixed;
            right: 80px;
            bottom: 30px;
            display: none;
            flex-direction: column;
            overflow: auto;
            overflow-x: none;
            z-index: 100;
        }

        .people_list {
            height: 500px;
            overflow: scroll;
            overflow-x: hidden;
        }


        /* 채팅방 리스트 */
        .chat_room:hover {
            background-color: #eeeeee;
        }

        .chat_room_active {
            background-color: #dddddd;
        }

        .card-body {
            padding: 10px;
        }

        /* 채팅방 리스트 끝 */

        /* 인물 목록 */
        .people_list {
            /* display: none; */
            display: flex;
            flex-direction: column;
        }

        .search_bar {
            height: 10%;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .dept_list_wrapper {
            height: 90%;
            display: flex;
            flex-direction: column;
        }

        .dept_list {
            display: flex;
            flex-direction: column;
            height: 40px;
        }

        .dept {
            height: 40px;
            width: 100%;
            font-size: 15px;
        }

        .team {
            height: 30px;
            font-size: 15px;
            padding: 0;
            margin: 10px;
            font-family: "Jua", sans-serif;
        }

        .chatting_btn {
            margin-left: 150px;
        }

        .team_list {
            display: flex;
            justify-content: center;
        }

        /* 인물 목록 끝 */

        /* 채팅방 버튼 */
        .chat_btn {
            border: 1px solid blue;
            height: 100px;
            display: flex;
            flex-direction: row;
            justify-content: center;
            align-items: center;
        }

        .pl_btn,
        .cr_btn {
            border-radius: 25px;
            --bs-btn-bg: #72abff;
            --bs-btn-border-color: #72abff;
            --bs-btn-hover-bg: #4992ff;
            margin: 0 15px;
        }

        .msg_btn_wrapper {
            height: 30px;
            display: flex;
            align-items: center;
            justify-content: flex-end;
        }

        .btn-outline-info {
            --mdb-btn-bg: transparent;
            --mdb-btn-color: #0e1010;
            --mdb-btn-hover-bg: #f6fbfd;
            --mdb-btn-hover-color: #0e1010;
            --mdb-btn-focus-bg: #f6fbfd;
            --mdb-btn-focus-color: #0e1010;
            --mdb-btn-active-bg: #f6fbfd;
            --mdb-btn-active-color: #0e1010;
            --mdb-btn-outline-border-color: #FEEFAD;
            --mdb-btn-outline-focus-border-color: #ffd000;
            --mdb-btn-outline-hover-border-color: #ffe367;
        }

        .btn1 {
            height: 35px;
        }

        /* 채팅방 버튼 끝 */

        /* 채팅방 */
        .chatting {
            /* display: none; */
            display: block;
        }

        .chatting_box {
            margin-top: 50px;
            height: 800px;
            display: flex;
            flex-direction: column;
        }

        .chatting_history {
            height: 80%;
            overflow: auto;
            overflow-x: none;
        }

        .msg_send_box {
            height: 20%;
            padding-top: 20px;
        }

        /* 채팅방 스타일 끝 */
    </style>
<style>
#main_logo span:hover {
  position: relative;
  top: 3px;
  display: inline-block;
  -webkit-font-smoothing: antialiased;
  animation: bounce 0.3s ease infinite alternate;
}
#main_logo span:{
	animation-delay: 0.1s;
}
#main_logo span{
	background: linear-gradient(to left, #f6eec9, #dfc853 70%);
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
}
@keyframes bounce {
  100% {top: -3px;}
}
.allposition{
	display: flex;
}
</style>
</head>
<body class="allposition">

<!--  -->


<script>
$(document).ready(function(){
	if(${ alertMsg != null }){
		switch ('${ modalColor }'){
			case 'R' :
				redAlert('${ alertTitle }', '${ alertMsg }');
				break;
			case 'G' :
				greenAlert('${ alertTitle }', '${ alertMsg }');
				break;
			case 'Y' :
				yellowAlert('${ alertTitle }', '${ alertMsg }');
				break;
		}
	}
	})
</script>

<main class="d-flex flex-nowrap"></main>
	<!-- 알림창 div -->
    <div id="redModal"></div>
    <div id="greenModal"></div>
    <div id="yellowModal"></div>  
    <script>
	    $('#redModal').iziModal({
	        headerColor: '#dc3545',
	        timeout: 3000,
          zindex: 9999,
	        timeoutProgressbar: true
	    });
	
	    $('#greenModal').iziModal({
	        headerColor: '#28a745',
	        timeout: 3000,
	        zindex: 9999,
	        timeoutProgressbar: true
	    });
	    
      $('#yellowModal').iziModal({
          headerColor: '#ffc107', 
          timeout: 3000,
          zindex: 9999,
          timeoutProgressbar: true,
      });
	    
      function redAlert(title, content){
          $('#redModal').iziModal('setTitle', title);
          $('#redModal').iziModal('setSubtitle', content);
          $('#redModal').iziModal('open');
      };

      function greenAlert(title, content){
          $('#greenModal').iziModal('setTitle', title);
          $('#greenModal').iziModal('setSubtitle', content);
          $('#greenModal').iziModal('open');
      };
      
      function yellowAlert(title, content){
          $('#yellowModal').iziModal('setTitle', title);
          $('#yellowModal').iziModal('setSubtitle', content);
          $('#yellowModal').iziModal('open');
      };
    </script>
	
        <div class="flex-shrink-0 p-3" style="width: 280px;">
            <a href="${contextPath}/"
                class="d-flex align-items-center pb-3 mb-3 link-body-emphasis text-decoration-none border-bottom">
                <svg class="bi pe-none me-2" width="30" height="24">
                    <use xlink:href="#bootstrap" />
                </svg>
                <span id="main_logo" class="fs-5 fw-semibold font-size25 jua-regular">
	                <span>RoLLoWa</span>
                </span>
            </a>
            <ul class="list-unstyled ps-0">
                <li class="mb-1">
                    <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#home-collapse" aria-expanded="true">
                        Home
                    </button>
                    <div class="collapse show" id="home-collapse">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Overview</a>
                            </li>
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Updates</a>
                            </li>
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Reports</a>
                            </li>
                        </ul>
                    </div>
                </li>
                
                <!-- ======================================= "가림" 구역 start ======================================= -->
                <!-- ======================================= 게시판 관련 start ======================================= -->
                <li class="mb-1">
                    <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#board-collapse" aria-expanded="false">
                        게시판
                    </button>
                    <div class="collapse" id="board-collapse">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                        	
                            <li><a href="${ contextPath }/board/list.do"
                                   class="link-body-emphasis d-inline-flex text-decoration-none rounded">공지사항 조회</a>
                            </li>
                            <!-- 글작성 권한을 가진 부장 or 사장일 경우 보여짐 -->
                          	 <li><a href="${ contextPath }/board/post.page"
                                  class="board-publisher d-none link-body-emphasis d-inline-flex text-decoration-none rounded">공지사항 등록</a>
                          	 </li>
                            
                            <!-- 글작성 권한을 가진 부장 or 사장일 경우 보여짐 -->
                            <li><a href="${ contextPath }/board/publisher/list.do?page=1&category=normal&department=&condition=&keyword="
                                   class="board-publisher d-none link-body-emphasis d-inline-flex text-decoration-none rounded">등록공지보관함</a>
                            </li>
                            
                            <!-- 글작성 권한을 가진 부장 or 사장일 경우 보여짐 -->
                            <li><a href="${ contextPath }/board/temp/list.do?page=1&category=normal&department=&condition=&keyword="
                                   class="board-publisher d-none link-body-emphasis d-inline-flex text-decoration-none rounded">임시공지보관함</a>
                            </li>
                            
                            <!--
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Annually</a>
                            </li>
                            -->
                        </ul>
                    </div>
                </li>
             <!-- ======================================= 게시판 관련 end ======================================= -->
             <!-- ======================================= 어트랙션 관련 start ======================================= -->
              <li class="mb-1">
                  <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                      data-bs-toggle="collapse" data-bs-target="#attraction-collapse" aria-expanded="false">
                      어트랙션
                  </button>
                  <div class="collapse" id="attraction-collapse">
                      <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">

                          <li><a href="${ contextPath }/attraction/list.do"
                                 class="link-body-emphasis d-inline-flex text-decoration-none rounded">어트랙션 조회</a>
                           </li> 

                          <li><a href="${ contextPath }/attraction/regist.page"
                                 class="attraction-manager d-none link-body-emphasis d-inline-flex text-decoration-none rounded">어트랙션 등록</a>
                          </li>

                          <li><a href="${ contextPath }/attraction/manage.do"
                                 class="attraction-manager d-none link-body-emphasis d-inline-flex text-decoration-none rounded">어트랙션 관리</a>
                          </li>


                      </ul>
                  </div>
              </li>
              <!-- ======================================= 어트랙션 관련 end ======================================= -->
              <script>
                $(document).ready(function(){
                  // 로그인 회원 정보조회
                  $.ajax({
                      url:"${ contextPath }/member/memInfo.do",
                      method:"get",
                      data:"userId=${ loginMember.userNo }",
                      success:function(memInfo){
                        // 직급이 부장 or 사장일 경우에만 공지사항 관리자 메뉴 노출
                        if(memInfo.positionCode == 'E' || memInfo.positionCode == 'F'){
                          $(".board-publisher").removeClass("d-none");
                        }
                        
                        // 어트랙션 운영팀 소속 팀원들에게만 어트랙션 관리자 메뉴 노출
                        if(memInfo.teamCode == 'B'){
                        	$(".attraction-manager").removeClass("d-none");
                        }
                      },error:function(){
                        console.log("로그인 회원 정보조회 AJAX 실패");
                      }
                    })
                })
              </script>
              <!-- ======================================= "가림" 구역 end ======================================= -->

                <!--◆◇◆◇◆◇◆◇◆◇◆◇ 김호관 사이드바 start ◆◇◆◇◆◇◆◇◆◇◆◇-->
                <li class="mb-1">
                    <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#org-collapse" aria-expanded="false">
                        조직안내
                    </button>
                    <div class="collapse" id="org-collapse">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li>
                            	<a href="${ contextPath }/organization/chart.page" class="link-body-emphasis d-inline-flex text-decoration-none rounded">조직도</a>
                            </li>
                            <li>
                            	<a href="${ contextPath }/organization/list.do" class="link-body-emphasis d-inline-flex text-decoration-none rounded">직원 검색</a>
                            </li>
                            <li>
                            	<a href="${ contextPath }/organization/manager.do" class="link-body-emphasis d-inline-flex text-decoration-none rounded">조직 관리</a>
                            </li>
                        </ul>
                    </div>
                </li>
                
                <li class="mb-1">
                    <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#mem-collapse" aria-expanded="false">
                        구성원 관리
                    </button>
                    <div class="collapse" id="mem-collapse">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li>
                            	<a href="${ contextPath }/attendance/list.do" class="link-body-emphasis d-inline-flex text-decoration-none rounded">출결 조회</a>
                            </li>
                            <li>
                            	<a href="${ contextPath }/attendance/accountList.do" class="link-body-emphasis d-inline-flex text-decoration-none rounded">급여 조회</a>
                            </li>
                            <li>
                            	<a href="${ contextPath }/attendance" class="link-body-emphasis d-inline-flex text-decoration-none rounded">구성원 상세 조회</a>
                            </li>
                            <li>
                            	<a href="${ contextPath }/attendance/signup.page" class="link-body-emphasis d-inline-flex text-decoration-none rounded">구성원 추가</a>
							</li>
                        </ul>
                    </div>
                </li>
                
                <li class="mb-1">
                    <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#reservation-collapse" aria-expanded="false">
                        예약 관리
                    </button>
                    <div class="collapse" id="reservation-collapse">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li>
                            	<a href="${ contextPath }/reservation/list.do" class="link-body-emphasis d-inline-flex text-decoration-none rounded">비품 예약</a>
                            </li>
                            <li>
                            	<a href="${ contextPath }/reservation/myList.do" class="link-body-emphasis d-inline-flex text-decoration-none rounded">내 예약 조회</a>
                            </li>
                            <li>
                            	<a href="${ contextPath }/reservation/reManager.do" class="link-body-emphasis d-inline-flex text-decoration-none rounded">비품 관리</a>
                            </li>
                        </ul>
                    </div>
                </li>
                <!--◆◇◆◇◆◇◆◇◆◇◆◇ 김호관 사이드바 end ◆◇◆◇◆◇◆◇◆◇◆◇-->
                            
                <!-- ======================================= calendar page ========================================= -->

                <li class="mb-1">
                    <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#orders-collapse" aria-expanded="false">
                        일정
                    </button>
                    <div class="collapse" id="orders-collapse">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li><a href="${contextPath}/calendar/pCalendar.page"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">부서 일정</a>
                            </li>
                            <li><a  href="${contextPath}/calendar/companyCalendar.page"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">회사 일정</a>
                            </li>
                            <li><a href="${contextPath}/calendar/calendarList.page"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">일정 관리</a>
                            </li>
                            <li><a href="${contextPath}/vacation/vacation.page"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">휴가</a>
                            </li>
                            <li><a href="${contextPath}/vacation/complete.page"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">지난 휴가</a>
                            </li>
                        </ul>
                    </div>
                </li>
                <!-- ======================================= calendar page ========================================= -->
  
                <!-- 전자결재 -->
                <li class="mb-1">
                    <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#approval-collapse" aria-expanded="false">
                        전자결재
                    </button>
                    <div class="collapse" id="approval-collapse">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li><a href="${contextPath}/pay/paymain.page"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">결재Home</a></li>
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">결재함</a>
                            </li>
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">결재작성하기</a>
                            </li>
                            <li><a href="${contextPath}/pay/myAllApproval.page"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">나의 결재함</a> 
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="border-top my-3"></li>
                <li class="mb-1">
                    <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#account-collapse" aria-expanded="false">
                        Account
                    </button>
                    <div class="collapse" id="account-collapse">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li><a href="${ contextPath }/member/mypage.page"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">My Page</a>
                            </li>
                            <li><a href="${ contextPath }/notification/list.page"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Notification</a>
                            </li>
                            <li><a href="${ contextPath }/member/logout.do" onclick="closeSocket();" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Sign
                                    out</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>
								
        <div class="b-example-divider b-example-vr"></div>
				<script>
					var alram;
					var chatting;
					var stompClient;
					
					// 내가 현재 열어놓은 채팅방 번호
					// 채팅방을 열지 않았다면 0
					var subRoomNo = 0;
					
					// 수신한 메세지 개수
					var msgCount = 0;
					
					
					
					$(document).ready(function() {
						// 채팅용 웹소켓 연결
						chatting = new SockJS("${contextPath}/chatting");
						stompClient = Stomp.over(chatting);
			    	stompClient.connect({}, function(frame) {
							// 구독 중인 채팅방 목록 조회
					    $.ajax({
					    	url: "${contextPath}/chat/rooms"
					    	, method: "get"
					    	, async: false
					    	, success: function(result) {					    		
					    		// 참여중인 채팅방 구독
					    		for(var i = 0; i < result.length; i++) {
					    			stompClient.subscribe("/topic/chat/room/" + result[i].chatRoomNo, function(msg) {
					    				// 메세지 수신 처리
					    				receiveMsg(msg);
					    			})
					    		}
					    		selectChatRoom();
					    	}
					    	, error: function() {
					    		console.log("채팅방 목록 조회 ajax 통신 실패");
					    	}
					    })
					    
						})
						// 알람용 웹소켓 연결
						alram = new SockJS("${contextPath}/alram");
						// 알람 수신 시 alert 발생
						alram.onmessage = function(evt) {
							const obj = JSON.parse(evt.data);
							alertify.confirm('부서 알림', obj.message, function(){ 
								location.href = "${contextPath}/board/detail.do?category=department&department=" + obj.teamCode + "&condition=&keyword&no=" + obj.boardNo;
								alertify.success('공지사항 페이지로 이동'); }
			                , function(){ alertify.error('Cancel')}).set('labels', {ok:'이동하기', cancel:'취소'});;
						}
					})
					
				</script>
</body>
</html>