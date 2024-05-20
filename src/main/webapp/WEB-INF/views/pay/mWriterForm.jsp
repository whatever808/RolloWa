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
	 #modal_btn{
	    PADDING: 10PX;
	    BACKGROUND: #fffbea;
	    BORDER: 1PX SOLID #fffbea;
    }
    
    .m_content_style{height: 800px; display: flex; flex-wrap: wrap; justify-content: space-between;}
		.deptNameModal{width: 30%; height: 80%; border: 1px solid black;}
		#textForm {width:70%; }
		
		.team-container {
    margin-bottom: 20px;
		}
		
		.teams {
		    position: relative;
		    height: 200px; /* 적절한 높이로 설정 */
		}
		
		.team {
		    position: absolute;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 100%;
		    visibility: hidden;
		}
		
		.user-management {
		    display: flex;
		    gap: 20px;
		    padding: 20px;
		    font-family: Arial, sans-serif;
		    width: 100%;
		    height: 100%;
		    flex-wrap: wrap;
		    flex-direction: row;
		    align-items: center;
		    justify-content: flex-start;
		}
		.user-list, .sidebar{height: 100%;}
		.selected-users{height: 100%; margin-top: 93px;} 
		.sidebar {
		    flex: 1;
		    border-right: 1px solid #ddd;
		}
		
		.sidebar ul {
		    list-style: none;
		    padding: 0;
		}
		
		.sidebar ul ul {
		    margin-left: 20px;
		}
		
		.sidebar li {
		    margin: 5px 0;
		}
		
		.sidebar li.selected {
		    font-weight: bold;
		}
		
		.user-list, .selected-users {
		    flex: 2;
		}
		
		.user-list table, .selected-users table {
		    width: 100%;
		    border-collapse: collapse;
		    margin-bottom: 20px;
		}
		
		.user-list th, .user-list td, .selected-users th, .selected-users td {
		    border: 1px solid #ddd;
		    padding: 8px;
		    text-align: center;
		}
		
		.user-list th, .selected-users th {
		    background-color: #f4f4f4;
		}
		
		.selected-users button {
		    background-color: #4CAF50;
		    color: white;
		    border: none;
		    padding: 5px 10px;
		    cursor: pointer;
		}
		
		.actions {
		   display: flex;
		    gap: 10px;
		    justify-content: center;
		    flex-direction: row;
		    flex-wrap: wrap;
		    align-items: baseline;
		    align-content: flex-end;
		}
		
		.actions button {
		    padding: 10px 20px;
		    cursor: pointer;
		}
		
		.actions button:first-child {
		    background-color: #4CAF50;
		    color: white;
		    border: none;
		}
		
		.actions button:last-child {
		    background-color: #f44336;
		    color: white;
		    border: none;
		}
		
		.user_modal{width: 100%; height: 80%;}
		.deptDiv{cursor: pointer;}
		.deptDiv li{cursor: pointer;}
		
		.deptDiv ul{display: none;}
		
		.deptDiv ul{display: none;}
		.teamN, .nameClick  {cursor: pointer;}
		

</style>

</head>
<body>
<script>
	$(document).ready(function(){
	    $(".deptDiv").click(function(){
	
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
	
	
	$(document).on("click", ".teamN", function(){
    $.ajax({
        url:"${contextPath}/pay/ajaxTeamSearch.do",
        type:"get",
        data:{
            name:$(this).text()
        },
        success:function(result){
        		var htmlthead = "<tr><th>No.</th><th>이름</th><th>직위</th></tr>";
            var htmlString = "";
            for (let i = 0; i < result.length; i++) {
                htmlString += '<tr class="nameClick" data-name="' + result[i].USER_NAME + '"><td>' + (i + 1) + '</td>' +
                              '<td>' + result[i].USER_NAME + '</td>' +
                              '<td>' + result[i].POSITION_NAME + '</td></tr>';
            }
            $(".user-list thead").html(htmlthead);
            $(".user-list tbody").html(htmlString);
        },
    })
		});
	
		
		$(document).ready(function(){
		
			$(document).on("click", ".nameClick", function(){
				 
				 console.log("길이" + $(".selected-users tbody tr").length);
					
				 	var hName = "<tr><th>이름</th><th>결재</th></tr>";
			    let dName = $(this).data("name");
			    var chName = '<tr>' +
			                     '<td class="name">' + dName + '</td>' +
			                     '<td><button class="approveButton">결재</button>&nbsp;<button class="removeBtn" data-remove="' + dName +'">x</button></td>' +
			                 '</tr>';         
			 var duplicate = false;
			 // 선택된 사용자의 이름을 갖는 행이 이미 있는지 확인
			    $(".selected-users tbody tr").each(function(){
			        if($(this).find(".name").text() === dName){
			            duplicate = true;
			            return false; // 중복된 이름을 찾았으면 반복문 종료
			        }
			    });

		    	
			    if(duplicate){
			        alert("중복된 결재자 이름입니다.");
			    } else {
			    	
			    		if($(".selected-users thead tr").length == 0 || $(".selected-users tbody tr").length == 0){
			    			$(".selected-users thead").append(hName); 
			    		}
			    		
			    		if($(".selected-users tbody tr").length <= 2){
				        	 $(".selected-users tbody").append(chName); // chName을 tbody에 추가
			        }else if($(".selected-users tbody tr").length >= 3){
			        	alert("최대 3명까지 선택 가능합니다.");
			        	return;
			        }
			       
			    }
			});
			
			
			$(document).on("click", ".removeBtn", function(){
				
					let cName = $(this).data("remove");
				
					$(".selected-users tbody tr").each(function(){
						 if($(this).find(".name").text() == cName){
							 $(this).remove();
						 }
					})
					
					if($(".selected-users tbody tr").length == 0){
						$(".selected-users thead tr").text("");
					}
					
					
			})
			
		})
	
		
			$(document).ready(function(){
		    $(document).on("click", "#okay", function(){
		        var selectedNames = []; // 선택된 사용자의 이름을 저장할 배열
		        
		        $(".selected-users tbody tr").each(function(){
		            var name = $(this).find(".name").text();
		            selectedNames.push(name); // 배열에 사용자 이름 추가
		        });
		        
		        $("input[type='hidden'][name='firstApproval']").val(selectedNames[0]);
		        $("input[type='hidden'][name='middleApproval']").val(selectedNames[1]);
		        $("input[type='hidden'][name='finalApproval']").val(selectedNames[2]);
		        $("#f_name").text("");
		        $("#m_name").text("");
		        $("#l_name").text("");
		        $("#f_name").text(selectedNames[0]);
		        $("#m_name").text(selectedNames[1]);
		        $("#l_name").text(selectedNames[2]);
		        if($("#f_name").text() == "" && $("#m_name").text() == "" && $("#l_name").text() == ""){
		        	alert("승인자를 3차까지 선택해주세요.");
		        }else{
		        	$("#modal").iziModal('close');
		        }
		    });
			});
		
		
		$(document).on("click", "#close",function(){
			 $("#modal").iziModal('close');
		})
			
		
		$(document).on("keypress", "#userSearch", function(){
				if($(this).val().trim() == ""){
					alert("다시입력해주세요");
					$("#userSearch").val("");
				}else{
					$.ajax({
						url:"${contextPath}/pay/ajaxSearchName.do",
						type:"get",
						data:{
							name:$("#userSearch").val()
						},
						success:function(result){
							console.log(result);
							 if(result.length == 0){
								 alert("검색하신 이름은 존재하지 않습니다.");
								 $("#userSearch").val("");
							 }else{
								
								 	var htmlthead = "<tr><th>No.</th><th>이름</th><th>직위</th><th>부서</th></tr>";
			            var htmlString = "";
			            for (let i = 0; i < result.length; i++) {
			                htmlString += '<tr class="nameClick" data-name="' + result[i].USER_NAME + '"><td>' + (i + 1) + '</td>' +
			                              '<td>' + result[i].USER_NAME + '</td>' +
			                              '<td>' + result[i].POSITION_NAME + '</td>' + 
			                              '<td>' + result[i].TEAM_NAME + '</td></tr>';
			            }
			            
			            $(".user-list thead").html(htmlthead);
			            $(".user-list tbody").html(htmlString);
								 
							 }
						}
					})
				}
				
		})
		
		
</script>

		<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
		
       <!-- content 추가 -->
        <div class="content p-4">
            <!-- 프로필 영역 -->
            <div class="informations">
                <!-- informations left area start -->
                <div class="left_con">
                    <div><h3>매출 보고서</h3></div>
                    	<c:choose>
                    	<c:when test="${ not empty list }">
	                      <form action="${contextPath}/pay/mReportUpdate.do" method="post" id="myForm">
	                    	</c:when>
                    	<c:otherwise>
		                    <form action="${contextPath}/pay/mReportInsert.do" method="post" id="myForm">
		                   	</c:otherwise>
                    	</c:choose>
                        <div id="sign_top">
                        		
                            <div id="sign_div_left">
                                <table border="1" id="sign_left">
                                    <tr>
                                        <th>부 서</th>
                                        <td>${member.get(0).teamName}</td>                   
                                        <input type="hidden" name="deptName" value="${member.get(0).teamName}">
                                        <input type="hidden" name="approvalNo" value="${list.get(0).APPROVAL_NO}">
                                        <input type="hidden" name="reportNo" value="${list.get(0).REPORT_NO}">
                                        <input type="hidden" name="reportType" value="${list.get(0).REPORT_TYPE}">
                                        <input type="hidden" name="writerNo" value="${userNo}"> 
                                    </tr>
                                    <tr>
                                        <th>기안일</th>
                                        <td><input type="date" name="writerDate" required value="${list.get(0).REGIST_DATE}"></td>
                                    </tr>
                                    <tr>
                                        <th>기안자</th>
                                        <td>${member.get(0).userName}</td>
                                        <input type="hidden" name="writerName" value="${member.get(0).userName}">
                                    </tr>
                                    <tr>
                                        <th>상태</th>
                                        <td>
                                            <select name="status" id="status">
                                                <option value="보통">보통</option>
                                                <option value="긴급">긴급</option>
                                            </select>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                            
                            
                            <!-- 결재승인자 모달 start -->
                            <input type="hidden" name="firstApproval">
                            <input type="hidden" name="middleApproval">
                            <input type="hidden" name="finalApproval">
                             <div id="modal">
                                 <div class="m_content_style">
                                 <div class="user_modal">
                                  	<div class="user-management">
                                  	
																    <div class="sidebar">
																        <ul>
																            <li><span class="deptDiv">인사부</span>
																             		<ul>
																                   <c:forEach var="i" begin="0" end="${ teamNames.size() - 1 }">
																                    	<c:if test="${ teamNames.get(i).DEPT_NAME eq '인사부' }">
													                            	<li class="teamN">${teamNames.get(i).TEAM_NAME}</li>
													                            </c:if>
																                		</c:forEach> 															               
																                </ul>
																            </li>
																            <li><span class="deptDiv">총무부</span>
																                <ul>
																                    <c:forEach var="i" begin="0" end="${ teamNames.size() - 1 }">
																                    	<c:if test="${ teamNames.get(i).DEPT_NAME eq '총무부' }">
													                            	<li class="teamN">${teamNames.get(i).TEAM_NAME}</li>
													                            </c:if>
																                		</c:forEach>  
																                </ul>
																            </li>
																            <li><span class="deptDiv">마케팅부</span>
																                <ul>
																                   <c:forEach var="i" begin="0" end="${ teamNames.size() - 1 }">
																                    	<c:if test="${ teamNames.get(i).DEPT_NAME eq '마케팅부' }">
													                            	<li class="teamN">${teamNames.get(i).TEAM_NAME}</li>
													                            </c:if>
																                		</c:forEach> 															               
																                </ul>
																            </li>
																            <li><span class="deptDiv">FB</span>
																                <ul>
																                   <c:forEach var="i" begin="0" end="${ teamNames.size() - 1 }">
																                    	<c:if test="${ teamNames.get(i).DEPT_NAME eq 'FB' }">
													                            	<li class="teamN">${teamNames.get(i).TEAM_NAME}</li>
													                            </c:if>
																                		</c:forEach> 															               
																                </ul>
																            </li>
																             <li><span class="deptDiv">인사부</span>
																                <ul>
																                   <c:forEach var="i" begin="0" end="${ teamNames.size() - 1 }">
																                    	<c:if test="${ teamNames.get(i).DEPT_NAME eq '인사부' }">
													                            	<li class="teamN">${teamNames.get(i).TEAM_NAME}</li>
													                            </c:if>
																                		</c:forEach> 															               
																                </ul>
																            </li>
																             <li><span class="deptDiv">운영부</span>
																                <ul>
																                   <c:forEach var="i" begin="0" end="${ teamNames.size() - 1 }">
																                    	<c:if test="${ teamNames.get(i).DEPT_NAME eq '운영부' }">
													                            	<li class="teamN">${teamNames.get(i).TEAM_NAME}</li>
													                            </c:if>
																                		</c:forEach> 															               
																                </ul>
																             </li>
																             <li><span class="deptDiv">서비스부</span>
																                <ul>
																                   <c:forEach var="i" begin="0" end="${ teamNames.size() - 1 }">
																                    	<c:if test="${ teamNames.get(i).DEPT_NAME eq '서비스부' }">
													                            	<li class="teamN">${teamNames.get(i).TEAM_NAME}</li>
													                            </c:if>
																                		</c:forEach> 															               
																                </ul>
																             </li>
																        </ul>
																    </div>
																    <!-- 결재승인자 모달 end -->
																    
																    
																    <div class="user-list">
																    	 <div class="actions">
																    	 	<input type="text" id="userSearch" placeholder="이름을 입력하세요.">
																    	 </div>
																        <table>
																            	<thead>
																	            </thead>
																	            <tbody> 
	          																	</tbody>
																        </table>
																    </div>
																    <div class="selected-users">
																        <table>
																            <thead>
																            </thead>
																            <tbody>
																            </tbody>
																        </table>
																    </div>
																 </div>
																    <div>
																	    <div class="actions">
																	        <button id="okay">확인</button>
																	        <button id="close">닫기</button>
																	    </div>
																    </div>
																</div>
                               </div>
                         </div>
                            

                            <div>
                                <table id="sign_table">
                                   	<tr id="tr_name">
                                        <th rowspan="3">승 <br> 인
                                        <button data-izimodal-open="#modal" id="modal_btn">
                                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-plus-circle" viewBox="0 0 16 16">
																				  <path d="M8 15A7 7 0 1 1 8 1a7 7 0 0 1 0 14m0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16"/>
																				  <path d="M8 4a.5.5 0 0 1 .5.5v3h3a.5.5 0 0 1 0 1h-3v3a.5.5 0 0 1-1 0v-3h-3a.5.5 0 0 1 0-1h3v-3A.5.5 0 0 1 8 4"/>
																				</svg>
                                        </button>
                                        </th>
                                        
                                       
                                        <c:choose>
	                                        <c:when test="${ empty list }">
		                                        <td>최초승인자</td>
		                                        <td>중간승인자</td>
		                                        <td>최종승인자</td>
		                                      </c:when>
	                                        <c:otherwise>
	                                        	<td></td>
		                                        <td></td>
		                                        <td></td>
	                                        </c:otherwise>
                                        </c:choose>
                                    </tr>
                                    <tr>
                                        <td  id="f_name" class="sing_name"></td>
                                        <td id="m_name" class="sing_name"></td>
                                        <td id="l_name" class="sing_name"></td>                                                      
                                    </tr>
                                </table>
                            </div>
                        </div>
                                  
                        <div>
                        
										    </div>
                        <div id="mid_btn">
                            <button id="plus_btn" type="button">추가</button>
                            <button id="del_btn" type="button">삭제</button>
                        </div>
                        <div class="table_middle">
	                         <table border="1" id="tr_table">
                                <tr>
                                    <th>매출구분</th>
                                    <td colspan="2">
                                        <select name="sales" id="sales" required>
                                            <option value="상품">상품</option>
                                            <option value="티켓">티켓</option>
                                            <option value="음식점">음식점</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th>담당자</th>
                                    <td colspan="2"><input type="text" name="manager" value="${ list.get(0).MANAGER_NAME }" required></td>
                                </tr>
                                <tr>
                                    <th>총매출금액(VAT별도)</th>
                                    <td colspan="2"><input type="text" name="totalSales" value="${ list.get(0).TOTAL_SALES.toString().trim() }" required style="text-align: right;"></td>
                                </tr>
                                <tr>
                                    <th colspan="3">매출정보</th>
                                </tr>
                                <tr>
                                    <th>품목</th>
                                    <th style="width: 100px;">수량</th>
                                    <th>매출금액</th>
                                </tr>
                                <c:choose>
                                <c:when test="${ empty list }">
                                <tr>
                                    <td><input type="text" class="item" name="item1"></td>
                                    <td><input type="number" class="count" min="1" name="count1"></td>
                                    <td><input type="text" class="sales_amount" name="sales2"></td>
                                </tr>
                                <tr>
                                    <td><input type="text" class="item" name="item2"></td>
                                    <td><input type="number" class="count" min="1" name="count2"></td>
                                    <td><input type="text" class="sales_amount" name="sales3"></td>
                                </tr>
                                <tr>
                                    <td><input type="text" class="item" name="item3"></td>
                                    <td><input type="number" class="count" min="1" name="count3"></td>
                                    <td><input type="text" class="sales_amount" name="sales4"></td>
                                </tr>
                                <tr id="tr_input">
                                    <td><input type="text" class="item" name="item4"></td>
                                    <td><input type="number" class="count" min="1" name="count4"></td>
                                    <td><input type="text" class="sales_amount" name="sales5"></td>
                                </tr>
                                </c:when>
                                <c:otherwise>
	                                <c:forEach var="i" begin="0" end="${ list.size() - 1}">
	                                	<tr id="tr_input">
	                                    <td><input type="text" name="item${i}" value="${list.get(i).ITEM}"></td>
	                                    <td><input type="number" name="count${i}" min="1" value="${list.get(i).VOLUMES}"></td>
	                                    <td><input type="text" name="sales${i}" value="${list.get(i).SALES_AMOUNT.toString().trim()}"></td>
	                                	</tr>
	                                </c:forEach>
                                </c:otherwise>
                                </c:choose>
                            </table>
	                            <input type="hidden" name="items" id="items">
	                            <input type="hidden" name="counts" id="counts">
	                            <input type="hidden" name="salesAmounts" id="sales_amounts">
                        </div>
                        <!--버튼 영역-->
                        <div id="btn_div">
                        		<button class="btn btn-primary" id="insertBtn" type="submit" onclick="submitbtn();">제출</button>
                            <button class="btn btn-warning" onclick="alert('저장이 완료되었습니다.');">저장</button>
                            <button type="reset" class="btn btn-danger" id="reset_btn">초기화</button>
                        </div>
                        <!------------>
                        
                        
                    </form>
                </div>
            </div>
        </div>
        
    <c:if test="${ not empty list }">
    <script>
    	$(document).ready(function(){
    			$("#status").val("${list.get(0).PAYMENT_STATUS}");
    			$("#sales").val("${list.get(0).SALES_DIVISION}")
    	})
    </script>
    </c:if>
     
    <script>
    	
    	$(document).ready(function(){
    	
    		$("#insertBtn").on("click", function(){
	    		$(".namecheck").each(function(){
		    		if($(this).val() == ""){
		    			alert("승인자를 선택해주세요.");
		    			return false;
		    		}
	    		})	    	
    		})
    	})
    	
    </script>
   
    <script>
	    	function submitbtn(){
   					let itemArr = [];
   					let countArr = [];
   					let salesArr = [];
   					//금액
	    		$(".item").each(function(){
					 		if($(this).val().trim() != ""){
					 			itemArr.push($(this).val());
							}
	        })
	        
	        $("#items").val(itemArr);
	     					
	    					//수량
	   			$(".count").each(function(){
				 		if($(this).val().trim() != ""){
				 			countArr.push($(this).val());
						}
	         })
	         $("#counts").val(countArr);
	    					
	   					// 매출금액
	    		$(".sales_amount").each(function(){
				 		if($(this).val().trim() != ""){
				 			salesArr.push($(this).val());
						}
	          })
	         $("#sales_amounts").val(salesArr);	
	
	         if(confirm('정말로 제출하시겠습니까?') == true){}
	                
	       }
   	</script>
    
    <script>
    $(document).ready(function(){
    
    	$(document).on("click", "#plus_btn", function () {
    		
    		
    		var result = "<tr>";
    		result += "<td><input type='text' class='item'></td>";
    		result += "<td><input type='number' class='count' min='1'></td>";
    		result += "<td><input type='text' class='sales_amount'></td>";
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
        $('#modal').iziModal({
            title: '결재선지정',
            //subtitle: '수정도 가능합니다.',
            headerColor: '#FEEFAD', // 헤더 색깔
            theme: '', //Theme of the modal, can be empty or "light".
            //padding: '15px', // content안의 padding
            //radius: 10, // 모달 외각의 선 둥글기
            width: '1100px',
           
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
   
    
</body>
</html>