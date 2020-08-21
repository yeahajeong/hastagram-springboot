<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>가입하기ㆍHastagram</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<jsp:include page="../include/static-head.jsp"/>
	
	<!-- join custom css -->
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/user/join-custom.css'/>">

	<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
	<!-- 전체화면 -->
	<div class="container-fluid" style="background-color: #fafafa;">
	
		<!-- contentBox -->
		<div class="content-box">
			
			<!-- 회원가입  -->
			<div>
				<!-- 회원가입 전체 박스 -->
				<article class="join-article">
					<div class="join-box">
					
						<!-- 첫번째 박스 : 가입하기 상자 -->
						<div class="common-box" style="padding-bottom: 30px;">
							<!-- 로고 이미지 -->
							<img class="logo-img" src="<c:url value='/resources/img/hastagram-logo.jpg'/>">
							<!-- 상자 메인 부분 -->
							<div class="box-main">
								<!-- [post] /user 요청 -->
								<form class="" action="<c:url value='/user' />" method="post">
									<!-- 소개글 -->
									<h2 class="intro-text">친구들의 사진과 동영상을 보려면 가입하세요.</h2>
									
									<!-- 카톡이나 페이스북으로 가입하기 배너 -->
									<div class="join-btn">
										<a class="kakao-btn" href="https://kauth.kakao.com/oauth/authorize?client_id=623078f297cf54c8346f98a5e807a5e1&redirect_uri=http://localhost:8000/myapp/kakaoLogin&response_type=code"">
											<%-- <span class="">Kakao로 로그인</span> --%>
											<img style="width: 266px; padding: 0px;" src="<c:url value='/resources/img/main/kakao_account_login_btn_medium_wide.png'/>" >
										</a>
									</div>
									
									<!-- 또는  -->
							 		<span class="or-bar-bax" style="margin-top: 16px;">
										<span class="bar"></span>
										<span class="or-text">또는</span>
										<span class="bar"></span>
									</span>
									
									<!-- 입력받는 폼 -->
									<div class="join-form">
										<span class="form-span">
											<input type="text" id="user_email" class="form-control input_box" placeholder="이메일" maxlength="75">
											<span class="msg-box" id="email_msg"></span>
								 		</span>
										<span class="form-span">
											<input type="text" id="user_id" class="form-control input_box" placeholder="아이디" maxlength="75">
											<span class="msg-box" id="id_msg"></span>
								 		</span>
										<span class="form-span">
											<input type="password" id="user_pw" class="form-control input_box" placeholder="비밀번호" maxlength="75">
											<span class="msg-box" id="pw_msg"></span>
								 		</span>
										<span class="form-span">
											<input type="password" id="user_pw_check" class="form-control input_box" placeholder="비밀번호 확인" maxlength="75">
											<span class="msg-box" id="pw_check_msg"></span>
								 		</span>
								 		<span class="form-span">
											<input type="text" id="user_name" class="form-control input_box" placeholder="이름" maxlength="75">
											<span class="msg-box" id="name_msg"></span>
								 		</span>
									</div>
									
									<!-- 가입 버튼 -->
									<div>
										<div class="join-btn">
											<button id="join-btn-btn" class="join-btn-btn" type="button">가입</button>
										</div>
									</div>
								</form>
							</div>
						</div>
						
						<!-- 두번째 박스 : 로그인 상자 -->
						<div class="common-box external-enter">
							<p class="p-text">계정이 있으신가요?
								<a href="<c:url value='/'/>">
									<span style="font-weight: bold;">로그인</span>
								</a>
							</p>
						</div>
						
						
						<!-- 세번째 : 앱 다운로드 -->
						<div class="app-box">
							<p class="app-text">앱을 다운로드하세요.</p>
							<div class="app-download-img-box">
								<a class="app-down-load-img" href="#">
									<img src="<c:url value='/resources/img/app-store.png'/>" style="height: 40px;">
								</a>
								<a class="app-down-load-img" href="#">
									<img src="<c:url value='/resources/img/google-play.png'/>" style="height: 40px;">
								</a>
							</div>
						</div>
						
					</div>
				</article>
			
			</div>
			
		</div>
		<!-- end of contentBox -->
		
		
		
		
		<!-- footer -->
		<jsp:include page="../include/footer.jsp"/>
		
	</div>
	<!-- end of 전체 화면 -->
	
	
	<!-- JQuery -->
	<script>
	
	$(function(){
		
		//회원 가입 검증
		//입력값 확인을 위한 정규표현식
		const getMailCheck = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
		const getIdCheck= RegExp(/^[a-zA-Z0-9_\.]{4,14}$/); //알파벳 소문자 대문자 숫자 사용, 한글 사용 불가 (4글자에서 14자 사용가능)
		const getPwCheck= RegExp(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/); //영문 대소문자 숫자 특수문자 
		const getName= RegExp(/^[가-힣]+$/); //한글로만
		
		//확인해야할 값 총 5개
		let chk1 = false, chk2 = false, chk3 = false, chk4 = false, chk5 = false;
		
		
		//이메일 입력값 검증
		$('#user_email').on('keyup', function(){
			console.log($(this).val());
			
			//공백확인
			if($('#user_email').val() === ""){
				$('#email_msg').html('<i style="color: red" class="far fa-times-circle"></i>');
				chk1 = false;
			
			//이메일 유효성 검증
			} else if(!getMailCheck.test($('#user_email').val())){
				
				$('#email_msg').html('<i style="color: red" class="far fa-times-circle"></i>');
				chk1 = false;
				
			//이메일 중복확인 비동기 처리
			} else {
				const email = $('#user_email').val();
				$.ajax({
					type: "POST",
					url: "/hastagram/user/emailCheck",
					headers: {
		                "Content-Type": "application/json",
		                "X-HTTP-Method-Override": "POST"
		            },
		            data: email,
		            datatype: "json",
		            success: function(data){
		            	console.log(data);
		            	if(data.confirm === "OK"){
		            		$('#email_msg').html('<i style="color: #262626;" class="far fa-check-circle"></i>');
		            		chk1 = true;
		            	} else {
		            		$('#email_msg').html('<i style="color: red" class="far fa-times-circle"></i>');
		            		chk1 = false;
		            	}
		            },
		            error: function(error){
		            	console.log("error : " + error);
		            }
				});
			}
		});
		
		
		//아이디 입력값 검증
		$('#user_id').on('keyup', function(){
			console.log($(this).val()); //값 콘솔에 출력
			
			//공백확인
			if($('#user_id').val() === ""){
				$('#id_msg').html('<i style="color: red" class="far fa-times-circle"></i>');
				chk2 = false;
			
			//아이디 유효성 검증
			} else if(!getIdCheck.test($('#user_id').val())){
				
				$('#id_msg').html('<i style="color: red" class="far fa-times-circle"></i>');
				chk2 = false;
				
			//아이디 중복확인 비동기 처리
			} else {
				const id = $('#user_id').val();
				$.ajax({
					type: "POST",
					url: "/hastagram/user/idCheck",
					headers: {
		                "Content-Type": "application/json",
		                "X-HTTP-Method-Override": "POST"
		            },
		            data: id,
		            datatype: "json",
		            success: function(data){
		            	console.log(data);
		            	if(data.confirm === "OK"){
		            		$('#id_msg').html('<i style="color: #262626;" class="far fa-check-circle"></i>');
		            		chk2 = true;
		            	} else {
		            		$('#id_msg').html('<i style="color: red" class="far fa-times-circle"></i>');
		            		chk2 = false;
		            	}
		            },
		            error: function(error){
		            	console.log("error : " + error);
		            }
				});
			}
		});
		
		
		//비밀번호 검증
		$('#user_pw').on('keyup', function(){
			//비밀번호 공백 확인
			if($('#user_pw').val() === "") {
				$('#pw_msg').html('<i style="color: red" class="far fa-times-circle"></i>');
				chk3 = false;
			}
			//비밀번호 유효성 검사
			else if(!getPwCheck.test($("#user_pw").val()) || $("#user_pw").val().length < 8){
				$('#pw_msg').html('<i style="color: red" class="far fa-times-circle"></i>');
				chk3 = false;
			}
			
			else {
				$('#pw_msg').html('<i style="color: #262626;" class="far fa-check-circle"></i>');
				chk3 = true;
			}
		});
		
		
		//비밀번호 확인 검증
		$('#user_pw_check').on('keyup', function() {
	
			//비밀번호 확인란 공백 확인
			if($("#user_pw_check").val() === ""){
				$('#pw_check_msg').html('<i style="color: red" class="far fa-times-circle"></i>');
				chk4 = false;
			}		         
			//비밀번호 확인란 유효성검사
			else if($("#user_pw").val() != $("#user_pw_check").val()){
				$('#pw_check_msg').html('<i style="color: red" class="far fa-times-circle"></i>');
				chk4 = false;
			} else {
				$('#pw_check_msg').html('<i style="color: #262626;" class="far fa-check-circle"></i>');
				chk4 = true;
			}
		});//end of passwordCheck
		
		
		//이름 값 검증
		$('#user_name').on('keyup', function() {
			
			//이름값 공백 확인
			//if($("#user_name").val() === ""){
			//	$('#name_msg').html('<i style="color: red" class="far fa-times-circle"></i>');
			//	chk5 = false;
			//}		         
			//이름값 유효성검사
			if(!getName.test($("#user_name").val())){
				$('#name_msg').html('<i style="color: red" class="far fa-times-circle"></i>');
				chk5 = false;
			} else {
				$('#name_msg').html('<i style="color: #262626;" class="far fa-check-circle"></i>');
				chk5 = true;
			}
		});//end of name
		
		
		//회원 가입 요청 처리
		$('#join-btn-btn').click(function(e) {
			
			if(chk1 && chk2 && chk3 && chk4 && chk5) {
				
				
				//값을 객체에 담기
				const email = $('#user_email').val();
				const id = $('#user_id').val();
				const pw = $('#user_pw').val();
				const name = $('#user_name').val();
				
				//json객체에 담기
				const user = {
					email: email,
					id: id,
					pw: pw,
					name: name
				};
				
				//통신
				$.ajax({
					type: "POST",
					url: "/hastagram/user",
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "POST"
					},
					dataType: "text",
					data: JSON.stringify(user),
					success: function(result) {
						console.log("result : " + result);
						if(result === "joinSuccess"){
							alert("회원가입 성공!");
							self.location = "/hastagram";
						}
					}
				}); //통신끝
				
			} else {
				alert('입력정보를 다시 확인하세요.')
			}
			
		});
		
		
	});
	
	</script>
	
	
</body>
</html>