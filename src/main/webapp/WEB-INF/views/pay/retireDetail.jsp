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
<style>
    .approval-form {
    width: 70%;
    margin: 0 auto;
    padding: 20px;
    background-color: #f7f7f7;
    border-radius: 5px;
    }

    /* 제목 스타일 */
    .form-title {
        font-size: 30px;
        font-weight: bold;
        color: #333;
    }

    /* 항목 레이블 스타일 */
    .form-label {
        font-weight: bold;
        margin-bottom: 5px;
        color: #666;
    }
    
    .m_content_style {
            display: flex;
            flex-direction: column;
     }
 
    #btn_div button{margin: 10px; margin-top: 50px;}
    
    
		#signature { border:1px solid #000; }
		#save, #clear { padding:5px 20px; border:0; color:#fff; background:#000; margin-top:5px; }
		
		.sg>img{width: 100%; height: 100%;}
		.sg{width: 179px; height: 133px;}
		
		/* 기본 스타일 리셋 */
* {
    margin: 0;
    padding: 0;
    box-sizing: border-box;
}

body {
    font-family: Arial, sans-serif;
    background-color: #f7f7f7;
    color: #333;
    line-height: 1.6;
    padding: 20px;
}

/* 문서 컨테이너 스타일 */
.document-container {
    max-width: 1095px;
    margin: 0 auto;
    padding: 20px;
    background-color: #fff;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
    border-radius: 8px;
}

/* 헤더 스타일 */
.header {
    text-align: center;
    margin-bottom: 20px;
}

.header h1 {
    font-size: 2em;
    color: #333;
    margin-bottom: 10px;
}

.approval-info {
    display: flex;
    justify-content: flex-end;
}

.approval-box {
    width: 20%;
    text-align: center;
    border: 1px solid #ddd;
    padding: 10px;
    border-radius: 8px;
    background-color: #f9f9f9;
    margin: 10px;
}

.approval-title {
    font-weight: bold;
    margin-bottom: 5px;
}

.approval-name {
    margin-bottom: 5px;
}
.approval-sign{
		width: 100%;
    height: 119px;
} 

.approval-date {
    color: #777;
    font-size: 0.9em;
}

/* 정보 테이블 스타일 */
.info-table, .content-table {
    width: 100%;
    border-collapse: collapse;
    margin-bottom: 20px;
}

.info-table th, .info-table td, .content-table th, .content-table td {
    border: 1px solid #ddd;
    padding: 10px;
    text-align: left;
}

.info-table th {
    background-color: #f9f9f9;
    width: 15%;
}

.content-table th {
    width: 10%;
    background-color: #f9f9f9;
}

.content-table .content {
    padding: 20px;
    line-height: 1.8;
}
#btn_content{
		display: flex;
    flex-wrap: nowrap;
    align-content: center;
    flex-direction: row-reverse;
}
#btn_content button{
	margin: 10px;
}
#modifybtn{    
		display: flex;
    justify-content: center;
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
	    		alert("정말로 승인을 하시겠습니까?");
	        var data = signature.toDataURL("image/png");
	        const image = canvas.toDataURL();
	        
	        
	        
	        var approvalName = "${list.get(0).FIRST_APPROVAL == userName ? 1 : list.get(0).MIDDLE_APPROVAL == userName ? 2 : list.get(0).FINAL_APPROVAL == userName ? 3 : 0}" 
	        
	        $.ajax({
	        	url:"${contextPath}/pay/ajaxSign.do",
	        	type:"post",
	        	data:{
	        		dataUrl:data,
	        		signName:"${userName}",
	        		no:"${list.get(0).APPROVAL_NO}",
	        		approvalSignNo:approvalName
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
	        		        
	        		    } else if (response.approvalSignNo == 2) {
	        		    	$('#middleSign').children().remove();
		        		    $("#apDt2").children().remove();
	        		      $('#middleSign').append('<img src="' + response.sign[0].middleSign + '" alt="Middle Approval Signature">');
	        		      if($("#apDt2").text() == ""){
		        		      $("#apDt2").append(response.sign[0].middleApDt);	
        		      	}
	        		    } else {
	        		    	$('#finalSign').children().remove();
	        		    	$("#apDt3").children().remove();
	        		      $('#finalSign').append('<img src="' + response.sign[0].finalSign + '" alt="Final Approval Signature">');
	        		    	if($("#apDt3").text() == ""){
	        		        $("#apDt3").append(response.sign[0].finalApDt);	        		    		
	        		    	}
	        		    }
	        		}
	              
	        		
	        	}
	        })
	        
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
                
                   
	                   <div class="document-container">
        <div class="header">
            <h1>매출보고서</h1>
            <!--버튼 영역-->
            <div id="btn_content">
			        <c:if test="${ not empty list and list.get(0).FINAL_APPROVAL == userName }  ">
		             <div id="btn_div">
		                 <button class="btn btn-warning" id="end_button" onclick="successbtn();">최종승인</button>
		             </div>                        	
		           </c:if>
		          	<div>
		          			<button class="btn btn-danger" data-izimodal-open="#modal2">승인</button>
		          	</div>
		         </div>
           <!------------>
           
           
             <div class="approval-info">
                <div class="approval-box">
                    <div class="approval-title">1차승인자</div>
                    <div class="approval-name">${list.get(0).FIRST_APPROVAL}</div>
                    <div class="approval-sign sg" id="firstSign">
                    <c:if test="${sign.get(0).firstSign != null}">
                    <img src="${sign.get(0).firstSign}">
                    </c:if>
                    </div>
                    <div class="approval-date" id="apDt1">${list.get(0).FIRST_APPROVAL_DATE}</div>
                </div>
                <div class="approval-box">
                    <div class="approval-title">2차승인자</div>
                    <div class="approval-name">${list.get(0).MIDDLE_APPROVAL}</div>
                    <div class="approval-sign sg" id="middleSign">
                    <c:if test="${sign.get(0).middleSign != null}">
                      <img src="${sign.get(0).middleSign}">
                    </c:if>
                    </div>
                    <div class="approval-date" id="apDt2">${list.get(0).MIDDLE_APPROVAL_DATE}</div>
                </div>
                <div class="approval-box">
                    <div class="approval-title">3차승인자</div>
                    <div class="approval-name">${list.get(0).FINAL_APPROVAL}</div>
                    <div class="approval-sign sg" id="finalSign">
                    <c:if test="${sign.get(0).finalSign != null}">
                    	<img src="${sign.get(0).finalSign}">
                    </c:if>
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
                    <td>이유준</td>
                    <th>상태</th>
                    <td>${list.get(0).PAYMENT_STATUS}</td>
                    <th>승인상태</th>
                    <td>${list.get(0).DOCUMENT_STATUS == 'I' ? '진행중' : '완료'}
                    
                    <c:if test="${ not empty list and list.get(0).CANCELLATION_CONTENT != null }">
			         				<button class="btn btn-danger" data-izimodal-open="#modal">반려사유 확인하기</button>
			        			</c:if>
                    
                    </td>
                    
                </tr>
            </table>
            <table class="content-table">
                
                <tr>
                    <th>제목</th>
                    <td colspan="2">2017년 1차 3/4분기 다음 지침의 건</td>
                </tr>
                 <tr>
                     <th>시작일</th>
                     <td>${ list.get(0).START_PERIOD }</td>
                     <th>마지막일</th>
                     <td>${ list.get(0).LAST_PERIOD }</td>
                 </tr>
                  <tr>
                      <th style="width: 150px;">사유</th>
                      <td colspan="3">${list.get(0).RETIRE_CONTENT}</td>
                  </tr>
            </table>
					        </div>
					      			<div id="modifybtn">
					           			<button class="btn btn-warning" id="modifyWriter" type="submit" style="display: none;">수정</button>
					          			<button class="btn btn-primary" onclick="submitbtn();" class="apbtn" style="display: none;">완료</button>
		               				<button class="btn btn-danger" data-izimodal-open="#modal" class="apbtn" style="display: none;">반려</button>
					          	</div>
					 				</div> 
                </div>
            </div>
        </div>
        
        <div id="modal2">
		        <div class="m_content_style"  >
		        <canvas id="signature" width="600" height="200"></canvas>
                <div>
									<button id="save">Save</button>
									<button id="clear">Clear</button>
								</div>      
		        </div>
		    </div>
        
   
       
    		 <div id="modal">
		        <div class="m_content_style">
		            내용 : <textarea style="height: 300px;" required name="calcellation" id="calcellation"></textarea>
				        <div style="display: flex; justify-content: end; align-items: end; margin: 10px;">
				        	<button class="btn btn-danger" onclick="reject();">확인</button>
				        </div>
		        </div>
		    </div>
        
    <script>
    $(document).ready(function() {
        if("${list.get(0).PAYMENT_WRITER_NO}" == "${userNo}") {
            $("#modifyWriter").css("display", "block");
        }
        
        if("${list.get(0).FIRST_APPROVAL}" == "${userName}" ||
        		"${list.get(0).MIDDLE_APPROVAL}" == "${userName}" || 
        		"${list.get(0).FINAL_APPROVAL}" == "${userName}"){
        	 $(".apbtn").css("display", "block");
        })
    });
    </script>
        
        
		<script>
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
    </script>	
    <script>
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
    </script>	
    
    <script>
    
    $("#modifyWriter").on("click", function(){
    	
    	let writerNo = "${ not empty list and list.get(0).FIRST_APPROVAL_DATE == null and userNo == list.get(0).PAYMENT_WRITER_NO }";
    	
    	if(writerNo == "true"){
	    	 	if(confirm('수정하시겠습니까?')){
						alert("작성페이지로 이동합니다.");
							location.href="${contextPath}/pay/modify.do?documentNo=" + ${list.get(0).EXPEND_NO} 
																									 			+ "&approvalNo=" + ${list.get(0).APPROVAL_NO} 
																								 	 			+ "&payWriterNo=" + ${list.get(0).PAYMENT_WRITER_NO} 
																									 			+ "&payWriter=${list.get(0).PAYMENT_WRITER}"
																									 			+ "&report=m";
	    		}
    	}else{
    		alert("결재가 진행된 상태이므로 수정이 불가능합니다.");
    	}
   
    })
    </script>
    
    <script>
      function reject(){
    	  
    	  if(confirm('반려를 완료하시겠습니까?')){
    		   location.href='${contextPath}/pay/reject.do?no=' + ${list.get(0).APPROVAL_NO} + "&content=" + $("#calcellation").val();
    	  }
    	  
      }
    </script>

    <script>
        function submitbtn(){
            let sbtn = confirm('결재을 완료하시겠습니까?');
            if(sbtn == true){
                alert("결재가 완료되었습니다.");
            }
        }
        
        function successbtn(){
            if(confirm("결재를 최종승인 하시겠습니까?")){
                alert("최종승인이 완료되었습니다.");
            }
            
        }       	
       
    </script>
        
        
        
        <jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
        <!-- content 끝 -->
    </main>

</body>
</html>