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
<meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="Mark Otto, Jacob Thornton, and Bootstrap contributors">
    <meta name="generator" content="Hugo 0.80.0">
</head>
<body>
  <div class="wrapper">
    <div class="wrap">
      
      <%@ include file="/WEB-INF/views/common/nav.jsp"%>
       
     
      <div>
        	
       	<div style="width:100%; z-index: 1; margin-top: 50px;">
    	<div style="width: 60%; margin: 0 auto;">
    		<div class="panel panel-default">
    			<form role="form" id="myForm" method="post" action="/board/modify">
					<div class="form-group">
						<label for="exampleFormControlInput1">BNO</label>
						<input type="text" name="bno" value="<c:out value="${board.bno }"></c:out>" class="form-control" id="exampleFormControlInput1" placeholder="제목입력" readonly>				</div>
					
					<div class="form-group">
						<label for="exampleFormControlInput1">Title</label>
						<input type="text" name="b_title" class="form-control" id="exampleFormControlInput1" placeholder="제목입력"
						value="<c:out value="${board.b_title}" />">
					</div>
					<div class="form-group">
						<label for="exampleFormControlTextarea1">Content</label>
						<textarea  name="b_content" class="form-control" id="exampleFormControlTextarea1" rows="3">
							<c:out value="${board.b_content}" />
						</textarea>
					</div>
					<div class="form-group">
						<label for="exampleFormControlInput1">Writer</label>
						<input type="text" name="mb_id" class="form-control" id="exampleFormControlInput1" placeholder="작성자입력"
						value="<c:out value="${board.mb_id}" />" readonly>
					</div>
					<!-- 원래 리스트페이지 상태로 가기위한 정보 -->
					<input type="hidden" id="pageNum" name="pageNum" value="${cri.pageNum }" />
					<input type="hidden" id="amount" name="amount" value="${cri.amount }" />
    			 	  
					  <!-- 페이징, 검색관련 정보 -->				  
					<input type="hidden" name="type" value='<c:out value="${cri.type }" />'>
					<input type="hidden" name="keyword" value='<c:out value="${cri.keyword }" />'>					
				</form>	
					
					<div class="form-group">
					   <button id="btnModify" type="button" class="btn btn-primary">수정</button>
					   <button id="btnRemove" type="button" class="btn btn-primary">삭제</button>
					</div>
				
    		</div>
    	</div>
    </div>
      <div class="row">
			<div class="col-lg-12">
				<div class="panel panel-default">
			
					<div class="panel-heading">File Attach</div>
					<!-- /.panel-heading -->
					<div class="panel-body">
						<div class="form-group uploadDiv">
							<input type="file" name='uploadFile' multiple>
						</div>
						
						<!-- 업로드된 파일정보 출력위치 -->
						<div class='uploadResult'> 
							<ul>
							
							</ul>
						</div>
					
					</div>
					<!--  end panel-body -->
			
				</div>
				<!--  end panel-body -->
			</div>
			<!-- end panel -->
		</div>  		  
	     
          </div>
        </div>
     </div>

 
      
      <div class="pagenav">
          <div style="width:60%; margin-top: 10px; margin: 0 auto;">
	  </div>
  </div>



<script>
$(document).ready(function(e){

	var form = $("#myForm");

	// 수정버튼 클릭
	$("#btnModify").click(function(){

		// 첨부파일목록의 태그를 참조하여 <input>태그로 구성하는 작업
		// 파일첨부 전송작업 처리부분. "<input type='hidden' name='attachList[0].fileName' value='파일정보'>"
		var str = "";

		$(".uploadResult ul li").each(function(i, obj){
			var objLi = $(obj);

			//console.dir(objLi);
			console.log(objLi.html());
			console.log(objLi.data("file"));

			str += "<input type='hidden' name='attachList["+i+"].uuid' value='"+ objLi.data("uuid")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].uploadPath' value='"+ objLi.data("path")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileName' value='"+ objLi.data("filename")+"'>";
			str += "<input type='hidden' name='attachList["+i+"].fileType' value='"+ objLi.data("type")+"'>";
		});

		console.log(str);

		//<form>태그정보를 submit작업
		// 리스트, 수정에 따라서 action주소가 다르기때문에 그에 따른 주소작업을 설정한다.
		if(confirm("수정완료! 저장하시겠습니까?")){
			form.attr("action","/board/modify").submit();
		}
		
		//form.submit();
	});
	//삭제버튼 클릭
	$("#btnRemove").click(function(){
		//<form>태그정보를 submit작업
		// 리스트, 수정에 따라서 action주소가 다르기때문에 그에 따른 주소작업을 설정한다.
		if(confirm("삭제하시겠습니까?")){
			form.attr("action","/board/remove").submit();
		}
		
		//form.submit();
	});
	
});	
	</script>
	<script>
	$(document).ready(function(e){	
	
	// 파일 업로드가 진행되기전에 복제
	var cloneObj = $(".uploadDiv").clone();

	// 파일첨부 상태가 변경이 되면 
	// 파일첨부시 업로드 설정
	// $("input[type='file']").change(function(e){
	$(".uploadDiv").on("change", "input[type='file']", function(e){	

		console.log("변경");

		var formData = new FormData();

		var inputFile = $("input[name='uploadFile']");

		var files = inputFile[0].files;

		if(files.length == 0) return;

		for(var i=0; i<files.length; i++) {
			if(!checkExtension(files[i].name, files[i].size)) {
				return false;
			}
			formData.append("uploadFile", files[i]);
		}

		

		// ajax로 파일업로드
		$.ajax({
			url: "/uploadAjaxAction",
			processData: false,
			contentType: false,
			data: formData,
			type: "POST",
			dataType: 'json', // 리턴되는 데이터형식
			success: function (result) {
				alert('ok');
				console.log(result);

				// 업로드한 파일들의 정보를 화면에 리스트 형태로 출력작업
				showUploadedFile(result);
				// 파일첨부 정보가 clear됨
				$(".uploadDiv").html(cloneObj.html());
			}
		});
	});

	// 파일업로드 제약(파일크기, 파일형식)
	var regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$");
	var maxSize = 5242880

	function checkExtension(fileName, fileSize) {

		if (fileSize >= maxSize) {
			alert("파일사이즈 초과");
			return false;
		}

		if (regex.test(fileName)) {
			alert("해당 파일의 종류는 업로드 할 수 없습니다");
			return false;
		}

		return true;
	}

	// 서버로부터 받아온 파일정보를 리스트형태로 출력해주는 위치
	var uploadResult = $(".uploadResult ul");

	function showUploadedFile(uploadResultArr){
	
	var str = "";
	
	//  선택자에 해당하는 대상이 여러개였을 때 반복적인 작업 기능을 제공하는 메서드
	$(uploadResultArr).each(function(i, obj){
	
		if(!obj.image){  //일반파일작업
			
			//  obj.uploadPath : "2021\03\31"
			// obj.uuid : "5c345afc-76e9-4477-92df-6879dd961748"
			// obj.fileName : "ProductTest_memory_info.png"
			// fileCallPath : "2021\03\31" "/" "5c345afc-76e9-4477-92df-6879dd961748" "_" "ProductTest_memory_info.png"
			var fileCallPath =  encodeURIComponent( obj.uploadPath+"/"+ obj.uuid +"_"+obj.fileName);
			
			// fileLink : "2021/03/31" "/" "5c345afc-76e9-4477-92df-6879dd961748" "_" "ProductTest_memory_info.png"
			var fileLink = fileCallPath.replace(new RegExp(/\\/g),"/"); //  /\\ /g
			
			str += "<li data-path='"+obj.uploadPath+"'";
			str += " data-uuid='"+obj.uuid+"'";
			str += " data-filename='"+obj.fileName+"'";
			str += " data-type='"+obj.image+"'>";
			str += "<div><a href='/download?fileName="+fileCallPath+"'>"+
				"<img src='/resources/img/attach.png'>"+obj.fileName+"</a>"+
				"<span style='cursor:pointer' data-file=\'"+fileCallPath+"\' data-type='file'> x </span>"+
				"<div></li>";
				
		}else{  // 이미지파일작업
			
			var fileCallPath =  encodeURIComponent( obj.uploadPath+ "/s_"+obj.uuid +"_"+obj.fileName);
			
			var originPath = obj.uploadPath+ "\\"+obj.uuid +"_"+obj.fileName;
			
			originPath = originPath.replace(new RegExp(/\\/g),"/");
			
			str += "<li data-path='"+obj.uploadPath+"'";
			str += " data-uuid='"+obj.uuid+"'";
			str += " data-filename='"+obj.fileName+"'";
			str += " data-type='"+obj.image+"'>";
			str +=	"<a href=\"javascript:showImage(\'"+originPath+"\')\">"+
					"<img src='/display?fileName="+fileCallPath+"'></a>"+
					"<span style='cursor:pointer' data-file=\'"+fileCallPath+"\' data-type='image'> x </span>"+
					"</li>";
		}
	});
	
	uploadResult.append(str);
	}

	// 파일삭제
	$(".uploadResult").on("click","span", function(e){
   
		var targetFile = $(this).data("file");
		var type = $(this).data("type");
		console.log(targetFile);
		
		// 선택자의 부모중 첫번째 엘리먼트를 가리킴
		var targetLi = $(this).closest("li");

		$.ajax({
			url: '/deleteFile',
			data: {fileName: targetFile, type:type},
			dataType:'text',
			type: 'POST',
			success: function(result){
				alert(result);

				// 삭제파일에 해당하는 li태그 제거
				targetLi.remove(); 

			}
   		}); //$.ajax
	});
	
});

	</script>  
</body>

</html>