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
	     <!-- 상품리스트 폼 -->
	<div class="row" style="margin: 0;">
    	<div class="col-lg-6" style="margin: 0 auto;">
    		<div class="panel panel-default">  		 
    			<div class="panel-body">
    			 <!-- 리스트 -->
    			 <table class="table table-striped">
				  <thead>
				    <tr>
				      <th scope="col"></th>
				      <th scope="col">번호</th>
				      <th scope="col">주문번호</th>
				      <th scope="col">주문날짜</th>				   
				      <th scope="col">받는분</th>
				      <th scope="col">금액</th>
				      <th scope="col">처리상태</th>
				      <th scope="col">상세보기</th>				   
				    </tr>
				  </thead>
				  <tbody>
				  <c:set var="i" value="${cri.pageNum }"></c:set>
				  <c:forEach items="${myOrderVO}" var="orderVO" varStatus="status">
				    <tr>
				      <th scope="row"><input type="checkbox" name="order_check" value="${orderVO.od_code}"></th>				      
				      <td>
				      	${(cri.pageNum - 1) * cri.amount + status.count}		      	
				      </td>				    
				      <td>
				      	${orderVO.od_code}				      
				      </td>
				      <td>
				      	<fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${orderVO.od_date }"/>
				      </td>				      
				      <td>${orderVO.od_name}</td>			      
				      <td>
				      	<fmt:formatNumber type="currency" value="${orderVO.od_total_price }"></fmt:formatNumber>
				      </td>
				      <td>
				      	
				      </td>
				      <td>
				      	<button type="button" name="my_order_detail" data-od_code="${orderVO.od_code}" class="btn btn-link">Link</button>
				      </td>
				    </tr>			  
				   </c:forEach>
				   </tbody>
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
<script id="orderDetailTemplate" type="text/x-handlebars-template">
	<tr class="dy_order_detail" style="text-align: center;"><td colspan="8">주문 상세내역</td></tr>
	<tr class="dy_order_detail">
		<th>선택</th>
		<th>번호</th>
		<th>상품명</th>
		<th>수량</th>
		<th>상품가격</th>
		<th>소계</th>
		<th colspan="2">비고</th>

	</tr>
	<c:set var="i" value="1"></c:set>
	{{#each .}}
	<tr class="dy_order_detail">
		<td><input type="checkbox" id="check_all"></td>
		<td> ${i } </td>	
		<td>{{pdt_name}}</td>
		<td>{{od_amount}}</td>
		<td>{{od_price}}</td>
		<td>{{total_price od_price od_amount}}</td>
		<td colspan="2"></td>
	</tr>
	{{/each}}
	<tr class="dy_order_detail"><td colspan="8" style="height: 30px;"></td></tr>
</script> 
<script>
// 핸들바의 사용자 정의 함수
Handlebars.registerHelper("total_price", function(od_price, od_amount){
	
	return od_price * od_amount;
}); 
	

</script>

<script>
	var orderDetailView = function(orderDetailData, orderDetailTarget, orderDetailTemplate){
		var detailTemplate = Handlebars.compile(orderDetailTemplate.html());
		var details = detailTemplate(orderDetailData);

		console.log(details);
		$(".dy_order_detail").remove();
		orderDetailTarget.after(details);
		
	}
</script>

	<script>

		$(document).ready(function(){

			$("button[name='my_order_detail']").on("click", function(){
				
				console.log("상품상세");
	            var od_code = $(this).attr("data-od_code");
				var current_tr = $(this).parents("tr");
	            
				$.ajax({
					url: '/order/my_order_Detail_List',
					type: 'get',
					dataType: 'json', 
					data: {od_code : od_code}, 
					success : function(data){
						//alert(data.length);

						orderDetailView(data, current_tr, $("#orderDetailTemplate"));
					}
				});
			});


		});

	</script>


</body>

</html>