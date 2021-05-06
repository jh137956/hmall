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
</head>
<body>
  <div class="wrapper">
    <div class="wrap">
      
      <%@ include file="/WEB-INF/views/common/nav.jsp"%>
            
     
        <div style="width:100%; z-index: 1; margin-top: 50px;">
        	
       		  <div class="row" style="width: 70%; margin: 0 auto;">
       		   
       		  <c:forEach items="${productVOList }" var="productVO">
		       <div class="" style="z-index: 1; height: 550px; width: 23%; margin-left: 1%; margin-right: 1%; margin-top: 20px;">
       		   <div class="card mb-3 shadow-sm">
    		     <div>
		            <a href="/product/product_read?pdt_num=${productVO.pdt_num }">
		            	<img src="/product/displayFile?fileName=${productVO.pdt_img}" style="width: 100%; height: 400px;"/>
		            </a>
	            </div>
	            <div class="card-body" style="height: 150px;">
		            <div>
		              <p class="card-text">This is a wider card</p>
		              <input type="hidden" name="pdt_num" value="${productVO.pdt_num }">
	                  <span><c:out value="${productVO.pdt_name }" /></span><br>
	                     <span><fmt:formatNumber type="currency" value="${productVO.pdt_price-productVO.pdt_discount}"></fmt:formatNumber></span>
	                     </div>
		                <div class="btn-group" style="float: right;">
		                  <input type="hidden" value=1 id="od_amount" name="od_amount" style="width: 100px">
		                  <c:if test="${productVO.pdt_count_buy != 0}">          
		                  <button type="button" data-pdt_num="${productVO.pdt_num }" name="btn_buy_now" class="btn btn-sm btn-outline-secondary">구매</button>
		                  </c:if>
		                  <c:if test="${productVO.pdt_count_buy == 0}">
		                  <button type="button" data-pdt_num="${productVO.pdt_num }" name="btn_buy_now" class="btn btn-sm btn-outline-secondary" disabled>구매</button>         
		                  </c:if>
		                  <button type="button" data-pdt_num="${productVO.pdt_num }" name="btnlistcart" class="btn btn-sm btn-outline-secondary">장바구니</button>
		                </div>	           
		            </div>
	            </div>
	          </div>
	       </c:forEach>
	       <form id="order_direct_form" method="get" action="/order/order">
	       		<input type="hidden" name="type" value="1">
	       </form> 
          </div>
        </div>
     </div>
	</div>
 
      
      <div class="pagenav">
          <div style="width:60%; margin-top: 10px; margin: 0 auto;">
	  </div>
  </div>

	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	
	<script id="subCGListTemplate" type="text/x-handlebars-template">
  {{#each .}}
    <li><a href="2차카테고리 참조하는 상품목록?cg_code={{cg_code}}">{{cg_name}}</a></li>
  {{/each}}
	</script>
<script>
	var subCGList = function(subCGData, targetSubCategory, templateObject) {
		
	    var template = Handlebars.compile(templateObject.html());
	    var subCGLi = template(subCGData);
	    
	    $(".mainCategory .subCategory").empty();
	
	    targetSubCategory.find(".subCategory").append(subCGLi);
	    
	  }
	
	$(document).ready(function(){
		
		// 장바구니 버튼 클릭시
		$("button[name='btnlistcart']").on("click", function(){
			console.log("장바구니");

			var pdt_num = $(this).attr("data-pdt_num");
	
			var pdt_count_buy = 1;

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
		$("button[name='btn_buy_now']").on("click", function(){
			
			var pdt_num = $(this).attr("data-pdt_num");
			var od_amount = $(this).parent().find("input[name='od_amount']").val();

			console.log("상품코드: " + pdt_num);
			console.log("수량: " + od_amount);

			var order_direct_form = $("#order_direct_form");
			order_direct_form.append("<input type='hidden' name='pdt_num' value='" + pdt_num +"'>");
			order_direct_form.append("<input type='hidden' name='od_amount' value='" + od_amount +"'>");

			order_direct_form.submit();
		});

	});

	</script>  
</body>

</html>