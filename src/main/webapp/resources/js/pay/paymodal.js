
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
