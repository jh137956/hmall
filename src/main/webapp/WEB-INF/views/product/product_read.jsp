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

<!-- 1)handlebars.js 참조 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
<!-- 2)UI Template(상품후기 목록 템플릿 -->
	<script id="reviewTemplate" type="text/x-handlebars-template">
			{{#each .}}
			<ul class="list-group">
				<li class="list-group-item" data-rv_num="{{rv_num}}">{{rv_num}}</li>				
				<li class="list-group-item" data-rv_content="{{rv_content}}">{{rv_content}}</li>
				<li class="list-group-item" data-mb_id="{{mb_id}}">{{mb_id}}</li>
				<li class="list-group-item" data-rv_score="{{rv_score}}">{{checkRating rv_score}}</li>
				<li class="list-group-item" data-replyDate="{{rv_reg_date}}">{{displayTime rv_reg_date}}</li>
				<li class="list-group-item">{{eqRelper mb_id}}</li>
			</ul>
			{{/each}}
	</script>

	<script>
		// 3) 상품후기 목록데이터 출력작업
		var printReviewData = function(reviewData, reviewTarget, reviewTemplate){
				var uiTemplate = Handlebars.compile(reviewTemplate.html());

				var reviewDataResult = uiTemplate(reviewData);
				
				reviewTarget.html(reviewDataResult);
			}

		// 상품후기 목록 페이징
		//var pageNum = curPage;
		var replyPageDisplay = ""; // [이전] 1 2 3 4 5... [다음]

		var displayPageCount = 5; // 출력될 갯수

		// 댓글 페이징번호를 출력하는 기능.
		var printReviewPaging = function(replyCnt, pageNum){
			
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

			
			$("#reviewPaging").html(str);

			//페이징정보 표시

			
		}
		
	</script>
<style>
		/*상품후기 별점*/
     #star_grade a{
     	font-size:22px;
        text-decoration: none;
        color: lightgray;
    }
    #star_grade a.on{
        color: black;
    }
    
    #star_grade_modal a{
     	font-size:22px;
        text-decoration: none;
        color: lightgray;
    }
    #star_grade_modal a.on{
        color: black;
    }
    
    .popup {position: absolute;}
    .back { background-color: gray; opacity:0.5; width: 100%; height: 300%; overflow:hidden;  z-index:1101;}
    .front { 
       z-index:1110; opacity:1; boarder:1px; margin: auto; 
      }
      
</style>
</head>
<body>
  <div class="wrapper">
    <div class="wrap">
      
      <%@ include file="/WEB-INF/views/common/nav.jsp"%>
      
      <div style="width:100%;">
		 <div class="row" style="margin: 0;">
       		<!-- 상세설명 -->
       		   
       		<div class="row no-gutters border rounded overflow-hidden flex-md-row mb-4 shadow-sm h-md-250 position-relative" style="width: 40%; height: 520px; margin: 0 auto;">
       		<div class="col-auto d-none d-lg-block">
	          <img style="width: 420px; height: 520px;"  src="/product/displayFile?fileName=${productVO.pdt_img }">
			</div>  
	        <div class="col p-4 d-flex flex-column position-static">
	          <span>상품 이름 :<strong class="d-inline-block mb-2 text-primary" >${productVO.pdt_name }</strong></span>         
	          <span>판매가 : <strong class="d-inline-block mb-2 text-primary" >${productVO.pdt_price }</strong></span>
	          <span>할인 : <strong class="d-inline-block mb-2 text-primary">${productVO.pdt_discount }</strong></span>
	          <span>제조사 : <strong class="d-inline-block mb-2 text-primary">${productVO.pdt_company }</strong></span>	          
	          <span>재고수량 : <strong class="d-inline-block mb-2 text-primary">${productVO.pdt_count_buy }</strong></span>
              <span style="margin-bottom: 4px;">구매수량 : <input type="text" value=1 id="pdt_count_buy" name="pdt_count_buy"></span>
             <div>
             <c:if test="${productVO.pdt_count_buy != 0}">
          	 <button type="button" id="btnOrder" class="btn btn-sm btn-outline-secondary">구매</button>
          	 </c:if>
          	 <c:if test="${productVO.pdt_count_buy == 0}">
          	 <p>재고준비중입니다</p>
          	 </c:if>
             <button type="button" id="btnCart" class="btn btn-sm btn-outline-secondary">장바구니</button>
             <button type="button" id="btnReview" class="btn btn-sm btn-outline-secondary">상품후기</button>
             </div>
	        </div>
	         <form id="order_direct_form" method="get" action="/order/order">
	       		<input type="hidden" name="type" value="1">
	         </form>       
         </div>
       </div>
       <div class="row" style="margin: 0;">
	       <div style="width: 70%; margin: 0 auto;">
		       <div style="text-align: center;">
		    	${productVO.pdt_detail }
		    	</div>
	    	</div>
       </div>
       <div class="row" style="margin: 0;">
		<div style="width: 30%; margin: 0 auto;">
    		<div class="panel panel-default">
    			<div class="panel-heading">
    			 Review List
    			</div>
    			<!-- 상품후기목록위치 -->
    			<div class="panel-body" id="reviewListView"></div>
				<!-- 페이징위치 -->
				<div class="panel-footer" id="reviewPaging"></div>
			</div>
		 </div>
		</div>
  	 </div>
   </div>
  </div>
      
      <div class="pagenav">
          <div style="width:60%; margin-top: 10px; margin: 0 auto;"></div>
      </div>
	
	<script>

	$(document).ready(function(){
		
		$("#btnCart").on("click", function(){
			console.log("장바구니");

			/*
			장바구니 코드 : 시퀀스,  로그인 id(세션처리),
			상품코드, 수량
			*/
			var pdt_num = ${productVO.pdt_num };
			var pdt_count_buy = $("#pdt_count_buy").val();

			$.ajax({
				url: "/cart/add",
				type: "post",
				data: {pdt_num : pdt_num, pdt_count_buy: pdt_count_buy},
				dataType: "text",
				success: function(data){
					if(data == "SUCCESS"){
						if(confirm("장바구니에 추가되었습니다 \n 확인하시겠습니까?")){
							location.href = "/cart/cart_list";
						}
					}else if(data == "LoginRequired"){
						alert("로그인을 해주세요");
						location.href = "/member/login";
					}
				} 
			});
		});
		
		// 즉시구매
		$("#btnOrder").on("click", function(){
			
			var pdt_num = ${productVO.pdt_num };
			var od_amount = $("#pdt_count_buy").val();;

			console.log("상품코드: " + pdt_num);
			console.log("수량: " + od_amount);

			var order_direct_form = $("#order_direct_form");
			order_direct_form.append("<input type='hidden' name='pdt_num' value='" + pdt_num +"'>");
			order_direct_form.append("<input type='hidden' name='od_amount' value='" + od_amount +"'>");

			order_direct_form.submit();
		});

	});

	</script>

	<script>

	// 상품후기 목록/ 페이징 기능
	var showReplyList = function(curPage){
		
		// 상품코드
		let pdt_num = ${productVO.pdt_num};
		let page = curPage;
				
		console.log(pdt_num);

		let url = "/review/pages/" + pdt_num + "/" + page;

		$.getJSON(url, function(data){

			// 댓글데이터 없을 경우
			//상품후기목록 
			printReviewData(data.list, $("#reviewListView"), $("#reviewTemplate"));
			// 페이징  
			printReviewPaging(data.reviewCnt, page);
		
		});
		
	}

	let curPage = 1;
	showReplyList(curPage);
	
	</script>  

	<script>
	
	$(document).ready(function(){
		
		$("#btnReview").on("click", function(){
			
			$("modalLabel").html("Product Review Modal-Register");
			
			$("button.btnModal").hide();
			$("#btnReviewAdd").show();
			
			$("#rv_content").val();

			$("#reviewModal").modal("show");

		});

		// 별점색상변경
		$("#star_grade a").click(function(e){
			e.preventDefault();
			$(this).parent().children("a").removeClass("on");
			$(this).addClass("on").prevAll("a").addClass("on");
		});

		// 상품후기 쓰기
		$("#btnReviewAdd").on("click", function(){

			let rv_score = 0;
			let rv_content = $("#rv_content").val();
			let pdt_num = $("#pdt_num").val();

			$("#star_grade a").each(function(i, e){
				if($(this).attr("class") == "on"){
					rv_score += 1;
				}
			});

			if(rv_score == 0){
				alert("별점을 선택해주세요");
				return;
			}else if(rv_content == "" || rv_content == null){
				alert("후기내용을 입력해주세요");
				return;
			}

			// ajax호출
			// 후기데이터 전송
			$.ajax({
				url: "/review/review_register",
				type: "post",
				data: {rv_score : rv_score, rv_content : rv_content, pdt_num : pdt_num},
				dataType: "text",
				success: function(data){
					alert("등록완료");
					$("#star_grade a").parent().children("a").removeClass("on");
					$("#rv_content").val("");

					$("#reviewModal").modal("hide");

					// 상품후기 목록호출
					showReplyList(1);
				}
			});

		});

		// 로그인 사용자와 상품후기 작성자가 동일하면 수정, 삭제 표시
		Handlebars.registerHelper("eqRelper", function(replyer, rv_num){

			var str = "";
			var login_id = "${sessionScope.loginStatus.mb_id}";

			if(replyer == login_id) {
				str += '<button type="button" class="btn btn-primary btn-edit">Modify</button>';
				str += '<button type="button" class="btn btn-primary btn-del">Delete</button>';
			}

			return new Handlebars.SafeString(str); // 태그문자열 처리시 사용

		});

		// 상품후기 수정버튼 클릭시
		$("#reviewListView").on("click", ".btn-edit", function(){
			console.log("수정버튼");

			// 모달대화상자 표시 - 수정내용 표시
			var rv_num, mb_id, pdt_num, rv_content, rv_score, rv_reg_date;

			rv_num = $(this).parents("ul.list-group").find("li[data-rv_num]").attr("data-rv_num");
			rv_content = $(this).parents("ul.list-group").find("li[data-rv_content]").attr("data-rv_content");
			mb_id = $(this).parents("ul.list-group").find("li[data-mb_id]").attr("data-mb_id");
			rv_score = $(this).parents("ul.list-group").find("li[data-rv_score]").attr("data-rv_score");
			rv_reg_date = $(this).parents("ul.list-group").find("li[data-rv_reg_date]").attr("data-rv_reg_date");

			console.log(rv_num);

			$("#modalLabel").html("Product Review Modal-Modify" + rv_num + " 번");

			$("#rv_num").val(rv_num);
			$("#rv_content").val(rv_content);			
			
			// 상품후기 수정 모달대화상자 별점 표시작업
			$("#star_grade a").each(function(index, item){
				if(index < rv_score){
					$(item).addClass("on");
				}else{
					$(item).removeClass("on");
				}
			});

			$("button.btnModal").hide();
			$("#btnReviewEdit").show();
			
			$("#reviewModal").modal("show");

		});
		
		// 후기 수정하기
		$("#btnReviewEdit").on("click", function(){
			
			let rv_score = 0;
			let rv_content = $("#rv_content").val();
			
			let rv_num = $("#rv_num").val();
		

			$("#star_grade a").each(function(i, e){
				if($(this).attr("class") == "on"){
					rv_score += 1;
				}
			});

			if(rv_score == 0){
				alert("별점을 선택해주세요");
				return;
			}else if(rv_content == "" || rv_content == null){
				alert("후기내용을 입력해주세요");
				return;
			}
			
			console.log(rv_score);
			console.log(rv_content);
			console.log(rv_num);			

			// ajax호출
			// 후기데이터 전송
			$.ajax({
				url: "/review/review_modify",
				type: "post",
				data: {rv_score : rv_score, rv_content : rv_content, rv_num : rv_num},
				dataType: "text",
				success: function(data){
					alert("상품후기 수정 완료");
					$("#star_grade a").parent().children("a").removeClass("on");
					$("#rv_content").val("");

					$("#reviewModal").modal("hide");

					// 상품후기 목록호출
					showReplyList(curPage);
				}
			});
				
		});

		// 상품 삭제 보기
		$("#reviewListView").on("click", ".btn-del", function(){

			console.log("삭제버튼");

			// 모달대화상자 표시 - 수정내용 표시
			var rv_num, mb_id, pdt_num, rv_content, rv_score, rv_reg_date;

			rv_num = $(this).parents("ul.list-group").find("li[data-rv_num]").attr("data-rv_num");
			rv_content = $(this).parents("ul.list-group").find("li[data-rv_content]").attr("data-rv_content");
			mb_id = $(this).parents("ul.list-group").find("li[data-mb_id]").attr("data-mb_id");
			rv_score = $(this).parents("ul.list-group").find("li[data-rv_score]").attr("data-rv_score");
			rv_reg_date = $(this).parents("ul.list-group").find("li[data-rv_reg_date]").attr("data-rv_reg_date");

			console.log(rv_num);

			$("#modalLabel").html("Product Review Modal-Modify" + rv_num  + "번");

			$("#rv_num").val(rv_num);
			$("#rv_content").val(rv_content);			
			
			// 상품후기 수정 모달대화상자 별점 표시작업
			$("#star_grade a").each(function(index, item){
				if(index < rv_score){
					$(item).addClass("on");
				}else{
					$(item).removeClass("on");
				}
			});

			$("button.btnModal").hide();
			$("#btnReviewDel").show();
			
			$("#reviewModal").modal("show");

		});	
			// 상품후기 삭제버튼 클릭시
		$("#btnReviewDel").on("click", function() {
		
			let rv_num = $("#rv_num").val();

			// ajax호출
			// 후기데이터 전송
			$.ajax({
				url: "/review/review_delete",
				type: "post",
				data: {rv_num : rv_num},
				dataType: "text",
				success: function(data){
					alert("상품후기 삭제 완료");
					$("#star_grade a").parent().children("a").removeClass("on");
					$("#rv_content").val("");

					$("#reviewModal").modal("hide");

					// 상품후기 목록호출
					showReplyList(curPage);
				}
			});
		});


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

		Handlebars.registerHelper("checkRating", function(rating){

			var stars = "";
	
			switch(rating){
				case 1:
					stars = "★☆☆☆☆";
					break;
				case 2:
					stars = "★★☆☆☆";
					break;
				case 3:
					stars = "★★★☆☆";
					break;
				case 4:
					stars = "★★★★☆";
					break;
				case 5:
					stars = "★★★★★";
					break;
				default:
					stars = "☆☆☆☆☆";
					break;
			}
			return stars;

		});

		// 이전, 다음 페이지 번호 클릭시
		$("#reviewPaging").on("click", "li.page-item a", function(e){
			e.preventDefault();
			console.log("페이지번호클릭");

			curPage = $(this).attr("href");
			showReplyList(curPage);
		});
	
	});
	
	</script>

<!-- 상품후기 (모달대화상자) : 상품후기, 수정, 삭제-->
<div class="modal fade" id="reviewModal" data-backdrop="static" data-keyboard="false" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  <div class="modal-dialog">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="modalLabel">Product Review Modal-Register</h5>
		
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
       <div class="form-group">
      	<label for="review">평점</label><br>
		<div class="rating">
			<p id="star_grade">
		        <a href="#">★</a>
		        <a href="#">★</a>
		        <a href="#">★</a>
		        <a href="#">★</a>
		        <a href="#">★</a>
			</p>
		</div>
		</div>
        <div class="form-group">
        	<label>상품후기</label>
			<input type="hidden" class="form-control" name="pdt_num" id="pdt_num" value="${productVO.pdt_num}">
			<input type="hidden" name="rv_num" id="rv_num">
        	<textarea class="form-control" name="rv_content" id="rv_content"></textarea>
        </div>
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
        <button type="button" id="btnReviewAdd" class="btn btn-primary btnModal">후기 저장</button>
		<button type="button" id="btnReviewEdit" class="btn btn-primary btnModal">후기 수정</button>
		<button type="button" id="btnReviewDel" class="btn btn-primary btnModal">후기 삭제</button>
      </div>
    </div>
  </div>
</div>
</body>

</html>