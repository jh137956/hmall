<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/main.css" rel="stylesheet">
<%@ include file="/WEB-INF/views/common/config.jsp"%>
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.80.0">
</head>
<body>
  <div class="wrapper">
    <div class="wrap">
      
      <%@ include file="/WEB-INF/views/common/nav.jsp"%>
			<div style="width: 60%; margin: 0 auto;">
				<div style="float: right;">
					<form id="searchForm" action="/board/list" method="get">
						<select name="type" id="type">
							<option value=""
								<c:out value="${pageMaker.cri.type == null ? 'selected':'' }" />>--</option>
							<option value="T"
								<c:out value="${pageMaker.cri.type == 'T' ? 'selected':'' }" />>제목</option>
							<option value="C"
								<c:out value="${pageMaker.cri.type == 'C' ? 'selected':'' }" />>내용</option>
							<option value="W"
								<c:out value="${pageMaker.cri.type == 'W' ? 'selected':'' }" />>작성자</option>
							<option value="TC"
								<c:out value="${pageMaker.cri.type == 'TC' ? 'selected':'' }" />>제목 or 내용</option>
							<option value="TW"
								<c:out value="${pageMaker.cri.type == 'TW' ? 'selected':'' }" />>제목 or 작성자</option>
							<option value="TCW"
								<c:out value="${pageMaker.cri.type == 'TCW' ? 'selected':'' }" />>제목 or 내용 or 작성자</option>
						</select> 
						<input type="text" name="keyword" value="${pageMaker.cri.keyword }"> 
						<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum }"> 
						<input type="hidden" name="amount" value="${pageMaker.cri.amount }">
						<button id="btnSearch" class="btn btn-primary" type="button">Search</button>
					</form>
				</div>
			</div>
		<div>
        	
       	<div style="width:100%; z-index: 1; margin-top: 100px;">
    	<div style="width: 60%; margin: 0 auto;">
    		<div class="panel panel-default">
    			<div class="panel-heading text-right">
    			 <button id="regBtn" type="button" class="btn btn-primary pull-right">글쓰기</button>
    			</div>
    			
    			<div class="panel-body">
    			 <!-- 리스트 -->
    			 <table class="table table-striped">
				  <thead>
				    <tr>
				      <th scope="col">번호</th>
				      <th scope="col">제목</th>
				      <th scope="col">작성자</th>
				      <th scope="col">작성일</th>
				      <th scope="col">수정일</th>
				    </tr>
				  </thead>
				  <tbody>
				  <c:forEach items="${list }" var="brdVO">
				    <tr>
				      <th scope="row"><c:out value="${brdVO.bno }"></c:out></th>				   
				      <td><a class="move" href="${brdVO.bno }"><c:out value="${brdVO.b_title }"></c:out></a>[<c:out value="${brdVO.replyCnt }"></c:out>]</td>
				      <td><c:out value="${brdVO.mb_id }"></c:out></td>
				      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${brdVO.b_regdate }"/></td>
				      <td><fmt:formatDate pattern="yyyy-MM-dd" value="${brdVO.b_update_date }"/></td>
				    </tr>
				   </c:forEach>
				   </tbody>
				</table>
    			</div>
    		</div>
    	</div>
    </div>
      <div style="width: 60%; margin: 0 auto; text-align: center;">
    	<div >
    	<!-- 페이징 표시 -->
   			<div class="panel-footer">
   			   <ul class="pagination">
   			   <c:if test="${pageMaker.prev }">
				    <li class="page-item">
				      <a href="${pageMaker.startPage - 1 }" class="page-link" href="#" tabindex="-1">Prev</a>
				    </li>
			    </c:if>
			    <c:forEach begin="${pageMaker.startPage }" end="${ pageMaker.endPage}" var="num">
			    	<li class="page-item ${pageMaker.cri.pageNum == num ? "active" : ""}">
			    		<a href="${num }" class="page-link" href="#">${num }</a>
			    	</li>
			    </c:forEach>
			    <c:if test="${pageMaker.next }">
				    <li class="page-item">
				      <a href="${pageMaker.endPage + 1 }" class="page-link" href="#">Next</a>
				    </li>
			    </c:if>
			  </ul>
   			</div>
    	</div>
    </div>  		  
      <form id="actionForm" action="/board/list" method="get">
		<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }" />'>
		<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }" />'>
		<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }" />'>
		<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }" />'>
  	  </form> 
          </div>
        </div>
     </div>

 
      
      <div class="pagenav">
          <div style="width:60%; margin-top: 10px; margin: 0 auto;">
	  </div>
  </div>

	
<script>
$(document).ready(function(){
    $("#regBtn").click(function(){
      location.href = "/board/board_insert";
    });
    
    
    var searchForm = $("#searchForm");

	var actionForm = $("#actionForm");
	// 제목 클릭시 다음 주소로 이동.
	$(".move").on("click", function(e){
		// 링크시 쿼리스트링정보(페이징,검색)를 다음주소로 보내는 작업
		// form태그 사용

		// <a href=""></a>, <input type="submit">
		e.preventDefault(); // 태그가 가지고있는 기본이벤트 성격을 취소.
		actionForm.append("<input type='hidden' name='bno' value='"  + $(this).attr("href") + "'>");
		actionForm.attr("action", "/board/get");
		actionForm.submit();
	});
	
	// [prev] 1 2 3 4 5 [next]
	$(".page-item a").on("click", function(e){
		e.preventDefault();

		console.log("click");
		
		actionForm.find("input[name='pageNum']").val($(this).attr("href"));
		actionForm.submit();

	});
	//동적으로 추가된 요소에는 이벤트를 설정할려면 on 으로 작업해야 한다.
	$("#searchForm #btnSearch").on("click", function(e){
		if(!searchForm.find("option:selected").val()){
			alert("검색종류를 선택하세요");
			return false;
		}

		if(!searchForm.find("input[name='keyword']").val()){
			alert("검색어를 선택하세요");
			return false;
		}

		// 검색시 페이지를 1로 시작해야 한다.
		// 리스트에서 변경된 페이지번호가 사용하여 검색결과가 안나올수 있다.
		searchForm.find("input[name='pageNum']").val("1");

		e.preventDefault();

		searchForm.submit();

	});
    
});	
</script>  
</body>

</html>