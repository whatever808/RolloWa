<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
		<!-- jQuery -->
		<script src="http://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- 모달 관련 -->
    <script src="${contextPath}/resources/js/iziModal.min.js"></script>
    <link rel="stylesheet" href="${contextPath}/resources/css/iziModal.min.css">
    
    <!-- 싸인 관련 -->
		<!-- <script src="https://code.jquery.com/jquery-1.12.4.min.js"></script> -->
		
		<!-- 기안서 공통 스타일 -->
    <link rel="stylesheet" href="${contextPath}/resources/css/pay/detail.css">
<style>
 .suBtn{
	 display: none;
 }
 .suBtn:hover{
	 display: none;
 }

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
	    			
	    			
	    			
	    			var data = signature.toDataURL("image/png");
	    	    const image = canvas.toDataURL();
	    	        
	    	    var approvalName = "${list.get(0).FIRST_APPROVAL == userName ? 1 : list.get(0).MIDDLE_APPROVAL == userName ? 2 : list.get(0).FINAL_APPROVAL == userName ? 3 : 0}" 
	    	    var formData = $("#formFix").serialize();
	    	    
	    	        $.ajax({
	    	        	url:"${contextPath}/pay/ajaxSign.do",
	    	        	type:"post",
	    	        	contentType: "application/x-www-form-urlencoded; charset=UTF-8", 
	    	        	data:{
	    	        		dataUrl:data,
	    	        		signName: "${userName}",
	    	        		approvalNo: "${list.get(0).APPROVAL_NO}",
	    	        		approvalSignNo: approvalName
	    	        	},
	    	        	success:function(response){
	    	        		
	    	        		console.log(response);
	    	        		
	    	        		if (response != "") {
	    	        		    alert("성공적으로 승인이 완료되었습니다.");

	    	        		    if (response.approvalSignNo == 1) {
	    	        		    	$('#firstSign').children().remove();
	    	        		    	$("#apDt1").children().remove();
	    	        		      $('#firstSign').append('<img src="' + response.sign[0].firstSign + '" alt="First Approval Signature"  id="imgcheck1">');
	    	        		      	if($("#apDt1").text() == ""){
	    			        		      $("#apDt1").append(response.sign[0].firstApDt);	
	    	        		      	}
	    	        		      	$("#approvalSt").empty();
														$("#approvalSt").text("진행");
	    	        		    } else if (response.approvalSignNo == 2) {
	    	        		    	$('#middleSign').children().remove();
	    		        		    $("#apDt2").children().remove();
	    	        		      $('#middleSign').append('<img src="' + response.sign[0].middleSign + '" alt="Middle Approval Signature" id="imgcheck2">');
	    	        		      if($("#apDt2").text() == ""){
	    		        		      $("#apDt2").append(response.sign[0].middleApDt);	
	            		      	}
	    	        		    } else if(response.approvalSignNo == 3){
	    	        		    	$('#finalSign').children().remove();
	    	        		    	$("#apDt3").children().remove();
		    	        		    $('#finalSign').append('<img src="' + response.sign[0].finalSign + '" alt="Final Approval Signature" id="imgcheck3">');
	    	        		    	if($("#apDt3").text() == ""){
	    	        		        $("#apDt3").append(response.sign[0].finalApDt);	        		    		
	    	        		    	}
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
					  $("#firstSign").append().html('<h1 style="color: red;" class="rejects" id="rejectCheck1">반려</h1>');
						  if($("#apDt1").text() == ""){
				        	$("#apDt1").append(list[0].firstApDt);	
		        	}
					  $("#approvalSt").empty();
						$("#approvalSt").text("진행");	
							
				  }else if(list[1].approvalSignNo == "2"){
					  alert("반려가 완료되었습니다.");
					  $("#middleSign").children().remove();
					  $("#apDt2").children().remove();
					  $("#middleSign").append().html('<h1 style="color: red;" class="rejects" id="rejectCheck2">반려</h1>');
						  if($("#apDt2").text() == ""){
		        		$("#apDt2").append(list[0].middleApDt);	
	    		  	}
							
				  }else{
					  alert("반려가 완료되었습니다.");
					  $("#finalSign").children().remove();
					  $("#apDt3").children().remove();
					  $("#finalSign").append().html('<h1 style="color: red;" class="rejects" id="rejectCheck3">반려</h1>');
						  if($("#apDt3").text() == ""){
		        		$("#apDt3").append(list[0].finalApDt);	
	    		  	}
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
								          <h1>지출결의서</h1>
								          <!--버튼 영역-->
								          <div id="btn_content">
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
       <c:if test="${ not empty refList }">
	        <div class="body">
	         		<table class="info-table" id="refTable">
	            		<tr>
	                    <th>수신참조인</th>
	                    <c:forEach var="item" items="${ refList }">
	                    <td>${item.REF_WRITER_NAME}</td>
	                    </c:forEach>
	                </tr>
	            </table>
	        </div>
        </c:if>
        <c:if test="${ list.get(0).MODIFY_TYPE eq 'S'}">
        	<table class="info-table">
      			<td style="border: 0px solid; text-align: end;">
      				<button type="button" class="btn btn-outline-primary" disabled>보완 보고서</button>
      			</td>
      		</table>
     		</c:if>
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
                    <td colspan="2">${list.get(0).TITLE}</td>
                </tr>
                 <tr>
                     <th>거래처</th>
                     <th>사용내역 및 용도</th>
                     <th>금액</th>
                 </tr>
                 <input type="hidden" name="fileLength" value="${ list.size() }">
                 
	               <c:forEach var="i" begin="0" end="${ list.size() - 1 }">
		                <c:if test="${ list.get(i).ACCOUNT != null and !list.get(i).ACCOUNT.equals('')}">
		                  		<tr>
		                      	<td>${ list.get(i).ACCOUNT }</td>
		                       	<td>${ list.get(i).CONTENT }</td>
		                       	<td class="amount">${ list.get(i).AMOUNT }</td>
		                  </tr>
		                </c:if>
                 	</c:forEach>
                 	
	                  <tr>
	                    <th colspan="2">합계</th>
	                    <td colspan="4" id="sums">${list.get(0).SUM}</td>
		                </tr>
		                <tr>
		                    <th colspan="2">부가가치세</th>
		                    <td colspan="4" id="vats">${list.get(0).VAT}</td>
		                </tr>
		                <tr>
		                    <th colspan="2">총 지출 합계</th>
		                    <td colspan="4" id="total_sum">${list.get(0).TOTAL_SUM}</td>
		                </tr>
		                <tr>
                    
                  	<c:choose>
									    <c:when test="${ not empty fileList }">
									    	<th colspan="2">파일 첨부</th>
										    <td colspan="4">
										      <c:forEach var="at" items="${ fileList }">
										        <a href="${contextPath}${at.ATTACH_PATH}/${at.MODIFY_NAME}" download="${at.ORIGIN_NAME}">${at.ORIGIN_NAME}</a><br>
										      </c:forEach>
										    </td>
									    </c:when>
									    <c:otherwise>
									    	
									    </c:otherwise>
								    </c:choose>
											
                		</tr>
            </table>
					       </div>
					      			<div id="modifybtn">
					           			<c:choose>
					      						<c:when test="${ list.get(0).DOCUMENT_STATUS == 'D' ||  list.get(0).DOCUMENT_STATUS == 'I' && list.get(0).PAYMENT_WRITER_NO == userNo}">
						           				<button class="btn btn-warning" class="modifyWriter" id=correction type="submit">수정</button>
						           			</c:when>
						           			<c:when test="${ list.get(0).DOCUMENT_STATUS == 'N' && list.get(0).PAYMENT_WRITER_NO == userNo}">
							           			<button class="btn btn-info" class="modifyWriter" id="secure" type="submit">보완</button>					      					
						           			</c:when>
					      					</c:choose>
					           			<c:choose>
													    <c:when test="${list.get(0).FINAL_APPROVAL.equals(userName)}">
													        <button class="btn btn-primary" id="lastbtn">완료</button>
													    </c:when>
													    <c:when test="${list.get(0).FIRST_APPROVAL.equals(userName)}">
													        <button class="btn btn-primary" id="firstbtn">완료</button>
													    </c:when>
													    <c:when test="${list.get(0).MIDDLE_APPROVAL.equals(userName)}">
													        <button class="btn btn-primary" id="middlebtn">완료</button>
													    </c:when>
													</c:choose>
					          	</div>
					          	<div style="display: flex; justify-content: flex-end;">
					          			<button class="delete-buttons" id="deldo" style="display: none;">삭제</button>
					          	</div>
					 				<div>
			           			<button id="historyBack" type="button" style="border: none; background-color: white;">
				           			<svg xmlns="http://www.w3.org/2000/svg" width="30" height="30" fill="currentColor" style="color: #e99db2;" class="bi bi-arrow-left-square-fill" viewBox="0 0 16 16">
												  <path d="M16 14a2 2 0 0 1-2 2H2a2 2 0 0 1-2-2V2a2 2 0 0 1 2-2h12a2 2 0 0 1 2 2zm-4.5-6.5H5.707l2.147-2.146a.5.5 0 1 0-.708-.708l-3 3a.5.5 0 0 0 0 .708l3 3a.5.5 0 0 0 .708-.708L5.707 8.5H11.5a.5.5 0 0 0 0-1"/>
												</svg>
											</button>							        
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
            $(".amount").each(function() {
                $(this).text($(this).text().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            });

            $("#sums").text($("#sums").text().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            $("#vats").text($("#vats").text().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
            $("#total_sum").text($("#total_sum").text().toString().replace(/\B(?=(\d{3})+(?!\d))/g, ","));
        });
    </script>
		    
		    
		<script>
    $(document).ready(function() {
        // 페이지가 로드될 때 sessionStorage에서 데이터 불러오기
        if (sessionStorage.getItem('DATA')) {
            $('#input_text').val(sessionStorage.getItem('DATA'));
        }

        // input_text의 값이 변경될 때마다 sessionStorage에 저장
        $('#input_text').on('input', function() {
            sessionStorage.setItem('DATA', $(this).val());
        });

        // 뒤로가기 버튼 클릭 시 이벤트
        $('#historyBack').on('click', function() {
            // 여기서는 페이지 이동을 위한 코드 추가 (예: window.history.back();)
        	location.href = document.referrer;
        });
    });

    // 페이지가 다시 로드될 때 sessionStorage에서 데이터 불러오기
    window.onpageshow = function(event) {
        if (event.persisted || (window.performance && (window.performance.navigation.type == 1 || window.performance.navigation.type == 2))) {
            if (sessionStorage.getItem('DATA')) {
                $('#input_text').val(sessionStorage.getItem('DATA'));
            }
        }
    };
    		
    
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
                       		 
                       		 function redAlert(title, message) {
                            	    $('#redModal').iziModal('setTitle', title);
                            	    $('#redModal').iziModal('setSubtitle', message);
                            	    $('#redModal').iziModal('open');
		                        	}
		
		                        	redAlert("게시글 삭제", "신청서가 정상적으로 삭제되었습니다.");
		
		                        	setTimeout(function() {
		                        	    location.href = document.referrer;
		                        	}, 3000);
		                        	
                            } else {
                                console.log("ajax 통신 실패");
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
		   $(document).ready(function(){
			    if("${list.get(0).DOCUMENT_STATUS}" == "Y" || "${list.get(0).DOCUMENT_STATUS}" == "N"){
			        $("#lastbtn").css("visibility", "hidden");
			        $("#firstbtn").css("visibility", "hidden");
			        $("#middlebtn").css("visibility", "hidden");
			    }
				});
		   
		   $(document).ready(function() {
				  
			    var approvalSt = "${list.get(0).DOCUMENT_STATUS}"
			    var paymentWriterNo = "${list.get(0).PAYMENT_WRITER_NO}";
			    var userName = "${userName}";
			    var userNo = "${userNo}";
			    
			 		// 수정 버튼 표시 여부 결정
			    if (paymentWriterNo != userNo) {
			    	$(".modifyWriter").css("display", "none");
			    }
			   
			 		

		   		if(paymentWriterNo == userNo){
		   			$("#deldo").css("display", "block");
		   		}
		   			
			    
			    if (approvalSt == "D" || approvalSt == "I") {
			        const firstApproval = "${list.get(0).FIRST_APPROVAL}";
			        const middleApproval = "${list.get(0).MIDDLE_APPROVAL}";
			        const finalApproval = "${list.get(0).FINAL_APPROVAL}";

			        const isSignedOrRejected1 = $("#img1").length || $("#reject1").length;
			        const isSignedOrRejected2 = $("#img2").length || $("#reject2").length;

			        if (firstApproval === userName) {
			            $(".suBtn").css("display", "block");
			        } else if (middleApproval === userName && isSignedOrRejected1) {
			        	// 첫 번째 승인자가 싸인을 한 경우에만 두 번째 승인자에게 버튼을 보여줌
			            $(".suBtn").css("display", "block");
			        } else if (finalApproval === userName && isSignedOrRejected1 && isSignedOrRejected2) {
			           // 첫 번째와 두 번째 승인자가 싸인을 한 경우에만 세 번째 승인자에게 버튼을 보여줌
			            $(".suBtn").css("display", "block");
			        }
			    }
			    
			    // 반려 사유 버튼 표시 여부 결정
			    if ("${list.get(0).CANCELLATION_CONTENT}" !== "" && paymentWriterNo === "${userNo}") {
			        $("#rejectContentBtn").css("display", "block");
			    }
			    
			    
			});
		   
		  //---------세번째 승인자의 완료버튼--------------
		  $("#lastbtn").on("click", function() {
		    if ($("#imgcheck3").length != 0 || $("#rejectCheck3").length != 0) {
		        submitLast();
		    } else {
		        alert("승인처리를 완료해주세요.");
		    }
			});
		  
		  function submitLast() {
			    // 결재를 완료하시겠습니까? 라는 확인 창을 띄운다.
			    if (confirm('결재을 완료하시겠습니까?')) {
			        
			        // 결재 상태가 "반려"인 경우를 확인한다.
			        if ("${sign.get(0).firstSign}" == "반려" || "${sign.get(0).middleSign}" == "반려" || ($("#rejectCheck3").length != 0 || "${sign.get(0).finalSign}" == "반려")) {
			            
			            // 상태가 "반려"일 경우 AJAX 요청을 통해 결재를 처리한다.
			            $.ajax({
			                url: "${contextPath}/pay/ajaxApprovalprocessing.do",
			                type: "post",
			                data: { status: "N", approvalNo: "${list.get(0).APPROVAL_NO}" },
			                success: function(response) {
			                	 if (response == 1) {
	                                	
			                		 	function yellowAlert(title, content){
			                	          $('#yellowModal').iziModal('setTitle', title);
			                	          $('#yellowModal').iziModal('setSubtitle', content);
			                	          $('#yellowModal').iziModal('open');
			                	    };
	
		                       	redAlert("전자결재", "결재가 최종승인 완료되었습니다.");
		
		                       	setTimeout(function() {
		                       	    location.href = document.referrer;
		                       	}, 3000);
	                      	}
			                },
			                error: function() {
			                    console.log("ajax통신 실패");
			                }
			            });

			        // 결재가 "반려"가 아니고 필요한 이미지가 모두 있는 경우를 확인한다.
			        } else if ($("#img1").length != 0 && $("#img2").length != 0 && ($("#img3").length != 0 || $("#imgcheck3").length != 0)) {
			            
			            // 상태가 "Y"일 경우 AJAX 요청을 통해 결재를 처리한다.
			            $.ajax({
			                url: "${contextPath}/pay/ajaxApprovalprocessing.do",
			                type: "post", 
			                data: { status: "Y", approvalNo: "${list.get(0).APPROVAL_NO}" },
			                success: function(response) {
			                    if (response == 1) {
			                        
			                    	function redAlert(title, message) {
                                	    $('#redModal').iziModal('setTitle', title);
                                	    $('#redModal').iziModal('setSubtitle', message);
                                	    $('#redModal').iziModal('open');
                           	}

                           	redAlert("전자결재", "결재가 최종승인 완료되었습니다.");

                           	setTimeout(function() {
                           	    location.href = document.referrer;
                           	}, 3000);
                                	
			                    }
			                },
			                error: function() {
			                    console.log("ajax 통신 실패");
			                }
			            });
			        }
			    }
			}
		  //--------------------------------------
		  $("#firstbtn").on("click", function() {
			  
			    if ($("#imgcheck1").length != 0 || $("#rejectCheck1").length != 0) {
			        console.log($("#imgcheck1").length != 0 || $("#rejectCheck1").length != 0);
			        yellowAlert("전자결재", "결재 승인이 완료되었습니다.");

			     		setTimeout(function() {
			     	    location.href = document.referrer;
			     		}, 3000);
			    } else {
			    	console.log($("#imgcheck1").length != 0 || $("#rejectCheck1").length != 0);
			        alert("승인처리를 완료해주세요.");
			    }
			});
		  
		  //두번째 승인자의 완료버튼
		 $("#middlebtn").on("click", function() {
		    if ($("#imgcheck2").length != 0 || $("#rejectCheck2").length != 0) {
		        console.log($("#imgcheck2").length != 0 || $("#rejectCheck2").length != 0);
		        
		        yellowAlert("전자결재", "결재 승인이 완료되었습니다.");

		     		setTimeout(function() {
		     	    location.href = document.referrer;
		     		}, 3000);
		     		
		    } else {
		        alert("승인처리를 완료해주세요.");
		    }
			});
				  
		  
		  function yellowAlert(title, message) {
       	    $('#yellowModal').iziModal('setTitle', title);
       	    $('#yellowModal').iziModal('setSubtitle', message);
       	    $('#yellowModal').iziModal('open');
    	}
			
		 
		  $(document).ready(function(){
			  
			  var approvalSt = "${list.get(0).DOCUMENT_STATUS}";
			  var paymentWriterNo = "${list.get(0).PAYMENT_WRITER_NO}";
			  if (approvalSt == "Y" || approvalSt == "N") {
          $(".suBtn").css("display", "none");
	      }
		  })
		  
	  
  
     $('#modal3').iziModal({
         title: '반려된 사유.',
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
 
     
     
		$("#correction").on("click", function(){
    	
    	let writerNo = "${ not empty list && (list.get(0).DOCUMENT_STATUS == 'N' || list.get(0).DOCUMENT_STATUS == 'D') && userNo == list.get(0).PAYMENT_WRITER_NO }";
    	
    	if(writerNo == "true"){
	    	 	if(confirm('수정하시겠습니까?')){
						alert("작성페이지로 이동합니다.");
							location.href="${contextPath}/pay/modify.do?documentNo=" + ${list.get(0).DRAFT_NO} 
																									 			+ "&approvalNo=" + ${list.get(0).APPROVAL_NO} 
																								 	 			+ "&payWriterNo=" + ${list.get(0).PAYMENT_WRITER_NO} 
																									 			+ "&payWriter=${list.get(0).PAYMENT_WRITER}"
																									 			+ "&report=j"
																									 			+ "&type=C";
	    		}
    	}else{
    		alert("결재가 진행된 상태이므로 수정이 불가능합니다.");
    	}
   
    })
    </script>
    <script>

		$("#secure").on("click", function(){
    	
    	let writerNo = "${ not empty list && (list.get(0).DOCUMENT_STATUS == 'N' || list.get(0).DOCUMENT_STATUS == 'D') && userNo == list.get(0).PAYMENT_WRITER_NO }";
    	
    	if(writerNo == "true"){
	    	 	if(confirm('수정하시겠습니까?')){
						alert("작성페이지로 이동합니다.");
							location.href="${contextPath}/pay/modify.do?documentNo=" + ${list.get(0).DRAFT_NO} 
																									 			+ "&approvalNo=" + ${list.get(0).APPROVAL_NO} 
																								 	 			+ "&payWriterNo=" + ${list.get(0).PAYMENT_WRITER_NO} 
																									 			+ "&payWriter=${list.get(0).PAYMENT_WRITER}"
																									 			+ "&report=j"
																									 			+ "&type=S";
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