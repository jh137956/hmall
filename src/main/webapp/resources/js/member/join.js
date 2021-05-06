$(document).ready(function() {
	
	var form = $("#joinForm");
	
	// 아이디중복체크 기능 사용여부확인 변수
	var isCheckId = "false";


	
	/* 아이디 중복체크 클릭 시 */
	$("#btn_check").on("click", function(){
		
		if($("#mb_id").val()=="" || $("#mb_id").val()== null){
			$("#id_availability").html("아이디를 먼저 입력해주세요.");
			return;
		} 		
		
		var mb_id = $("#mb_id").val();
		
		// ajax방식은 제어의 흐름이 클라이언트시작 -> 서버요청 -> 클라이언트  종료
		// ajax방식은 서버요청에 실행되는 코드가 response.redirect,redirect: 주소이동 구문이 사용안하거나 
		// 동작되어서는 안된다.
		$.ajax({
			url: '/member/checkIdDuplicate',
			type: 'post',
			dataType: 'text',  //  '/member/checkIdDuplicate'주소에서 넘어오는 리턴값의 형식
			data: {mb_id : mb_id},  // javasciprt object 표현구문.www.w3school.com 참고
			success : function(data){
				if(data== 'SUCCESS'){
					// 사용 가능한 아이디
					$("#id_availability").css("color", "blue");
					$("#id_availability").html("사용가능한 아이디 입니다.");
					
					isCheckId = "true";  // 아이디 중복체크를 한 용도
				} else {
					// 사용 불가능 - 이미 존재하는 아이디
					$("#id_availability").html("이미 존재하는 아이디입니다. \n다시 시도해주세요.");
				}
			}
		});
	});
	
	/* 이메일 인증 클릭 시 */
	$("#btn_sendAuthCode").on("click", function(){
		var receiveMail = $("#mb_email").val();
		
		if($("#mb_email").val()=="" || $("#mb_email").val()== null){
			// 메시지를 alert()   사용하지않고, 임의의 위치에 출력하는 형태
			$("#authcode_status").html("이메일을 먼저 입력해주세요.");
			return;
		}
		
		// 현재 작업이 진행중인 메시지를 보여주는 구문.
		$("#authcode_status").css("color", "grey");
		$("#authcode_status").html('인증코드 메일을 전송중입니다.  잠시만 기다려주세요...');
		
		$.ajax({
			url: '/email/send',    // EmailController.java
			type: 'post',
			dataType: 'text',
			data: {receiveMail : receiveMail},  //  {key : value}
			success: function(data){
				$("#email_authcode").show();
				$("#authcode_status").css("color", "grey");
				$("#authcode_status").html('메일이 전송되었습니다.  입력하신 이메일 주소에서 인증코드 확인 후 입력해주세요.');
			}
		});
	});
	
	/* 인증코드 입력 후 확인 클릭 시 */
	$("#btn_checkAuthCode").on("click", function(){
		var mb_authcode = $("#mb_authcode").val(); // 메일을 통하여 받았던 인증코드를 보고 입력하면 인증코드를참조 
		
		$.ajax({
			url: '/member/checkAuthcode',
			type: 'post',
			dataType: 'text',
			data: {mb_authcode : mb_authcode},
			success: function(data){
				if(data == 'SUCCESS'){
					$("#email_authcode").hide(); // 인증코드 입력화면 숨김.
					$("#authcode_status").css("color", "blue");
					$("#authcode_status").html('인증 성공');
					$("#mb_email").attr("readonly",true);
					$("#btn_sendAuthCode").attr("disabled", true);
					isCheckEmail = "true";  // 인증메일 유효성 검사에 사용하기위한 변수. 
					return;
					
				} else {
					$("#email_authcode").hide();
					$("#authcode_status").css("color", "red");
					$("#authcode_status").html('인증 실패. 다시 시도해주세요.');
					return;
				}
			}
		});
	});
	
	
	/* 회원가입 버튼 클릭 시 */ 
	$("#btnjoin").on("click", function(){
	
		var mb_id = $("#mb_id");
		var mb_pw = $("#mb_pw");
		var mb_pw2 = $("#mb_pw2");
		var mb_name = $("#mb_name");
		var mb_email = $("#mb_email");
		var mb_cp = $("#mb_cp");
		var mb_post = $("input[name='mb_post']");
		var mb_addr = $("input[name='mb_addr']");
		var mb_addr2 = $("input[name='mb_addr2']");

		/* 유효성 검사 */
		if(mb_id.val() == null || mb_id.val() == "") {
			alert("아이디를 입력해주세요");
			mb_id.focus();

		}else if(isCheckId == "false") {
			alert("아이디 중복확인을 해주세요");
			$("#btn_check").focus();

		}else if(mb_pw.val() == null || mb_pw.val() == "") {
			alert("비밀번호를 입력해주세요");
			mb_pw.focus();

		}else if(mb_pw2.val() == null || mb_pw2.val() == "") {
			alert("비밀번호 확인을 입력해주세요");
			mb_pw2.focus();

		}else if(mb_pw.val() != mb_pw2.val()) {
			alert("비밀번호와 비밀번호확인이 다릅니다");
			mb_pw2.focus();

		}else if(mb_name.val() == null || mb_name.val() == "") {
			alert("이름을 입력해주세요");
			mb_name.focus();

		}else if(mb_email.val() == null || mb_email.val() == "") {
			alert("이메일를 입력해주세요");
			mb_email.focus();

		}else if(mb_cp.val() == null || mb_cp.val() == "") {
			alert("휴대전화번호를 입력해주세요");
			mb_cp.focus();

		}else if(mb_post.val() == null || mb_post.val() == "") {
			alert("우편번호를 입력해주세요");
			$("#btn_find_addr").focus();

		}else if(mb_addr.val() == null || mb_addr.val() == "") {
			alert("기본주소를 입력해주세요");
			$("#btn_find_addr").focus();

		}else if(mb_addr2.val() == null || mb_addr2.val() == "") {
			alert("상세주소를 입력해주세요");
			mb_addr2.focus();

		}else {
			form.submit();  // 전송태그를 <button type="button"> 를 사용하여 서브밋메서들 호출함.
		}

	});
	
	$("#btncancle").on("click", function(){
		
		var result = confirm("가입을 취소하시겠습니까?");
		if(result){
			location.href="/"; 
		} else{}
	});
	

});

