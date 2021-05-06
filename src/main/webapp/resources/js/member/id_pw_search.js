$(document).ready(function(){

	// 비밀번호 찾기
    $("#btn-passwordSearch").on("click", function(){
        
        var userInfo = {mb_id:$("#mb_id").val(), mb_name:$("#mb_name").val()};

        $.ajax({
            url: '/member/find_password',
            type: 'post',
            data: userInfo,
            dataType: 'text',
            success: function(data) {
                // 비밀번호 출력작업
                
                if(data == "SUCCESS") {
                	alert("가입하신 메일로 전송되었습니다");
                }else {
                	$("#result").html("입력정보가 틀립니다");
                }
            }
        })

    });
    
    // 아이디 찾기
     $("#btn-idSearch").on("click", function(){
        
        var userInfo = {mb_name:$("#mb_name").val(), mb_email:$("#mb_email").val()};

        $.ajax({
            url: '/member/find_id',
            type: 'post',
            data: userInfo,
            dataType: 'text',
            success: function(data) {
                // 비밀번호 출력작업
                
                if(data != "") {
                	$("#result").html($("#mb_name").val() + " 님의 아이디는 " + data);
                }else {
                	$("#result").html("입력정보가 틀립니다");
                }

                $("#mb_name").val(""); 
                $("#mb_email").val("");
                
            }
        })

    });

});