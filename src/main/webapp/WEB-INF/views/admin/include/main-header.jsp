<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

  <!-- Main Header -->
  <header class="main-header">
    <!-- Logo -->
    <a href="/admin/admin/" class="logo">
      <!-- mini logo for sidebar mini 50x50 pixels -->
      <span class="logo-mini"><b>A</b>LT</span>
      <!-- logo for regular state and mobile devices -->
      <span class="logo-lg"><b>H</b>Mall</span>
    </a>

    <!-- Header Navbar -->
    <nav class="navbar navbar-static-top" role="navigation">
      <!-- Sidebar toggle button-->
      <a href="#" class="sidebar-toggle" data-toggle="push-menu" role="button">
        <span class="sr-only">Toggle navigation</span>
      </a>
      <!-- Navbar Right Menu -->
      <div class="navbar-custom-menu">
        <ul class="nav navbar-nav">
          <!-- Messages: style can be found in dropdown.less-->
          <li class="">
            <!-- Menu toggle button -->
             <c:if test="${sessionScope.adLoginStatus == null }">
	            <li>
	              <a href="/admin/admin_login"><span>login</span></a>
	            </li>	         
	           </c:if>
	           <!-- 로그인 후 표시 -->
	           <c:if test="${sessionScope.adLoginStatus != null }">
	             <li>
	              <a href="/admin/logout"><span>로그아웃</span></a>
	            </li>
	            <li>
	              <a href="/admin/admin_modify"><span>관리자페이지</span></a>
	            </li>
	            <li>
	             <a><span><fmt:formatDate value="${sessionScope.adLoginStatus.admin_date_late }" pattern="yyyy-MM-dd HH:mm:ss"/></span></a>
	            </li>
	            <li>
	             <a><span>${sessionScope.adLoginStatus.admin_name } 님</span></a>
	            </li>	            	             
            </c:if>    
	          <li>
	            <a href="#" data-toggle="control-sidebar"><i class="fa fa-gears"></i></a>
	          </li>
        	</ul>
      	</div>
   	</nav>
    
   </header>   