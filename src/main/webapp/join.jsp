<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link href="/resources/main.css" rel="stylesheet">
<%@include file="/WEB-INF/views/common/config.jsp" %>
</head>
<body>
  <div class="wrapper">
    <div class="wrap">
      
      <%@ include file="/WEB-INF/views/common/nav.jsp"%>
            
      <div class="content">
        <div class="container">
        <div class="membership">
            <div>
                <h3 style="text-align: center;" class="head-style">회원가입</h3>
            </div>
            <form class="joinForm" name="joinPage" id="joinPage" method="post" action="/member/join">
                <div class="info">
                    <table>
                        <tr>
                            <th><span class="span-color">*</span>이름</th>    
                            <td><input type="text" id="mb_name" name="mb_name" class="input-text"></td>
                        </tr>
                        <tr>
                            <th><span class="span-color">*</span>아이디</th>    
                            <td><input type="text" id="mb_id" name="mb_id" class="input-text">
                                <input type="button" name="btn_check" id="btn_check" value="아이디중복확인" class="button">
                                <p class="hint">*영문, 숫자만 가능합니다. (6~16자)</p>
                            </td>
                        </tr>
                        <tr>
                            <th><span class="span-color">*</span>비밀번호</th>    
                            <td><input type="password" id="mb_pw" name="mb_pw" class="input-text"><br></td>
                        </tr>
                        <tr>
                            <th><span class="span-color">*</span>비밀번호 확인</th>    
                            <td><input type="password" id="mb_pw2" name="mb_pw2" class="input-text"><br>
                                <p class="hint">*영소문자, 숫자, 특수문자 포함(6~16자)</p>
                                
                            </td>
                        </tr>
                        <tr>
                            <th><span class="span-color">*</span>성별</th>
                            <td><label><input type="radio" name="mb_sex" value="Y" style="margin-left: 20px;" checked="checked"> 남</label>
                                <label><input type="radio" name="mb_sex" value="N" style="margin-left: 20px;"> 여</label>
                            </td> 
                        </tr>
                        <tr>
                            <th rowspan="2"><span class="span-color">*</span>이메일</th>
                            <td><input  type="text" id="mb_email" name="mb_email" class="input-text">
                                <select id="emailaddr" name="emailaddr">
                                    <option value="메일주소선택">메일주소선택</option>
                                    <option value="네이버">naver.com</option>
                                    <option value="다음">daum.net</option>
                                    <option value="네이트">nate.com</option>
                                    <option value="기타">기타</option>
                                </select>
                                <input type="button" name="email_check" id="email_check" value="인증메일발송" class="button">
                            </td>
                        </tr>
                        <tr>   
                            <td>
                                
                                <input type="text" id="mb_authcode" >
                                <input type="button" name="email_check2" id="email_check2" value="인증확인" class="button">
                            </td>
                        </tr> 
                        <tr>
                            <th><span class="span-color">*</span>휴대전화</th>
                            <td>
                                 <select id="form-control">    
                                    <option value="">선택</option>
                                    <option value="010">010</option>
                                    <option value="011">011</option>
                                    <option value="016">016</option>
                                    <option value="017">017</option>
                                    <option value="019">019</option>
                                </select>
                                <input type="tel" class="input-text"  id="mb_cp" name="mb_cp" placeholder="휴대폰 번호를 입력해 주세요">
                            </td>
                        </tr>
                        <tr>
                            <th rowspan="2"><span class="span-color">*</span>주소</th>
                            <td><input type="text" id="sample2_postcode" name="mb_post" class="input-text" placeholder="우편번호" readonly>
								<input type="button" onclick="sample2_execDaumPostcode()" id="btn_postCode" class="btn btn-default" value="우편번호 찾기">
                            </td>
                        </tr>
                        <tr>
                       		<td>
								<input type="text"  name="mb_addr" class="input-text" placeholder="주소" readonly>
								<input type="text"  id="sample2_detailAddress" name="mb_addr2" class="input-text" placeholder="상세주소" >
								<input type="hidden" id="sample2_extraAddress" class="form-control" placeholder="참고항목">
                            </td>
                        </tr>
                        <tr>
                            <th><span class="span-color"></span>정보수신 여부</th>
                            <td>
                            	<label><input type="radio" name="mb_accept_e" value="Y" style="margin-left: 20px;" checked="checked"> 예</label>
	      						<label><input type="radio" name="mb_accept_e" value="N" style="margin-left: 20px;"> 아니오</label>
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="transmit">
                    <button id="btnjoin" type="button" class="btn btn-primary pull-right">회원가입</button>
                    <button id="btnjoin" type="button" class="btn btn-primary pull-right">취소</button>
                </div>
            </form>
        </div>
        
        <!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
				<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div>
				
				<%-- 우편번호API 동작코드 --%>
				<!-- iOS에서는 position:fixed 버그가 있음, 적용하는 사이트에 맞게 position:absolute 등을 이용하여 top,left값 조정 필요 -->
				<div id="layer" style="display:none;position:fixed;overflow:hidden;z-index:1;-webkit-overflow-scrolling:touch;">
				<img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnCloseLayer" style="cursor:pointer;position:absolute;right:-3px;top:-3px;z-index:1" onclick="closeDaumPostcode()" alt="닫기 버튼">
				</div>
				
				<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
				<script>
				    // 우편번호 찾기 화면을 넣을 element
				    var element_layer = document.getElementById('layer');
				
				    function closeDaumPostcode() {
				        // iframe을 넣은 element를 안보이게 한다.
				        element_layer.style.display = 'none';
				    }
				
				    function sample2_execDaumPostcode() {
				        new daum.Postcode({
				            oncomplete: function(data) {
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
				                if(data.userSelectedType === 'R'){
				                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
				                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
				                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
				                        extraAddr += data.bname;
				                    }
				                    // 건물명이 있고, 공동주택일 경우 추가한다.
				                    if(data.buildingName !== '' && data.apartment === 'Y'){
				                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
				                    }
				                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
				                    if(extraAddr !== ''){
				                        extraAddr = ' (' + extraAddr + ')';
				                    }
				                    // 조합된 참고항목을 해당 필드에 넣는다.
				                    document.getElementById("sample2_extraAddress").value = extraAddr;
				                
				                } else {
				                    document.getElementById("sample2_extraAddress").value = '';
				                }
				
				                // 우편번호와 주소 정보를 해당 필드에 넣는다.
				                document.getElementById('sample2_postcode').value = data.zonecode;
				                document.getElementById("sample2_address").value = addr;
				                // 커서를 상세주소 필드로 이동한다.
				                document.getElementById("sample2_detailAddress").focus();
				
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
				    function initLayerPosition(){
				        var width = 300; //우편번호서비스가 들어갈 element의 width
				        var height = 400; //우편번호서비스가 들어갈 element의 height
				        var borderWidth = 5; //샘플에서 사용하는 border의 두께
				
				        // 위에서 선언한 값들을 실제 element에 넣는다.
				        element_layer.style.width = width + 'px';
				        element_layer.style.height = height + 'px';
				        element_layer.style.border = borderWidth + 'px solid';
				        // 실행되는 순간의 화면 너비와 높이 값을 가져와서 중앙에 뜰 수 있도록 위치를 계산한다.
				        element_layer.style.left = (((window.innerWidth || document.documentElement.clientWidth) - width)/2 - borderWidth) + 'px';
				        element_layer.style.top = (((window.innerHeight || document.documentElement.clientHeight) - height)/2 - borderWidth) + 'px';
				    }
				</script>
			
			<!-- /.content -->
		</div>
		<!-- /.content-wrapper -->
     
    </div>
      </div>
      
     
    </div>
 	
</body>

</html>