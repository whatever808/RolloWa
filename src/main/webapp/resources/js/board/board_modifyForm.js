// 게시글 내용란용 ckditor 생성
ClassicEditor.create(document.querySelector("#boardContent"), {
    language:"ko"
}).catch(error = function(){
    console.log("ckeditor error");
});

// "초기화" 버튼 클릭시, Editor 내용 비움용 function
function resetForm(){
    console.log(theEditor);
}


// 페이지 로딩즉시 실행될 functions
$(document).ready(function(){

    // 부서게시판 게시글 작성을 선택할시 실행될 function
    $(".board-category").on("change", function(){
        $(this).val() == '부서게시판' ? $(".department-category").removeClass("d-none")
                                     : $(".department-category").addClass("d-none");
    })

})
