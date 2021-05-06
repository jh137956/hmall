<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

	 <div class="usermenu">
       
        <div class="login_menu">
          <ul>
          <!-- 로그인 전 표시 -->
          <c:if test="${sessionScope.loginStatus == null }">
            <li>
              <a href="/member/login"><span>login</span></a>
            </li>
            <li style="border: 1px solid #343a40; margin-top: 5px; height: 17px;"></li>
            <li>
              <a href="/member/join"><span>join</span></a>
            </li>
           </c:if>
           <!-- 로그인 후 표시 -->
           <c:if test="${sessionScope.loginStatus != null }">
             <li>
              <a href="/member/logout"><span>logout</span></a>
            </li>
            <li style="border: 1px solid #343a40; margin-top: 5px; height: 17px;"></li>
             <li>
              <a href="/member/mypage"><span>myPage</span></a>
            </li>
            <li style="border: 1px solid #343a40; margin-top: 5px; height: 17px;"></li>
            <li>
              <a href="/cart/cart_list"><span>cart</span></a>
            </li>

            </c:if>
          </ul>
        </div>  
      </div>
	 <div class="mainlogo" style="width:100%; text-align:center; ">
        <a href="/"><img src="/resources/lion.png" style="width: 150px; height: 100px; display: inline-block;"></a>  
     </div>
      <div class="navi_bar">
      	<div style="width: 80%; margin: 0 auto; height: 50px;">
          <ul>
        	<c:forEach items="${mainCateList }" var="cateVO"> 
	          <li class="mainCategory" style="display: inline-block; width: 150px; ">
                <a href="#" data-code="${cateVO.cg_code }">${cateVO.cg_name }</a>
                <!--2차 카테고리-->
                <ul class="subCategory" style="z-index: 9999;"></ul>
              </li>	
        	</c:forEach>
          </ul>
        </div>
      </div>
      <script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
      <script>
		var subCategoryList = function(subCGListData, subCategoryTarget, subCGListTemplate) {
			var subCGTemplate = Handlebars.compile(subCGListTemplate.html());
			var options = subCGTemplate(subCGListData);
	
			$("#subCategory option").remove(); // 기존 option태그 제거
			subCategoryTarget.append(options); // 새로운 2차 카테고리 option태그 추가
		}
	  </script>
      <script id="subCGListTemplate" type="text/x-handlebars-template">
        {{#each .}}
          <li style="line-height: 50px; background-color: #313f4c; width: 150px;">
			<a href="/product/product_list?cg_code={{cg_code}}">{{cg_name}}</a>
		  </li>
        {{/each}}
	  </script>
      <script>
        $(document).ready(function(){

          $(".mainCategory").on("click", function(){

            var mainCategory = $(this);
            var cg_code = $(this).find("a").attr("data-code");
            var url = "/product/subCategoryList/" + cg_code;

            //alert(url);

            // ajax요청작업
            // 1차 카테고리를 참조하는 2차 카테고리 정보
            $.getJSON(url, function(data){
              subCGList(data, mainCategory, $("#subCGListTemplate"));
            });
          });
        });

        var subCGList = function(subCGData, targetSubCategory, templateObject) {

          var template = Handlebars.compile(templateObject.html());
          var subCGLi = template(subCGData);

          $(".mainCategory .subCategory").empty();

          targetSubCategory.find(".subCategory").append(subCGLi);
        }
      </script>

