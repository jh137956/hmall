<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>	
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

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
            
     
        <div style="width:100%;">
        	    <!-- 상품리스트 폼 -->
	<div class="row" style="margin: 0;">
    	<div style="margin: 0 auto;">
    		<div class="panel panel-default">
    			<div class="panel-body">
    			
    			 <!-- 리스트 -->
    			 <table class="table table-striped">
					<button type="button" id="btn_cart_check_del" class="btn btn-primary" style="float: right;">선택삭제</button>
				  <thead>
				    <tr>
				      <th scope="col"><input type="checkbox" id="check_all"></th>
				      <th scope="col">상품번호</th>
				      <th scope="col">이미지</th>
				      <th scope="col">상품명</th>
				      <th scope="col">수량</th>
				      <th scope="col">가격</th>
				      <th scope="col">배송비</th>
				      <th scope="col">취소</th>
				    </tr>
				  </thead>
				  <tbody>
				  <%--데이터가 존재하지 않을경우 --%>
				  <c:if test="${empty cartVOList}">
				  <tr>
				  	<td colspan="8">
				  		<p>장바구니가 비었습니다</p>
				  	</td>
				  </tr>
				  </c:if>
				  
				  <c:set var="i" value="1"></c:set>
				  <c:set var="price" value="0"></c:set>
				  <c:forEach items="${cartVOList }" var="cartVO">
				  <c:set var="price" value="${(cartVO.pdt_price * cartVO.cart_count_buy) - (cartVO.pdt_discount * cartVO.cart_count_buy)}"></c:set>
				    <tr>
				      <td>
				        <input type="checkbox" name="cart_check" value="${cartVO.cart_code }">
				      </td>
				      <th scope="row">${i }</th>
				      <td>
				      	<img src="/cart/displayFile?fileName=${cartVO.pdt_img}">
				      </td>
				      <td>
				      	<c:out value="${cartVO.pdt_name }"></c:out>			      	
				      </td>
				       <td>
				      	<input type="number" name="cart_count_buy" value="<c:out value="${cartVO.cart_count_buy }" />"  />
				      	<button type="button" name="btn-cartedit" data-cart_code="${cartVO.cart_code }" class="btn btn-primary ">수정</button>			      	
				      </td>				      		      
				      <td data-price="${price}">
						<fmt:formatNumber type="currency" value="${price}"></fmt:formatNumber>
					  </td>
				      <td>
				      	<p>[기본배송조건]</p>
				      </td>
				      <td>
				      	<button type="button" name="btn-CartDel" data-cart_code="${cartVO.cart_code }" class="btn btn-danger">삭제</button>
				      </td>			      
				    </tr>
				    <c:set var="i" value="${i+1 }"></c:set>
				    <c:set var="sum" value="${sum + price}"></c:set>
				   </c:forEach>			   
				   </tbody>
				</table>
    			</div>
    			
    			<div class="panel-body" id="sum_price">
    			 <table class="table table-striped">
    			  <tr>
    			  	<td>총 주문금액</td>
    			  	<td data-sum="${sum}">
					  <fmt:formatNumber type="currency" value="${sum}"></fmt:formatNumber>
					</td>
    			  </tr>
    			 </table>	 
    			</div>
    			
    			<div class="panel-footer" id="sum_price">
    			 <table class="table table-striped">
    			  <tr>
    			  	<td>총 주문금액</td>
    			  	<td>
					   <button type="button" name="btn_all_cart_list" class="btn btn-primary ">장바구니 비우기</button>
					   <button type="button" name="btn_order" class="btn btn-primary ">상품 전체 주문</button>
					</td>
    			  </tr>
    			 </table>	 
    			</div>
    		</div>
    	</div>
    </div>
       		
   </div>
  </div> 	 
 </div>

      
	<div class="pagenav">
		<div style="width:60%; margin-top: 10px; margin: 0 auto;">
		
		</div>
	</div>

	<script>

		$(document).ready(function(){

			// 장바구니 삭제
			$("button[name='btn-CartDel']").on("click", function(){
				
				if(confirm("삭제하시겠습니까?")){
					var cart_code = $(this).attr("data-cart_code");
					
					var cart_tr = $(this).parents("tr");

					var cart_price = cart_tr.find("td[data-price]").attr("data-price");

					console.log(cart_price);

					var sum_price = $("div#sum_price td[data-sum]").attr("data-sum");

					console.log(sum_price);

					$.ajax({
						url: '/cart/cart_delete',
						type: 'post',
						dataType: 'text', 
						data: {cart_code : cart_code},  
						success : function(data){
							if(data== 'SUCCESS'){
								//location.href = "/cart/cart_list";
								alert("삭제완료");
								// 행을 화면에서 제거
								cart_tr.remove();

								// 합계 계산
								sum_price = parseInt(sum_price) - parseInt(cart_price);

								$("div#sum_price td[data-sum]").attr("data-sum", sum_price); // 삭제시 값 변경이 지속적으로 처리해야함
								$("div#sum_price td[data-sum]").text(sum_price);
							}
						}
					});

			}
			});

			$("input[name='cart_count_buy']").on("change", function(){
				console.log("수량변경");
			});

			// 수량수정버튼 클릭시
			$("button[name='btn-cartedit']").on("click", function(){
				console.log("수량변경완료");
				// 주요 파라미터 : 장바구니 코드, 변경된 수량
				var cart_code = $(this).attr("data-cart_code");

				var qty = $(this).siblings("input[name='cart_count_buy']").val();  // cart_tr.find("input[name='cart_count_buy']").val();
				console.log(qty);
				
				var cart_tr = $(this).parents("tr");
				
				$.ajax({
					url: '/cart/cart_count_update',
					type: 'post',
					dataType: 'text', 
					data: {cart_code : cart_code, cart_count_buy : qty}, 
					success : function(data){
						if(data== 'SUCCESS'){
							//location.href = "/cart/cart_list";
							alert("수정완료");
							location.href = "/cart/cart_list";
	
							// 합계 계산
						
						}
					}
				});
				

			});

			// 장바구니 비우기
			$("button[name='btn_all_cart_list']").on("click", function(){
				location.href = "/cart//cart_all_delete";
			});


			// 주문버튼 이동
			$("button[name='btn_order']").on("click", function(){
				location.href = "/order/order?type=2";
			});


			// 장바구니 선택삭제	<input type="checkbox" name="cart_check" value="${cartVO.cart_code }">
			$("#btn_cart_check_del").on("click", function(){

				// console.log($("input[name='cart_check']:checked").length);
				if($("input[name='cart_check']:checked").length == 0){
					alert("삭제할 상품을 선택해주세요");
					return;
				}
				
				var result = confirm("선택한 상품을 삭제하시겠습니까?");

				if(result){
					var checkArr = [];

					$("input[name='cart_check']:checked").each(function(){
						var cart_code = $(this).val();
						checkArr.push(cart_code);
					});

					$.ajax({
						url: "/cart/cart_check_delete",
						type: "post",
						dataType: "text", 
						data: {checkArr : checkArr}, 
						success : function(data){
							if(data== "SUCCESS"){
								//location.href = "/cart/cart_list";
								alert("선택된 상품이 삭제되었습니다");
								console.log(data);
								location.href = "/cart/cart_list";
				
							}
						}
					});
				}

			});

			// 체크박스 전체선택
			$("#check_all").on("click", function(){
				$("input[name='cart_check']").prop("checked", this.checked);
			});

			//데이터 행의 체크박스 클릭
			$("input[name='cart_check']").on("click", function(){
				$("#check_all").prop("checked", false);
			});

		});



	</script>


</body>

</html>