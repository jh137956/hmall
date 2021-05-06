<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/main.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/common/config.jsp"%>
</head>

<body>
	<div class="wrapper">
		<div class="wrap">

			<%@ include file="/WEB-INF/views/common/nav.jsp"%>

			<div class="content">
				<div id="login">
					<div class="container">
						<div id="login-row"
							class="row justify-content-center align-items-center">
							<div id="login-column" class="col-md-6">
								<div id="login-box" class="col-md-12" style="margin-top: 20px;">
									<form id="login-form" class="form login-box" action="/member/loginPost" method="post">
										<h3 class="text-center text-info">Login</h3>
										<div class="form-group">
											<label for="userid" class="text-info">id:</label><br> <input
												type="text" name="mb_id" id="mb_id" class="form-control">
										</div>
										<div class="form-group">
											<label for="password" class="text-info">password:</label><br>
											<input type="password" name="mb_pw" id="mb_pw" class="form-control">
										</div>
										<div class="btn-login">
											<button type="button" id="btn_login" name="btn_login" class="btn btn-info btn-md align">submit</button>
										</div>	  
									</form>								
								</div>
								<div class="user-find">
									<div>
								          <ul style="height: 10px; text-align: center; display: inline-block;">
								            <li>
								              <a href="/member/find_id" id="find_id"><span>아이디찾기</span></a>
								            </li>
								            <li style="border: 1px solid #000; margin-top: 5px; height: 15px;"></li>
								            <li>
								              <a href="/member/find_password" id="find_pw"><span>비밀번호찾기</span></a>
								            </li>
								            <li style="border: 1px solid #000; margin-top: 5px; height: 15px;"></li>
								            <li>
								              <a href=""><span>회원가입</span></a>
								            </li>
								          </ul>
								        </div>
								    </div>
							</div>
						</div>
						
					</div>
				</div>
			</div>
		</div>
	</div>
<script>

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
			alert("로그인 성공!");
			form.submit();
		}
	});
	
});

</script>
</body>

</html>