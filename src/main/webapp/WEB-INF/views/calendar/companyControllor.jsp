<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
                         <td> 1 </td>
                         <td><input type="color" value="#24E5F0" id="color-style" style="width: 35px; height: 15px;" onclick="return false"></td>
                         <td> 이벤트 </td>
                         <td class="over"> 제목 </td>
                         <td class="over">'2024-04-24' + ' ~ ' + '2024-04-27'</td>
                         <td>
	                         <div class="pretty p-icon p-curve p-thick p-jelly">
	                            <input type="checkbox" name="check" value="1" />
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
         <div align="center">
         	<ul class="pagination">
					  <li class="page-item disabled"><a class="page-link" href="#">◁</a></li>
					  <li class="page-item active"><a class="page-link" href="#">1</a></li>
					  <li class="page-item"><a class="page-link" href="#">2</a></li>
					  <li class="page-item"><a class="page-link" href="#">3</a></li>
					  <li class="page-item"><a class="page-link" href="#">▷</a></li>
					</ul>
         </div>
         <br>     
         <div align="end">
					 <button class="btn btn-outline-danger">삭제</button>
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