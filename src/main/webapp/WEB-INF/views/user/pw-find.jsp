<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>비밀번호찾기ㆍHastagram</title>
	
	<jsp:include page="../include/static-head.jsp"/>
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/user/find-custom.css'/>">
</head>
<body>
	<!-- 전체화면 -->
	<div class="container-fluid" style="background-color: #fafafa;">
		<!-- content-box : 비번찾기 박스 -->
		<div class="content-box">
			<!-- 비밀번호 찾기 박스 -->
			<div class="find-pw-box">
				<div class="find-pw">
					<div class="find-icon">
						<span><i class="far fa-flushed fa-6x"></i></span>
					</div>
					<div class="find-box">
						<h4 class="msg1">로그인에 문제가 있나요?</h4>
					</div>
					<div class="find-box">
						<div class="msg2">가입한 이메일을 입력하면 다시 계정에 로그인 할 수 있는 임시 비밀번호를 보내드립니다.</div>
					</div>
					<div class="find-box">
						<form method="post">
							<input id="email" class="find-input-box" placeholder="이메일" type="text">
						</form>
					</div>
					<div class="find-box">
						<button id="send_link_btn" class="join-btn-btn">로그인 링크 보내기</button>
					</div>
					<div class="findBox find-bar-box" style="margin-top: 16px;">
						<div class="find-bar"></div>
						<div class="or-text">또는</div>
						<div class="find-bar"></div>
					</div>
					<div class="find-box">
						<a class="join-account" href="<c:url value='/user/join'/>">새 계정 만들기</a>
					</div>
					<div class="login-back">
						<div class="login-back-btn" style="height: 48px;">
							<a href="<c:url value='/login'/>">로그인으로 돌아가기</a>
						</div>
					</div>
				</div>
			</div>
		
		
		</div>
		<!-- end of contentBox -->
		
		<!-- 네비게이션 메뉴 -->
		<jsp:include page="../include/top-menu.jsp"/>
		
		
		<!-- footer -->
		<jsp:include page="../include/footer.jsp"/>
		
	</div>
	<!-- end of 전체 화면 -->
	
	<script type="text/javascript">
		$(function(){
			
			let chk = false;
			
			//이메일 입력값확인
			$('#email').on('keyup', function() {
				if($('#email').val() === "") {
					chk = false;
				} else {
					chk = true;
				}
			});
			
			//로그인 링크 보내기 요청
			$('#send_link_btn').click(function(e) {
				
				const email = $('#email').val();
				// const login = {
				// 	email: email
				// };
				
				if(chk) {
					$.ajax({
						type: "POST",
						url: "/user/pw-find",
						headers: {
			                "Content-Type": "application/json",
			                "X-HTTP-Method-Override": "POST"
			            },
			            // dataType: "text",
			            // data: JSON.stringify(email),
						data: email,
						datatype: "json",
			            success: function(result) {
			            	console.log("result: " + result);
			            	if(result === "Success") {
			            		alert('이메일로 임시 비밀번호를 발송하였습니다.');
			            		self.location = "/login";
			            	} else if (result === "Social"){
								alert('소셜 가입자는 해당 서비스를 이용할 수 없습니다.');
							} else {
								alert('일치하는 회원의 정보가 존재하지 않습니다.');
							}
			            }
					});
					
				} else {
					
					alert('이메일을 입력해주세요.')
				}
				
			});
			
		});
	</script>
</body>
</html>