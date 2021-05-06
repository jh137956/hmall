$(document).ready(function() {
	
	var form = $("#login-form");
	
	// 로그인 버튼 클릭 시 
	$("#btn_login").on("click", function(e){
		
		e.preventDefault(); // 전송기능 취소
		
		var admin_id = $("#admin_id");
		var admin_pw = $("#admin_pw");

		if(admin_id.val()==null || admin_id.val()==""){
			alert("Please enter your ID.");
			admin_id.focus();
			
		} else if(admin_pw.val()==null || admin_pw.val()==""){
			alert("Please enter your Password.");
			admin_pw.focus();

		} else {
			form.submit();
		}
	});
	


});

