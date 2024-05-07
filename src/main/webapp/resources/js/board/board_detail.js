$(document).ready(function(){

    // attachment list show or hide function start ------------------------------------------------------------------------
    $(".show-hide").on("click", function(){
        if($(this).hasClass("show")){       // 리스트 노출요청
            // 첨부파일 리스트 보여주기
            $(".attachment-list").removeClass("d-none");

            // 기존 아이콘(show 아이콘) 숨기기
            $(this).addClass("d-none");

            // "숨김(위화살표)" 아이콘 노출
            $(this).siblings(".hide").removeClass("d-none");

        }else if($(this).hasClass("hide")){ // 리스트 숨김요청
            // 첨부파일 리스트 숨김처리
            $(".attachment-list").addClass("d-none");

            // 기존 아이콘(hide 아이콘) 숨기기
            $(this).addClass("d-none");

            // "열기(아래화살표)" 아이콘 노출
            $(this).siblings(".show").removeClass("d-none");
        }
    })
    // attachment list show or hide function end ------------------------------------------------------------------------

})