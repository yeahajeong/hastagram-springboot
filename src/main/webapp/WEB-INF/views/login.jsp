<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Hastagram</title>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <jsp:include page="include/static-head.jsp"/>

    <!-- main custom css -->
    <link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/login-custom.css'/>">

</head>
<body>
<!-- 전체 화면 -->
<div class="container-fluid" style="background-color: #fafafa;">

    <!-- total-box : 로그인 전체 화면 -->
    <div class="content-box carousel" data-ride="carousel">

        <!-- 로그인 화면 : 배너 이미지 - 핸드폰 모양 -->
        <div class="carousel-inner login-banner">
            <div class="carousel-item active  phone-shape-img">
                <!-- 바뀌는 이미지 -->
                <img class="banner-inner-img" src="<c:url value='/resources/img/main/main-screenshoot1.jpg'/>">
            </div>
            <div class="carousel-item phone-shape-img">
                <!-- 바뀌는 이미지 -->
                <img class="banner-inner-img" src="<c:url value='/resources/img/main/main-screenshoot2.jpg'/>">
            </div>
            <div class="carousel-item phone-shape-img">
                <!-- 바뀌는 이미지 -->
                <img class="banner-inner-img" src="<c:url value='/resources/img/main/main-screenshoot3.jpg'/>">
            </div>
            <div class="carousel-item phone-shape-img">
                <!-- 바뀌는 이미지 -->
                <img class="banner-inner-img" src="<c:url value='/resources/img/main/main-screenshoot4.jpg'/>">
            </div>
            <div class="carousel-item phone-shape-img">
                <!-- 바뀌는 이미지 -->
                <img class="banner-inner-img" src="<c:url value='/resources/img/main/main-screenshoot5.jpg'/>">
            </div>
        </div>

        <!-- 로그인 화면 : 오른쪽 로그인 박스 -->
        <div class="login-box">
            <!-- 첫번째 박스 : 로그인 인풋 박스 -->
            <div class="common-box">

                <!-- 하스타 그램 로고 -->
                <img class="logo-img" src="<c:url value='/resources/img/hastagram-logo.jpg'/>">

                <!-- 로그인 폼 -->
                <form class="login-form" action="<c:url value='/user'/>" method="post" style="margin-bottom: 10px;">
                    <div style="margin-bottom: 24px;"></div>
                    <!-- 입력 박스 -->
                    <span class="form-span">
                        <input type="text" class="form-control input_box" id="login_id" placeholder="아이디" maxlength="75">
                    </span>
                    <span class="form-span">
                        <input type="password" class="form-control input_box" id="login_pw" placeholder="비밀번호" maxlength="75">
                    </span>
                    <!-- 로그인 버튼 -->
                    <button type="button" id="login-btn" class="common-btn login-btn">
                        <span>로그인</span>
                    </button>

                    <!-- 또는  -->
                    <span class="or-bar-bax" style="margin-top: 16px;">
							<span class="bar"></span>
							<span class="or-text">또는</span>
							<span class="bar"></span>
						</span>

                    <!-- 카카오로 로그인 버튼 -->
                    <a class="common-btn kakao-btn" style="padding: 0px;" href="https://kauth.kakao.com/oauth/authorize?client_id=76f68e8c2c7e5519d412f7c1680211fa&redirect_uri=http://localhost:8000/hastagram/social_login/kakao&response_type=code">
                        <%-- <span class="kakao-text">Kakao로 로그인</span> --%>
                        <img style="width: 260px; padding: 0px;" src="<c:url value='/resources/img/main/kakao_account_login_btn_medium_wide.png'/>" >
                    </a>

                    <!-- 경고창 -->
                    <div class="msg-box" id="alert_msg"></div>

                    <!-- 비밀번호 찾기 -->
                    <a class="a-text" href="<c:url value='/hastagram/user/pw-find'/>">비밀번호를 잊으셨나요?</a>
                </form>

            </div>

            <!-- 두번째 박스 : 회원가입 박스 -->
            <div class="common-box external-enter">
                <p class="p-text">계정이 없으신가요?
                    <a href="<c:url value='/user/join'/>">
                        <span style="font-weight: bold;">가입하기</span>
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
    </div>


    <!-- footer -->
    <jsp:include page="include/footer.jsp"/>

</div>
<!-- end of 전체 화면 -->

<script>
    $(function() {

        //확인 값 2개
        let chk1 = false, chk2 = false;

        $('#login_id').on('keyup', function(){

            if($('#login_id').val() === "") {
                chk1 = false;
            } else {
                chk1 = true;
            }
        });

        $('#login_pw').on('keyup', function(){

            if($('#login_pw').val() === "") {
                chk2 = false;
            } else {
                chk2 = true;
            }
        });


        //로그인 버튼 클릭 이벤트
        $('#login-btn').click(function(e) {

            if(chk1 && chk2) {

                const id = $('#login_id').val();
                const pw = $('#login_pw').val();

                //콘솔에 값 출력
                console.log("id: " + id);
                console.log("pw: " + pw);

                //json객체에 담기
                const userInfo = {
                    id: id,
                    pw: pw
                };

                $.ajax({
                    type: "POST",
                    url: "/hastagram/user/loginCheck",
                    headers: {
                        "Content-Type": "application/json",
                        "X-HTTP-Method-Override": "POST"
                    },
                    data: JSON.stringify(userInfo),
                    dataType: "text",
                    success: function(data) {

                        console.log("result:" + data);

                        if(data === "emailFail") {
                            $('#alert_msg').html('<p>입력한 사용자 이름을 사용하는 계정을 찾을 수 없습니다. 사용자 이름을 확인하고 다시 시도하세요.</p>');
                            $('#login_email').focus();

                        } else if(data === "pwFail") {
                            $('#login_pw').focus();
                            $('#alert_msg').html('<p>잘못된 비밀번호입니다. 다시 확인하세요.</p>');

                        } else if(data === "loginSuccess") {
                            alert("로그인성공!");
                            self.location="/hastagram/post/list";
                        }
                    }
                }); //통신끝!

            } else {
                alert('입력 정보를 다시 확인하세요');
            }
        });


        $('#login_pw').keydown(function(key){
            //엔터키 코드 13
            if(key.keyCode == 13) {
                $('#login-btn').click();
            }
        });



    });
</script>


</body>
</html>
