$(document).ready(function(){

    // 연령제한이 있을경우 실행될 function ---------------------------------------------------------------------
    $("#regist-form input[name=ageLimit]").on("change", function(){
        $("#age-limit-y").prop("checked") ? $(".age-limit").removeClass("d-none")
                                          : $(".age-limit").addClass("d-none");
    })
    
    // 연령제한 나이입력 input 요소 유효성 검사용 function -------------------------------------------------------
    $("#age-limit").on("keyup", function(){
        const regExp = /^([1-9]{1}[0-9]{0,2})$/;

        if(!regExp.test($(this).val())){
            $(this).val("");
            alert("유효한 나이값을 입력해주세요.");
        }
    })

})