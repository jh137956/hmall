<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>

<head>
	<meta charset="UTF-8">
	<style>
		.uploadResult {
			width: 100%;
			background-color: gray;
		}

		.uploadResult ul {
			display: flex;
			flex-flow: row;
			justify-content: center;
			align-items: center;
		}

		.uploadResult ul li {
			list-style: none;
			padding: 10px;
		}

		.uploadResult ul li img {
			width: 100px;
		}
	</style>

	<style>
		.bigPictureWrapper {
			position: absolute;
			display: none;
			justify-content: center;
			align-items: center;
			top: 0%;
			width: 100%;
			height: 100%;
			background-color: gray;
			z-index: 100;
		}

		.bigPicture {
			position: relative;
			display: flex;
			justify-content: center;
			align-items: center;
		}
	</style>

	<title>Insert title here</title>

</head>

<body>

	<div class="bigPictureWrapper">
		<div class="bigPicture"></div>
	</div>

	<div class="uploadDiv">
		<input type="file" name="uploadFile" multiple>
	</div>

	<div class="uploadResult">
		<ul></ul>
	</div>

	<button id="uploadBtn">upload</button>
	<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

	<script>

		// 파일 첨부전에 깨끗한 상태의 태그를 복제
		var cloneObj = $(".uploadDiv").clone();


		// 업로드 버튼 이벤트 설정
		$("#uploadBtn").on("click", function () {
			var formData = new FormData(); // <form>태그 수준에 해당하는 객체

			var inputFile = $("input[name='uploadFile']");

			var files = inputFile[0].files;

			console.log(files);

			for (var i = 0; i < files.length; i++) {

				// 유효성 검사(파일의 종류 : 확장자 제한, 크기제한)
				if (!checkExtension(files[i].name, files[i].size)) {
					console.log('첨부된파일 제약 문제있음');
					return false;
				}

				console.log("파일명: " + files[i].name);

				formData.append("uploadFile", files[i]); // <form>태그에 자식레벨로 파일정보추가
			}

			//ajax 파일전송작업
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

		// 서버로부터 받아온 파일정보를 리스트형태로 출력해주는 위치
		var uploadResult = $(".uploadResult ul");

		function showUploadedFile(uploadResultArr) {

			var str = "";

			$(uploadResultArr).each(function (i, obj) {

				if (!obj.image) {

					var fileCallPath = encodeURIComponent(obj.uploadPath + "/" + obj.uuid + "_" + obj.fileName);

					var fileLink = fileCallPath.replace(new RegExp(/\\/g), "/");

					str += "<li><div><a href='/download?fileName=" + fileCallPath + "'>" +
						"<img src='/resources/img/attach.png'>" + obj.fileName + "</a>" +
						"<span data-file=\'" + fileCallPath + "\' data-type='file'> x </span>" +
						"<div></li>"

				} else { // 이미지 파일 작업

					var fileCallPath = encodeURIComponent(obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);

					var originPath = obj.uploadPath + "\\" + obj.uuid + "_" + obj.fileName;

					originPath = originPath.replace(new RegExp(/\\/g), "/");

					str += "<li><a href=\"javascript:showImage(\'" + originPath + "\')\">" +
						"<img src='display?fileName=" + fileCallPath + "'></a>" +
						"<span style='cursor:pointer' data-file=\'" + fileCallPath + "\' data-type='image'> x </span>" +
						"<li>";
				}
			});

			uploadResult.append(str);
		}

		function showImage(fileCallPath){
	  
			//alert(fileCallPath);
			
			$(".bigPictureWrapper").css("display","flex").show();
			
			$(".bigPicture")
			.html("<img src='/display?fileName="+fileCallPath+"'>")
			.animate({width:'100%', height: '100%'}, 1000);

		}
		
		// setTimeout() : 1회, setInterval() : 반복적
		$(".bigPictureWrapper").on("click", function(e){
			$(".bigPicture").animate({width:'0%', height: '0%'}, 1000);
			setTimeout(() => {
				$(this).hide();
			}, 1000);
		});

		// 파일삭제
		$(".uploadResult").on("click","span", function(e){
	   
			var targetFile = $(this).data("file");
			var type = $(this).data("type");
			console.log(targetFile);
			
			$.ajax({
				url: '/deleteFile',
				data: {fileName: targetFile, type:type},
				dataType:'text',
				type: 'POST',
				success: function(result){
					alert(result);
					}
			}); //$.ajax
	   
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

	</script>


</body>

</html>