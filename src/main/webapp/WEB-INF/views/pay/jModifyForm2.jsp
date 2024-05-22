<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
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
    
    
    <!-- TinyMCE 에디터 CDN 연결 -->
	   <script src="https://cdn.tiny.cloud/1/kv8msifnng66ha7xgul5sc6cehyxcp480zm27swyti7b7u38/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
	   <!-- TinyMCE 관련 스크립트 -->
	   <script src="${ contextPath }/resources/js/board/editor.js"></script>
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
	    BACKGROUND: WHITE;
	    BORDER: 1PX SOLID WHITE;
    }
    </style>

</head>
<body>
	<!-- <script src="${contextPath}/resources/js/pay/paymodal.js"></script> -->
	<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
	 <!-- content 추가 -->
        <div class="content p-4">
            <!-- 프로필 영역 -->
            <div class="informations">
                <!-- informations left area start -->
                <div class="left_con">
                    <div><h3>지출결의서</h3></div>
	                    	<form action="${contextPath}/pay/jReportUpdate.do" method="post" enctype="multipart/form-data">
                        <div id="sign_top">
                            <div id="sign_div_left">
                                <table border="1" id="sign_left">
                                    <tr>
                                        <th>부 서</th>
                                        <td>${member.get(0).teamName}</td>                   
                                        <input type="hidden" name="deptName" value="${member.get(0).teamName}">
                                        <input type="hidden" name="draftNo" value="${list.get(0).DRAFT_NO}">
                                        <input type="hidden" name="reportNo" value="${list.get(0).REPORT_NO}">
                                        <input type="hidden" name="reportType" value="${list.get(0).REPORT_TYPE}">
                                        <input type="hidden" name="documentNo" value="${list.get(0).DOCUMENT_NUMBER}">
                                        <input type="hidden" name="writerName" value="${member.get(0).userName}">
                                        <input type="hidden" name="writerName" value="${member.get(0).userNo}">
                                                                      
                                    </tr>
                                    <tr>
                                        <th>기안일</th>
                                        <td><input type="date" name="writerDate" required></td>
                                    </tr>
                                    <tr>
                                        <th>기안자</th>
                                        <td>${member.get(0).userName}</td>
                                        <input type="hidden" name="payWriter" value="${list.get(0).PAYMENT_WRITER}">
                                        <input type="hidden" name="payWriterNo" value="${list.get(0).PAYMENT_WRITER_NO}">
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
                            <div>
                                <table id="sign_table">
                                		<div style="margin: -12px">
                                        <button data-izimodal-open="#modal" id="modal_btn"><h4>결&nbsp;&nbsp;재&nbsp;&nbsp;승&nbsp;&nbsp;인</h4></button>
                                		</div>
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
                                   	<tr id="tr_name">
                                        <th rowspan="3">승 <br> 인</th>
                                        <c:choose>
	                                        <c:when test="${ empty list }">
		                                        <td id="f_name">최초승인자</td>
		                                        <td id="m_name">중간승인자</td>
		                                        <td id="l_name">최종승인자</td>
		                                      </c:when>
	                                        <c:otherwise>
	                                        	<td id="f_name">${ list.get(0).FIRST_APPROVAL }</td>
		                                        <td id="m_name">${ list.get(0).MIDDLE_APPROVAL }</td>
		                                        <td id="l_name">${ list.get(0).FINAL_APPROVAL }</td>
	                                        </c:otherwise>
                                        </c:choose>
                                    </tr>
                                    <tr>
                                        <td class="sing_name"></td>
                                        <td class="sing_name"></td>
                                        <td class="sing_name"></td>                                                      
                                    </tr>
                                </table>
                            </div>
                        </div>
                        
                        <div id="mid_btn">
                            <button id="plus_btn" type="button">추가</button>
                            <button id="del_btn" type="button">삭제</button>
                        </div>
                       
                         <div class="table_middle">
		                         <input type="hidden" name="firstApproval" id="first_name" class="namecheck" value="${ list.get(0).FIRST_APPROVAL }">
		                         <input type="hidden" name="middleApproval" id="middle_name" class="namecheck" value="${ list.get(0).MIDDLE_APPROVAL }">
		                         <input type="hidden" name="finalApproval" id="last_name" class="namecheck" value="${ list.get(0).FINAL_APPROVAL }"> 
                            <table border="1" id="tr_table">
                                <tr>
                                    <th>거래처</th>
                                    <th>사용내역 및 용도</th>
                                    <th>금액</th>
                                </tr>
	                               	<c:forEach var="i" begin="0" end="${ list.size() - 1 }">
		                               	<tr>
		                                   	<td><input type="text" name="account${i}" value="${ list.get(i).ACCOUNT }"></td>
		                                    <td><input type="text" name="usage${i}" value="${ list.get(i).CONTENT }"></td>
		                                    <td class="num"><input type="text" name="price${i}"  value="${ list.get(i).AMOUNT }"></td>
		                                </tr>
		                              </c:forEach>
                           </table>
                           <table>
                                <tr>
                                    <th colspan="2">합계</th>
                                    <td><input type="text" name="totalPrice" value="${ list.get(0).SUM }"></td>
                                </tr>
                                <tr>
                                    <th colspan="2">부가가치세</th>
                                    <td><input type="text" name="vat" value="${ list.get(0).VAT }"></td>
                                </tr>
                                <tr>
                                    <th colspan="2">총 지출 합계</th>
                                    <td><input type="text" name="totalExpendPrice"  value="${ list.get(0).TOTAL_SUM }"></td>
                                </tr>
                                <tr>
                                    <th>파일첨부</th>
                                    <td colspan="2">
                                    	<input type="file"  name="uploadFiles" multiple>
                                    </td>
                                </tr>
                               <c:if test="${ not empty list }">
                                <tr id="trFile">
                                  <th>기존첨부파일</th> 
                                  <td colspan="2">
                                   <!-- 기존의 첨부파일 목록들 -->
		                            		<c:forEach var="at" items="${ fileList }">
		                            			<div class="attach">
		                            				<a href="${contextPath}${at.ATTACH_PATH}/${at.MODIFY_NAME}" download="${at.ORIGIN_NAME}">${at.ORIGIN_NAME}</a>
		                            				<span class="origin_del" data-fileno="${ at.FILE_NO }">x</span>
		                            			</div>
		                            		</c:forEach>
                                  </td>
                                </tr>
                               </c:if>
                            </table>
                               <input type="hidden" name="fileLength" value="${ fileList.size() }">
                        </div>
                        <!--버튼 영역-->
                        <div id="btn_div">

                            <button type="submit" class="btn btn-primary" id="submit_btn">제출</button>
 
                            <button type="button" class="btn btn-warning" onclick="alert('저장이 완료되었습니다.');">저장</button>
                            <button type="reset" class="btn btn-danger" id="reset_btn">초기화</button>
                        </div>
                        <!------------>
                    </form>
                </div>
            </div>
        </div>
        
        <script>
        $(document).ready(function(){
        	$(document).on("click", ".origin_del", function(){
        		
        		let inputEl = document.createElement("input");
        		inputEl.value = $(this).data("fileno");
        		inputEl.name = "delFileNo";
        		inputEl.type = "hidden";
        		
        		$("#sign_top").append(inputEl);
        		
        		$(this).closest(".attach").remove();
        		
        		
        	})
        })
        
        </script>
        
        
        <script>
        	$(document).ready(function(){
        		let atlength = $(".attach").length;
        		$("#fileLength").val(atlength);
        		console.log($("#fileLength").val(atlength));
        	  
        		if($(".attach").length == 0){
        			$("#trFile").remove();
        		}
        	})
        </script>
        
       <script>
       $(document).ready(function(){
    	   let arr = [];
          	$(document).on("click", ".origin_del", function(){
          			
          			arr.push($(this).data("fileno"));
          			
          			
          			$("#fileDelete").val(arr);
          			
          			$(this).parent().remove();
          			
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
    	
    	let i = 10;
    	$(document).on("click", "#plus_btn", function () {
    		
    		let result = "<tr>";
    		result += "<td><input type='text' name='account" + (i) + "'></td>";
    		result += "<td><input type='text' name='usage" + (i) + "'></td>";
    		result += "<td class='num'><input type='text' name='price" + (i) + "'></td>";
    		result += "</tr>";
    		i++;
    		
       $("#tr_table").children().last().after(result);
       
       
    	});
    	
    	
    	$(document).on("click", "#del_btn", function () {
    	    //$("#tr_table tr:last-child").remove();
    	    $("#tr_table").children("tr").last().remove();
    	});
    })
    </script>
        
	   <script>
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
	      
	       $("#modal_btn").on("click", function(){
		    	   	$("#f_name").text("");
		          $("#m_name").text("");
		          $("#l_name").text("");
		          $("#m_co2").children().remove();
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
	              $("#m_co2").children().eq(0).prepend("<b>1차</b><br>[" + $(this).parent().prev().text() + "]<br>");
	          }else if($("#m_co2").children().length == 2){
	              alert("2차 승인자로 선택하였습니다.");
	              $("#m_name").append(childrenTextArray[1].substring($(this).text().indexOf("▶") + 1));
	              $("#middle_name").val($(this).text().substring($(this).text().indexOf("▶") + 1));
	              $("#middleb").val($(this).parent().prev().text());
	              $("#m_co2").children().eq(1).prepend("<b>2차</b><br>[" + $(this).parent().prev().text() + "]<br>");
	
	
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
	              $("#m_co2").children().eq(2).prepend("<b>3차</b><br>[" + $(this).parent().prev().text() + "]<br>");
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