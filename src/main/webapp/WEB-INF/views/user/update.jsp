<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>정보변경하기ㆍHastagram</title>
	
	<jsp:include page="../include/static-head.jsp"/>
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/user/edit-custom.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/post/modal-custom.css'/>">
</head>
<body>
	<!-- 전체화면 -->
	<div class="container-fluid" style="background-color: #fafafa;">
	
		<!-- contentBox -->
		<div class="contentBox">
		
			<div class="accountBox">
				<ul class="accountMenu" style="padding-left: 0px;">
					<li>
						<a class="eachMenu selectMenu" href="<c:url value='/user/update' />">프로필 편집</a>
					</li>
					<li>
						<a class="eachMenu hoverMenu" href="<c:url value='/user/pw-change' />">비밀번호 변경</a>
					</li>
					<li>
						<a class="eachMenu hoverMenu" href="<c:url value='/user/withdrawal' />">회원 탈퇴</a>
					</li>
				</ul>
				<article class="accountArticle">
					<div class="profileForm">
						<div class="profilePhoto">
							<img class="profilePhotoImg" style="height: 100%; width: 100%;" alt="${user.id}님의 프로필 사진" src="<c:url value='/resources/img/none-user-img.jpg'/>">
							<%--<c:set var="len" value="${fn:length(login.profileImage.fileName) }" />
				        	<c:set var="filetype" value="${fn:toUpperCase(fn:substring(login.profileImage.fileName, len-4, len)) }" />
				        	<c:choose>
				        		<c:when test="${(filetype eq '.JPG') or (filetype eq 'JPEG') or (filetype eq '.GIF') or (filetype eq '.PNG')}">
									<img class="profilePhotoImg" style="height: 100%; width: 100%;" alt="${user.id}님의 프로필 사진" src="<c:url value='/hastagram/user/profile/${login.userNo }'/>">
								</c:when>
								<c:otherwise>
									<img class="profilePhotoImg" style="height: 100%; width: 100%;" alt="${user.id}님의 프로필 사진" src="<c:url value='/resources/img/none-user-img.jpg'/>">
								</c:otherwise>
				       		</c:choose>--%>
						</div>
						<div class="profileId">
							<h1 class="profileIdText">${login.id }</h1>
							<button class="profilePhotoChange" type="button" data-toggle="modal" data-target="#profilePhotoEdit">프로필 사진 바꾸기</button>
						</div>
					</div>
					
					
					<!-- 모달 -->	
					<div class="modal fade" id="profilePhotoEdit">
						<div class="modal-dialog m-box">
							<div class="modal-content m-content">
								<div class="m-title">
									<h3>프로필 사진 바꾸기</h3>
								</div>
								<div class="modal-body m-body">
									<button id="photoEdit" class="modal-btn" tabindex="0" style="color: #3897f0; font-weight: 700;">사진 업로드</button>
									<button id="photoRemove" class="modal-btn" tabindex="0" style="color: #ed4956; font-weight: 700;">현재 사진 삭제</button>
									<button id="cancleBtn" class="modal-btn" data-dismiss="modal" tabindex="0">취소</button>
								</div>
							</div>
						</div>
					</div>
					
					<form class="editForm" method="post">
						<input type="hidden" id="user_no" value="${login.userNo }">
					
						<div class="eachEdit">
							<aside class="eachEditText">아이디</aside>
							<div class="eachEditForm">
								<input class="eachEditInput" id="user_id" type="text" value="${login.id }">
							</div>
						</div>
						<div class="eachEdit">
							<aside class="eachEditText">사용자 이름</aside>
							<div class="eachEditForm">
								<input class="eachEditInput" id="user_name" type="text" value="${login.name }">
							</div>
						</div>
						<div class="eachEdit">
							<aside class="eachEditText">소개</aside>
							<div class="eachEditForm">
								<textarea class="inputTextarea" id="user_intro" placeholder="${login.intro }"></textarea>
							</div>
						</div>
						<div class="eachEdit">
							<aside class="eachEditText">이메일</aside>
							<div class="eachEditForm">
								<input class="eachEditInput" id="user_email" type="text" value="${login.email }">
							</div>
						</div>
						<div class="eachEdit">
							<aside class="eachEditText"></aside>
							<div class="eachEditForm">
								<button class="emailChkBtn" type="button">이메일 확인</button>
							</div>
						</div>
						<div class="eachEdit">
							<aside class="eachEditText">전화번호</aside>
							<div class="eachEditForm">
								<input class="eachEditInput" id="user_phone" type="text" value="${login.phone }">
							</div>
						</div>
						<div class="eachEdit" style="margin-top: 25px;">
							<aside class="eachEditText"></aside>
							<div class="eachEditForm">
								<button id="modifyBtn" class="emailChkBtn" type="button">제출</button>
							</div>
						</div>
					</form>
					
					<form id="fileForm" method="post" action="<c:url value='/user/profile/upload'/>" enctype="multipart/form-data">
						<input type="hidden" name="userNo" value="${login.userNo }">
						<input type="file" id="file" name="file" style="display:none" >
						<input type="submit" id="fileUpload" style="display:none">
					</form>
					
					<form role="form" method="post">
						<input type="hidden" name="userNo" value="${login.userNo }">
					</form>
					
				</article>
			</div>
		
		</div>
		
		<!-- 네비게이션 메뉴 -->
		<jsp:include page="../include/top-menu.jsp"/>
		
		
		<!-- footer -->
		<jsp:include page="../include/footer.jsp"/>
		
	</div>
	
	<script>
		$(function() {
			
			const formObj = $("form[role='form']");
			
			$('#photoEdit').click(function(e) {
				//프로필 변경 버튼 누르면 파일 찾기 창을 띄움
		      	$("input:file").click();
		   	});
			
			$("input:file").on("change", function() {
				$('#fileUpload').click();
			});
			
			
			//프로필 사진 삭제
			$("#photoRemove").on("click", function() {
				formObj.attr("method", "post");
				formObj.attr("action", "profile/delete");
				formObj.submit();
			});
			
			
			
			
			
			//입력값 확인 정규 표현식
			const getEmail = RegExp(/^[A-Za-z0-9_\.\-]+@[A-Za-z0-9\-]+\.[A-Za-z0-9\-]+/);
			const getId= RegExp(/^[a-zA-Z0-9_\.]{4,14}$/);
			const getName= RegExp(/^[가-힣]+$/);
			const getPhone= RegExp(/^\d{3}-\d{3,4}-\d{4}$/);
			
			let chk1 = false, chk2 = false, chk3 = false, chk4 = false;
			
			//아이디 값 확인
			function idCheck() {
				let id = $('#user_id').val();
				
				if(id === "") {
					alert("아이디 값을 입력해주세요.");
					chk1 = false;
				} else if(!getId.test(id)) {
					alert("사용 불가능한 문자가 포함되어있습니다.")
					chk1 = false;
				} else {
					chk1 = true;
				}
			}
			
			//이름 값 확인
			function nameCheck() {
				let name = $('#user_name').val();
				
				if(name === "") {
					chk2 = true;
				} else {
					if(!getName.test(name)) {
						alert("한글로만 입력해주세요.")
						chk2 = false;
					} else {
						chk2 = true;
					}
				}
			}
			
			//이메일 값 확인
			function emailCheck() {
				let email = $('#user_email').val();
				
				if(email === "") {
					alert("이메일을 입력해주세요.");
					chk3 = false;
				} else if(!getEmail.test(email)) {
					alert("이메일 형식에 맞지 않습니다.")
					chk3 = false;
				} else {
					chk3 = true;
				}
			}
			
			//이름 값 확인
			function phoneCheck() {
				let phone = $('#user_phone').val();
				
				if(phone==="") {
					chk4 = true;
				} else {
					if(!getPhone.test(phone)) {
						alert("000-0000-0000 형식에 맞게 입력해주세요.")
						chk4 = false;
					} else {
						chk4 = true;
					}
				}
				
			}
			
			//제출 버튼 
			$('#modifyBtn').click(function(e) {
				
				idCheck();
				emailCheck();
				nameCheck();
				phoneCheck();
				
				if(chk1 && chk2 && chk3 && chk4) {
					const id = $('#user_id').val();
					const name = $('#user_name').val();
					const email = $('#user_email').val();
					const intro = $('#user_intro').val();
					const phone = $('#user_phone').val();
					const userNo = $('#user_no').val();
					
					//json객체에 담기
					const user = {
						email: email,
						id: id,
						name: name,
						intro: intro,
						phone: phone,
						userNo: userNo
					};
					
					//통신
					$.ajax({
						type: "POST",
						url: "/hastagram/user/update",
						headers: {
							"Content-Type": "application/json",
							"X-HTTP-Method-Override": "POST"
						},
						dataType: "text",
						data: JSON.stringify(user),
						success: function(result) {
							console.log("result : " + result);
							if(result === "updateSuccess"){
								alert("회원정보 변경 성공!");
								self.location = "redirect:/hastagram/user/update";
							} else if (result === "idFail") {
								alert("중복된 아이디가 존재합니다.");
							} else if (result === "emailFail") {
								alert("중복된 이메일이 존재합니다.")
							}
						}
					}); //통신끝
					
				} else {

				}
				
			});
			
			
			
			
		});
	</script>
</body>
</html>