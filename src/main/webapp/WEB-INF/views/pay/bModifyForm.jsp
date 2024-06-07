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
    <link href="${contextPath}/resources/css/pay/writer2.css" rel="stylesheet">
    
  
   	
<style>

body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 20px;
    background-color: #f9f9f9;
}

.document {
    max-width: 1250px;
    margin: 0 auto;
    background: white;
    padding: 20px;
    border: 1px solid #ddd;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.title2 {
    text-align: center;
    font-size: 24px;
    margin-bottom: 20px;
}

.header2, .content2, .details2 {
    margin-bottom: 20px;
}

table {
    width: 100%;
    border-collapse: collapse;
}

td.label {
    width: 16%;
    background-color: #f2f2f2;
    padding: 8px;
    text-align: right;
    font-weight: bold;
}

td.value {
    padding: 8px;
    text-align: left;
}

td.value.small {
    width: 20%;
}

.details h2 {
    margin-top: 0;
}

.details h3 {
    text-align: center;
}

ol {
    padding-left: 20px;
}

ol li {
    margin-bottom: 10px;
}

ul {
    padding-left: 20px;
    list-style-type: disc;
}
.text_3{
		font-size: 15px;
    color: #222222;
    height: fit-content;
    border: none;
    border-bottom: solid rgb(170, 170, 170) 1px;
    padding-bottom: 10px;
    padding-left: 10px;
    position: relative;
    background: none;
    z-index: 5;
}

table {
    width: 100%;
    border-collapse: collapse;
    margin-top: 10px;
}
table, th, td {
    border: 1px solid black;
}
th, td {
    padding: 8px;
    text-align: left;
}
th {
    background-color: #feefad;
}
.checkBox {
    display: inline-block;
    width: 20px;
}
.teamName, .userName {
    padding-left: 10px;
}
#clickBox .userItem {
    margin: 5px 0;
    padding: 5px;
    border: 1px solid #ddd;
    border-radius: 4px;
}
.removeName{cursor: pointer;}
#okayBtn{
		background-color: #fdeeac;
    border-radius: 16px;
    padding: 5px;
    width: 63px;
    margin: 10px;
    border: none;
}

.input-container {
    position: relative;
    width: 200px;
}

.input-search {
    padding: 8px;
    border: 1px solid #ccc;
    border-radius: 5px;
    width: 100%;
    outline: none;
}

/* 포커스 시 스타일링 */
.input-search:focus {
    border-color: dodgerblue;
    box-shadow: 0 0 5px dodgerblue;
}
#searchBox{
		text-align: center;
    margin: 30px;
}
#searchBox th td{text-align: center;}


</style>

</head>
<body>
		<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
<script>
$(document).ready(function(){
    $(".deptDiv").click(function(){
    	
      $(this).siblings("ul").find(".teamN").slideToggle();
      
    });
  });
	
	
	$(document).on("click", ".teamN", function(){
    $.ajax({
        url:"${contextPath}/pay/ajaxTeamSearch.do",
        type:"get",
        data:{
            name:$(this).text()
        },
        success:function(result){
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
		        
		        if($(".selected-users tbody tr").length != 3){
		        	alert("승인자를 3차까지 선택해주세요.");
		        }else if($(".selected-users tbody tr").length == 3){
		        	$("#modal").iziModal('close');
		        }
		    });
			});
		
		
		$(document).on("click", "#close",function(){
			 $("#modal").iziModal('close');
		})
			
		
		$(document).on("keyup", "#userSearch", function(ev){
			
			if(ev.key == 'Enter'){
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
				
			}
		})
		
		
</script>


 <!-- 결재승인자 모달 start -->

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


<div id="modal2">
		<div id="title">
			<input type="text" id="laterName" class="input-search" placeholder="검색하세요.">
		</div>
		<div id="searchBox">
		
		</div>
		<div id="clickBox">
			
		</div>
		<div style="display: flex; justify-content: flex-end;">
			<button id="okayBtn">확인</button>
		</div>
</div>

<script>
$(document).on("click", "#okayBtn", function(){
	
    let no = $("#clickBox").find(".checkuserNumber");
    let referrer = [];
    for(let i = 0; i < no.length; i++){
        referrer.push($(no[i]).val());
    }
    $("input[type='hidden'][name='referrer']").val(referrer);
    
    
    let name = $("#clickBox").find(".userName");
    let referrerNames = [];
    for(let i = 0; i < name.length; i++){
    	referrerNames.push($(name[i]).text());
    }
    $("input[type='hidden'][name='referrerName']").val(referrerNames);
    
    
    let userNames = [];
    $("#clickBox .userName").each(function() {
        userNames.push($(this).text());
    });
    $("#referrerTd").empty();
    $("#referrerTd").append(userNames.join(", "));
    
    $("#modal2").iziModal('close');
});
</script>




   <script>
        $(document).ready(function() {
        	
            $(document).on("keyup", "#laterName", function(ev) {
                $("#searchBox").empty();
                if (ev.key === "Enter") {
                    let keyword = $("#laterName").val().trim();
                    if (keyword) {
                        $.ajax({
                            url: "${contextPath}/pay/laterSearchDept.do",
                            type: "get",
                            data: { keyword: keyword },
                            success: function(response) {
                                let span = "";
                                if (response.length > 0) {
                                    span += "<table>";
                                    span += "<tr><th>선택</th><th>팀 이름</th><th>직급</th><th>사용자 이름</th></tr>";
                                    response.forEach(function(item) {
                                        span += "<tr id='searchTr'>";
                                        span += "<td><input type='checkbox' class='checkBox'></td>";
                                        span += "<td class='teamName'>" + item.TEAM_NAME + "</td>";
                                        span += "<td class='positionName'>" + item.POSITION_NAME + "</td>";
                                        span += "<td class='userName'>" + item.USER_NAME + "</td>";
                                        span += "<input type='hidden' class='userNumber' value='" + item.USER_NO + "'>";
                                        span += "</tr>";
                                    });
                                    span += "</table>";
                                    $("#searchBox").append(span);
                                } else {
                                    $("#searchBox").html("<span>검색한 사원은 존재하지 않습니다.</span>");
                                   	$("##laterName").val();
                                }
                            },
                            error: function() {
                                console.log("ajax 통신 실패");
                            }
                        });
                    }
                }
            });

            $(document).on("change", ".checkBox", function() {
                let $row = $(this).closest("tr");
                let teamName = $row.find(".teamName").text();
                let userName = $row.find(".userName").text();
                let positionName = $row.find(".positionName").text();
                let userNumber = $row.find(".userNumber").val();
								console.log(teamName);
								console.log(userName);
								console.log(userNumber);
                if ($(this).is(":checked")) {
                    let duplicate = false;
                    $("#clickBox .userNumber").each(function() {
                        if ($(this).val() == userNumber) {
                            duplicate = true;
                            return false; // each문 종료
                        }
                    });
                    if (duplicate) {
                        alert("중복된 이름입니다.");
                        $(this).prop("checked", false);
                    } else {
                    	let userItemHTML ='<div class="userItem">' +
									                        '<span class="teamName">' + teamName + '</span>' +
									                        '<span class="positionName">' + positionName + '</span>' +
									                        '<span class="userName">' + userName + '</span>' +
									                        '<input type="hidden" class="checkuserNumber" value="' + userNumber + '">' +
									                        '<span class="removeName">' + 
									                        '<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-square" viewBox="0 0 16 16">' + 
																					  '<path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"/>' + 
																					  '<path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708"/>' + 
																					'</svg>'
								                        '</div>';
                        $("#clickBox").append(userItemHTML);
               
                        
                    }
                } else {
                    $("#clickBox .userNumber").each(function() {
                        if ($(this).val() == userNumber) {
                            $(this).closest(".userItem").remove();
                        }
                    });
                }
                
                
            });
            
            $(document).on("click", ".removeName", function() {
                let $row = $(this).closest(".userItem");
                let hiddenEl = $row.find(".checkuserNumber").val(); 
                $row.remove();
                
                // 삭제된 사용자의 번호를 가진 행에서 체크박스를 해제
                $("#searchBox tr").each(function() {
                    let userNumber = $(this).find(".userNumber").val();
                    if (hiddenEl === userNumber) {
                        $(this).find(".checkBox").prop("checked", false);
                        return false; // each 반복문 종료
                    }
                });
            });
            
            $(document).on("change", ".checkBox", function() {
                let $row = $(this).closest("tr");
                let userNumber = $row.find(".userNumber").val();
                
                // 체크박스가 해제된 경우
                if (!$(this).is(":checked")) {
                    // 삭제된 사용자의 번호를 가진 행에서 체크박스 해제
                    $("#clickBox .userItem").each(function() {
                        if ($(this).find(".checkuserNumber").val() === userNumber) {
                            $(this).remove();
                            return false; // each 반복문 종료
                        }
                    });
                }
            });
            
            
        });
    </script>

       <!-- content 추가 -->
        <div class="content p-4">
            <!-- 프로필 영역 -->
            <div class="informations">
                <!-- informations left area start -->
                <div class="left_con">
		                <form action="${contextPath}/pay/bReportUpdate.do" method="post" id="myForm">
		                   <input type="hidden" name="deptName" value="${list.get(0).DEPARTMENT}">
                       <input type="hidden" name="approvalNo" value="${list.get(0).APPROVAL_NO}">
                       <input type="hidden" name="fixNo" value="${list.get(0).FIX_NO}">
                       <input type="hidden" name="reportNo" value="${list.get(0).REPORT_NO}">
                       <input type="hidden" name="reportType" value="${list.get(0).REPORT_TYPE}">
                       <input type="hidden" name="writerNo" value="${userNo}">
                      <input type="hidden" name="firstApproval" value="${ list.get(0).FIRST_APPROVAL }" class="hiddenSignName">
											 <input type="hidden" name="middleApproval" value="${ list.get(0).MIDDLE_APPROVAL }" class="hiddenSignName">
											 <input type="hidden" name="finalApproval" value="${ list.get(0).FINAL_APPROVAL }" class="hiddenSignName">
											 <input type="hidden" name="payWriter" value="${list.get(0).PAYMENT_WRITER}">
                       <input type="hidden" name="payWriterNo" value="${list.get(0).PAYMENT_WRITER_NO}">
                       <input type="hidden" name="modifyType" value="${type}">
											 <input type="hidden" name="referrer" value="">
											 <input type="hidden" name="referrerName" value="">
		                   <div class="document">
										        <h1 class="title2">비품 신청서</h1>
										
										        <div class="header2">
										            <table>
										                <tr>
										                    <td class="label">부서</td>
										                    <td class="value" colspan="3">${member.get(0).teamName}</td>
										                </tr>
										                <tr>
										                    <td class="label">기안자</td>
										                    <td class="value" colspan="4">${member.get(0).userName}</td>
										                    <input type="hidden" name="writerName" value="${list.get(0).PAYMENT_WRITER}">
										                </tr>
										                <tr>
										                    <td class="label">기안일</td>
										                    <td class="value" colspan="4">
										                    <input type="date" name="writerDate" required>
										                    </td>
										                </tr>
										                <tr>
										                    <td class="label">
											                    승인자
											                    <button data-izimodal-open="#modal" id="modal_btn">
	                                        <svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-person-plus" viewBox="0 0 16 16">
																					  <path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
																					  <path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5"/>
																					</svg>
	                                        </button>
										                    </td>
										                    <td class="value small sing_name" id="f_name">${ list.get(0).FIRST_APPROVAL }</td>
										                    <td class="value small sing_name" id="m_name">${ list.get(0).MIDDLE_APPROVAL }</td>
										                    <td class="value small sing_name" id="l_name">${ list.get(0).FINAL_APPROVAL }</td>
										                </tr>
										                <tr>
										                    <td class="label">
											                    수신참조인
											                    <button data-izimodal-open="#modal2" id="modal_btn">
																					<svg xmlns="http://www.w3.org/2000/svg" width="28" height="28" fill="currentColor" class="bi bi-person-plus" viewBox="0 0 16 16">
																					  <path d="M6 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6m2-3a2 2 0 1 1-4 0 2 2 0 0 1 4 0m4 8c0 1-1 1-1 1H1s-1 0-1-1 1-4 6-4 6 3 6 4m-1-.004c-.001-.246-.154-.986-.832-1.664C9.516 10.68 8.289 10 6 10s-3.516.68-4.168 1.332c-.678.678-.83 1.418-.832 1.664z"/>
																					  <path fill-rule="evenodd" d="M13.5 5a.5.5 0 0 1 .5.5V7h1.5a.5.5 0 0 1 0 1H14v1.5a.5.5 0 0 1-1 0V8h-1.5a.5.5 0 0 1 0-1H13V5.5a.5.5 0 0 1 .5-.5"/>
																					</svg>
	                                        </button>
										                    </td>
										                    <td  colspan="3" id="referrerTd">
										                   
										                    </td>
										                </tr>
										                <tr>
                                        <td class="label">상태</td>
                                        <td colspan="4">
                                            <select name="status" id="status">
                                                <option value="보통">보통</option>
                                                <option value="긴급">긴급</option>
                                            </select>
                                        </td>
                                    </tr>
										                <tr>
										                    <td class="label">제목</td>
										                    <td class="value" colspan="4"><input type="text" name="title"  value="${ list.get(0).TITLE }" required></td>
										                </tr>
										            </table>
										        </div>
														<div id="mid_btn">
		                    				<button id="plus_btn" type="button">추가</button>
                   							<button id="del_btn" type="button">삭제</button>
                   					</div>
										        <div class="content2">
										            <table id="tr_table">
										            	 <tr>
	                                    <td class="label">품명</td>
	                                    <td class="label">규격</td>
	                                    <td class="label">수량</td>
	                                    <td class="label">단가</td>
	                                    <td class="label">금액</td>
	                                    <td class="label">비고</td>
                                		</tr>
												            <c:forEach var="i" begin="0" end="${list.size() - 1}">
																			<c:if test="${list[i].PRODUCT_NAME != null and !list[i].PRODUCT_NAME.equals('')}">
			                                <tr>
			                                    <td><input type="text" class="text_1" name="pName" value="${list.get(i).PRODUCT_NAME}"></td>
			                                    <td><input type="text" class="text_2" name="size" value="${list.get(i).PRODUCT_SIZE}"></td>
			                                    <td><input type="number"  min="1" class="text_3" name="amount" value="${list.get(i).QUANTITY}"></td>
			                                    <td><input type="text" class="unitprice" name="unitPrice" value="${list.get(i).UNIT_PRICE}" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')"></td>
			                                    <td><input type="text" class="price" name="price" value="${list.get(i).PRICE}" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')"></td>
			                                    <td><input type="text" class="etc" name="etc" value="${list.get(i).NOTE}"></td>
			                                </tr>
																		   </c:if>			
																		</c:forEach>
										            </table>
										            <table class="content2">
		                                <tr>
		                                    <td class="label">합계</td>
		                                    <td><input type="text" name="totalSum" value="${ list.get(0).TOTAL_SUM }" oninput="this.value = this.value.replace(/[^0-9]/g, '').replace(/\d(?=(?:\d{3})+$)/g, '$&,')" required></td>
		                                </tr>
		                                <tr>
		                                    <td class="label">기타</td>
		                                    <td><textarea id="" cols="30" rows="10" name="etcList">${ list.get(0).ETC_CONTENT }</textarea></td>
		                                </tr>
                           			 </table>
										        </div>
										
										        <div id="btn_div">
										           <button class="btn btn-primary" id="insertBtn" type="submit" onclick="submitbtn();">제출</button>
                            	 <button type="reset" class="btn btn-danger" id="reset_btn">초기화</button>
										        </div>
										    </div>
										                        
                        
                        
                    </form>
                </div>
            </div>
        </div>
        
     <script>
     $(document).ready(function() {
         $(document).on('input', "input[name='amount'], input[name='unitPrice']", function() {
             var row = $(this).closest('tr');
             var amount = parseFloat(row.find("input[name='amount']").val().replace(/,/g, '')) || 0;
             var unitPrice = parseFloat(row.find("input[name='unitPrice']").val().replace(/,/g, '')) || 0;
             var price = amount * unitPrice;

             if(unitPrice !== ""){
                 row.find("input[name='price']").val(price.toLocaleString());
             } else {
                 row.find("input[name='price']").val("");
             }

             updateTotalSum();
         });

         function updateTotalSum() {
             var sum = 0;
             $("#tr_table").find("input[name='price']").each(function() {
                 var price = parseFloat($(this).val().replace(/,/g, '')) || 0;
                 sum += price;
             });
             $("input[name='totalSum']").val(sum.toLocaleString());
         }

         // 초기 페이지 로드시 총합을 계산
         updateTotalSum();
     });
    </script>
        
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
    		
    		$(".unitprice").each(function(){
    			$(this).val($(this).val().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    		})
    		
    		$(".price").each(function(){
    			$(this).val($(this).val().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
    		})
    		
    		
    		$("input[name='totalSum']").val($("input[name='totalSum']").val().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));

    	})
    
    
    </script>
     
    <script>
        document.querySelector("#myForm").addEventListener("submit", function(event) {
            if (confirm('정말로 제출하시겠습니까?')) {
                let valid = true;
                
                $(".hiddenSignName").each(function() {
                    if ($(this).val() == "null" || $(this).val() == "") {
                        alert("승인자를 3차까지 선택해주세요.");
                        event.preventDefault();
                        valid = false;
                        return false; // .each 루프 중지
                    }
                });
                
                if (!valid) {
                    event.preventDefault(); // 폼 제출 막기
                }
            } else {
                event.preventDefault(); // 확인 메시지에서 취소를 선택한 경우 폼 제출 막기
            }
        });
    </script>
    <script>
        $(document).ready(function() {
            $(document).on("click", "#plus_btn", function () {
                var result = "<tr>";
		                result += "<td><input type='text' class='text_1' name='pName'></td>";
		                result += "<td><input type='text' class='text_2' name='size'></td>";
		                result += "<td><input type='number' min='1' class='text_3' name='amount'></td>";
		                result += '<td><input type="text" class="text_4" name="unitPrice" oninput="this.value = this.value.replace(/[^0-9]/g, \'\').replace(/\\d(?=(?:\\d{3})+$)/g, \'$&,\')"></td>';
		                result += '<td><input type="text" class="text_5" name="price" oninput="this.value = this.value.replace(/[^0-9]/g, \'\').replace(/\\d(?=(?:\\d{3})+$)/g, \'$&,\')"></td>';
		                result += "<td><input type='text' class='text_6' name='etc'></td>";
		                result += "</tr>";
                $("#tr_table").append(result);
            });
            
            $(document).on("click", "#del_btn", function () {
                // 데이터 행이 있는 경우에만 삭제
                if ($("#tr_table tr").length > 2) {
                    $("#tr_table tr:last").remove();
                } else {
                    alert("삭제할 행이 없습니다.");
                }
            });
        });
    </script>
   
   
        
     <script>
        $('#modal').iziModal({
            title: '<h4 style="color:black">결재선지정</h4>',
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
        	title: '<h4 style="color:black">수신참조인</h4>',
            //subtitle: '수정도 가능합니다.',
            headerColor: '#FEEFAD', // 헤더 색깔
            theme: '', //Theme of the modal, can be empty or "light".
            //padding: '15px', // content안의 padding
            //radius: 10, // 모달 외각의 선 둥글기
            width: '500px',
           
        });
    </script>
        
        
        
   <jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
   
    
</body>
</html>