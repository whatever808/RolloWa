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
    <link href="${contextPath}/resources/css/pay/writer2.css" rel="stylesheet">
    
    <!-- TinyMCE 에디터 CDN 연결 -->
	   <script src="https://cdn.tiny.cloud/1/kv8msifnng66ha7xgul5sc6cehyxcp480zm27swyti7b7u38/tinymce/7/tinymce.min.js" referrerpolicy="origin"></script>
	   <!-- TinyMCE 관련 스크립트 -->
	   <script src="${ contextPath }/resources/js/board/editor.js"></script>
 <style>
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
	 <!-- content 추가 -->
        <div class="content p-4">
            <!-- 프로필 영역 -->
            <div class="informations">
                <!-- informations left area start -->
                <div class="left_con">
                    <div><h3>지출 결의서</h3></div>
                    	
		                   <form action="${contextPath}/pay/jReportInsert.do" method="post" id="myForm" enctype=multipart/form-data>
		                  
                        <div id="sign_top">
                            <div id="sign_div_left">
                                <table border="1" id="sign_left">
                                    <tr>
                                        <th>부 서</th>
                                        <td>${member.get(0).teamName}</td>                   
                                        <input type="hidden" name="deptName" value="${member.get(0).teamName}">
                                        <input type="hidden" name="approvalNo" value="${list.get(0).APPROVAL_NO}">
                                        <input type="hidden" name="expendNo" value="${list.get(0).EXPEND_NO}">
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
                        
                        <div id="mid_btn">
                            <button id="plus_btn" type="button">추가</button>
                            <button id="del_btn" type="button">삭제</button>
                        </div>
                       
                         <div class="table_middle">
		                         <input type="hidden" name="firstApproval" id="first_name" class="namecheck">
		                         <input type="hidden" name="middleApproval" id="middle_name" class="namecheck">
		                         <input type="hidden" name="finalApproval" id="last_name" class="namecheck"> 
                            <table border="1" id="tr_table">
                            		<tr>
                            				<th>제목</th>
                            				<td colspan="2"><input type="text" name="title"></td>
                            		</tr>
                                <tr>
                                    <th>거래처</th>
                                    <th>사용내역 및 용도</th>
                                    <th>금액</th>
                                </tr>
	                                <tr>
	                                    <td><input type="text" name="account1"></td>
	                                    <td><input type="text" name="usage1"></td>
	                                    <td class="num"><input type="text" name="price1"></td>
	                                </tr>
	                                <tr>
	                                    <td><input type="text" name="account2"></td>
	                                    <td><input type="text" name="usage2"></td>
	                                    <td class="num"><input type="text" name="price2"></td>
	                                </tr>
	                                <tr>
	                                    <td><input type="text" name="account3"></td>
	                                    <td><input type="text" name="usage3"></td>
	                                    <td class="num"><input type="text" name="price3"></td>
	                                </tr>
	                                <tr>
	                                   	<td><input type="text" name="account4"></td>
	                                    <td><input type="text" name="usage4"></td>
	                                    <td class="num"><input type="text" name="price4"></td>
	                                </tr>
                           </table>
                           <table>
                                <tr>
                                    <th colspan="2">합계</th>
                                    <td><input type="text" name="totalPrice"></td>
                                </tr>
                                <tr>
                                    <th colspan="2">부가가치세</th>
                                    <td><input type="text" name="vat"></td>
                                </tr>
                                <tr>
                                    <th colspan="2">총 지출 합계</th>
                                    <td><input type="text" name="totalExpendPrice"></td>
                                </tr>
                                <tr>
                                    <th>파일첨부</th>
                                    <td colspan="2">
                                    	<input type="file"  name="uploadFiles" multiple>
                                    </td>
                                </tr>
                            </table>
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
    	
    	let i = 40;
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