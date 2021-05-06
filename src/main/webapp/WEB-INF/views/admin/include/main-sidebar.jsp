<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<aside class="main-sidebar">
     <!-- sidebar: style can be found in sidebar.less -->
    <section class="sidebar">

      <!-- Sidebar user panel (optional) -->
     
      <!-- search form (Optional) -->
      <form action="#" method="get" class="sidebar-form">
        <div class="input-group">
          <input type="text" name="q" class="form-control" placeholder="Search...">
          <span class="input-group-btn">
              <button type="submit" name="search" id="search-btn" class="btn btn-flat"><i class="fa fa-search"></i>
              </button>
            </span>
        </div>
      </form>
      <!-- /.search form -->

      <!-- Sidebar Menu -->
      <ul class="sidebar-menu" data-widget="tree">
       <c:if test="${sessionScope.adLoginStatus == null }">
       	<li>
          <a>로그인을 해주세요</a>
        </li>
       </c:if>
      <c:if test="${sessionScope.adLoginStatus != null }">
        <li class="header">menu</li>
        <!-- Optionally, you can add icons to the links -->
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>상품관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="${pageContext.request.contextPath }/admin/product/product_insert">상품등록</a></li>
            <li><a href="${pageContext.request.contextPath }/admin/product/pro_list">상품목록</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>주문관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="${pageContext.request.contextPath }/admin/order/order_list">주문목록</a></li>
            <li><a href="#">Link in level 2</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>회원관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="${pageContext.request.contextPath }/admin/member/userInfo_list">회원목록</a></li>
            <li><a href="#">Link in level 2</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>게시판관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="${pageContext.request.contextPath }/admin/board/adlist">게시판 관리</a></li>
            <li><a href="#">Link in level 2</a></li>
          </ul>
        </li>
        <li class="treeview">
          <a href="#"><i class="fa fa-link"></i> <span>통계/매출현황 관리</span>
            <span class="pull-right-container">
                <i class="fa fa-angle-left pull-right"></i>
              </span>
          </a>
          <ul class="treeview-menu">
            <li><a href="${pageContext.request.contextPath }/chart/chart_product_total">매출/판매량 관리</a></li>
            <li><a href="${pageContext.request.contextPath }/admin/order/order_sale">매출통계</a></li>
          </ul>
        </li>
        </c:if>
      </ul>
      <!-- /.sidebar-menu -->
    </section>
    <!-- /.sidebar -->
    
  </aside>    