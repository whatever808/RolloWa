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

    <link href="${contextPath}/resources/css/mainPage/mainPage.css" rel="stylesheet">

    <!-- 모달 관련 -->
    <script src="${contextPath}/resources/js/iziModal.min.js"></script>
    <link rel="stylesheet" href="${contextPath}/resources/css/iziModal.min.css">

    <!-- 결재신청서 공통스타일 -->
    <link href="${contextPath}/resources/css/pay/writer.css" rel="stylesheet">
    
    
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
                    <div><h3>매출 보고서</h3></div>
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
                                        <td>운영팀</td>
                                    </tr>
                                    <tr>
                                        <th>기안일</th>
                                        <td><input type="date"></td>
                                    </tr>
                                    <tr>
                                        <th>기안자</th>
                                        <td>홍길동</td>
                                    </tr>
                                    <tr>
                                        <th>상태</th>
                                        <td>
                                            <select name="" id="">
                                                <option value="">보통</option>
                                                <option value="">긴급</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                           

                            <div>
                                <table id="sign_table">
                                    <tr style="border: 1px solid white">
                                        <button data-izimodal-open="#modal" id="modal_btn">결&nbsp;&nbsp;재&nbsp;&nbsp;승&nbsp;&nbsp;인</button>
                                        
                                            <div id="modal">
                                                <!-- Modal content -->
                                                <!-- 스타일에 한해서는 이런식으로 class명을 주시기 바랍니다. -->
                                                <div class="m_content_style">
                                                    <div id="m_co_top">
                                                        <div id="m_co1">
                                                                <button class="atag">영업</button>
                                                                <ul>
                                                                    <button class="btn_result">과장-홍길동</button><br>
                                                                    <button class="btn_result">과장-김말순</button><br>
                                                                    <button class="btn_result">과장-홍길동</button><br>
                                                                    <button class="btn_result">과장-김말순</button><br>
                                                                    <button class="btn_result">과장-김말순</button><br>
                                                                </ul>
                                                                <button class="atag">홍보</button>
                                                                <ul>
                                                                    <button class="btn_result">과장-홍길동</button><br>
                                                                    <button class="btn_result">과장-김말순</button><br>
                                                                    <button class="btn_result">과장-홍길동</button><br>
                                                                    <button class="btn_result">과장-김말순</button><br>
                                                                    <button class="btn_result">과장-김말순</button><br>
                                                                </ul>
                                                                <button class="atag">경영</button>
                                                                <ul>
                                                                    <button class="btn_result">과장-홍길동</button><br>
                                                                    <button class="btn_result">과장-김말순</button><br>
                                                                    <button class="btn_result">과장-홍길동</button><br>
                                                                    <button class="btn_result">과장-김말순</button><br>
                                                                    <button class="btn_result">과장-김말순</button><br>
                                                                </ul>
                                                        </div>
                                                        <div>
                                                            <svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" class="bi bi-chevron-double-right" viewBox="0 0 16 16" style="margin: 20px;">
                                                                <path fill-rule="evenodd" d="M3.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L9.293 8 3.646 2.354a.5.5 0 0 1 0-.708"/>
                                                                <path fill-rule="evenodd" d="M7.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L13.293 8 7.646 2.354a.5.5 0 0 1 0-.708"/>
                                                            </svg>
                                                        </div>
                                                        <div id="m_co2"></div>
                                                        <div id="reset_div">
                                                            <div>
                                                                
                                                            </div>
                                                            <div>
                                                                <button id="reset_button">
                                                                    <svg xmlns="http://www.w3.org/2000/svg" width="25" height="25" fill="currentColor" class="bi bi-dash-circle-fill" viewBox="0 0 16 16">
                                                                        <path d="M16 8A8 8 0 1 1 0 8a8 8 0 0 1 16 0M4.5 7.5a.5.5 0 0 0 0 1h7a.5.5 0 0 0 0-1z"/>
                                                                    </svg>
                                                                </button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            
                                            
                                        </th>
                                    </tr>
                                    <tr id="tr_name">
                                        <th rowspan="3">승 <br> 인</th>
                                        <td id="f_name"></td>
                                        <td id="m_name"></td>
                                        <td id="l_name"></td>
                                        <th rowspan="3">결 <br> 재</th>
                                        <td></td>
                                    </tr>
                                    <tr>
                                        <td class="sing_name"><div>싸인</div></td>
                                        <td class="sing_name">
                                            <div>
                                            </div>
                                        </td>
                                        <td class="sing_name">
                                            <div>
                                            </div>
                                        </td>
                                        <td class="sing_name" id="div_modal">
                                            <div>
                                                
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>김사원승인일자</td>
                                        <td>박부장승인일자</td>
                                        <td>최사장승인일자</td>
                                        <td>결재일자</td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                        <div id="mid_btn">
                            <button id="plus_btn" type="button">추가</button>
                            <button id="del_btn" type="button">삭제</button>
                        </div>
                        <div class="table_middle">
	                         <input type="hidden" name="firstApproval" id="first_name">
	                         <input type="hidden" name="middleApproval" id="middle_name">
	                         <input type="hidden" name="finalApproval" id="last_name">   
                            <table border="1" id="tr_table">
                                <tr>
                                    <th>매출구분</th>
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
                                    <td colspan="2"><input type="text"></td>
                                </tr>
                                <tr>
                                    <th>총매출금액(VAT별도)</th>
                                    <td colspan="2"><input type="text"></td>
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
                                    <td><input type="text" class="item" name='item'></td>
                                    <td><input type="number" class="count" min="0" name='count'></td>
                                    <td><input type="text" class="sales_amount" name='sales_amount'></td>
                                </tr>
                                <tr>
                                    <td><input type="text" class="item" name='item'></td>
                                    <td><input type="number" class="count" min="0" name='count'></td>
                                    <td><input type="text" class="sales_amount" name='sales_amount'></td>
                                </tr>
                                <tr>
                                    <td><input type="text" class="item" name='item'></td>
                                    <td><input type="number" class="count" min="0" name='count'></td>
                                    <td><input type="text" class="sales_amount" name='sales_amount'></td>
                                </tr>
                                <tr id="tr_input">
                                    <td><input type="text" class="item" name='item'></td>
                                    <td><input type="number" class="count" min="0" name='count'></td>
                                    <td><input type="text" class="sales_amount" name='sales_amount'></td>
                                </tr>
                            </table>
                        </div>
                        <!--버튼 영역-->
                        <div id="btn_div">
                            <button type="button" class="btn btn-primary" onclick="submitbtn();">제출</button>
                            <button type="button" class="btn btn-warning" onclick="alert('저장이 완료되었습니다.');">저장</button>
                            <button type="reset" class="btn btn-danger" id="reset_btn">초기화</button>
                            <input type="hidden" name="items" id="itemid">
                        </div>
                        <!------------>
                    </form>
                </div>
            </div>
        </div>
        
        <!-- 추가버튼 스크립트 -->
        <script>
        $(document).ready(function(){
        	
        	$(document).on("click", "#plus_btn", function () {
				
		          var result = "<tr>"
				          result += "<td><input type='text' class='item' name='item'></td>";
				          result += "<td><input type='number' class='count' min='0' name='count'></td>";
				          result += "<td><input type='text' class='sales_amount' name='sales_amount'></td>";
				          result += "</tr>";
		          
				       $("#tr_table").children().last().after(result);
		         
		      });
        	
        	
        	$(document).on("click", "#del_btn", function () {
        	    //$("#tr_table tr:last-child").remove();
        	    $("#tr_table").children("tr").last().remove();
        	});
		      
        	
        })
		      
		
		      
		     
		      
        
        </script>
        
    
       
         <script>
         
            function submitbtn(){
                let sbtn = confirm('정말로 제출하시겠습니까?');
                if(sbtn == true){
                    alert("제출이 완료되었습니다.");
                    
                    /*
                   //품목
                  let arr = []; 
                  $(".item").each(function(){
                        let item = $(this).val().trim(); // 각 요소의 값 가져오기
                        
                        // 값이 비어있지 않으면 배열에 추가
                        if(item !== ""){
                            arr.push(item);
                        }
                    });
                  
                    $("input[type='hidden'][name='item']").val(arr);
                    
                    
                    let arr = [];
                    
                    $(".item").each(function(){
                          let item = $(this).val().trim(); // 각 요소의 값 가져오기
                          
                          // 값이 비어있지 않으면 배열에 추가
                          if(item !== ""){
                              arr.push(item);
                          }
                      });
                    
                      $("input[type='hidden'][name='item']").val(arr);
                      
                      let arr = [];
                      
                      $(".item").each(function(){
                            let item = $(this).val().trim(); // 각 요소의 값 가져오기
                            
                            // 값이 비어있지 않으면 배열에 추가
                            if(item !== ""){
                                arr.push(item);
                            }
                        });
                      
                        $("input[type='hidden'][name='item']").val(arr);
                	*/
             
                	}
            }
               
            $("#reset_btn").click(function(){
                if(confirm("정말로 초기화 하시겠습니까?") == true){
                    return;
                }else{
                    return false;
                }
            })

            $(document).ready(function(){
                $(".atag").click(function(){

                const $p = $(this).next();
                console.log($p);

                if($p.css("display") == "none"){

                    $(this).siblings("ul").slideUp();

                    $p.slideDown();
                }else{
                    $p.slideUp();
                } 
                })

            })
            
            
             <!-- 모달 출력 스크립트 -->
            $(document).on("click", "#reset_button", function(){

                if($("#m_co2").children().length >= 1){
                    if(confirm("초기화 하시겠습니까?")){
                        $("#m_co2").children().remove();
                        $("#f_name").text("");
                        $("#m_name").text("");
                        $("#l_name").text("");
                    }
                }else{
                    alert("초기화할 승인자가 없습니다.");
                }
                
                    
            })

       	 	 $(document).on("click", ".btn_result", function(){
                
                let div = document.createElement("div");
                div.className = "success";
                $("#m_co2").append(div);
                div.append($(this).text());
                
                //map => 객체생성 클릭한 요소의 text값을 map안에 차곡차곡 return해서 담고 .get() 배열로 얻어낸다.
                const childrenTextArray = $("#m_co2").children().map(function() {
                    return $(this).text();
                }).get();
                
            
                if($("#m_co2").children().length == 1){
                    alert("1차 승인자로 선택하였습니다.");
                    $("#f_name").append(childrenTextArray[0]);
                    $("#first_name").val($(this).text().substring($(this).text().indexOf("-") + 1));
                    $("#firstb").val($(this).parent().prev().text());
                    $("#m_co2").children().eq(0).prepend("<b>1차</b><br><" + $(this).parent().prev().text() + ">");
                }else if($("#m_co2").children().length == 2){
                    alert("2차 승인자로 선택하였습니다.");
                    $("#m_name").append(childrenTextArray[1]);
                    $("#middle_name").val($(this).text().substring($(this).text().indexOf("-") + 1));
                    $("#middleb").val($(this).parent().prev().text());
                    $("#m_co2").children().eq(1).prepend("<b>2차</b><br><" + $(this).parent().prev().text() + ">");


                    /*
                    let duplicateFound = false;
                    for (let i = 0; i < childrenTextArray.length; i++) {
                        if ($(".btn_result").children().text() === childrenTextArray[i]) {
                            duplicateFound = true;
                            alert("중복된 승인자가 존재합니다.");
                            break; // 중복이 발견되면 루프를 중단합니다.
                        }
                    }
                    if (!duplicateFound) {
                        alert("2차 승인자로 선택하였습니다.");
                        $("#f_name").append(childrenTextArray[0]);
                    }
                    */
                   
                }else if($("#m_co2").children().length == 3){
                    alert("3차 승인자로 선택하였습니다.");
                    $("#l_name").append(childrenTextArray[2]);
                    $("#last_name").val($(this).text().substring($(this).text().indexOf("-") + 1));
                    $("#lastb").val($(this).parent().prev().text());
                    $("#m_co2").children().eq(2).prepend("<b>3차</b><br><" + $(this).parent().prev().text() + ">");
                }else if($("#m_co2").children().length >= 4){
                    alert("더이상 승인자를 선택할 수 없습니다.");
                    $("#m_co2").children().eq(3).remove();
                  
                }

                 
          })
        </script>
        
         <script>
            $('#modal').iziModal({
                title: '결재선지정',
                //subtitle: '수정도 가능합니다.',
                headerColor: '#FEEFAD', // 헤더 색깔
                theme: '', //Theme of the modal, can be empty or "light".
                padding: '15px', // content안의 padding
                //radius: 10, // 모달 외각의 선 둥글기
                group: 'name111',
                loop: true,
                arrowKeys: true,
                navigateCaption: true,
                navigateArrows: true,
                zindex: 300, // zindex 모달의 화면 우선 순위 입니다. 
                focusInput: true, // 가장 맨 위에 보이게 해주는 속성값
                restoreDefaultContent: false
            });

            $('#modal-iframe').iziModal({
                iframe: true,
                iframeURL: 'https://www.youtube.com/watch?v=tPDGlPqhzIc'
            })

            // 2. 요소에 이벤트가 일어 났을떄 모달이 작동
            $("#modal-test").on('click', function () {
                //event.preventDefault(); //위의 클릭 이벤트가 일어나는 동안 다른 이벤트가 발생하지 않도록해주는 명령어

                $('#modal').iziModal('open');
            });
        </script>
        
        
        
    </main>
    <script src="../../resources/js/common/bootstrap.bundle.min.js"></script>

    <script src="../../resources/js/common/sidebars.js"></script>

</body>
</html>