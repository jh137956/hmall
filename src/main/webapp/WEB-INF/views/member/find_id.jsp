<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/main.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/common/config.jsp"%>
<script scr="/js/member/login.jsp"></script>
<script type="text/javascript" src="/js/member/id_pw_search.js"></script>
</head>
<body>
	<div class="wrapper">
		<div class="wrap">

			<%@ include file="/WEB-INF/views/common/nav.jsp"%>

			<div class="content">
				<div id="find_id">
					<div class="container">
						<div id="login-row"
							class="row justify-content-center align-items-center">
							<div id="login-column" class="col-md-6">
								<div id="login-box" class="col-md-12" style="margin-top: 20px;">
									<form id="find_id" class="form login-box" action="" method="post">
										<h3 class="text-center text-info">아이디 찾기</h3>
										<div class="form-group">
											<label for="mb_name" class="text-info">name:</label><br> 
											<input type="text" name="mb_name" id="mb_name" class="form-control">
										</div>
										<div class="form-group">
											<label for="mb_email" class="text-info">email:</label><br>
											<input type="email" name="mb_email" id="mb_email" class="form-control">
										</div>
										<div class="btn-idSearch">
											<input type="button" name="btn-idSearch" id="btn-idSearch" class="btn btn-info btn-md align" value="find">
											<p id="result" style="color:red;"></p>
										</div>	  
									</form>								
								</div>
								<div class="user-find">
									<div>
								          <ul style="height: 10px; text-align: center; display: inline-block;">
								            <li>
								              <a href="/member/find_id"><span>아이디찾기</span></a>
								            </li>
								            <li style="border: 1px solid #000; margin-top: 5px; height: 15px;"></li>
								            <li>
								              <a href="/member/find_password"><span>비밀번호찾기</span></a>
								            </li>
								            <li style="border: 1px solid #000; margin-top: 5px; height: 15px;"></li>
								            <li>
								              <a href="/member/join"><span>회원가입</span></a>
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
</body>

</html>