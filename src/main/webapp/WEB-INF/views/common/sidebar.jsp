<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />

<!DOCTYPE html>
<html>

<head>
	<script src="${ contextPath }/resources/js/common/color-modes.js"></script>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <meta name="description" content="">
  <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
  <meta name="generator" content="Hugo 0.122.0">
  <title>SideBar</title>

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
  
  <!-- alertify 관련 -->
  <script src="${contextPath}/resources/alertify/js/alertify.min.js"></script>
	<link rel="stylesheet" href="${ contextPath }/resources/alertify/css/alertify.min.css" />
	<link rel="stylesheet" href="${ contextPath }/resources/alertify/css/default.min.css" />

  <!-- 모달 관련 -->
  <script src="${ contextPath }/resources/js/iziModal.min.js"></script>
  <link rel="stylesheet" href="${ contextPath }/resources/css/iziModal.min.css">

  <!-- 체크박스 관련 스타일 -->
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/pretty-checkbox@3.0/dist/pretty-checkbox.min.css">

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

</head>

<body>

    <main class="d-flex flex-nowrap">
        <div class="flex-shrink-0 p-3" style="width: 280px;">
            <a href="/"
                class="d-flex align-items-center pb-3 mb-3 link-body-emphasis text-decoration-none border-bottom">
                <svg class="bi pe-none me-2" width="30" height="24">
                    <use xlink:href="#bootstrap" />
                </svg>
                <span class="fs-5 fw-semibold">회사로고</span>
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
                <li class="mb-1">
                    <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#dashboard-collapse" aria-expanded="false">
                        Dashboard
                    </button>
                    <div class="collapse" id="dashboard-collapse">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Overview</a>
                            </li>
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Weekly</a>
                            </li>
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Monthly</a>
                            </li>
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Annually</a>
                            </li>
                        </ul>
                    </div>
                </li>
                <li class="mb-1">
                    <button class="btn btn-toggle d-inline-flex align-items-center rounded border-0 collapsed"
                        data-bs-toggle="collapse" data-bs-target="#orders-collapse" aria-expanded="false">
                        Orders
                    </button>
                    <div class="collapse" id="orders-collapse">
                        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small">
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">New</a></li>
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Processed</a>
                            </li>
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Shipped</a>
                            </li>
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Returned</a>
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
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">New...</a>
                            </li>
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Profile</a>
                            </li>
                            <li><a href="#"
                                    class="link-body-emphasis d-inline-flex text-decoration-none rounded">Settings</a>
                            </li>
                            <li><a href="#" class="link-body-emphasis d-inline-flex text-decoration-none rounded">Sign
                                    out</a></li>
                        </ul>
                    </div>
                </li>
            </ul>
        </div>

        <div class="b-example-divider b-example-vr"></div>

        <!-- content 추가 -->
        <div class="content">

        </div>
        <!-- content 끝 -->

        <div class="msg_open_btn">
            <i class="fa-solid fa-comment fa-5x"></i>
        </div>
        <div class="msg_close_btn">
            <i class="fa-regular fa-circle-xmark fa-5x"></i>
        </div>

        <!-- Modal structure -->
        <div id="people_list">
            <!-- Modal content -->
            <!-- 스타일에 한해서는 이런식으로 class명을 주시기 바랍니다. -->
            <div class="m_content_style">
                <div class="people_list">
                    <div class="search_bar form-outline" data-mdb-input-init style="margin-top: 15px;">
                        <input type="text" id="form12" class="form-control" />
                        <label class="form-label" for="form12">인물 검색</label>
                    </div>
                    <div class="btn_wrapper">
                        <button type="button" class="btn1 forget_btn">채팅하기</button>
                    </div>
                    <div class="dept_list_wrapper">
                        <div class="d-inline-flex gap-1 dept_list">
                            <button class="btn1 forget_btn dept" type="button" data-bs-toggle="collapse"
                                data-bs-target="#dept1" aria-expanded="false" data-mdb-ripple-init>
                                경리부
                            </button>
                        </div>
                        <div class="collapse multi-collapse" id="dept1">
                            <div class="card card-body team">
                                <button class="btn btn-outline-info team" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#team1" aria-expanded="false" data-mdb-ripple-init>
                                    경리1팀
                                </button>
                            </div>
                            <div class="collapse multi-collapse team_list" id="team1">
                                <ul>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="card card-body team">
                                <button class="btn btn-outline-info team" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#team2" aria-expanded="false" data-mdb-ripple-init>
                                    경리1팀
                                </button>
                            </div>
                            <div class="collapse multi-collapse team_list" id="team2">
                                <ul>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="d-inline-flex gap-1 dept_list">
                            <button class="btn1 forget_btn dept" type="button" data-bs-toggle="collapse"
                                data-bs-target="#dept2" aria-expanded="false" data-mdb-ripple-init>
                                경리부
                            </button>
                        </div>
                        <div class="collapse multi-collapse" id="dept2">
                            <div class="card card-body team">
                                <button class="btn btn-outline-info team" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#team3" aria-expanded="false" data-mdb-ripple-init>
                                    경리1팀
                                </button>
                            </div>
                            <div class="collapse multi-collapse team_list" id="team3">
                                <ul>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="card card-body team">
                                <button class="btn btn-outline-info team" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#team4" aria-expanded="false" data-mdb-ripple-init>
                                    경리1팀
                                </button>
                            </div>
                            <div class="collapse multi-collapse team_list" id="team4">
                                <ul>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="d-inline-flex gap-1 dept_list">
                            <button class="btn1 forget_btn dept" type="button" data-bs-toggle="collapse"
                                data-bs-target="#dept3" aria-expanded="false" data-mdb-ripple-init>
                                경리부
                            </button>
                        </div>
                        <div class="collapse multi-collapse" id="dept3">
                            <div class="card card-body team">
                                <button class="btn btn-outline-info team" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#team5" aria-expanded="false" data-mdb-ripple-init>
                                    경리1팀
                                </button>
                            </div>
                            <div class="collapse multi-collapse team_list" id="team5">
                                <ul>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                            <div class="card card-body team">
                                <button class="btn btn-outline-info team" type="button" data-bs-toggle="collapse"
                                    data-bs-target="#team6" aria-expanded="false" data-mdb-ripple-init>
                                    경리1팀
                                </button>
                            </div>
                            <div class="collapse multi-collapse team_list" id="team6">
                                <ul>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="list-group-item">
                                        <div class="pretty p-icon p-smooth">
                                            <input type="checkbox" />
                                            <div class="state p-success">
                                                <i class="icon fa fa-check"></i>
                                                <label>부장 유재석</label>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
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

        $(".msg_open_btn").on("click", function () {
            animateCSS('.msg_close_btn', 'bounce');
        })

        $(".msg_close_btn").on("click", function () {
            $(".msg_open_btn").css("display", "block");
            $(".msg_close_btn").css("display", "none");
            $(".msgbox").css("display", "none");
        })

        $(".msg_close_btn").on("click", function () {
            animateCSS('.msg_open_btn', 'bounce');
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
    })
    // 1. 해당 아이디의 모달 등록이 필요함
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

    const animateCSS = (element, animation, prefix = 'animate__') =>
        new Promise((resolve, reject) => {
            const animationName = `${prefix}${animation}`;
            const node = document.querySelector(element);

            //node.classList.add(`${prefix}animated`, animationName);

            function handleAnimationEnd(event) {
                event.stopPropagation();
                node.classList.remove(`${prefix}animated`, animationName);
                resolve('Animation ended');
            }

            node.addEventListener('animationend', handleAnimationEnd, { once: true });
        });


</script>

</body>
</html>