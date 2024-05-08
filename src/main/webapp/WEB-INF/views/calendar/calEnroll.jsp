<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${ pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
 <style>
     /* *{border: 1px solid black;} */
     .out-line{
         min-height: 800px;
         width: 100%;
         display: flex;
         flex-direction: row;
         box-sizing: border-box;
     }
     .clander-add-area{
         display: flex;
         flex-direction: column;
         gap: 15px;
         padding: 10px;
     }
     .clander-add-area>div{
         margin-left: 30px;
     }
     .line-cirecle-sm{
         border-radius: 100%;
         height: fit-content;
         margin-left: 30px;
         margin-bottom: 10px;
         padding: 5px;
         text-align: center;
         cursor: pointer;
     }
     .display-item-center{
         justify-content: center;
         align-items: center;
     }
     .Category, .Co-worker{
         display:  -webkit-box;
         overflow-y: hidden;
     }
     .date-time-area{
         display: flex;
         justify-content: space-evenly;
         text-align: center;
         width: 80%;
     }
     .date-area, .time-area{
         width: 80%;
         text-align: center;
     }
     .date-area{
         height: 30px;
     }
     .time-area{
         height: 50px;
     }
     .Title>input, .Place>input{
         width: 80%;
         height: 25px;
         padding: 10px;
     }
     .enroll{
         text-align: end;
     }
     .font-size25{
         font-size: 25px;
     }
     .font-size20{
         font-size: 20px;
     }
     .marginR30{
         margin-right: 30px;
     }
     .content-text-area{
         width: 80%;
         min-height: 150px;
     }
     .inner-line{
         padding: 30px;
     }
     .inner-line>div, .inner-line>label{ 
         margin-left: 30px;
     }
 </style>

</head>
<body>
  <div class="out-line">
      <!-- 메뉴판 -->
      <jsp:include page="/WEB-INF/views/common/sidebarHeader.jsp"/>
      <!-- 컨텐츠 영역 -->
      <div class="content" style="max-width: 1000px; padding: 30px;">
          <fieldset class="clander-add-area radious10 inner-line line-shadow">
              <legend><h1 class="animate__animated animate__bounce jua-regular">일정 추가</h1></legend>
              <div style="display: flex; justify-content: space-between; align-items: center;">
                  <div class="font-size25 jua-regular" id="categoryName">Category</div>

                  <div class="pretty p-default p-round p-smooth font-size20 privateArea" id="privateName">
                      <input type="checkbox" />
                      <div class="state p-danger">
                          <label class="jua-regular">private</label>
                      </div>
                  </div>
              </div> 

              <div class="Category">
                  <div class="pretty p-default p-curve">
                      <input type="radio" name="color" />
                      <div class="state p-success-o">
                          <label>회의</label>
                      </div>
                  </div>
              
                  <div class="pretty p-default p-curve">
                      <input type="radio" name="color" />
                      <div class="state p-success-o">
                          <label>미팅</label>
                      </div>
                  </div>
              
                  <div class="pretty p-default p-curve">
                      <input type="radio" name="color" />
                      <div class="state p-success-o">
                          <label>이벤트</label>
                      </div>
                  </div>
              
                  <div class="pretty p-default p-curve">
                      <input type="radio" name="color" />
                      <div class="state p-success-o">
                          <label>계약</label>
                      </div>
                  </div>
              
                  <div class="pretty p-default p-curve">
                      <input type="radio" name="color" />
                      <div class="state p-success-o">
                          <label>기타</label>
                      </div>
                  </div>                
              </div>

              <div class="font-size25 jua-regular" id="co-workerName">Co-worker</div>
              <div class="Co-worker">
                  <div class="pretty p-default p-round p-smooth p-plain">
                      <input type="checkbox" />
                      <div class="state p-success-o">
                          <label> 김우빈</label>
                      </div>
                  </div>

                  <div class="pretty p-default p-round p-smooth p-plain">
                      <input type="checkbox" />
                      <div class="state p-success-o">
                          <label> 전지현</label>
                      </div>
                  </div>

                  <div class="pretty p-default p-round p-smooth p-plain">
                      <input type="checkbox" />
                      <div class="state p-success-o">
                          <label> 아이유</label>
                      </div>
                  </div>

                  <div class="pretty p-default p-round p-smooth p-plain">
                      <input type="checkbox" />
                      <div class="state p-success-o">
                          <label> 뚱이</label>
                      </div>
                  </div>

                  <div class="pretty p-default p-round p-smooth p-plain">
                      <input type="checkbox" />
                      <div class="state p-success-o">
                          <label> 징징이</label>
                      </div>
                  </div>


              </div>
              <div style="display: flex;">
                  <label class="font-size25 jua-regular" for="color-style" id="colorName">Color</label>
                  <input type="color" id="color-style">
              </div>
              <label class="font-size25 jua-regular" for="title" id="titleName">Title</label>
              <div class="Title"><input class="font-size20" type="text" id="title"></div>

              <div style="width: 80%; display: flex; justify-content: space-between;">
                  <div class="font-size25 jua-regular" id="all_day">All Day</div>

                  <div class="pretty p-switch all_day">
                      <input type="checkbox" />
                      <div class="state p-success">
                          <label>종일</label>
                      </div>
                  </div>

              </div>

              <div class="date-time-area">
                  <div style="width: 40%;">
                      <div><input class="date-area jua-regular" type="date" id="currentDate1"></div>
                      <br>
                      <div><input class="time-area jua-regular" type="time" id="currentTime1"></div>
                  </div>
                  <div style="place-self: center; font-size: xx-large;">~</div>
                  <div style="width: 40%;">
                      <div><input class="date-area jua-regular" type="date" id="currentDate2"></div>
                      <br>
                      <div><input class="time-area jua-regular" type="time" id="currentTime2"></div>
                  </div>
              </div>

              <div class="font-size25 jua-regular" id="contentName">Content</div> 
              <div><textarea class="content-text-area" style="resize: none;"></textarea></div>
              
              <div class="font-size25 jua-regular" id="placeName">Place</div>
              <div class="Place"><input class="font-size20" type="text"></div>

              <div class="enroll marginR30"><button class="btn btn-outline-primary">등록</button></div>
          </fieldset>
      </div>
  </div>
  <jsp:include page="/WEB-INF/views/common/sidebarFooter.jsp"/>
  <script>
      const offset = new Date().getTimezoneOffset() * 60000;
      const today = new Date(Date.now() - offset);
      let dateData = today.toISOString().slice(0, 10);
      let timeData = today.toISOString().slice(11, 16);
      document.getElementById('currentDate1').value = dateData;
      document.getElementById('currentTime1').value = timeData;
      
      today.setDate(today.getDate() + 1);
      today.setTime(today.getTime() + 12*1000*60*60);

      dateData = today.toISOString().slice(0, 10);
      timeData = today.toISOString().slice(11, 16);
      document.getElementById('currentDate2').value = dateData;
      document.getElementById('currentTime2').value = timeData;
  </script>
  <script>
      $(document).ready(function(){
          $(".Category").children().click(function(e){
              animateCSS('#categoryName', 'bounce');
          })

          $(".Co-worker").children().click(function(e){
              animateCSS('#co-workerName', 'bounce');
          })

          $("#color-style").click(function(){
           animateCSS('#colorName', 'bounce');
          })

          $("#title").click(function(){
              animateCSS('#titleName', 'bounce');
          })
          
          $(".privateArea").children().click(function(){
              animateCSS('#privateName', 'bounce');
          })

          $(".content-text-area").click(function(){
              animateCSS('#contentName', 'bounce');
          })

          $(".Place").children().click(function(){
              animateCSS('#placeName', 'bounce');
          })

          $(".all_day").click(function(){
              animateCSS('#all_day', 'bounce');

          })

      })

      const animateCSS = (element, animation, prefix = 'animate__') =>
      new Promise((resolve, reject) => {
          const animationName = `${prefix}${animation}`;
          const node = document.querySelector(element);

          node.classList.add(`${prefix}animated`, animationName);

          function handleAnimationEnd(event) {
          event.stopPropagation();
          node.classList.remove(`${prefix}animated`, animationName);
          resolve('Animation ended');
          }

          node.addEventListener('animationend', handleAnimationEnd, {once: true});
      });

  </script>
</body>
</html>