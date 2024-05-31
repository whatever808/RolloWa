<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

    <!-- 모달 관련 -->
    <script src="${contextPath}/resources/js/iziModal.min.js"></script>
    <link rel="stylesheet" href="${contextPath}/resources/css/iziModal.min.css">
    
    <!-- 싸인 관련 -->
		<!-- <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> -->
		
		<!-- 기안서 공통 스타일 -->
    <link rel="stylesheet" href="${contextPath}/resources/css/pay/detail.css">
<style>
</style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
		<script src="https://cdnjs.cloudflare.com/ajax/libs/signature_pad/1.5.3/signature_pad.min.js"></script>

<script>
$(document).ready(function(){
	var canvas = $("#signature")[0];
	var signature = new SignaturePad(canvas, {
	    minWidth: 2,
	    maxWidth: 2,
	    penColor: "rgb(0, 0, 0)"
	});
	
	$("#clear").on("click", function() {
	    signature.clear();
	});
	
	$("#save").on("click", function() {
	    if (signature.isEmpty()) {
	        alert("내용이 없습니다.");
	    } else {
	    		if(confirm("정말로 승인을 하시겠습니까?")){
	    			
	    			
	    			let productNameArr = [];
	    			for(let i=0; i<"${list.size()}"; i++){
	    				productNameArr.push("${list.get(i).PRODUCT_NAME}");
	    			}
	    			
	    			let productAmountArr = [];
	    			for(let i=0; i<"${list.size()}"; i++){
	    				productAmountArr.push("${list.get(i).QUANTITY}");
	    			}
	    			console.log("productNameArr :" + productNameArr);
	    			console.log("productAmountArr :" + productAmountArr);
	    			//var formdata = $("#form").sereailize();
	    			
	    			var data = signature.toDataURL("image/png");
	    	    const image = canvas.toDataURL();
	    	        
	    	    var approvalName = "${list.get(0).FIRST_APPROVAL == userName ? 1 : list.get(0).MIDDLE_APPROVAL == userName ? 2 : list.get(0).FINAL_APPROVAL == userName ? 3 : 0}" 
	    	        
	    	        $.ajax({
	    	        	url:"${contextPath}/pay/ajaxSign.do",
	    	        	type:"post",
	    	        	data:{
	    	        		dataUrl:data,
	    	        		signName:"${userName}",
	    	        		approvalNo:"${list.get(0).APPROVAL_NO}",
	    	        		approvalSignNo:approvalName,
	    	        		deptType:"Fix",
	    	        		fixName:productNameArr,
	    	        		fixAmount:productAmountArr
	    	        	},
	    	        	success:function(response){
	    	        		
	    	        		console.log(response);
	    	        		
	    	        		if (response != "") {
	    	        		    alert("성공적으로 승인이 완료되었습니다.");

	    	        		    if (response.approvalSignNo == 1) {
	    	        		    	$('#firstSign').children().remove();
	    	        		    	$("#apDt1").children().remove();
	    	        		      $('#firstSign').append('<img src="' + response.sign[0].firstSign + '" alt="First Approval Signature">');
	    	        		      	if($("#apDt1").text() == ""){
	    			        		      $("#apDt1").append(response.sign[0].firstApDt);	
	    	        		      	}
	    	        		      	$("#approvalSt").empty();
														$("#approvalSt").text("진행");
	    	        		    } else if (response.approvalSignNo == 2) {
	    	        		    	$('#middleSign').children().remove();
	    		        		    $("#apDt2").children().remove();
	    	        		      $('#middleSign').append('<img src="' + response.sign[0].middleSign + '" alt="Middle Approval Signature">');
	    	        		      if($("#apDt2").text() == ""){
	    		        		      $("#apDt2").append(response.sign[0].middleApDt);	
	            		      	}
	    	        		      $("#approvalSt").empty();
													$("#approvalSt").text("진행");
	    	        		    } else {
	    	        		    	$('#finalSign').children().remove();
	    	        		    	$("#apDt3").children().remove();
	    	        		      $('#finalSign').append('<img src="' + response.sign[0].finalSign + '" alt="Final Approval Signature">');
	    	        		    	if($("#apDt3").text() == ""){
	    	        		        $("#apDt3").append(response.sign[0].finalApDt);	        		    		
	    	        		    	}
	    	        		    	$("#approvalSt").empty();
	    										$("#approvalSt").text("승인");	
	    	        		    }
	    	        		}
	    	              
	    	        		$("#modal2").iziModal('close');
	    	        	}
	    	        })
	    			
	    		};
	        
	        
	    }
	});
});



$(document).on("click", "#rejectBtn", function(){
		
	 	var approvalName = "${list.get(0).FIRST_APPROVAL == userName ? 1 : list.get(0).MIDDLE_APPROVAL == userName ? 2 : list.get(0).FINAL_APPROVAL == userName ? 3 : 0}" 
  	  
	  if(confirm("정말로 반려하시겠습니까?")){
			$.ajax({
			  url:"${contextPath}/pay/ajaxReject.do",
			  type:"post",
			  data:{
				  approvalNo:"${list.get(0).APPROVAL_NO}",
					content:$("#calcellation").val(),
					approvalSignNo:approvalName
			  },
			  success:function(list){
				  
				  console.log(list);
				  if(list[1].approvalSignNo == "1"){
					  alert("반려가 완료되었습니다.");
					  $("#firstSign").children().remove();
					  $("#apDt1").children().remove();
					  $("#firstSign").append().html('<h1 style="color: red;" class="rejects">반려</h1>');
						  if($("#apDt1").text() == ""){
				        	$("#apDt1").append(list[0].firstApDt);	
		        	}
						  $("#approvalSt").empty();
							$("#approvalSt").text("반려");	
							
				  }else if(list[1].approvalSignNo == "2"){
					  alert("반려가 완료되었습니다.");
					  $("#middleSign").children().remove();
					  $("#apDt2").children().remove();
					  $("#middleSign").append().html('<h1 style="color: red;" class="rejects">반려</h1>');
						  if($("#apDt2").text() == ""){
		        		$("#apDt2").append(list[0].middleApDt);	
	    		  	}
						  $("#approvalSt").empty();
							$("#approvalSt").text("반려");	
							
				  }else{
					  alert("반려가 완료되었습니다.");
					  $("#finalSign").children().remove();
					  $("#apDt3").children().remove();
					  $("#finalSign").append().html('<h1 style="color: red;" class="rejects">반려</h1>');
						  if($("#apDt3").text() == ""){
		        		$("#apDt3").append(list[0].finalApDt);	
	    		  	}
						  $("#approvalSt").empty();
							$("#approvalSt").text("반려");	
					 }
				  $("#modal").iziModal('close');
					  
				  }
				
			  
			  
		  })
		  
	  }
	  
	  
})

	
</script>



        <!-- content 추가 -->
        <div class="content p-4">
            <!-- 프로필 영역 -->
            <div class="informations">
                <!-- informations left area start -->
                <div class="left_con">
                
                   
	                 <div class="document-container">
								      <div class="header">
								          <h1>비품신청서</h1>
								          <!--버튼 영역-->
								          <div id="btn_content">
									        <c:if test="${ not empty list and list.get(0).FINAL_APPROVAL == userName }  ">
								             <div id="btn_div">
								                 <button class="btn btn-warning" id="end_button" onclick="successbtn();">최종승인</button>
								             </div>                        	
								           </c:if>
								          	<div style="display: flex;">
								          			<button class="approve-button suBtn" data-izimodal-open="#modal2">승인</button>
								          			<button class="reject-button suBtn" data-izimodal-open="#modal">반려</button>
								          	</div>
								         </div>
								         <!------------>
								         
           
            <div class="approval-info">
                <div class="approval-box">
                    <div class="approval-title">1차승인자</div>
                    <div class="approval-name">${list.get(0).FIRST_APPROVAL}</div>
                    <div class="approval-sign sg" id="firstSign">
	                    <c:choose>
	                    	<c:when test="${sign.get(0).firstSign != null && sign.get(0).firstSign == '반려'}">
	                    		<h1 style="color: red;" class="rejects">반려</h1>
	                    	</c:when>
	                    	<c:when test="${sign.get(0).firstSign != null && sign.get(0).firstSign != '반려'}">
	                    		<img src="${sign.get(0).firstSign}" id="img1">
	                    	</c:when>
                    	</c:choose>
                    </div>
                    <div class="approval-date" id="apDt1">${list.get(0).FIRST_APPROVAL_DATE}</div>
                </div>
                <div class="approval-box">
                    <div class="approval-title">2차승인자</div>
                    <div class="approval-name">${list.get(0).MIDDLE_APPROVAL}</div>
                    <div class="approval-sign sg" id="middleSign">
                    	<c:choose>
	                    	<c:when test="${sign.get(0).middleSign != null && sign.get(0).middleSign == '반려'}">
	                    		<h1 style="color: red;" class="rejects">반려</h1>
	                    	</c:when>
	                    	<c:when test="${sign.get(0).middleSign != null && sign.get(0).middleSign != '반려'}">
	                    		<img src="${sign.get(0).middleSign}" id="img2">
	                    	</c:when>
                    	</c:choose>
                    </div>
                    <div class="approval-date" id="apDt2">${list.get(0).MIDDLE_APPROVAL_DATE}</div>
                </div>
                <div class="approval-box">
                    <div class="approval-title">3차승인자</div>
                    <div class="approval-name">${list.get(0).FINAL_APPROVAL}</div>
                    <div class="approval-sign sg" id="finalSign">
                    	<c:choose>
	                    	<c:when test="${sign.get(0).finalSign != null && sign.get(0).finalSign == '반려'}">
	                    		<h1 style="color: red;" class="rejects">반려</h1>
	                    	</c:when>
	                    	<c:when test="${sign.get(0).finalSign != null && sign.get(0).finalSign != '반려'}">
	                    		<img src="${sign.get(0).finalSign}" id="img3">
	                    	</c:when>
                    	</c:choose>
                    </div>
                    <div class="approval-date" id="apDt3">${list.get(0).FINAL_APPROVAL_DATE}</div>
                </div>
            </div>
        </div>
        <div class="body">
            <table class="info-table">
                <tr>
                    <th>기안부서</th>
                    <td>${list.get(0).DEPARTMENT}</td>
                    <th>기안일자</th>
                    <td>${list.get(0).REGIST_DATE}</td>
                    <th>문서번호</th>
                    <td>${list.get(0).APPROVAL_NO} </td>
                </tr>
                <tr>
                    <th>기안자</th>
                    <td>${list.get(0).PAYMENT_WRITER}</td>
                    <th>상태</th>
                    <td>${list.get(0).PAYMENT_STATUS}</td>
                    <th>승인상태</th>
                    <td id="approvalSt">${list.get(0).DOCUMENT_STATUS == 'I' ? '진행' : list.get(0).DOCUMENT_STATUS == 'N' ? '반려' : list.get(0).DOCUMENT_STATUS == 'D' ? "대기" : "완료" }
                    </td>
                </tr>
            </table>
            <div id="rej">
            		<button class="btn btn-danger" data-izimodal-open="#modal3" id="rejectContentBtn">사유 확인</button>
            </div>
            <table class="content-table">
                
                <tr>
                    <th>제목</th>
                    <td colspan="5">${ list.get(0).TITLE }</td>
                </tr>
                 <tr>
                     <th>품명</th>
                     <th>규격</th>
                     <th>수량</th>
                     <th>단가</th>
                     <th>가격</th>
                     <th colspan="2">비고</th>
                 </tr>
                 
								 <c:forEach var="i" begin="0" end="${ list.size() - 1 }">
		                <c:if test="${ list.get(0).PRODUCT_NAME != null and list.get(i).PRODUCT_NAME != ''}">
		                  		<tr>
		                      	<td>${ list.get(i).PRODUCT_NAME }</td>
		                       	<td>${ list.get(i).PRODUCT_SIZE }</td>
		                       	<td>${ list.get(i).QUANTITY }</td>
		                       	<td>${ list.get(i).UNIT_PRICE }</td>
		                       	<td>${ list.get(i).PRICE }</td>
		                       	<td>${ list.get(i).NOTE }</td>
		                  		</tr>
		                </c:if>
                 </c:forEach>
                 
                  <tr>
	                    <th colspan="3">합계</th>
	                    <td colspan="3">${list.get(0).TOTAL_SUM}</td>
	                </tr>
	                <tr>
		                  <th colspan="3">기타</th>
		                  <td colspan="3">${list.get(0).ETC_CONTENT}</td>
		               </tr>
            </table>
					        </div>
					      			<div id="modifybtn">
					           			<button class="btn btn-warning" id="modifyWriter" type="submit" style="display: none;">수정</button>
					          			<button class="btn btn-primary" onclick="submitbtn();" style="display: none;" id="aproS">완료</button>
					          	</div>
					          	<div style="display: flex; justify-content: flex-end;">
					          			<button class="delete-buttons" id="deldo">삭제</button>
					          	</div>
					 				</div> 
                </div>
            </div>
        </div>
        
       <!-------------- 승인싸인 모달창 ------------->
        <div id="modal2">
		        <div class="m_content_style"  >
		        <canvas id="signature" width="600" height="200"></canvas>
                <div id="saveDiv">
									<button id="save">승인</button>
									<button id="clear">Clear</button>
								</div>      
		        </div>
		    </div>
		    <!---------------------------------------->
		    
		    
		    <!-------------- 기인자 반려 사유 확인 모달창 ------------->
		   	<div id="modal3">
		        <div class="m_content_style">
		        	<div style="height: 300px"> ${list.get(0).CANCELLATION_CONTENT}</div>
		        </div>
		    </div>
		    <!-------------------------------------------->
		    
		    
		    <!-------------- 승인자 반려 사유 작성 모달 ------------->
    		<div id="modal">
		        <div class="m_content_style">
		            내용 : <textarea style="height: 300px; resize: none;" name="calcellation" id="calcellation" placeholder="자세하게 작성해주세요." required></textarea>
				        <div style="display: flex; justify-content: end; align-items: end; margin: 10px;">
				        	<button class="btn btn-danger" id="rejectBtn">확인</button>
				        </div>
		        </div>
		    </div>
		    <!---------------------------------------------->
		    
    <script>
		   $(document).ready(function() {
		   		if("${list.get(0).PAYMENT_WRITER_NO}" == "${userNo}"){
		   			$(".delete-buttons").css("display", "block");
		   		}
			   
		   })
		   
    	$(document).ready(function() {
        $("#deldo").on("click", function(){
            var isDeletable = "${ list.get(0).DOCUMENT_STATUS == 'D' && userNo == list.get(0).PAYMENT_WRITER_NO }";
            if(isDeletable == 'true') {
            	
                if(confirm("정말로 삭제하시겠습니까?")) {
                    $.ajax({
                        url: "${contextPath}/pay/ajaxApprovaldelete.do",
                        type: "GET",
                        data: {
                            no: "${list.get(0).APPROVAL_NO}"
                        },
                        success: function(response) {
                        	 if(response == "SUCCESS") {
                                 alert("삭제가 완료되었습니다.");
                                 history.back();
                                 setTimeout(function() {
                                     location.reload();
                                 }, 1); 
                             } else {
                                 alert("삭제 실패");
                             }
                        },
                        error: function() {
                            console.log("ajax 통신 오류");
                        }
                    });
                }
                
            } else {
                alert("결재가 진행된 상태이므로 삭제가 불가능합니다.");
            }
        });
    });
    
   
		   $(document).ready(function() {
				  
			    var approvalSt = $("#approvalSt").text().trim();
			    var paymentWriterNo = "${list.get(0).PAYMENT_WRITER_NO}";
			    var userName = "${userName}";
			    
			    // 수정 버튼 표시 여부 결정
			    if (approvalSt === "완료" && paymentWriterNo === "${userNo}") {
			    	  $("#modifyWriter").css("display", "none");
			    } else {
			        $("#modifyWriter").css("display", "block");
			    }
			    
			    // 승인 상태에 따라 버튼 표시 여부 결정
			    if (approvalSt !== "완료") {
			        if ("${list.get(0).FIRST_APPROVAL}" === userName) {
			            $(".suBtn").css("display", "block");
			        } else if ("${list.get(0).MIDDLE_APPROVAL}" === userName && $("#img1").length) {
			            // 첫 번째 승인자가 싸인을 한 경우에만 두 번째 승인자에게 버튼을 보여줌
			            $(".suBtn").css("display", "block");
			        } else if ("${list.get(0).FINAL_APPROVAL}" === userName && $("#img1").length && $("#img2").length) {
			            // 첫 번째와 두 번째 승인자가 싸인을 한 경우에만 세 번째 승인자에게 버튼을 보여줌
			            $(".suBtn").css("display", "block");
			        }
			    }
			    
			    // 반려 사유 버튼 표시 여부 결정
			    if ("${list.get(0).CANCELLATION_CONTENT}" !== "" && paymentWriterNo === "${userNo}") {
			        $("#rejectContentBtn").css("display", "block");
			    }
			    
			    // 승인/반려 버튼 표시 여부 결정
			    if ("${list.get(0).FIRST_APPROVAL}" === userName || "${list.get(0).MIDDLE_APPROVAL}" === userName || "${list.get(0).FINAL_APPROVAL}" === userName) {
			        $("#aproS").css("display", "block");
			    } else {
			        $(".suBtn").css("display", "none"); 
			    }
			});
		  
			  function submitbtn() {
				    if (confirm('결재을 완료하시겠습니까?')) {
				        var approvalSt = $("#approvalSt").text().trim();
				        if (approvalSt == "반려" || approvalSt == "완료") {
				            $(".suBtn").css("display", "none");
				            if (approvalSt == "완료") {
				                $("#modifyWriter").css("display", "none");
				            }
				        }
				        
				        alert("결재가 완료되었습니다.");
				        location.href = document.referrer;
				    }
				}
	  
    
       $('#modal3').iziModal({
           title: '반려(철회)된 사유.',
           headerColor: '#FEEFAD', // 헤더 색깔
           theme: '', //Theme of the modal, can be empty or "light".
           padding: '15px', // content안의 padding
           radius: 10, // 모달 외각의 선 둥글기
          
       });
       
       // 2. 요소에 이벤트가 일어 났을떄 모달이 작동
       $("#modal-test").on('click', function () {

           $('#modal3').iziModal('open'); // 모달을 출현

       });
       
       $('#modal').iziModal({
           title: '반려사유를 작성해주세요.',
           headerColor: '#FEEFAD', // 헤더 색깔
           theme: '', //Theme of the modal, can be empty or "light".
           padding: '15px', // content안의 padding
           radius: 10, // 모달 외각의 선 둥글기
          
       });
       
       // 2. 요소에 이벤트가 일어 났을떄 모달이 작동
       $("#modal-test").on('click', function () {

           $('#modal').iziModal('open'); // 모달을 출현

       });
       
       
       $('#modal2').iziModal({
           title: '싸인',
           headerColor: '#FEEFAD', // 헤더 색깔
           theme: '', //Theme of the modal, can be empty or "light".
           padding: '15px', // content안의 padding
           radius: 10, // 모달 외각의 선 둥글기
          
       });
       
       // 2. 요소에 이벤트가 일어 났을떄 모달이 작동
       $("#modal-test").on('click', function () {

           $('#modal2').iziModal('open'); // 모달을 출현

       });
   
    	$("#modifyWriter").on("click", function(){
    	
    	let writerNo = "${ not empty list && (list.get(0).DOCUMENT_STATUS == 'N' || list.get(0).DOCUMENT_STATUS == 'D') && userNo == list.get(0).PAYMENT_WRITER_NO }";
    	
    	if(writerNo == "true"){
	    	 	if(confirm('수정하시겠습니까?')){
						alert("작성페이지로 이동합니다.");
							location.href="${contextPath}/pay/modify.do?documentNo=" + ${list.get(0).FIX_NO} 
																									 			+ "&approvalNo=" + ${list.get(0).APPROVAL_NO} 
																								 	 			+ "&payWriterNo=" + ${list.get(0).PAYMENT_WRITER_NO} 
																									 			+ "&payWriter=${list.get(0).PAYMENT_WRITER}"
																									 			+ "&report=b";
	    		}
    	}else{
    		alert("결재가 진행된 상태이므로 수정이 불가능합니다.");
    	}
   
    })
    </script>
    
        
        
        
        <jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
        <!-- content 끝 -->
    </main>

</body>
</html>