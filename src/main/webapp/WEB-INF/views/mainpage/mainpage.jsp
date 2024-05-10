<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.servletContext.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	        <!-- content 추가 -->
        <div class="content p-4">
            
            <!-- main page area start -->
            <div class="main-page">

<!------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------>
                
                <!-- profile area start -->
                <div class="profile">

                    <!-- left -->
                    <div class="left">
                        <img src="../../../resources/images/defaultProfile.png" alt="" id="profileImg">
                    </div>

                    <!-- right start -->
                    <div class="right">

                        <div class="user-name">
                            <b>유가림</b>&nbsp&nbsp<label>(판다월드, 팀장)</label>
                        </div>

                        <div>
                            <table>
                                <tr>
                                    <td><button type="button" class="btn btn-primary btn-sm">근무정보(근무중)</button></td>
                                    <td><button type="button" class="btn btn-secondary btn-sm">휴가(총 30일)</button></td>
                                    <td><button type="button" class="btn btn-warning btn-sm">업무정보</button></td>
                                </tr>
                                <tr>
                                    <td>출근 - 13:23</td>
                                    <td>사용 - 5일</td>
                                    <td>오늘의 일정 - 5건</td>
                                </tr>
                                <tr>
                                    <td>퇴근 - 13:23</td>
                                    <td>잔여 - 30일</td>
                                </tr>
                            </table>
                        </div>

                    </div>
                    <!-- right end -->

                </div>
                <!-- profile area end -->

<!----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------->

                <!-- calendar & list area start -->
                <div class="informations">
                    <!-- informations left area start -->
                    <div class="left">
                        <div class="calendar">

                            <!-- year & month -->
                            <div class="year-month">
                                <!-- 캘린더 api 연동할꺼임 -->
                            </div>

                            <!-- calendar -->
                            <div class="calendar-table">
                            
                            </div>

                            <!-- calendar schedule list -->
                            <div class="schedule">
                                
                            </div>

                        </div>
                    </div>
                    <!-- informations left area end -->

<!------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------>

                    <!-- list area start (right) -->
                    <div class="right">
                        <!-- list area top start -->
                        <div class="top">
                            <!-- notice start -->
                            <div class="notice">
                                <table class="table">
                                    <tr>
                                        <th>
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-clipboard-check" viewBox="0 0 16 16">
                                                <path fill-rule="evenodd" d="M10.854 7.146a.5.5 0 0 1 0 .708l-3 3a.5.5 0 0 1-.708 0l-1.5-1.5a.5.5 0 1 1 .708-.708L7.5 9.793l2.646-2.647a.5.5 0 0 1 .708 0"/>
                                                <path d="M4 1.5H3a2 2 0 0 0-2 2V14a2 2 0 0 0 2 2h10a2 2 0 0 0 2-2V3.5a2 2 0 0 0-2-2h-1v1h1a1 1 0 0 1 1 1V14a1 1 0 0 1-1 1H3a1 1 0 0 1-1-1V3.5a1 1 0 0 1 1-1h1z"/>
                                                <path d="M9.5 1a.5.5 0 0 1 .5.5v1a.5.5 0 0 1-.5.5h-3a.5.5 0 0 1-.5-.5v-1a.5.5 0 0 1 .5-.5zm-3-1A1.5 1.5 0 0 0 5 1.5v1A1.5 1.5 0 0 0 6.5 4h3A1.5 1.5 0 0 0 11 2.5v-1A1.5 1.5 0 0 0 9.5 0z"/>
                                            </svg>
                                            공지사항
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                                            </svg>
                                        </th>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>공지사항 제목</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일 작성자</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>공지사항 제목</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일 작성자</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>공지사항 제목</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일 작성자</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>공지사항 제목</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일 작성자</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>공지사항 제목</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일 작성자</sapn>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <!-- notice end -->

                            <!-- edsm start -->
                            <div class="edsm">
                                <table class="table">
                                    <tr>
                                        <th>
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-inbox" viewBox="0 0 16 16">
                                                <path d="M4.98 4a.5.5 0 0 0-.39.188L1.54 8H6a.5.5 0 0 1 .5.5 1.5 1.5 0 1 0 3 0A.5.5 0 0 1 10 8h4.46l-3.05-3.812A.5.5 0 0 0 11.02 4zm9.954 5H10.45a2.5 2.5 0 0 1-4.9 0H1.066l.32 2.562a.5.5 0 0 0 .497.438h12.234a.5.5 0 0 0 .496-.438zM3.809 3.563A1.5 1.5 0 0 1 4.981 3h6.038a1.5 1.5 0 0 1 1.172.563l3.7 4.625a.5.5 0 0 1 .105.374l-.39 3.124A1.5 1.5 0 0 1 14.117 13H1.883a1.5 1.5 0 0 1-1.489-1.314l-.39-3.124a.5.5 0 0 1 .106-.374z"/>
                                            </svg>
                                            전자결재
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                                            </svg>
                                        </th>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>전자결재 제목</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>전자결재 제목</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>전자결재 제목</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>전자결재 제목</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>전자결재 제목</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일</sapn>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <!-- edsm end -->
                        </div>
                        <!-- list area top end -->

                        <!-- list area bottom start -->
                        <div class="bottom">

                            <!-- notification area start -->
                            <div class="notification">
                                <table class="table">
                                    <tr>
                                        <th>
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-bell" viewBox="0 0 16 16">
                                                <path d="M8 16a2 2 0 0 0 2-2H6a2 2 0 0 0 2 2M8 1.918l-.797.161A4 4 0 0 0 4 6c0 .628-.134 2.197-.459 3.742-.16.767-.376 1.566-.663 2.258h10.244c-.287-.692-.502-1.49-.663-2.258C12.134 8.197 12 6.628 12 6a4 4 0 0 0-3.203-3.92zM14.22 12c.223.447.481.801.78 1H1c.299-.199.557-.553.78-1C2.68 10.2 3 6.88 3 6c0-2.42 1.72-4.44 4.005-4.901a1 1 0 1 1 1.99 0A5 5 0 0 1 13 6c0 .88.32 4.2 1.22 6"/>
                                            </svg>
                                            알림
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                                            </svg>
                                        </th>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>알림내용</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일 작성자</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>알림내용</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일 작성자</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>알림내용</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일 작성자</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>알림내용</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일 작성자</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>알림내용</b><br>
                                            <sapn class="regist-date-writer">oooo년 oo월 oo일 작성자</sapn>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <!-- notification area end -->

                            <!-- chat area start -->
                            <div class="chat">
                                <table class="table">
                                    <tr>
                                        <th>
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chat-dots" viewBox="0 0 16 16">
                                                <path d="M5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0m4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0m3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2"/>
                                                <path d="m2.165 15.803.02-.004c1.83-.363 2.948-.842 3.468-1.105A9 9 0 0 0 8 15c4.418 0 8-3.134 8-7s-3.582-7-8-7-8 3.134-8 7c0 1.76.743 3.37 1.97 4.6a10.4 10.4 0 0 1-.524 2.318l-.003.011a11 11 0 0 1-.244.637c-.079.186.074.394.273.362a22 22 0 0 0 .693-.125m.8-3.108a1 1 0 0 0-.287-.801C1.618 10.83 1 9.468 1 8c0-3.192 3.004-6 7-6s7 2.808 7 6-3.004 6-7 6a8 8 0 0 1-2.088-.272 1 1 0 0 0-.711.074c-.387.196-1.24.57-2.634.893a11 11 0 0 0 .398-2"/>
                                            </svg>
                                            채팅
                                            <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-plus" viewBox="0 0 16 16">
                                                <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
                                            </svg>
                                        </th>
                                    </tr>
                                    <tr>
                                        <td>
                                            <span class="chat-profile">
                                                <img src="../../../resources/images/logo.png" alt="">
                                            </span>
                                            <b>채팅방이름</b><br>
                                            <sapn class="chatting-preview">최근 채팅내용~~~~~</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>공지사항 제목</b><br>
                                            <sapn class="chatting-preview">최근 채팅내용~~~~~</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>공지사항 제목</b><br>
                                            <sapn class="chatting-preview">최근 채팅내용~~~~~</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>공지사항 제목</b><br>
                                            <sapn class="chatting-preview">최근 채팅내용~~~~~</sapn>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <b>공지사항 제목</b><br>
                                            <sapn class="chatting-preview">최근 채팅내용~~~~~</sapn>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <!-- chat area end -->

                        </div>
                        <!-- list area bottom end -->
            
                    </div>
                    <!-- list area end (right)-->

                </div>
                <!-- calendar & list area end -->

            </div>
            <!-- main page area end -->

        </div>
        <!-- content 끝 -->
	<jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
</body>
</html>