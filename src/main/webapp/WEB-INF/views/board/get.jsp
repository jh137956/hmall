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
    
 <!-- Custom styles for this template -->
    <link href="/resources/starter-template.css" rel="stylesheet">
	<!-- 1)handlebars.js 참조 -->
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>



	<!-- 2)UI Template -->
	<script id="replyTemplate" type="text/x-handlebars-template">
			{{#each .}}
			<ul class="list-group">
				<li class="list-group-item" data-rno="{{rno}}">{{rno}}</li>
				<li class="list-group-item" data-reply="{{reply}}">{{reply}}</li>
				<li class="list-group-item" data-mb_id="{{mb_id}}">{{mb_id}}</li>
				<li class="list-group-item" data-replydate="{{displayTime replydate}}">{{displayTime replydate}}</li>				
				<li class="list-group-item">{{eqRelper mb_id}}</li>			
			</ul>
			{{/each}}
	</script> 
	
									
								
	<script>

		// 3) 댓글데이타 삽입해서 출력작업
		var printReplyData = function(replyData, replyTarget, replyTemplate){
				var uiTemplate = Handlebars.compile(replyTemplate.html());

				var replyDataResult = uiTemplate(replyData);
				
				replyTarget.html(replyDataResult);
		}

		
		var pageNum = 1;
		var replyPageDisplay = ""; // [이전] 1 2 3 4 5... [다음]

		var displayPageCount = 5; // 출력될 갯수

		// 댓글 페이징번호를 출력하는 기능.
		var printReplyPaging = function(replyCnt){
			
			// 페이징 알고리즘
			var endNum = Math.ceil(pageNum / 10.0) * 10; // 10의 의미는 출력될 페이지 수(pageSize)
			var startNum = endNum - 9;

			var prev = startNum != 1;
			var next = false;

			// 마지막 페이지 수 번호 * 10개 >= 총 데이터 수(실제)
			if(endNum * displayPageCount >= replyCnt){
				endNum = Math.ceil(replyCnt/parseFloat(displayPageCount)); // 실제 데이터를 이용한 전체 페이지 수
			}

			// 실제 데이터가 마지막페이지 번호 * 10보다 크면 다음데이터를 표시하기위하여 next = true 로 해줘야 한다
			if(endNum * displayPageCount < replyCnt){
				next = true;
			}

			/*
			<nav aria-label="Page navigation example">
			<ul class="pagination">
				<li class="page-item"><a class="page-link" href="#">Previous</a></li>
				<li class="page-item"><a class="page-link" href="#">1</a></li>
				<li class="page-item"><a class="page-link" href="#">2</a></li>
				<li class="page-item"><a class="page-link" href="#">3</a></li>
				<li class="page-item"><a class="page-link" href="#">Next</a></li>
			</ul>
			</nav>

			*/

			var str = '<ul class="pagination">';
			// 이전 표시여부
			if(prev){
				str += '<li class="page-item"><a class="page-link" href="' + (startNum - 1) + '">Previous</a></li>';
			}
			// 페이지 번호 출력
			for(var i=startNum; i<= endNum; i++){
				var active = pageNum == i ? "active":""; // 현제 페이지 상태를 나타내는 스타일시트 적용

				str += '<li class="page-item ' + active + ' "><a class="page-link" href="' + i + '">' + i + '</a></li>';
			}
			// 다음 페이지 표시
			if(next){
				str += '<li class="page-item"><a class="page-link" href="' + (endNum + 1) + '">Next</a></li>';
			}

			str += '</ul>';

			console.log(str);

			
			$("#replyPaging").html(str);

			//페이징정보 표시

			
		}
		
		var showReplyList = function (page){
			
			// 게시물의 글번호
			// 페이지번호		
			var bno = ${board.bno};
			var page = page;
		
			// 댓글목록 데이타 요청작업
			//  /replies/pages/{bno}/{page} --> /replies/pages/26111276/1.json
			$.getJSON("/replies/pages/" + bno + "/" + page + ".json", function(data){
				
				if(data.list == null || data.list.length == 0) {
					$("#replyListView").html("");
					$("#replyPaging").html("");
					return;
				}
				// 댓글목록
				printReplyData(data.list, $("#replyListView"), $("#replyTemplate"));
				
				// 댓글페이징
				printReplyPaging(data.replyCnt, page);
			});
		}

		
		

	
	</script>
	
	<script>
		$(document).ready(function(){

			var bno = ${board.bno };

			$.getJSON("/board/getAttachList", {bno:bno}, function(arr){
				console.log(arr);

				var str = "";

				$(arr).each(function(i, attach){
					
					//image type
					if(attach.fileType){
						var fileCallPath =  encodeURIComponent( attach.uploadPath+ "/s_"+attach.uuid +"_"+attach.fileName);
						
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
						str += "<img src='/display?fileName="+fileCallPath+"'>";
						str += "</div>";
						str += "</li>";
					}else{
						
						str += "<li data-path='"+attach.uploadPath+"' data-uuid='"+attach.uuid+"' data-filename='"+attach.fileName+"' data-type='"+attach.fileType+"' ><div>";
						str += "<span> "+ attach.fileName+"</span><br/>";
						str += "<img src='/resources/img/attach.png'></a>";
						str += "</div>";
						str += "</li>";
					}
	 			});
	 
	 		$(".uploadResult ul").html(str);

			});
			
			// 동적으로 추가된 태그를 선택자로 사용하여 이벤트 설정시 다음과 같이해야 한다.(중요)
			$("#replyPaging").on("click", "li a", function(e){
				e.preventDefault();
			

				var targetPageNum = $(this).attr("href");

				pageNum = targetPageNum;

				showReplyList(pageNum);

			});
		});
	</script>
	   
</head>
<body>
	<div class="wrapper">
		<div class="wrap">

			<%@ include file="/WEB-INF/views/common/nav.jsp"%>
			

			<div>
				<div style="width: 50%; z-index: 1; margin:0 auto; margin-top: 50px;">
					<div style="width: 100%; margin: 0 auto;">						
						<div class="panel-body" style="margin-top: 30px;">					
							<div class="form-group">
								<label for="exampleFormControlInput1">BNO</label> <input
									type="text" name="bno" value="${board.bno }"
									class="form-control" readonly>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1">Title</label> <input
									type="text" name="title" value="${board.b_title }"
									class="form-control" readonly>
							</div>
							<div class="form-group">
								<label for="exampleFormControlTextarea1">Content</label>
								<textarea name="content" class="form-control" rows="3" readonly>${board.b_content }</textarea>
							</div>
							<div class="form-group">
								<label for="exampleFormControlInput1">Writer</label> <input
									type="text" name="writer" value="${ board.mb_id}"
									class="form-control" readonly>
							</div>

							<div class="form-group">
								<c:if test="${sessionScope.loginStatus.mb_id == board.mb_id }">
									<button id="btnModify" type="button" class="btn btn-primary">Modify</button>
								</c:if>
								<button id="btnList" type="button" class="btn btn-info">List</button>
								<!-- Button trigger modal : data-toggle="modal" data-target="#replyModal" -->
								<button id="btnReplyFormView" type="button"
									class="btn btn-primary">Reply</button>
							</div>

							<form id="operForm" action="/board/modify" method="get">
								<input type="hidden" id="bno" name="bno" value="<c:out value="${board.bno }"></c:out>"> 
								<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum }" /> 
								<input type="hidden" id="amount" name="amount" value="${cri.amount }" /> 
								<input type="hidden" name="type" value='<c:out value="${cri.type }" />'> 
								<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }" />'>
							</form>
						</div>
					</div>
					<div class="row">
						<div class="col-lg-12">
							<div class="panel panel-default">

								<div class="panel-heading">File Attach</div>
								<!-- /.panel-heading -->
								<div class="panel-body">
									<!-- 업로드된 파일정보 출력위치 -->
									<div class='uploadResult'>
										<ul>

										</ul>
									</div>
								</div>
								<!--  end panel-body -->

							</div>
							<!--  end panel-body -->
						</div>
						<!-- end panel -->
					</div>

					<!--  댓글목록 위치-->
					<div class="row">
						<div style="width: 60%; margin: 0 auto;">
							<div class="panel panel-default">
								<div class="panel-heading">Reply List</div>

								<div class="panel-body" id="replyListView"></div>

								<div class="panel-footer" id="replyPaging" style="margin-top: 10px;"></div>
							</div>
						</div>
					</div>

				</div>
				<div class="modal fade" id="replyModal" data-backdrop="static" data-keyboard="false" tabindex="-1"
					aria-labelledby="exampleModalLabel" aria-hidden="true">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title" id="modalLabel">Reply Register Modal</h5>
								<button type="button" class="close" data-dismiss="modal" aria-label="Close">
									<span aria-hidden="true">&times;</span>
								</button>
							</div>
							<div class="modal-body">
								<div class="form-group">
									<label>Reply</label> 
									<input type="hidden" class="form-control" name="replyRno" id="replyRno"> 
									<input class="form-control" name="reply" id="reply">
								</div>
								<div class="form-group">
									<label>Replyer</label> 
									<input class="form-control" name="mb_id" id="mb_id" value="${sessionScope.loginStatus.mb_id}" readonly>
								</div>
							</div>
							<div class="modal-footer">							
								<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
								<button type="button" id="btnReplyAdd" class="btn btn-primary btnModal">Save Add</button>
								<button type="button" id="btnReplyEdit" class="btn btn-primary btnModal">Save Edit</button>
								<button type="button" id="btnReplyDel" class="btn btn-primary btnModal">Reply Del</button>					
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>



	<div class="pagenav">
		<div style="width: 60%; margin-top: 10px; margin: 0 auto;"></div>
	</div>

<script>
	
	$(document).ready(function(){
		// 4)사용자정의 헬퍼(Handlebars 버전의 함수)
		// 댓글 날짜를 하루기준으로 표현을 1)24시간 이전 시:분:초 2)24시간 이후 년/월/일
		Handlebars.registerHelper("displayTime", function(timeValue){
			
			var today = new Date(); // 1970년1월1일 0시0분0초 0 밀리세컨드
			var gap = today.getTime() - timeValue;
	
			var dateObj = new Date(timeValue);
			var str = "";
	
			if (gap < (1000 * 60 * 60 * 24)){
				var hh = dateObj.getHours();
				var mi = dateObj.getMinutes();
				var ss = dateObj.getSeconds();
	
				return [ (hh > 9 ? '' : '0') + hh, ':', (mi > 9 ? '' : '0') + mi,
						':', (ss > 9 ? '' : '0') + ss ].join('');
			}else {
				var yy = dateObj.getFullYear();
				var mm = dateObj.getMonth();
				var dd = dateObj.getDate();
	
				return [ yy, '/', (mm > 9 ? '' : '0') + mm, '/',
						(dd > 9 ? '' : '0') + dd ].join('');
			}
		});
	
		
		
	// 게시물에 해당하는 댓글목록, 페이징 출력작업
	var page = 1;
	showReplyList(page);

		// 모달대화상자 : 1)댓글쓰기 뷰
		$("#btnReplyFormView").on("click", function(){
			
			//alert();
			$("#modalLabel").html("Reply Regist Modal");

			// 댓글수정시 수정내용을 지우기.
			$("#reply").val("");
			

			// 작성자 활성화. 작성자 기본값 : readonly 
			//$("#mb_id").attr("readonly", false);

			$("#replyNo").html("");
			

			$("#replyModal .btnModal").hide(); // 댓글추가,수정,삭제버튼 숨김
			$("#replyModal #btnReplyAdd").show(); // 댓글추가버튼 보여짐.

			$("#replyModal").modal("show");
		});
		
		// 로그인 사용자와 상품후기 작성자가 동일하면 수정, 삭제 표시
		Handlebars.registerHelper("eqRelper", function(replyer, rno){

			var str = "";
			var login_id = "${sessionScope.loginStatus.mb_id}";

			if(replyer == login_id) {
				str += '<button type="button" class="btn btn-primary btn-edit">Modify</button>';
				str += '<button type="button" class="btn btn-primary btn-del">Delete</button>';
			}

			return new Handlebars.SafeString(str); // 태그문자열 처리시 사용

		});
		
		//모달대화상자 : 2)댓글수정하기 뷰
		$("#replyListView").on("click", ".btn-edit", function(){

			// 수정하고자 하는 내용 보기작업
			var rno, reply, replyer, replyDate;

			// jquery dom 관련 메서드
			rno = $(this).parent().parent().find("li[data-rno]").attr("data-rno");
			reply = $(this).parent().parent().find("li[data-reply]").attr("data-reply");
			mb_id = $(this).parent().parent().find("li[data-mb_id]").attr("data-mb_id");
			replydate = $(this).parent().parent().find("li[data-replydate]").attr("data-replydate");

			//console.log(rno);

			// 모달대화상자의 제목표시
			$("#modalLabel").html("Reply Modify Modal"+  "댓글번호:[" + rno + "]");

			// 작성자 비활성화
			$("#mb_id").attr("readonly", true);
			// 수정내용
			// 입력양식 태그는 val(), 다른 태그는 text(),html()
			$("#replyNo").html(rno);
			$("#replyRno").val(rno);
			$("#reply").val(reply);
			$("#mb_id").val(mb_id);

			$("#replyModal .btnModal").hide(); // 댓글추가,수정,삭제버튼 숨김
			$("#replyModal #btnReplyEdit").show(); // 댓글수정버튼 보여짐.

			$("#replyModal").modal("show");
		});

		//모달대화상자 : 3)댓글삭제 뷰
		$("#replyListView").on("click", ".btn-del", function(){
			//alert('댓글삭제버튼');

			var rno, reply, replyer, replydate;

			rno = $(this).parent().parent().find("li[data-rno]").attr("data-rno");
			reply = $(this).parent().parent().find("li[data-reply]").attr("data-reply");
			mb_id = $(this).parent().parent().find("li[data-mb_id]").attr("data-mb_id");
			replydate = $(this).parent().parent().find("li[data-replydate]").attr("data-replydate");

			$("#modalLabel").html("Reply Delete Modal " +  "댓글번호:[" + rno + "]" );

			// 작성자 비활성화
			$("#mb_id").attr("readonly", true);

			// 삭제내용
			$("#replyNo").html(rno);
			$("#replyRno").val(rno);
			$("#reply").val(reply);
			$("#mb_id").val(mb_id);


			$("#replyModal .btnModal").hide(); // 댓글추가,수정,삭제버튼 숨김
			$("#replyModal #btnReplyDel").show(); // 댓글삭제버튼 보여짐.

			$("#replyModal").modal("show");
		});
		
		

	var modal = $("#replyModal");
	//댓글 저장하기
	$("#btnReplyAdd").click(function(){

	// 댓글, 작성자 텍스트박스 유효성 검사
		// javascript object문법형식
		var reply = { bno : ${board.bno },  reply : $("#reply").val(), mb_id : $("#mb_id").val()};
	
		//alert(reply.reply + ',' + reply.replyer);
	
		$.ajax({
			type: 'post',
			url : '/replies/new',
			data : JSON.stringify(reply),
			contentType: "application/json; charset=utf-8",
			success: function(result){
				alert(result);
	
				// ajax작업으로 입력한 데이터가 유지되기때문에 다음사용을 위하여 지움
				$("#reply").val("");
				$("#mb_id").val("");
	
				modal.modal('hide');
				
				// 댓글리스트 출력작업. 함수호출은 못함(영역 인식이 안됨)
	
				showReplyList(1); 				
			},
			error: function(){
				alert("error");
			}
		});
	});
	
	// 댓글수정하기
	$("#btnReplyEdit").on("click", function(){

		//수정데이타
		// javascript object문법형식
		var reply = { rno : $("#replyRno").val(),  reply : $("#reply").val()};

		console.log(reply);
		console.log( JSON.stringify(reply));
		//return;


		$.ajax({
			type: 'put',
			url : '/replies/' + $("#replyRno").val(),
			data : JSON.stringify(reply), // reply객체의 값을 JSON문자열로 변환작업
			contentType : "application/json; charset=utf-8",
			success : function(data){
				alert("수정완료");
				$("#replyModal").modal("hide");

				showReplyList(1);
			},
			error : function(){
				alert("실패");		
			}
		});
	});
	
	// 댓글 삭제하기
	$("#btnReplyDel").click(function(){

		var rno = $("#replyRno").val()

		$.ajax({
			type: 'delete', // rest이론에서 기능에 맞는 요청방식을 사용
			url: '/replies/' + rno,
			success: function(data){
				if(data == "success") alert(rno + "삭제성공");

				// ajax작업으로 입력한 데이터가 유지되기때문에 다음사용을 위하여 지움
				$("#reply").val("");
				$("#mb_id").val("");

				modal.modal('hide');
				
				// 댓글리스트 출력작업. 함수호출은 못함(영역 인식이 안됨)
				showReplyList(1); 
			},
			error: function(){
				alert("실패");
			}

		});

	});
	
});
</script>

<script>

$(document).ready(function(){
	
	var form = $("#operForm");
	
	//리스트버튼 클릭
	$("#btnList").click(function(){
		//location.href = "/board/list";  // 페이지 이동(주소)

		form.attr("action","/board/list");
		form.submit();

	});
	// 수정버튼 클릭
	$("#btnModify").click(function(){
		//<form>태그정보를 submit작업
		// 리스트, 수정에 따라서 action주소가 다르기때문에 그에 따른 주소작업을 설정한다.
		if(confirm("수정하시겠습니까?")){
			form.attr("action","/board/modify").submit();
		}
		
		//form.submit();
	});
	
	
});

</script>

 
</body>

</html>