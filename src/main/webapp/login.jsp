<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/main.css" rel="stylesheet">
<%@include file="/WEB-INF/views/common/config.jsp" %>
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
								<div id="login-box" class="col-md-12">
									<form id="login-form" class="form login-box" action="" method="post">
										<h3 class="text-center text-info">Login</h3>
										<div class="form-group">
											<label for="userid" class="text-info">id:</label><br> <input
												type="text" name="mb_id" id="mb_id" class="form-control">
										</div>
										<div class="form-group">
											<label for="password" class="text-info">password:</label><br>
											<input type="text" name="mb_pw" id="mb_pw" class="form-control">
										</div>
										<div class="btn-login">
											<input type="submit" name="submit" class="btn btn-info btn-md align" value="submit">
										</div>	  
									</form>								
								</div>
								<div class="user-find">
								          <ul>
								            <li>
								              <a href=""><span>아이디찾기</span></a>
								            </li>
								            <li>
								              <a href=""><span>비밀번호찾기</span></a>
								            </li>
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
			

			<div class="pagenav">
				<h1>페이징</h1>
			</div>
		</div>
	</div>
</body>

</html>