$(document).ready(function() {
	
	var form = $("#login-form");
	
	// 로그인 버튼 클릭 시 
	$("#btn_login").on("click", function(e){
		
		e.preventDefault(); // 전송기능 취소
		
		var mb_id = $("#mb_id");
		var mb_pw = $("#mb_pw");

		if(mb_id.val()==null || mb_id.val()==""){
			alert("Please enter your ID.");
			mb_id.focus();
			
		} else if(mb_pw.val()==null || mb_pw.val()==""){
			alert("Please enter your Password.");
			mb_pw.focus();

		} else {
			form.submit();
		}
	});
	


});

