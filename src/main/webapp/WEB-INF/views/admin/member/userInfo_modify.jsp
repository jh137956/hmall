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
			<form id="searchForm" action="/admin/member/userInfo_list" method="get">
				<select name="type" id="type">
					<option value="" <c:out value="${pageMaker.cri.type == null ? 'selected':''}" />>--</option>
					<option value="N" <c:out value="${pageMaker.cri.type == 'N' ? 'selected':''}" />>상품명</option>
					<option value="D" <c:out value="${pageMaker.cri.type == 'D' ? 'selected':''}" />>상품설명</option>
					<option value="C" <c:out value="${pageMaker.cri.type == 'C' ? 'selected':''}" />>상품회사</option>
					<option value="ND" <c:out value="${pageMaker.cri.type == 'ND' ? 'selected':''}" />>상품명 or 상품설명</option>
					<option value="NC" <c:out value="${pageMaker.cri.type == 'NC' ? 'selected':''}" />>상품명 or 상품회사</option>
					<option value="NDC" <c:out value="${pageMaker.cri.type == 'NDC' ? 'selected':''}" />>상품명 or 상품설명 or 상품회사</option>
				</select>
				<input type="text" name="keyword" value="${pageMaker.cri.keyword}">
				<input type="hidden" name="pageNum" value="${pageMaker.cri.pageNum}">
				<input type="hidden" name="amount" value="${pageMaker.cri.amount}">
				<button id="btnSearch" type="button" class="btn btn-primary">검색</button>
			</form>
		</div>
	</div>
	
	
	
   <div class="membership">
	<div class="container"
		style=" min-width: 900px; background-color: white; font-size: 14px;">
		<form id="userModifyForm" action="./userInfo_modify" method="post">
			<div class="container" style="width: 800px;">
				<h4>회원 수정</h4>
				* 아래 항목을 작성해주세요.<br>
				<br>
				<br>
				<div class="form-group" style="width: 100%;">
					<label for="inputId">* 아이디</label> <br /> 
					<input type="text" class="form-control" id="mb_id" name="mb_id" value="<c:out value="${vo.mb_id}" />" 
						placeholder="아이디를 입력해 주세요" readonly
						style="max-width: 540px; width: calc(100% - 100px); margin-right: 5px; display: inline-block;">
				</div>
				<div class="form-group">
					<label for="inputPassword">* 비밀번호</label> 
					<input type="password" class="form-control" id="mb_pw" name="mb_pw" value="<c:out value="${vo.mb_pw}" />"
						placeholder="비밀번호를 입력해주세요" style="max-width: 630px;">
				</div>						
				<div class="form-group">
					<label for="inputName">* 이름</label> 
					<input type="text" class="form-control" id="mb_name" name="mb_name" value="<c:out value="${vo.mb_name}" />"
						placeholder="이름을 입력해 주세요" readonly style="max-width: 630px;">
				</div>
				<div class="form-group">
					<label for="inputName">* 성별</label> 
					<label><input type="radio" name="mb_sex" value="M"
							style="margin-left: 20px;" <c:out value="${vo.mb_sex == 'M'? 'checked' :  ''}" />> 남</label> 
					<label><input type="radio" name="mb_sex" value="W"
							style="margin-left: 20px;" <c:out value="${vo.mb_sex == 'W'? 'checked' :  ''}" />> 여</label>
				</div>
				<div class="form-group">
					<label for="InputEmail">* 이메일 주소</label><br /> 
					<input type="email" class="form-control" id="mb_email" value="<c:out value="${vo.mb_email}" />" name="mb_email" 
						placeholder="이메일 주소를 입력해주세요" 
						style="max-width: 526px; width: calc(100% - 115px); margin-right: 5px; display: inline-block;">
					<p id="authcode_status" style="color: red;"></p>
				</div>
		
				<div class="form-group">
					<label for="inputMobile">* 휴대폰 번호</label> 
					<input type="tel" class="form-control" id="mb_cp" name="mb_cp" 
						value="<c:out value="${vo.mb_cp}" />" placeholder="휴대폰 번호를 입력해 주세요" style="max-width: 630px;">
				</div>
				<div class="form-group">
					<label for="inputAddr">* 주소</label> <br /> 
					<input type="text" id="sample2_postcode" style="max-width: 200px; margin: 3px 0px; display: inline-block;"
						class="form-control" name="mb_post" value="<c:out value="${vo.mb_post}" />" placeholder="우편번호"
						readonly> <input type="button" onclick="sample2_execDaumPostcode()" value="우편번호 찾기"><br>
					<input type="text" id="sample2_address" class="form-control" style="max-width: 630px; margin: 3px 0px;" readonly
						name="mb_addr" value="<c:out value="${vo.mb_addr}" />" placeholder="주소"><br> 
					<input type="text" id="sample2_detailAddress" class="form-control" style="max-width: 630px; margin: 3px 0px;" 
						name="mb_addr2" value="<c:out value="${vo.mb_addr2}" />" placeholder="상세주소"> 
					<input type="hidden" id="sample2_extraAddress" class="form-control" placeholder="참고항목">
				</div>
				<div class="form-group">
					<label>* 수신 동의</label><br /> 이벤트 등 프로모션 메일 알림 수신에 동의합니다. 
					<label><input type="radio" name="mb_accept_e" value="Y" 
						style="margin-left: 20px;" <c:out value="${vo.mb_accept_e == 'Y'? 'checked' :  ''}" />> 예</label> 
					<label><input type="radio" name="mb_accept_e" value="N"
						style="margin-left: 20px;" <c:out value="${vo.mb_accept_e == 'N'? 'checked' :  ''}" />> 아니오</label>
				</div>
			</div>
			<div class="form-group text-center" style="margin: 0 auto; width:50%; display: inline-block;">
				<button id="btn_modify"  type="button" class="btn btn-primary pull-right">수정완료</button>
				<button id="btn_cancle" onclick="history.back()" type="button" class="btn btn-primary pull-right">취소</button>
			</div>
			<br>
			<br>
			<br>
			<br>
		</form>


				<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
				<div id="layer"
					style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
					<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
						id="btnCloseLayer"
						style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
						onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div>

				<%-- 우편번호API 동작코드 --%>
				<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
				<div id="layer"
					style="display: none; position: fixed; overflow: hidden; z-index: 1; -webkit-overflow-scrolling: touch;">
					<img src="//t1.daumcdn.net/postcode/resource/images/close.png"
						id="btnCloseLayer"
						style="cursor: pointer; position: absolute; right: -3px; top: -3px; z-index: 1"
						onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div>

				<script
					src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script>
					// 우편번호 찾기 화면을 넣을 element
					var element_layer = document
							.getElementById('layer');

					function closeDaumPostcode() {
						// iframe을 넣은 element를 안보이게 한다.
						element_layer.style.display = 'none';
					}

					function sample2_execDaumPostcode() {
						new daum.Postcode(
								{
									oncomplete : function(data) {
										// 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

										// 각 주소의 노출 규칙에 따라 주소를 조합한다.
										// 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
										var addr = ''; // 주소 변수
										var extraAddr = ''; // 참고항목 변수

										//사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
										if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
											addr = data.roadAddress;
										} else { // 사용자가 지번 주소를 선택했을 경우(J)
											addr = data.jibunAddress;
										}

										// 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
										if (data.userSelectedType === 'R') {
											// 법정동명이 있을 경우 추가한다. (법정리는 제외)
											// 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
											if (data.bname !== ''
													&& /[동|로|가]$/g
															.test(data.bname)) {
												extraAddr += data.bname;
											}
											// 건물명이 있고, 공동주택일 경우 추가한다.
											if (data.buildingName !== ''
													&& data.apartment === 'Y') {
												extraAddr += (extraAddr !== '' ? ', '
														+ data.buildingName
														: data.buildingName);
											}
											// 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
											if (extraAddr !== '') {
												extraAddr = ' ('
														+ extraAddr
														+ ')';
											}
											// 조합된 참고항목을 해당 필드에 넣는다.
											document
													.getElementById("sample2_extraAddress").value = extraAddr;

										} else {
											document
													.getElementById("sample2_extraAddress").value = '';
										}

										// 우편번호와 주소 정보를 해당 필드에 넣는다.
										document
												.getElementById('sample2_postcode').value = data.zonecode;
										document
												.getElementById("sample2_address").value = addr;
										// 커서를 상세주소 필드로 이동한다.
										document
												.getElementById(
														"sample2_detailAddress")
												.focus();

										// iframe을 넣은 element를 안보이게 한다.
										// (autoClose:false 기능을 이용한다면, 아래 코드를 제거해야 화면에서 사라지지 않는다.)
										element_layer.style.display = 'none';
									},
									width : '100%',
									height : '100%',
									maxSuggestItems : 5
								}).embed(element_layer);

						// iframe을 넣은 element를 보이게 한다.
						element_layer.style.display = 'block';

						// iframe을 넣은 element의 위치를 화면의 가운데로 이동시킨다.
						initLayerPosition();
					}

					// 브라우저의 크기 변경에 따라 레이어를 가운데로 이동시키고자 하실때에는
					// resize이벤트나, orientationchange이벤트를 이용하여 값이 변경될때마다 아래 함수를 실행 시켜 주시거나,
					// 직접 element_layer의 top,left값을 수정해 주시면 됩니다.
					function initLayerPosition() {
						var width = 300; //우편번호서비스가 들어갈 element의 width
						var height = 400; //우편번호서비스가 들어갈 element의 height
						var borderWidth = 5; //샘플에서 사용하는 border의 두께

						// 위에서 선언한 값들을 실제 element에 넣는다.
						element_layer.style.width = width + 'px';
						element_layer.style.height = height + 'px';
						element_layer.style.border = borderWidth
								+ 'px solid';
						// 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
						element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width) / 2 - borderWidth)
								+ 'px';
						element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height) / 2 - borderWidth)
								+ 'px';
					}
				</script>

				<!-- /.content -->
			</div>
			<!-- /.content-wrapper -->
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
		
		var form = $("#userModifyForm");

		/* 회원수정 버튼 클릭 시 */ 
		$("#btn_modify").on("click", function(){
			
			// 유효성 검사구문
	
			alert("수정완료");
			form.submit();
			
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
		

	});
	
</script>


</body>

</html>