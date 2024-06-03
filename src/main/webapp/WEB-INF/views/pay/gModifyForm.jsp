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
    
      <!-- TinyMCE 에디터 CDN 연결 -->
	   <script src="https://cdn.tiny.cloud/1/kv8msifnng66ha7xgul5sc6cehyxcp480zm27swyti7b7u38/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
	   <!-- TinyMCE 관련 스크립트 -->
	   <script src="${ contextPath }/resources/js/board/editor.js"></script>
   	
<style>

body {
    font-family: Arial, sans-serif;
    margin: 0;
    padding: 20px;
    background-color: #f9f9f9;
}

.document {
    max-width: 800px;
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
.origin_del{cursor: pointer; font-size: 20px;}
.attach a{color: black;}

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
			
		
		$(document).on("keypress", "#userSearch", function(ev){
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

       <!-- content 추가 -->
        <div class="content p-4">
            <!-- 프로필 영역 -->
            <div class="informations">
                <!-- informations left area start -->
                <div class="left_con">
		                <form action="${contextPath}/pay/gReportUpdate.do" method="post" id="myForm" enctype="multipart/form-data">
		                   <input type="hidden" name="deptName" value="${member.get(0).teamName}">
                       <input type="hidden" name="approvalNo" value="${list.get(0).APPROVAL_NO}">
                       <input type="hidden" name="reportType" value="${list.get(0).REPORT_TYPE}">
                       <input type="hidden" name="draftNo" value="${list.get(0).APPROVAL_NO}">
                       <input type="hidden" name="writerNo" value="${userNo}">
                       <input type="hidden" name="salesNo" value="${list.get(0).SALES_NO}">
                       <input type="hidden" name="firstApproval" id="first_name" class="hiddenSignName" value="${ list.get(0).FIRST_APPROVAL }">
		                   <input type="hidden" name="middleApproval" id="middle_name" class="hiddenSignName" value="${ list.get(0).MIDDLE_APPROVAL }">
		                   <input type="hidden" name="finalApproval" id="last_name" class="hiddenSignName" value="${ list.get(0).FINAL_APPROVAL }"> 
											 <input type="hidden" name="payWriter" value="${list.get(0).PAYMENT_WRITER}">
                       <input type="hidden" name="payWriterNo" value="${list.get(0).PAYMENT_WRITER_NO}">
		                   <div class="document">
										        <h1 class="title2">기안서</h1>
										
										        <div class="header2">
										            <table>
										                <tr>
										                    <td class="label">부서</td>
										                    <td class="value" colspan="3">${member.get(0).teamName}</td>
										                </tr>
										                <tr>
										                    <td class="label">기안자</td>
										                    <td class="value" colspan="4">${member.get(0).userName}</td>
										                    <input type="hidden" name="writerName" value="${member.get(0).userName}">
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
										                    <td class="value" colspan="4"><input type="text" name="title" value="${ list.get(0).TITLE }" required></td>
										                </tr>
										            </table>
										        </div>
										        <div class="content2">
										            <table id="tr_table">
										               <tr>
                                    	<td class="label">시행일자</td>
                                    	<td class="value"><input type="date" name="dateStart" required></td>
                                    	<td class="label">협조부서</td>
                                    	<td class="value"><input type="text" name="depWith" value="${ list.get(0).COOPERATION_DEPARTMENT }" required></td>
                               		 </tr>
			                             <tr>
	                                    <td colspan="4" class="value" class="value">
	                                        <textarea class="form-control" name="content" id="editor" required>${ content }</textarea>
	                                    </td>
			                             </tr>
			                             <tr>
	                                    <c:choose>
	                                    <c:when test="${ not empty list }">
	                                    <td class="label">기존첨부파일</td>
		                                    <td colspan="3">
			                                    <c:forEach var="at" items="${ list }">
				                                  	<div class="attach">
					                                    <a href="${ contextPath }${ at.ATTACH_PATH }/${ at.MODIFY_NAME }" download="${ at.ORIGIN_NAME }">${ at.ORIGIN_NAME }</a>
					                                    <span class="origin_del" data-fileno="${ at.FILE_NO }">
					                                    	<svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-x-square" viewBox="0 0 16 16">
																								  <path d="M14 1a1 1 0 0 1 1 1v12a1 1 0 0 1-1 1H2a1 1 0 0 1-1-1V2a1 1 0 0 1 1-1zM2 0a2 2 0 0 0-2 2v12a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V2a2 2 0 0 0-2-2z"/>
																								  <path d="M4.646 4.646a.5.5 0 0 1 .708 0L8 7.293l2.646-2.647a.5.5 0 0 1 .708.708L8.707 8l2.647 2.646a.5.5 0 0 1-.708.708L8 8.707l-2.646 2.647a.5.5 0 0 1-.708-.708L7.293 8 4.646 5.354a.5.5 0 0 1 0-.708"/>
																								</svg>
																							</span>
					                                  </div>	                                    
			                                    </c:forEach>
		                                    </td>
	                                    </c:when>
	                                    <c:otherwise>
	                                    </c:otherwise>
	                                    </c:choose>
		                               </tr>
		                               <tr>
		                               		<td class="label">첨부파일</td>
	                                    <td colspan="3"><input type="file" name="uploadFiles" required multiple></td>
		                               </tr>
										            </table>
										        </div>
										
										        <div id="btn_div">
										           <button class="btn btn-primary" id="insertBtn" type="submit">제출</button>
                            	 <button type="reset" class="btn btn-danger" id="reset_btn">초기화</button>
										        </div>
										    </div>
										                        
                        
                        
                    </form>
                </div>
            </div>
        </div>
        
    <script>
    	$(document).on("click", ".origin_del", function(){
    		
    		let inputEl = document.createElement("input");
    		inputEl.value=$(this).data("fileno");
    		inputEl.name="delFileNo";
    		inputEl.type="hidden";
    		
    		$(".header2").append(inputEl);
    	
    		$(this).closest(".attach").remove();
    		// CSS 선택자와 일치하는 가장 가까운(closest) 상위 조상 요소를 찾아서 반환
    	})
    </script>
        
    <c:if test="${ not empty list }">
    <script>
    	$(document).ready(function(){
    			$("#status").val("${list.get(0).PAYMENT_STATUS}");
    	})
    </script>
    </c:if>
     
    
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