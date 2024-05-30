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
		