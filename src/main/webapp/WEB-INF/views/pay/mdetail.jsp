<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <script src="../assets/js/color-modes.js"></script>

    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.122.0">
    <title>메인페이지</title>

    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/4.1.1/animate.min.css"/>
    <link rel="canonical" href="https://getbootstrap.com/docs/5.3/examples/sidebars/">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/@docsearch/css@3">

    <link href="../../../resources/css/common/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">

    <script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
    <link href="../../../resources/css/common/sidebars.css" rel="stylesheet">
    <script src="../../../resources/js/common/bootstrap.bundle.min.js"></script>
    <script src="../../../resources/js/common/sidebars.js"></script>

    <link href="/src/main/webapp/resources/css/mainPage/mainPage.css" rel="stylesheet">
    
    <!-- 결재신청서 공통스타일 -->
    <link href="/src/main/webapp/resources/css/pay/writer.css" rel="stylesheet">
    
    <style>
        .b-example-divider {
            width: 100%;
            height: 3rem;
            background-color: rgba(0, 0, 0, .1);
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


         /*----- 결재공통 스타일------------*/
      
				
        /*--------------------------------------*/

        .table_middle{
           margin: auto;
           width: 1130px;
           text-align: center;
           height: auto;
           margin-top: 50px;
        }
        .table_middle>table{width: 100%; font-size: 20px;}
        .table_middle tr{height: 40px;}
        .table_middle input{height: 40px; width: 100%;}
        .table_middle textarea{width: 100%; height: 100%; resize: none;}
        .table_middle select{display: flex; justify-content: left;}

        #date_td>input{width: 200px;}

        #plus_btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            background-color: #000000;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        #plus_btn:hover {
            background-color: #696969b4;
        }
        #del_btn {
            display: inline-block;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            background-color: #000000;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
        }

        #del_btn:hover {
            background-color: #696969b4;
        }
        #mid_btn{ width: 1100px; display: flex; align-items: center; justify-content: right;}
        #mid_btn button{margin-left: 20px; margin: 10px;}

        /*-----------------*/
        /*--------버튼 스타일----------*/
        #my-button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 20px;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            background-color: #4683ca;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 100px;
        }

        #my-button:hover {
            background-color: #4684cab9;
        }

        #btn_div{
            padding-top: 40px;
            margin: auto;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        #btn_div button{
            margin: 30px;
        }
        
			 #end_button {
            display: inline-block;
            padding: 10px 20px;
            font-size: 20px;
            font-weight: bold;
            text-align: center;
            text-decoration: none;
            border: none;
            border-radius: 5px;
            background-color: #e42a2a;
            color: white;
            cursor: pointer;
            transition: background-color 0.3s;
            width: 130px;
        }
        #end_button{
            background-color: #e42a2ab0;
        }


        /*----------------------------*/
    </style>


    <!-- Custom styles for this template -->
    <link href="../../resources/css/common/sidebars.css" rel="stylesheet">
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
        <div class="content p-4">
            <!-- 프로필 영역 -->
            <div class="informations">
                <!-- informations left area start -->
                <div class="left_con">
                    <div><h3>매출보고서</h3></div>
                    <form action="">
                        <div id="sign_top">
                            <div id="sign_div_left">
                                <table border="1" id="sign_left">
                                    <tr>
                                        <th>문서번호</th>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <th>부  서</th>
                                        <td>${payDto.department}</td>
                                    </tr>
                                    <tr>
                                        <th>기안일</th>
                                        <td>${payDto.registDt}</td>
                                    </tr>
                                    <tr>
                                        <th>기안자</th>
                                        <td>${payDto.payWriter}</td>
                                    </tr>
                                    <tr>
                                        <th>상태</th>
                                        <td>
                                            ${payDto.payStatus}
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            <div id="signs_s">
                                <table id="sign_table">
                                
                                	<tbody>
                                	 <tr>
                                        <th rowspan="3">승 <br> 인</th>
                                        <td class="left_td">${payDto.firstApproval}</td>
                                        <td class="left_td">${payDto.middleApproval}</td>
                                        <td class="left_td">${payDto.finalApproval}</td>
                                        <th rowspan="3">결 <br> 재</th>
                                        <td class="left_td"></td>
                                    </tr>
                                    <tr>
                                        <td class="sing_name"><div></div></td>
                                        <td class="sing_name"><div></div></td>
                                        <td class="sing_name"><div></div></td>
                                        <td class="sing_name"><div></div></td>
                                    </tr>
                                    <tr>
                                        <td class="left_td">${payDto.firstApproDt == null ? "" : payDto.firstApproDt}</td>
                                        <td class="left_td">${payDto.middleApproDt == null ? "" : payDto.middleApproDt}</td>
                                        <td class="left_td">${payDto.finalApproDt == null ? "" : payDto.finalApproDt}</td>
                                        <td class="left_td">${payDto.registDt}</td>
                                    </tr>
                                	</tbody>   
                                </table>
                            </div>
                        </div>
                        
                        <div class="table_middle">
                            <table border="1">
                                <tr>
                                    <th style="width: 300px;">매출구분</th>
                                    <td colspan="2">
                                        <select name="" id="">
                                            <option value="">상품</option>
                                            <option value="">티켓</option>
                                            <option value="">음식점</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>담당자</th>
                                    <td colspan="2"></td>
                                </tr>
                                <tr>
                                    <th>총매출금액(VAT별도)</th>
                                    <td colspan="2"></td>
                                </tr>
                                <tr>
                                    <th colspan="3">매출정보</th>
                                </tr>
                                <tr>
                                    <th>품목</th>
                                    <th style="width: 100px;">수량</th>
                                    <th>매출금액</th>
                                </tr>
                                
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                </tr>
                            </table>
                        </div>
                        <!--버튼 영역-->
                        <div id="btn_div">
                            <button id="my-button" onclick="submitbtn();" >완료</button>
                            <button id="end_button" onclick="successbtn();">최종승인</button>
                        </div>
                        <!------------>
                    </form>
                </div>
            </div>
        </div>

        <script>
            function submitbtn(){
                let sbtn = confirm('결재을 완료하시겠습니까?');
                if(sbtn == true){
                    alert("결재가 완료되었습니다.");
                }
            }
            
            function successbtn(){
                if(confirm("승인을 최종완료 하시겠습니까?")){
                    alert("최종승인이 완료되었습니다.");
                }
                
            }
 	 	          console.log("${payDto}");        	
           
        </script>
        <!-- content 끝 -->
    </main>
    <script src="../../resources/js/common/bootstrap.bundle.min.js"></script>

    <script src="../../resources/js/common/sidebars.js"></script>

</body>
</html>