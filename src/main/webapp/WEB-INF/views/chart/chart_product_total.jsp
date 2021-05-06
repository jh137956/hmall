<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!--
This is a starter template page. Use this page to start your new project from
scratch. This page gets rid of all links and provides the needed markup only.
-->
<html>
<head>
  <!-- css file -->
<%@include file="/WEB-INF/views/admin/include/head_inc.jsp" %>
<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
<script>
	google.charts.load('current', {'packages':['corechart'] }  );
	//google.charts.load('current', {'packages':['bar']}); 
	
	google.charts.setOnLoadCallback(drawChart); //drawChart() 함수 호출
	
	function drawChart() {
		
		var jsonData = $.ajax({
			url: "/chart/chartTotalData", // 주소를 호출하면 구글에서 요구하는 차트데이터 포맷에 맞게 데이터를 json형태로 받아온다
			type: "get",
			dataType: "json",
			async: false,
		}).responseText; // json 내용을 텍스트로 읽어드림
		
		console.log(jsonData);

		var data
        = new google.visualization.DataTable(jsonData);
        //제이슨 형식을 구글의 테이블 형식으로 바꿔주기 위해서 집어넣음
        //차트를 출력할 div
        //LineChart, ColumnChart, PieChart에 따라서 차트의 형식이 바뀐다.
        
        // var chart = new google.visualization.PieChart(document.getElementById('chart_div')); //원형 그래프
        
        //var chart
        // = new google.visualization.LineChart(
                //document.getElementById('chart_div')); 선 그래프 
                
        var chart = new google.visualization.ColumnChart(document.getElementById('chart_div'));
            //차트 객체.draw(데이터 테이블, 옵션) //막대그래프
            
            //cuveType : "function" => 곡선처리
            
            //데이터를 가지고 (타이틀, 높이, 너비) 차트를 그린다.
            chart.draw(data, {
                title : "상품별(상품코드) 총 판매금액",
                curveType : "function", //curveType는 차트의 모양이 곡선으로 바뀐다는 뜻
                width : 800,
                height : 600
            });
	}
</script>

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
		<div class="row">
		<div class="col-lg-12">
			<form id="" action="/admin/chart/chartTotalData_month" method="get">
			<c:set var="today" value="<%= new java.util.Date()%>" />
			<c:set var="year"><fmt:formatDate value="${today }" pattern="yyyy"/></c:set>
			<c:set var="month"><fmt:formatDate value="${today }" pattern="MM"/></c:set>
				<select name="year" id="year">
					<c:forEach begin="0" end="2" var="i" step="1">
						<option value="<c:out value="${year-2+i }" />" ${(year-2+i) == sel_year ? 'selected' : '' }>
					<c:out value="${year-2+i }" />
					</option> 
					</c:forEach>
					
					<c:forEach begin="1" end="2" var="i" step="1">
						<option value="<c:out value="${year+i }" />" ${(year+i) == sel_year ? 'selected' : '' }>
					<c:out value="${year+i }" /></option>
					</c:forEach>				
				</select>년
				<select name="month" id="month">
					<c:forEach begin="1" end="12" var="i" step="1">
					<fmt:formatNumber var="dal" minIntegerDigits="2" value="${i}" type="number" />
					<fmt:formatNumber var="cur_month" minIntegerDigits="2" value="${month}" type="number" />
					<option value="${dal }" ${dal == sel_month ? 'selected' : '' }>${dal}</option>
					</c:forEach>				
				</select>월
				<button id="btnSearch" type="submit" class="btn btn-primary">검색</button>
			</form>
		</div>
	</div>
      <!--------------------------
        | Your Page Content Here |
        -------------------------->
		<div id="chart_div"></div>
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
</body>
</html>