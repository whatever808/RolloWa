<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>List 회사 일정</title>
<style>
.out-line {
	min-height: 800px;
	width: 100%;
	box-sizing: border-box;
}

.search-date {
	display: flex;
	gap: 5%;
}

.size-fit {
	display: contents;
}

.search-list {
	width: 100%;
	padding: 10px;
}

.search-list * {
	/* padding: 5px; */
	text-align: center;
}

.inner-line {
	padding: 30px;
}

.inner-line>div {
	margin-left: 10px;
}

.date-area {
	width: 30%;
	text-align: center;
}
.over{
    text-overflow: ellipsis;
    overflow: hidden;
    white-space: nowrap;
}
</style>
</head>
<body>
	<div class="out-line">
				<jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
				  <script>
				  	$(document).ready(function(){
				  		$.ajax({
				  			url:'${path}/calendar/companyControllor.ajax',
				  			type:'post',
				  			data: {
				  				'page':'${page}',
				  				'dataStart': $('#currentDate1').val(),
				  				'dataEnd': $('#currentDate2').val()
				  			},
				  			success:function(result){
				  				console.log(result);
				  				
				  				const list = result.list;
				  				const paging = result.paging;
				  				
				  				let tableEl = ''; 
				  				for (let i =0; i<list.lenght; i++){
											tableEl = 	'<tr><td>'+ result[i].calNO +'</td>'
				  										+ '<td><input type="color" value="' + list[i].color + '" id="color-style" style="width: 35px; height: 15px;" onclick="return false"></td>'
				  										+ '<td>'+ result[i].group.codeName +'</td>'
				  										+ '<td class="over">'+ result[i].calTitle +'</td>'
				  										+ '<td class="over">'+ result[i].duraDate +'</td>'
				  										+ '<td><div class="pretty p-icon p-curve p-thick p-jelly">'
		                          + '<input type="checkbox" name="check"'+ result[i].calNO +'" />'
				  										+ '<div class="state p-danger"><label></label></div></div></td></tr>'
	  							}
				  				
				  				$('tbody').append(tableEl);
				  			},
				  			error:function(){
				  				console.log('실패');
				  			}
				  		})
				  		
				  	})
				  </script>
        <!-- 컨텐츠 영역 -->
        <div class="content" style="max-width: 1120px; padding: 30px;">
          <fieldset class="radious10 inner-line line-shadow">
	          <legend>
							<h1 class="jua-regular">회사 일정 리스트</h1>
						</legend>
                <br><br>
                <div class="search-date">
                 <div class="font-size25 jua-regular">날짜</div>
                 <div class="size-fit">
									<input type="date" id="currentDate1" class="date-area jua-regular">
									</div>
	                  <div>~</div>
	                  <div class="size-fit">
										<input type="date" id="currentDate2" class="date-area jua-regular">
									</div>
                </div>
                <br>
                <div >
                  <table class="search-list table table table-hover">
                      <thead>
                          <tr>
                            <th class="font-size20 jua-regular" style="width: 10px;">No</th>
                            <th class="font-size20 jua-regular" style="width: 10px;">color</th>
                            <th class="font-size20 jua-regular">Category</th>
                            <th class="font-size20 jua-regular">Title</th>
                            <th class="font-size20 jua-regular">Date</th>
                            <th class="font-size20 jua-regular" style="width: 10px;">Check</th>
                          </tr>
                      </thead>
                      <tbody>
                      
                       
                       <tr>
                         <td>
	                         <div class="pretty p-icon p-curve p-thick p-jelly">
	                            <input type="checkbox" name="check" value="${c.calNO}" />
	                            <div class="state p-danger">
	                           				<label></label>
	                       			</div>
	                         </div>
                         </td>
                      	</tr>
                       
                        
                 </tbody>
             </table>
         </div>
         <br>
         <div style="display: flex;justify-content: space-between;">
         <div>
         	<ul class="pagination"></ul>
         </div>     
         <div>
					 <button class="btn btn-outline-danger">삭제</button>
				 </div>
				 </div>
      </fieldset>
   	</div>
  </div>
  
<script>
const offset = new Date().getTimezoneOffset() * 60000;
const today = new Date(Date.now()- offset);

let dateData = today.toISOString().slice(0, 10);
document.getElementById('currentDate1').value = dateData;

today.setDate(today.getDate() + 1);
today.setTime(today.getTime()+ 12* 1000* 60* 60);

dateData0 = today.toISOString().slice(0, 10);

document.getElementById('currentDate2').value = dateData0;
</script>
</body>
</html>