<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<script src="https://kit.fontawesome.com/24aa787f08.js" crossorigin="anonymous"></script>	
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/main.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/common/config.jsp"%>

<script type="text/javascript" src="/js/member/modify.js"></script>
</head>
<body>
<div class="wrapper">
  <div class="wrap">

	<%@ include file="/WEB-INF/views/common/nav.jsp"%>
	
	<div class="content">
		<div class="container" style="width: 700px; margin: 0 auto; padding-left: 0px; padding-right: 0px; margin-top: 100px;">
			<div class="row" style="width: 100%; margin: 0 auto; padding: 0; ">
		      <div style="width:150px; text-align: center;">
		        <a href="/member/modify">
		        <i class="fas fa-chevron-circle-down fa-5x"></i>
		        <h4>회원수정</h4>
		        </a>
		      </div>    
		      <div style="width:150px; text-align: center;">
		      <a href="/order/my_order_list">
		        <i class="fas fa-chevron-circle-down fa-5x"></i>
		        <h4>주문내역</h4>
		      </a>
		      </div>	      
		      <div style="width:150px; text-align: center;">
		      <a href="/member/delete">
		        <i class="fas fa-chevron-circle-down fa-5x" id="deleteMember"></i>
		        <h4>회원탈퇴</h4>
		      </a>  
		      </div>
		      <div style="width:150px; text-align: center;">
		      <a href="/board/list">
		        <i class="fas fa-chevron-circle-down fa-5x" id="deleteMember"></i>
		        <h4>게시판</h4>
		      </a>  
		      </div>		    		      
      		</div>
		</div>	
	</div>


	</div>
</div>

<script>
	$("#deleteMember").on("click", function(){
		if(confirm("삭제하시겠습니까?")){
			
		}
	});
</script>
</body>

</html>