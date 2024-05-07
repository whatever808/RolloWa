<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <c:set var="contextPath" value="${ pageContext.request.contextPath }" />
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <title>메인페이지</title>
            <!-- animate -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css" />

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

            <!-- jQuery -->
            <script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>

            <!-- 모달 관련 -->
            <script src="${ contextPath }/resources/js/iziModal.min.js"></script>
            <link rel="stylesheet" href="${ contextPath }/resources/css/iziModal.min.css">

            <!-- 체크박스 관련 스타일 -->
            <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretty-checkbox@3.0/dist/pretty-checkbox.min.css">

				    <!-- css -->
				    <!-- <link href="/resources/css/common/sidebars.css" rel="stylesheet"> -->
				    <link rel="stylesheet" href="${ contextPath }/resources/css/common.css">
				    <link rel="stylesheet" href="${ contextPath }/resources/css/common/mdb.min.css" />
				    <link href="${ contextPath }/resources/css/login.css" rel="stylesheet">
				    <script src="${ contextPath }/resources/js/login.js"></script>
        </head>

        <body id="particles-js"></body>
        <div class="animated bounceInDown">
            <div class="container">
                <span class="error animated tada" id="msg"></span>
                <form name="form1" class="box" onsubmit="return checkStuff()">
                    <h4>회사 이름</h4>
                    <h5>Sign in to your account.</h5>
                    <input type="text" name="email" placeholder="user id" autocomplete="off">
                    <i class="typcn typcn-eye" id="eye"></i>
                    <input type="password" name="password" placeholder="Passsword" id="pwd" autocomplete="off">
                    <!-- <label>
                <input type="checkbox">
                <span></span>
                <small class="rmb">Remember me</small>
            </label> -->
                    <div class="forget_wrapper">
                        <a href="#" class="" data-izimodal-open="#forget_id" style="margin-right: 10px">
                            <h6>아이디 찾기</h6>
                        </a>
                        <a href="#" class="" data-izimodal-open="#forget_pwd" style="margin-left: 10px;">
                            <h6>비밀번호 찾기</h6>
                        </a>
                    </div>
                    <input type="submit" value="Sign in" class="btn1">
                </form>
                <!--<a href="#" class="dnthave">Don’t have an account? Sign up</a>-->
            </div>
            <!-- 아이디 찾기 modal -->
            <div id="forget_id" class="modal_frame">
                <!-- Modal content -->
                <!-- 스타일에 한해서는 이런식으로 class명을 주시기 바랍니다. -->
                <div class="m_content_style">
                    <form action="">
                        사번 : <input type="text"> <br>
                        <div class="btn_wrapper">
                            <input type="submit" value="제출" class="btn1 forget_btn">
                        </div>
                    </form>
                </div>
            </div>
            <!-- 비밀번호 찾기 modal -->
            <div id="forget_pwd" class="modal_frame">
                <!-- Modal content -->
                <!-- 스타일에 한해서는 이런식으로 class명을 주시기 바랍니다. -->
                <div class="m_content_style">
                    <form action="">
                        아이디 : <input type="text" name=""> <br>
                        전화번호 : <input type="text" name="" placeholder="01012345678"> <br>
                        <div class="btn_wrapper">
                            <button type="button" class="btn1 forget_btn">휴대폰인증</button>
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script>
            // 1. 해당 아이디의 모달 등록이 필요함
            $('#forget_id').iziModal({
                title: '<h6>아이디 찾기</h6>',
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
            // 1. 해당 아이디의 모달 등록이 필요함
            $('#forget_pwd').iziModal({
                title: '<h6>비밀번호 찾기</h6>',
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

        </script>

        </html>