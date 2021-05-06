<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <!-- css file -->
<%@include file="/WEB-INF/views/admin/include/head_inc.jsp" %>
<script src="/ckeditor/ckeditor.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>

</head>
<!--
BODY TAG OPTIONS:
=================
Apply one or more of the following classes to get the
desired effect
|---------------------------------------------------------|
| SKINS         | skin-blue                               |
|               | skin-black                              |
|               | skin-purple                             |
|               | skin-yellow                             |
|               | skin-red                                |
|               | skin-green                              |
|---------------------------------------------------------|
|LAYOUT OPTIONS | fixed                                   |
|               | layout-boxed                            |
|               | layout-top-nav                          |
|               | sidebar-collapse                        |
|               | sidebar-mini                            |
|---------------------------------------------------------|
-->
<body class="hold-transition skin-blue sidebar-mini">
<div class="wrapper">

  <!-- Main Header -->
	<%@include file="/WEB-INF/views/admin/include/main-header.jsp" %>

  <!-- Left side column. contains the logo and sidebar -->
    <%@include file="/WEB-INF/views/admin/include/main-sidebar.jsp" %>
   

  <!-- Content Wrapper. Contains page content -->
  <div class="content-wrapper">
    <!-- Content Header (Page header) -->
    <section class="content-header">
      <h1>
        Page Header
        <small>Optional description</small>
      </h1>
      <ol class="breadcrumb">
        <li><a href="#"><i class="fa fa-dashboard"></i> Level</a></li>
        <li class="active">Here</li>
      </ol>
    </section>

    <!-- Main content -->
    <section class="content container-fluid">
	
	<!-- 검색 -->
	<div class="row">
		<div class="col-lg-12">
			<form id="searchForm" action="/admin/order/order_list" method="get">
				<select name="type" id="type">
					<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected':''}" />>--</option>
					<option value="N" <c:out value="${pageMaker.cri.type == 'N' ? 'selected':''}" />>주문번호</option>
					<option value="D" <c:out value="${pageMaker.cri.type == 'D' ? 'selected':''}" />>아이디</option>
					<option value="C" <c:out value="${pageMaker.cri.type == 'C' ? 'selected':''}" />>날짜</option>
					<option value="ND" <c:out value="${pageMaker.cri.type == 'ND' ? 'selected':''}" />>주문번호 or 아이디</option>
					<option value="NC" <c:out value="${pageMaker.cri.type == 'NC' ? 'selected':''}" />>주문번호 or 날짜</option>
					<option value="NDC" <c:out value="${pageMaker.cri.type == 'NDC' ? 'selected':''}" />>주문번호 or 아이디 or 날짜</option>
				</select>
				<input type="text" name="keyword" value="${pageMaker.cri.keyword}">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				<button id="btnSearch" type="button" class="btn btn-primary">검색</button>
			</form>
		</div>
	</div>
	
	
	
     <!-- 상품리스트 폼 -->
	<div class="row">
    	<div class="col-lg-12">
    		<div class="panel panel-default">  		 
    			<div class="panel-body">
    			 <!-- 리스트 -->
    			 <button type="button" id="btn_order_check_del" class="btn btn-primary" style="float: right;">선택삭제</button>
    			 <table class="table table-striped">
				  <thead>
				    <tr>
				      <th scope="col"><input type="checkbox" id="check_all"></th>
				      <th scope="col">번호</th>
				      <th scope="col">주문자</th>
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
				  <c:forEach items="${order_list }" var="orderVO" varStatus="status">
				    <tr>
				      <th scope="row"><input type="checkbox" name="order_check" value="${orderVO.od_code}"></th>				      
				      <td>
				      	${(cri.pageNum - 1) * cri.amount + status.count}		      	
				      </td>
				      <td>${orderVO.mb_id}</td>
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
				      	<button type="button" name="order_detail" data-od_code="${orderVO.od_code}" class="btn btn-link">Link</button>
				      </td>
				    </tr>			  
				   </c:forEach>
				   </tbody>
				</table>
    			</div>
    		</div>
    	</div>
    </div>
    
     <div class="row">
    	<div class="col-lg-12">
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
		
		    				<hr>
		    				${pageMaker }
    			</div>
    	</div>
    </div>
    
    <!-- 페이지번호, 수정버튼, 삭제버튼 클릭시 -->
    <form id="actionForm" action="/admin/order/order_list" method="get">
		<input type="hidden" name="pageNum" value='<c:out value="${pageMaker.cri.pageNum }" />'>
		<input type="hidden" name="amount" value='<c:out value="${pageMaker.cri.amount }" />'>
		<input type="hidden" name="type" value='<c:out value="${pageMaker.cri.type }" />'>
		<input type="hidden" name="keyword" value='<c:out value="${pageMaker.cri.keyword }" />'>
	</form>

    </section>
    <!-- /.content -->
  </div>
  <!-- /.content-wrapper -->

  <!-- Main Footer -->
	<%@include file="/WEB-INF/views/admin/include/main-footer.jsp" %>

  <!-- Control Sidebar -->
  <aside class="control-sidebar control-sidebar-dark">
    <!-- Create the tabs -->
    <ul class="nav nav-tabs nav-justified control-sidebar-tabs">
      <li class="active"><a href="#control-sidebar-home-tab" data-toggle="tab"><i class="fa fa-home"></i></a></li>
      <li><a href="#control-sidebar-settings-tab" data-toggle="tab"><i class="fa fa-gears"></i></a></li>
    </ul>
    <!-- Tab panes -->
    <div class="tab-content">
      <!-- Home tab content -->
      <div class="tab-pane active" id="control-sidebar-home-tab">
        <h3 class="control-sidebar-heading">Recent Activity</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <i class="menu-icon fa fa-birthday-cake bg-red"></i>

              <div class="menu-info">
                <h4 class="control-sidebar-subheading">Langdon's Birthday</h4>

                <p>Will be 23 on April 24th</p>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

        <h3 class="control-sidebar-heading">Tasks Progress</h3>
        <ul class="control-sidebar-menu">
          <li>
            <a href="javascript:;">
              <h4 class="control-sidebar-subheading">
                Custom Template Design
                <span class="pull-right-container">
                    <span class="label label-danger pull-right">70%</span>
                  </span>
              </h4>

              <div class="progress progress-xxs">
                <div class="progress-bar progress-bar-danger" style="width: 70%"></div>
              </div>
            </a>
          </li>
        </ul>
        <!-- /.control-sidebar-menu -->

      </div>
      <!-- /.tab-pane -->
      <!-- Stats tab content -->
      <div class="tab-pane" id="control-sidebar-stats-tab">Stats Tab Content</div>
      <!-- /.tab-pane -->
      <!-- Settings tab content -->
      <div class="tab-pane" id="control-sidebar-settings-tab">
        <form method="post">
          <h3 class="control-sidebar-heading">General Settings</h3>

          <div class="form-group">
            <label class="control-sidebar-subheading">
              Report panel usage
              <input type="checkbox" class="pull-right" checked>
            </label>

            <p>
              Some information about this general settings option
            </p>
          </div>
          <!-- /.form-group -->
        </form>
      </div>
      <!-- /.tab-pane -->
    </div>
  </aside>
  <!-- /.control-sidebar -->
  <!-- Add the sidebar's background. This div must be placed
  immediately after the control sidebar -->
  <div class="control-sidebar-bg"></div>
</div>
<!-- ./wrapper -->

<!-- REQUIRED JS SCRIPTS -->

 <%@include file="/WEB-INF/views/admin/include/scripts.jsp" %>

<!-- Optionally, you can add Slimscroll and FastClick plugins.
     Both of these plugins are recommended to enhance the
     user experience. -->
     
<script>
$(document).ready(function(){
	
	
});
</script>



<!--주문상세 데이터와 결합될 태그 구성-->
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
		<td colspan="2">비고</td>
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

		$("button[name='order_detail']").on("click", function(){
			
			console.log("상품상세");
            var od_code = $(this).attr("data-od_code");
			var current_tr = $(this).parents("tr");
            
			$.ajax({
				url: '/admin/order/order_Detail_List',
				type: 'get',
				dataType: 'json', 
				data: {od_code : od_code}, 
				success : function(data){
					//alert(data.length);

					orderDetailView(data, current_tr, $("#orderDetailTemplate"));
				}
			});
		});
     

		

		// 검색버튼
		var searchForm = $("#searchForm");

		$("#searchForm #btnSearch").on("click", function(e){
			if(!searchForm.find("option:selected").val()){
				alert("검색종류를 선택해주세요");
				return false;
			}

			if(!searchForm.find("input[name='keyword']").val()){
				alert("검색어를 선택해주세요");
				return false;
			}

			searchForm.find("input[name='pageNum']").val("1");

			searchForm.submit();
		});
		
		
		// 주문 선택삭제
		$("#btn_order_check_del").on("click", function(){

			if($("input[name='order_check']:checked").length == 0){
				alert("삭제할 상품을 선택해주세요");
				return;
			}
			
			var result = confirm("선택한 주문을 삭제하시겠습니까?");

			if(result){
				var checkArr = [];

				$("input[name='order_check']:checked").each(function(){
					var od_code = $(this).val();
					checkArr.push(od_code);
				});

				$.ajax({
					url: "/admin/order/order_check_delete",
					type: "post",
					dataType: "text", 
					data: {checkArr : checkArr}, 
					success : function(data){
						if(data== "SUCCESS"){
							//location.href = "/cart/cart_list";
							alert("선택된 주문이 삭제되었습니다");
							console.log(data);
							location.href = "/admin/order/order_list";
			
						}
					}
				});
			}

		});
		
		// 체크박스 전체선택
		$("#check_all").on("click", function(){
			$("input[name='order_check']").prop("checked", this.checked);
		});

		//데이터 행의 체크박스 클릭
		$("td[name='order_all_check']").on("click", function(){
			$("#check_all").prop("checked", false);
		});



	});
	
</script>


</body>

</html>