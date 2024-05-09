<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 
 		<!-- 사인관련 스크립트 -->
		<script src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/signature_pad/1.5.3/signature_pad.min.js"></script>
		<!-- ------------ -->
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
    
    /*-----사인 스타일-----*/
    #signature { border:1px solid #000; }
		#save, #clear { padding:5px 20px; border:0; color:#fff; background:#000; margin-top:5px; }
		
</style>

</head>
<body>


<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
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
                                        <button data-izimodal-open="#modal" id="modal_btn"><h4>결&nbsp;&nbsp;재&nbsp;&nbsp;승&nbsp;&nbsp;인</h4></button>
                                        
                                            <div id="modal">
                                                <!-- Modal content -->
                                                <!-- 스타일에 한해서는 이런식으로 class명을 주시기 바랍니다. -->
                                                <div class="m_content_style">
                                                    <div id="m_co_top">
                                                        <div id="m_co1">
                                                                <button class="atag">총무부</button>
                                                                <ul>
                                                                	 <c:forEach var="l" items="${maDeptList}">
       																															 <button class="btn_result">${l.teamName}(${l.positionName}) ▶${l.userName}</button><br>
    																															 </c:forEach>
                                                                </ul>
                                                                
                                                                <button class="atag">운영부</button>
                                                                <ul>
                                                                	<c:forEach var="l" items="${operatDeptList}">
                                                                    <button class="btn_result">${l.teamName}(${l.positionName}) ▶${l.userName}</button><br>
                                                                	</c:forEach>
                                                                </ul>
                                                                <button class="atag">마케팅부</button>
                                                                <ul>
                                                                	<c:forEach var="l" items="${marketDeptList}">
                                                                    <button class="btn_result">${l.teamName}(${l.positionName}) ▶${l.userName}</button><br>
                                                                	</c:forEach>
                                                                </ul>
                                                                <button class="atag">FB</button>
                                                                <ul>
                                                                  <c:forEach var="l" items="${fbDeptList}">
                                                                    <button class="btn_result">${l.teamName}(${l.positionName}) ▶${l.userName}</button><br>
                                                                	</c:forEach>
                                                                </ul>
                                                                <button class="atag">인사부</button>
                                                                <ul>
                                                                    <c:forEach var="l" items="${hrDeptList}">
                                                                   		<button class="btn_result">${l.teamName}(${l.positionName}) ▶${l.userName}</button><br>
                                                                		</c:forEach>
                                                                </ul>
                                                                <button class="atag">서비스부</button>
                                                                <ul>
                                                                    <c:forEach var="l" items="${serviceDeptList}">
                                                                   		<button class="btn_result">${l.teamName}(${l.positionName}) ▶${l.userName}</button><br>
                                                                		</c:forEach>
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
                                               <a href="#" data-izimodal-open="#modal2">Sign</a>
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
                        <div>
                        
                        
                        <div id="modal2">
										        <!-- Modal content -->
										        <!-- 스타일에 한해서는 이런식으로 class명을 주시기 바랍니다. -->
										        <div class="m_content_style">
														    <div id="signature-container">
															    <canvas id="signature-pad" width="500" height="150"  style="z-index: 1000px"></canvas>
															    <button id="clear-button">지우기</button>
															    <button id="undo-button">되돌리기</button>
															    <button id="save-button">서명 저장</button>
															</div>
														
										        </div>
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
                    $("#f_name").append(childrenTextArray[0].substring($(this).text().indexOf("▶") + 1));
                    $("#first_name").val($(this).text().substring($(this).text().indexOf("▶") + 1));
                    $("#firstb").val($(this).parent().prev().text());
                    $("#m_co2").children().eq(0).prepend("<b>1차</b><br>○" + $(this).parent().prev().text() + "○<br>");
                }else if($("#m_co2").children().length == 2){
                    alert("2차 승인자로 선택하였습니다.");
                    $("#m_name").append(childrenTextArray[1].substring($(this).text().indexOf("▶") + 1));
                    $("#middle_name").val($(this).text().substring($(this).text().indexOf("▶") + 1));
                    $("#middleb").val($(this).parent().prev().text());
                    $("#m_co2").children().eq(1).prepend("<b>2차</b><br>○" + $(this).parent().prev().text() + "○<br>");


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
                    $("#l_name").append(childrenTextArray[2].substring($(this).text().indexOf("▶") + 1));
                    $("#last_name").val($(this).text().substring($(this).text().indexOf("▶") + 1));
                    $("#lastb").val($(this).parent().prev().text());
                    $("#m_co2").children().eq(2).prepend("<b>3차</b><br>○" + $(this).parent().prev().text() + "○<br>");
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
                width: '1000px',
               
            });

            // 2. 요소에 이벤트가 일어 났을떄 모달이 작동
            $("#modal-test").on('click', function () {
                //event.preventDefault(); //위의 클릭 이벤트가 일어나는 동안 다른 이벤트가 발생하지 않도록해주는 명령어

                $('#modal').iziModal('open');
            });
            
            
        </script>
        
        <script>
        


        User
        반려사유 4개만 작성해줘
        ChatGPT
        물론이죠. 여러분의 반려사유에는 무엇이 있을까요?

        User
        결재가 반려된사유 예시 4개만
        ChatGPT
        결재 요청서에 필요한 정보가 부족하여 처리할 수 없음.
        예산 초과로 인해 결재가 반려됨.
        결재 규정에 위반되어 반려 처리됨.
        결재 권한을 갖지 않은 사용자로 인해 반려됨.
        User
        배우이름 30개만 알려줘
        ChatGPT
        물론이죠. 다음은 30명의 배우 이름입니다:

        레오나르도 디카프리오
        메릴 스트립
        데니스 베이더
        브래드 피트
        앤 해서웨이
        조니 뎁
        케이트 블란쳇
        톰 행크스
        줄리아 로버츠
        라이언 고슬링
        캐서린 제타 존스
        레이첼 맥아담스
        조지 클루니
        사카리아 리비
        나탈리 포트만
        로다박
        윌 스미스
        케이트 윈슬렛
        라이언 레이놀즈
        애쉬턴 커처
        엠마 스톤
        클린트 이스트우드
        샬리즈 테론
        콜린 퍼스
        케이트 허드슨
        제니퍼 로렌스
        조나 힐
        샘 윈체스터
        앤디 서키스
        제이슨 스타
        User
        한국배우이름으로
        ChatGPT
        알겠어요. 한국 배우들의 이름 중에서 30개를 알려드릴게요:

        송강호
        이병헌
        김혜수
        하정우
        전지현
        이정재
        김래원
        전혜진
        손예진
        곽도원
        김남길
        김고은
        정우성
        김윤석
        박보영
        이성민
        김희애
        하지원
        조인성
        김소현
        박서준
        고아라
        최민식
        이민호
        김태리
        이동휘
        이제훈
        김새론
        유아인
        문채원
        User
        String.equals(Object)" because "documentType" is null
        ChatGPT
        이 에러는 "documentType"이 null인 상태에서 "String.equals(Object)" 메소드가 호출되었기 때문에 발생합니다.

        "String.equals(Object)" 메소드는 객체를 비교하는데 사용됩니다. 하지만 "documentType"이 null이라면 해당 메소드를 호출할 수 없습니다. null 값을 비교하려고 하면 NullPointerException이 발생합니다.

        해결하기 위해선, "documentType"이 null인지 확인한 후에 equals 메소드를 호출하는 것이 좋습니다. 다음과 같이 코드를 작성할 수 있습니다:

        java
        코드 복사
        if (documentType != null && documentType.equals("yourComparisonValue")) {
            // 비교 로직
        }
        이렇게 하면 "documentType"이 null이 아닌 경우에만 equals 메소드가 호출되어 NullPointerException을 방지할 수 있습니다.

        User
        the server si not running in debug mode. select from one of the following options 해석해줘
        ChatGPT
        이 문장은 "서버가 디버그 모드에서 실행되고 있지 않습니다. 다음 중 하나의 옵션을 선택하세요." 라고 해석됩니다.

        User
        DEBUG: [13:57:17] [PayController:296] - list : [MemberDeptDto(userNo=1050, userName=유재석, teamCode=A, positionCode=E, teamName=경영지원팀, positionName=부장, deptName=총무부), MemberDeptDto(userNo=1051, userName=박명수, teamCode=A, positionCode=D, teamName=경영지원팀, positionName=차장, deptName=총무부), MemberDeptDto(userNo=1052, userName=정준하, teamCode=A, positionCode=C, teamName=경영지원팀, positionName=과장, deptName=총무부), MemberDeptDto(userNo=1055, userName=제니, teamCode=B, positionCode=E, teamName=어트랙션 운영팀, positionName=부장, deptName=운영부), MemberDeptDto(userNo=1056, userName=리사, teamCode=B, positionCode=D, teamName=어트랙션 운영팀, positionName=차장, deptName=운영부), MemberDeptDto(userNo=1057, userName=로제, teamCode=B, positionCode=C, teamName=어트랙션 운영팀, positionName=과장, deptName=운영부), MemberDeptDto(userNo=1060, userName=랩몬, teamCode=C, positionCode=E, teamName=시설 유지보수팀, positionName=부장, deptName=운영부), MemberDeptDto(userNo=1061, userName=슈가, teamCode=C, positionCode=D, teamName=시설 유지보수팀, positionName=차장, deptName=운영부), MemberDeptDto(userNo=1062, userName=정국, teamCode=C, positionCode=C, teamName=시설 유지보수팀, positionName=과장, deptName=운영부), MemberDeptDto(userNo=1065, userName=김채원, teamCode=D, positionCode=E, teamName=안전 및 보안팀, positionName=부장, deptName=운영부), MemberDeptDto(userNo=1066, userName=사쿠라, teamCode=D, positionCode=D, teamName=안전 및 보안팀, positionName=차장, deptName=운영부), MemberDeptDto(userNo=1067, userName=허윤진, teamCode=D, positionCode=C, teamName=안전 및 보안팀, positionName=과장, deptName=운영부), MemberDeptDto(userNo=1070, userName=키드밀리, teamCode=E, positionCode=E, teamName=이벤트 기획팀, positionName=부장, deptName=마케팅부), MemberDeptDto(userNo=1071, userName=곽준빈, teamCode=E, positionCode=D, teamName=이벤트 기획팀, positionName=차장, deptName=마케팅부), MemberDeptDto(userNo=1072, userName=빠니보틀, teamCode=E, positionCode=C, teamName=이벤트 기획팀, positionName=과장, deptName=마케팅부), MemberDeptDto(userNo=1075, userName=주우재, teamCode=F, positionCode=E, teamName=디지털 마케팅팀, positionName=부장, deptName=마케팅부), MemberDeptDto(userNo=1076, userName=전현무, teamCode=F, positionCode=D, teamName=디지털 마케팅팀, positionName=차장, deptName=마케팅부), MemberDeptDto(userNo=1077, userName=박나래, teamCode=F, positionCode=C, teamName=디지털 마케팅팀, positionName=과장, deptName=마케팅부), MemberDeptDto(userNo=1080, userName=고든램지, teamCode=G, positionCode=E, teamName=음식점 운영팀, positionName=부장, deptName=FB), MemberDeptDto(userNo=1081, userName=최현석, teamCode=G, positionCode=D, teamName=음식점 운영팀, positionName=차장, deptName=FB), MemberDeptDto(userNo=1082, userName=이연복, teamCode=G, positionCode=C, teamName=음식점 운영팀, positionName=과장, deptName=FB), MemberDeptDto(userNo=1085, userName=슬기, teamCode=H, positionCode=E, teamName=채용팀, positionName=부장, deptName=인사부), MemberDeptDto(userNo=1086, userName=예리, teamCode=H, positionCode=D, teamName=채용팀, positionName=차장, deptName=인사부), MemberDeptDto(userNo=1087, userName=아이린, teamCode=H, positionCode=C, teamName=채용팀, positionName=과장, deptName=인사부), MemberDeptDto(userNo=1090, userName=지석진, teamCode=I, positionCode=E, teamName=교육팀, positionName=부장, deptName=인사부), MemberDeptDto(userNo=1091, userName=김종국, teamCode=I, positionCode=D, teamName=교육팀, positionName=차장, deptName=인사부), MemberDeptDto(userNo=1092, userName=송지효, teamCode=I, positionCode=C, teamName=교육팀, positionName=과장, deptName=인사부), MemberDeptDto(userNo=1095, userName=탁재훈, teamCode=J, positionCode=E, teamName=고객문의팀, positionName=부장, deptName=서비스부), MemberDeptDto(userNo=1096, userName=신동엽, teamCode=J, positionCode=D, teamName=고객문의팀, positionName=차장, deptName=서비스부), MemberDeptDto(userNo=1097, userName=이상민, teamCode=J, positionCode=C, teamName=고객문의팀, positionName=과장, deptName=서비스부)]
        positionName에 접근하는방법
        ChatGPT
        이 로그에서 "positionName"에 접근하는 방법은 다음과 같습니다. 각 MemberDeptDto 객체는 사용자 정보와 함께 포지션 이름(positionName)을 포함하고 있습니다. 이 정보에 접근하려면 각 MemberDeptDto 객체를 가져와야 합니다. Java 코드에서는 아마 이 정보를 리스트(list)에 저장하고 있을 것입니다.

        따라서 리스트(list)에서 MemberDeptDto 객체를 가져와서(positionName)에 접근하는 방법은 다음과 같습니다:

        java
        코드 복사
        List<MemberDeptDto> list = // 여기에 리스트(list)를 초기화하는 코드가 있어야 합니다.

        for (MemberDeptDto member : list) {
            String positionName = member.getPositionName();
            // 여기서 positionName을 사용할 수 있습니다.
        }
        위의 코드에서 "list"는 로그에서 보여진 리스트(list)의 이름입니다. "getPositionName()" 메소드는 MemberDeptDto 클래스에서 positionName을 반환하는 메소드입니다. 이것으로 각 MemberDeptDto 객체의 positionName에 접근할 수 있습니다.

        User
        builder생성방법
        ChatGPT
        Builder를 생성하는 방법은 일반적으로 다음과 같습니다. Builder 패턴은 객체를 생성할 때 매개변수가 많을 때 특히 유용합니다. 아래 예제는 Java 언어를 기준으로 작성되었습니다.

        먼저, 객체의 필수 및 선택적 매개변수를 가지는 내부 정적 클래스를 생성합니다.
        java
        코드 복사
        public class YourObject {
            private final String requiredField1;
            private final String requiredField2;
            private final String optionalField1;
            private final String optionalField2;

            public static class Builder {
                // 필수 매개변수
                private final String requiredField1;
                private final String requiredField2;
                
                // 선택적 매개변수 - 기본값 설정
                private String optionalField1 = "";
                private String optionalField2 = "";

                // 필수 매개변수를 받는 생성자
                public Builder(String requiredField1, String requiredField2) {
                    this.requiredField1 = requiredField1;
                    this.requiredField2 = requiredField2;
                }

                // 선택적 매개변수를 설정하는 메소드
                public Builder optionalField1(String value) {
                    optionalField1 = value;
                    return this;
                }

                public Builder optionalField2(String value) {
                    optionalField2 = value;
                    return this;
                }

                // Builder 클래스의 build 메소드
                public YourObject build() {
                    return new YourObject(this);
                }
            }

            // private 생성자를 통해 외부에서 직접 객체 생성 방지
            private YourObject(Builder builder) {
                requiredField1 = builder.requiredField1;
                requiredField2 = builder.requiredField2;
                optionalField1 = builder.optionalField1;
                optionalField2 = builder.optionalField2;
            }
        }
        이제 객체를 생성할 때 Builder를 사용합니다.
        java
        코드 복사
        YourObject yourObject = new YourObject.Builder("value1", "value2")
                                    .optionalField1("value3")
                                    .optionalField2("value4")
                                    .build();
        위의 예제에서는 "YourObject"라는 클래스와 그 클래스의 "Builder" 내부 정적 클래스를 정의하고 있습니다. "Builder" 클래스는 필수 매개변수를 받는 생성자와 선택적 매개변수를 설정하는 메소드를 포함하고 있습니다. 최종적으로 "build" 메소드를 호출하여 실제 객체를 생성합니다.

        User
        List<MemberDeptDto> list = payServiceImpl.selectDepartment();
        		
        		// 총무부의 이름, 팀이름, 직급(부장,과장,차장)
        		Map<String, Object> managementDept = new HashMap<>();
        		
        		for(int i=0; i<list.size(); i++) {
        			if(list.get(i).getDeptName().equals("총무부")) {
        				managementDept.put("userNo", list.get(i).getUserNo());
        				managementDept.put("userName", list.get(i).getUserName());
        				managementDept.put("teamName", list.get(i).getTeamName());
        				managementDept.put("positionName", list.get(i).getPositionName());
        				managementDept.put("deptName", list.get(i).getDeptName());	
        			}
        		}
        ChatGPT
        위 코드는 "총무부" 부서에 속한 사용자의 정보를 가져와서 Map에 저장하는 것으로 보입니다. 그러나 현재 코드는 "총무부"에 속한 사용자 중 마지막 사용자의 정보만을 Map에 저장하고 있습니다. 반복문이 돌면서 "총무부" 부서에 속한 사용자들의 정보가 있는 리스트(list)를 탐색하는데, 조건을 만족하는 각 사용자에 대해 Map에 사용자 정보를 덮어씌우고 있습니다. 따라서 마지막 사용자의 정보만이 최종적으로 Map에 남게 됩니다.

        모든 "총무부" 부서의 사용자 정보를 저장하기 위해서는 Map을 List로 변경하여 여러 사용자의 정보를 저장해야 합니다. 아래는 수정된 코드입니다:

        java
        코드 복사
        List<MemberDeptDto> list = payServiceImpl.selectDepartment();
        List<Map<String, Object>> managementDeptList = new ArrayList<>();

        for (MemberDeptDto member : list) {
            if ("총무부".equals(member.getDeptName())) { // 부서 이름 비교 시 문자열 상수를 먼저 위치시키는 것이 좋습니다.
                Map<String, Object> managementDept = new HashMap<>();
                managementDept.put("userNo", member.getUserNo());
                managementDept.put("userName", member.getUserName());
                managementDept.put("teamName", member.getTeamName());
                managementDept.put("positionName", member.getPositionName());
                managementDept.put("deptName", member.getDeptName());
                managementDeptList.add(managementDept); // 각 사용자 정보를 리스트에 추가
            }
        }
        위의 코드는 "총무부" 부서에 속한 모든 사용자의 정보를 담은 리스트인 "managementDeptList"를 생성합니다. 각 사용자 정보는 Map에 저장되고, 이 Map은 리스트에 추가됩니다. 이렇게 하면 모든 "총무부" 부서의 사용자 정보를 저장할 수 있습니다.

        User
        Map<String, Object> managementDept;
        		for(int i=0; i<list.size(); i++) {
        			if(list.get(i).getDeptName().equals("총무부")) {
        				managementDept = new HashMap<>();
        				managementDept.put("userNo", list.get(i).getUserNo());
        				managementDept.put("userName", list.get(i).getUserName());
        				managementDept.put("teamName", list.get(i).getTeamName());
        				managementDept.put("positionName", list.get(i).getPositionName());
        				managementDept.put("deptName", list.get(i).getDeptName());	
        			}
        		}
        ChatGPT
        위의 코드는 "총무부" 부서에 속한 사용자 중 마지막 사용자의 정보만을 저장하는 문제가 있습니다. 반복문이 돌면서 "총무부" 부서에 속한 사용자들의 정보가 있는 리스트(list)를 탐색하는데, 조건을 만족하는 각 사용자에 대해 새로운 Map을 생성하고 사용자 정보를 저장하고 있습니다. 그러나 각 반복에서 생성된 Map은 이전 반복에서 생성된 Map을 덮어씌우게 됩니다. 따라서 반복문이 종료된 후에는 마지막 사용자의 정보만이 최종적으로 Map에 남게 됩니다.

        모든 "총무부" 부서의 사용자 정보를 저장하기 위해서는 Map을 List로 변경하여 여러 사용자의 정보를 저장해야 합니다. 각 반복에서 새로운 Map을 생성하여 리스트에 추가하는 방식으로 코드를 수정할 수 있습니다. 아래는 수정된 코드입니다:

        java
        코드 복사
        List<MemberDeptDto> list = payServiceImpl.selectDepartment();
        List<Map<String, Object>> managementDeptList = new ArrayList<>();

        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getDeptName().equals("총무부")) {
                Map<String, Object> managementDept = new HashMap<>();
                managementDept.put("userNo", list.get(i).getUserNo());
                managementDept.put("userName", list.get(i).getUserName());
                managementDept.put("teamName", list.get(i).getTeamName());
                managementDept.put("positionName", list.get(i).getPositionName());
                managementDept.put("deptName", list.get(i).getDeptName());
                managementDeptList.add(managementDept); // 각 사용자 정보를 리스트에 추가
            }
        }
        위의 코드는 "총무부" 부서에 속한 모든 사용자의 정보를 담은 리스트인 "managementDeptList"를 생성합니다. 각 사용자 정보는 Map에 저장되고, 이 Map은 리스트에 추가됩니다. 이렇게 하면 모든 "총무부" 부서의 사용자 정보를 저장할 수 있습니다.

        User
        	
        		List<MemberDeptDto> list = payServiceImpl.selectDepartment();
        		
        		// 총무부의 이름, 팀이름, 직급(부장,과장,차장)
        		
        		Map<String, String> managementDept;
        		for(int i=0; i<list.size(); i++) {
        			if(list.get(i).getDeptName().equals("총무부")) {
        				managementDept = new HashMap<>();
        				managementDept.put("userNo", list.get(i).getUserNo());
        				managementDept.put("userName", list.get(i).getUserName());
        				managementDept.put("teamName", list.get(i).getTeamName());
        				managementDept.put("positionName", list.get(i).getPositionName());
        				managementDept.put("deptName", list.get(i).getDeptName());	
        			}
        		}
        ChatGPT
        위의 코드는 "총무부" 부서에 속한 사용자 중 마지막 사용자의 정보만을 저장하는 문제가 있습니다. 반복문이 돌면서 "총무부" 부서에 속한 사용자들의 정보가 있는 리스트(list)를 탐색하는데, 조건을 만족하는 각 사용자에 대해 새로운 Map을 생성하고 사용자 정보를 저장하고 있습니다. 그러나 각 반복에서 생성된 Map은 이전 반복에서 생성된 Map을 덮어씌우게 됩니다. 따라서 반복문이 종료된 후에는 마지막 사용자의 정보만이 최종적으로 Map에 남게 됩니다.

        모든 "총무부" 부서의 사용자 정보를 저장하기 위해서는 Map을 List로 변경하여 여러 사용자의 정보를 저장해야 합니다. 각 반복에서 새로운 Map을 생성하여 리스트에 추가하는 방식으로 코드를 수정할 수 있습니다. 아래는 수정된 코드입니다:

        java
        코드 복사
        List<MemberDeptDto> list = payServiceImpl.selectDepartment();
        List<Map<String, String>> managementDeptList = new ArrayList<>();

        for (int i = 0; i < list.size(); i++) {
            if (list.get(i).getDeptName().equals("총무부")) {
                Map<String, String> managementDept = new HashMap<>();
                managementDept.put("userNo", list.get(i).getUserNo());
                managementDept.put("userName", list.get(i).getUserName());
                managementDept.put("teamName", list.get(i).getTeamName());
                managementDept.put("positionName", list.get(i).getPositionName());
                managementDept.put("deptName", list.get(i).getDeptName());
                managementDeptList.add(managementDept); // 각 사용자 정보를 리스트에 추가
            }
        }
        위의 코드는 "총무부" 부서에 속한 모든 사용자의 정보를 담은 리스트인 "managementDeptList"를 생성합니다. 각 사용자 정보는 Map에 저장되고, 이 Map은 리스트에 추가됩니다. 이렇게 하면 모든 "총무부" 부서의 사용자 정보를 저장할 수 있습니다.

        User
        <button class="atag">총무부</button>
                                                                        <ul>
                                                                        	<c:forEach var="l" items="${maDeptList}">
                                                                            <button class="btn_result">${deptName}(${ l.positionName }) - ${ l.userName }</button><br>
                                                                        	</c:forEach>
                                                                        </ul>
        ChatGPT
        이 HTML 코드는 "총무부" 버튼과 해당 부서의 사용자 목록을 나타내는 목록을 포함합니다. 사용자 목록은 JSP 코드로 생성되며, 각 사용자의 직급(positionName), 이름(userName) 및 부서 이름(deptName)을 표시하는 버튼으로 구성됩니다.

        그러나 ${deptName}과 ${l.positionName}이 올바르게 작동하지 않을 것으로 보입니다. 이 코드에서는 JSP의 표현언어(EL)를 사용하여 변수 값을 표시하고 있지만, ${deptName}과 ${l.positionName}을 사용하여 변수 값을 가져오려고 시도하고 있습니다. 이 변수들은 JSP에서 정의되지 않았으므로 오류가 발생합니다.

        대신에 ${l.deptName}과 ${l.positionName}을 사용하여 각 사용자의 부서 이름과 직급을 가져와야 합니다. 아래는 수정된 코드입니다:

        html
        코드 복사
        <button class="atag">총무부</button>
        <ul>
            <c:forEach var="l" items="${maDeptList}">
                <button class="btn_result">${l.deptName}(${l.positionName}) - ${l.userName}</button><br>
            </c:forEach>
        </ul>
        이렇게 하면 각 사용자의 부서 이름, 직급 및 이름이 올바르게 표시됩니다.

        User
         <td class="sing_name" id="div_modal">
                                                
                                                    <div>
                                                       <a href="#" data-izimodal-open="#modal2">Sign</a>
                                                    </div>
                                                    <div>
                                                    <div id="modal2">
        																				        <!-- Modal content -->
        																				        <!-- 스타일에 한해서는 이런식으로 class명을 주시기 바랍니다. -->
        																				        <div class="m_content_style">
        																								  <canvas id="signature"></canvas>
        																									<div>
        																										<button id="save">Save</button>
        																										<button id="clear">Clear</button>
        																									</div> 
        																				        </div>
        																				    </div>
        																				    </div>
                                                </td> 싸인이 안그려져
        ChatGPT
        싸인이 그려지지 않는 문제는 몇 가지 가능한 원인이 있을 수 있습니다. 이를 해결하기 위해 몇 가지 가능한 해결책을 살펴보겠습니다:

        Canvas 크기 설정: Canvas 요소에 크기가 설정되어 있는지 확인하십시오. Canvas는 기본적으로 너비와 높이가 300x150 픽셀로 설정되어 있습니다. 실제로 그려지는 영역이 Canvas의 크기보다 클 경우 그리기가 보이지 않을 수 있습니다. Canvas의 크기를 적절하게 조정하여 실제로 그릴 수 있는 영역이 화면에 표시되도록 해야 합니다.
        Canvas Context 가져오기: JavaScript를 사용하여 Canvas의 Context를 가져오고, 이 Context를 통해 그리기 작업을 수행합니다. 모든 그리기 작업은 Context를 통해 이루어져야 합니다. Context를 올바르게 가져오는지 확인하십시오.
        이벤트 핸들러 구현: 사용자가 마우스나 터치를 사용하여 Canvas에 그림을 그리기 위해 적절한 이벤트 핸들러를 구현해야 합니다. 이벤트 핸들러를 통해 마우스의 움직임을 감지하고 이를 Canvas에 그리는 작업을 수행해야 합니다.
        스타일 및 CSS: Canvas와 그리기에 사용되는 요소들의 스타일 및 CSS를 확인하십시오. 부모 요소나 자식 요소가 가려서 Canvas가 보이지 않을 수도 있습니다. 또한 Canvas와 버튼 요소 사이에 겹치거나 충돌하는 CSS 스타일이 있는지 확인하십시오.
        버튼 이벤트 처리: 버튼을 클릭할 때 모달 창이 올바르게 표시되는지 확인하십시오. 모달 창이 올바르게 열리지 않으면 그림을 그릴 수 없습니다.
        이러한 해결책들을 확인하여 문제를 해결할 수 있을 것입니다. 만약 이 문제가 계속된다면, 더 자세한 정보가 필요할 수 있으니 더 많은 정보를 제공해주시기 바랍니다.

        User
        모달창으로 사인작성하려고하는데 작성이안돼
        ChatGPT
        사인이 작성되지 않는 문제를 해결하기 위해서는 다음과 같은 접근 방법을 고려할 수 있습니다:

        Canvas 설정 확인: Canvas의 너비와 높이가 충분한지 확인하세요. 너비와 높이가 충분하지 않으면 그리기 작업이 표시되지 않을 수 있습니다. Canvas의 너비와 높이를 적절하게 설정하세요.
        이벤트 핸들러: Canvas에 그리기 작업을 위한 마우스 이벤트 핸들러를 올바르게 구현했는지 확인하세요. 사용자의 마우스 이벤트(마우스 다운, 마우스 무브, 마우스 업 등)를 캡처하고 Canvas에 그림을 그리도록 이벤트 핸들러를 설정하세요.
        Canvas Context: JavaScript를 사용하여 Canvas의 Context를 가져오고, 이 Context를 통해 그리기 작업을 수행하세요. 모든 그리기 작업은 Context를 통해 이루어져야 합니다. Context를 올바르게 가져오는지 확인하세요.
        그리기 기능 확인: Canvas의 그리기 기능이 올바르게 작동하는지 확인하세요. 예를 들어, 단순한 선이나 도형을 그려보세요. Canvas의 그리기 기능이 제대로 작동하지 않으면 사인도 작성되지 않을 수 있습니다.
        디버깅: 개발자 도구를 사용하여 JavaScript 코드를 디버깅하고 오류를 확인하세요. 오류가 발생한 경우 콘솔을 확인하여 어떤 오류가 발생했는지 확인하세요.
        이러한 단계를 따라 사인이 작성되지 않는 문제를 해결할 수 있을 것입니다. 만약 문제가 지속된다면, 더 많은 정보를 제공해주시면 도움이 될 것입니다.

        User
          <div id="signature-container">
            <canvas id="signature-pad" width="300" height="150"></canvas>
            <button id="clear-button">지우기</button>
            <button id="undo-button">되돌리기</button>
            <button id="save-button">서명 저장</button>
          </div>var canvas = document.getElementById("signature-pad");
        	  var ctx = canvas.getContext("2d");
        	  var drawing = false;
        	  var history = [];

        	  $(canvas).on("mousedown", function(e) {
        	    drawing = true;
        	    ctx.beginPath();
        	    ctx.moveTo(e.clientX - canvas.getBoundingClientRect().left, e.clientY - canvas.getBoundingClientRect().top);
        	    history.push(ctx.getImageData(0, 0, canvas.width, canvas.height));
        	  });

        	  $(canvas).on("mousemove", function(e) {
        	    if (drawing) {
        	      ctx.lineTo(e.clientX - canvas.getBoundingClientRect().left, e.clientY - canvas.getBoundingClientRect().top);
        	      ctx.stroke();
        	    }
        	  });

        	  $(canvas).on("mouseup", function() {
        	    drawing = false;
        	  });

        	  $("#clear-button").on("click", function() {
        	    ctx.clearRect(0, 0, canvas.width, canvas.height);
        	    history = [];
        	    $("#signed-message").hide();
        	  });

        	  $("#undo-button").on("click", function() {
        	    if (history.length > 0) {
        	      ctx.putImageData(history.pop(), 0, 0);
        	    }
        	  });

        	  $("#save-button").on("click", function() {
        	    var signatureDataURL = canvas.toDataURL(); // 이미지 데이터 URL로 변환
        	    // 여기서 서명 데이터를 처리하거나 전송할 수 있습니다.

        	    $("#signed-message").show();
        	  });
        ChatGPT
        제공해주신 코드는 Canvas를 사용하여 서명을 작성하고 관련 버튼을 통해 서명을 지우고 되돌리고 저장하는 JavaScript 코드입니다. 그러나 여기에 몇 가지 수정이 필요합니다:

        history 변수명 충돌: history는 이미 JavaScript에서 내장 객체로 사용되는 변수입니다. 변수명을 history로 설정하면 내장 객체에 대한 접근이 불가능하므로 다른 이름으로 변경해야 합니다.
        Canvas의 위치 계산: 마우스 이벤트를 통해 Canvas의 위치를 계산할 때, canvas.getBoundingClientRect().left와 canvas.getBoundingClientRect().top을 사용하고 있습니다. 그러나 이 코드는 문서에서 Canvas의 위치를 계산하는 데 사용됩니다. 모달 창 안에 있는 Canvas의 위치를 올바르게 계산하려면 수정이 필요합니다.
        아래는 수정된 코드입니다:

        javascript
        코드 복사
        var canvas = document.getElementById("signature-pad");
        var ctx = canvas.getContext("2d");
        var drawing = false;
        var undoHistory = []; // history 변수명을 변경하여 충돌을 피합니다.

        $(canvas).on("mousedown", function(e) {
          drawing = true;
          ctx.beginPath();
          var rect = canvas.getBoundingClientRect(); // 모달 안에 있는 Canvas의 위치를 계산합니다.
          ctx.moveTo(e.clientX - rect.left, e.clientY - rect.top); // Canvas의 위치를 모달 창의 위치에 맞게 조정합니다.
          undoHistory.push(ctx.getImageData(0, 0, canvas.width, canvas.height));
        });

        $(canvas).on("mousemove", function(e) {
          if (drawing) {
            var rect = canvas.getBoundingClientRect(); // 모달 안에 있는 Canvas의 위치를 계산합니다.
            ctx.lineTo(e.clientX - rect.left, e.clientY - rect.top); // Canvas의 위치를 모달 창의 위치에 맞게 조정합니다.
            ctx.stroke();
          }
        });

        $(canvas).on("mouseup", function() {
          drawing = false;
        });

        $("#clear-button").on("click", function() {
          ctx.clearRect(0, 0, canvas.width, canvas.height);
          undoHistory = [];
          $("#signed-message").hide();
        });

        $("#undo-button").on("click", function() {
          if (undoHistory.length > 0) {
            ctx.putImageData(undoHistory.pop(), 0, 0);
          }
        });

        $("#save-button").on("click", function() {
          var signatureDataURL = canvas.toDataURL(); // 이미지 데이터 URL로 변환
          // 여기서 서명 데이터를 처리하거나 전송할 수 있습니다.

          $("#signed-message").show();
        });
        
        </script>
        
        <script>
            $('#modal2').iziModal({
                title: '결재선지정',
                //subtitle: '수정도 가능합니다.',
                headerColor: '#FEEFAD', // 헤더 색깔
                theme: '', //Theme of the modal, can be empty or "light".
                padding: '15px', // content안의 padding
                //radius: 10, // 모달 외각의 선 둥글기
                width: '700px',
               
            });

            // 2. 요소에 이벤트가 일어 났을떄 모달이 작동
            $("#modal-test").on('click', function () {
                //event.preventDefault(); //위의 클릭 이벤트가 일어나는 동안 다른 이벤트가 발생하지 않도록해주는 명령어

                $('#modal2').iziModal('open');
            });
            
            
        </script>
        
        
        
   <jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
    </main>
</body>
</html>