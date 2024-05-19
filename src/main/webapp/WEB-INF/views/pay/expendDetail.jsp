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
    #table_y{ width: 800px; display: flex; flex-direction: column;  margin: auto; text-align: center;}
    #table_y tbody{width: 800px;}
    #table_y th{ border: 1px solid gray;}
    #table_y td{ border: 1px solid gray;}
    #tr_style th{width: 95px; text-align: center;}
    #tr_style td{width: 160px;}
    #text_div{margin: auto; border: 1px solid black; height:300px;}
    .tables{margin-top: -7px;}
    #text_div_bottom{margin: auto; display: flex; justify-content: center; align-items: center; flex-direction: column; margin-top:-11px; }
    #text_div{display: flex; flex-direction: column; justify-content: end; align-items: center; width: 800px;}
    #text_div div{margin: 20px;}
    #writer{display: flex; justify-content: end; width: 700px;}
    
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
	    		
	        var data = signature.toDataURL("image/jpeg");
	        const image = canvas.toDataURL();
	        
	        console.log(data);
	        console.log(image);
	        /*
	        const link = document.createElement("a");
	        link.href = image;
	        link.download = "PaintJS[🎨]";
	        link.click();
	        */
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
	        	success:function(result){
	        		if(result == "SUCCESS"){
	        			alert("승인이 완료되었습니다.");
	        		}
	        	},
	        	error:function(){
	        		
	        	}
	        	
	       
	        	
	        })
	        
	        
	        //window.open(data, "test", "width=600, height=200, scrollbars=no");
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
                
                   
	                    <div id="table_y">
	
								        <div>
								            <table border="1"  class="form-label table">
								                <tr>
								                    <th colspan="9" rowspan="3" style="width: 400px;" class="form-title" >매출 보고서</th>
								                    <th style="width: 120px;">${list.get(0).FIRST_APPROVAL}</th>
								                    <th style="width: 120px;">${list.get(0).MIDDLE_APPROVAL}</th>
								                    <th style="width: 120px;">${list.get(0).FINAL_APPROVAL}</th>
								                </tr>
								                <tr>
								                    <td style="height: 80px;"></td>
								                    <td>
									                    <c:if test="${list.get(0).FIRST_APPROVAL eq userName}">
									                    	<button class="btn btn-danger" data-izimodal-open="#modal2">싸인</button>
									                    </c:if>
								                    </td>
								                    <td>
									                    <c:if test="${list.get(0).FIRST_APPROVAL eq userName}">
									                    	<button class="btn btn-danger" data-izimodal-open="#modal2">싸인</button>
									                    </c:if>
								                    </td>
								                </tr>
								                <tr>
								                    <td>${list.get(0).FIRST_APPROVAL_DATE}</td>
								                    <td>${list.get(0).MIDDLE_APPROVAL_DATE}</td>
								                    <td>${list.get(0).FINAL_APPROVAL_DATE}</td>
								                </tr>
								            </table>    
								        </div>
								
								        <div>
								            <table border="1" class="form-label table">
								                <tr id="tr_style">
								                    <th>부서</th>
								                    <td>${list.get(0).DEPARTMENT}</td>
								                    <th>상태</th> 
								                    <td>${list.get(0).PAYMENT_STATUS}</td>
								                </tr>
								            </table>
								        </div>
								
								        <div>
								            <table border="1" class="form-label table">
								                <tr>
								                    <th style="width: 200px;">매출구분</th>
								                    <td style="width: 200px;">${ list.get(0).SALES_DIVISION }</td>
								                    <th style="width: 200px;">담당자</th>
								                    <td>${ list.get(0).MANAGER_NAME }</td>
								                </tr>
								                <tr>
								                    <th colspan="4" style="text-align: center;">매출정보</th>
								                </tr>
								                <tr>
								                    <th>품목</th>
								                    <th >수량</th>
								                    <th colspan="2">매출금액</th>
								                </tr>
								               	
								               	<c:forEach var="l" items="${list}">
		                                <tr>
		                                    <td>${l.ITEM}</td>
		                                    <td>${l.VOLUMES}</td>
		                                    <td colspan="2">${l.SALES_AMOUNT}</td>
		                                </tr> 			
                                </c:forEach>
                                
								                <tr>
								                    <th colspan="2">총매출금액(VAT별도)</th>
								                    <td colspan="2">${ list.get(0).TOTAL_SALES }</td>
								                </tr>
								            </table>    
								        </div>
								        
								        <div id="text_div_bottom" >
								            <div id="text_div" class="form-label">
								                <div>위와 같이 매출보고서를 제출합니다.</div>
								                <div>${list.get(0).REGIST_DATE}</div>
								                <div id="writer">
								                    <div>기안자 :  ${list.get(0).PAYMENT_WRITER} (인)</div>
								                </div>
								            </div>
								        </div>
								        
								        <!--버튼 영역-->
								        <c:if test="${ not empty list and list.get(0).CANCELLATION_CONTENT != null }">
								         		<button class="btn btn-danger" data-izimodal-open="#modal">반려사유 확인하기</button>
								        </c:if>
								        
								        <c:if test="${ not empty list and list.get(0).FIRST_APPROVAL == userName or list.get(0).MIDDLE_APPROVAL == userName or list.get(0).FINAL_APPROVAL == userName }  ">
	                        <div id="btn_div">
	                            <button class="btn btn-primary" onclick="submitbtn();" >완료</button>
	                          	<button class="btn btn-danger" data-izimodal-open="#modal">반려</button>
	                            <button class="btn btn-warning" id="end_button" onclick="successbtn();">최종승인</button>
	                        </div>                        	
                        </c:if>
                        <div>
                        		<c:if test="${ list.get(0).PAYMENT_WRITER_NO eq userNo}">
                         			<button class="btn btn-warning" id="modifyWriter" type="submit">수정</button>
                   					</c:if>
                      	</div>
                      	<div>
                      			<button class="btn btn-danger" data-izimodal-open="#modal2">승인</button>
                      	</div>
                        <!------------>
								
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