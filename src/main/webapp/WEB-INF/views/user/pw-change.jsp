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
	<title>비밀번호변경하기ㆍHastagram</title>
	
	<jsp:include page="../include/static-head.jsp"/>
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/user/edit-custom.css'/>">
</head>
<body>
	<!-- 전체화면 -->
	<div class="container-fluid" style="background-color: #fafafa;">
	
		<!-- contentBox -->
		<div class="contentBox">
		
			<div class="accountBox">
				<ul class="accountMenu" style="padding-left: 0px;">
					<li>
						<a class="eachMenu hoverMenu" href="<c:url value='/user/update' />">프로필 편집</a>
					</li>
					<li>
						<a class="eachMenu selectMenu" href="<c:url value='/user/pw-change' />">비밀번호 변경</a>
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
									<img class="profilePhotoImg" style="height: 100%; width: 100%;" alt="${user.id}님의 프로필 사진" src="<c:url value='/user/profile/${login.userNo }'/>">
								</c:when>
								<c:otherwise>
									<img class="profilePhotoImg" style="height: 100%; width: 100%;" alt="${user.id}님의 프로필 사진" src="<c:url value='/resources/img/none-user-img.jpg'/>">
								</c:otherwise>
				       		</c:choose>--%>
						</div>
						<div class="profileId">
							<h1 class="profileIdText">${login.id }</h1>
						</div>
					</div>
					
					<form class="editForm" method="post" action="<c:url value='/user/pw-change' />">
						<div class="eachEdit">
							<aside class="eachEditText">현재 비밀번호</aside>
							<div class="eachEditForm">
								<input id="oldPw" class="eachEditInput" type="password">
								<span class="error_next_box" id="pwMsg" style="margin-top: 15px;"></span>
							</div>
						</div>
						<div class="eachEdit">
							<aside class="eachEditText">새 비밀번호</aside>
							<div class="eachEditForm">
								<input id="newPw" class="eachEditInput" type="password">
							</div>
						</div>
						<div class="eachEdit">
							<aside class="eachEditText">새 비밀번호 확인</aside>
							<div class="eachEditForm">
								<input id="newPwCheck" class="eachEditInput" type="password">
								<span class="error_next_box" id="newPwMsg" style="margin-top: 15px;"></span>
							</div>
						</div>
						
						<input type="hidden" id="userNo" value="${login.userNo }">
						<input type="hidden" id="email" value="${login.email }">
						<input type="hidden" id="id" value="${login.id }">
						<input type="hidden" id="name" value="${login.name }">
						
						<div class="eachEdit" style="margin-top: 25px;">
							<aside class="eachEditText"></aside>
							<div class="eachEditForm">
								<c:if test="${empty login.social}">
									<button class="emailChkBtn" type="button">비밀번호 변경</button>
								</c:if>
								<c:if test="${not empty login.social}">
									<p>소셜 로그인 이용자는 비밀번호를 변경할 수 없습니다.</p>
								</c:if>

							</div>
						</div>
						<div class="eachEdit">
							<aside class="eachEditText"></aside>
							<div class="eachEditForm">
								<a class="" href="<c:url value='/user/pw-find' />">비밀번호를 잊으셨나요?</a>
							</div>
						</div>
					</form>
				</article>
			</div>
		
		</div>
		
		<!-- 네비게이션 메뉴 -->
		<jsp:include page="../include/top-menu.jsp"/>
		
		<!-- footer -->
		<jsp:include page="../include/footer.jsp"/>
		<!-- end of footer -->
		
	</div>
	
	<script type="text/javascript">
		
		$(function() {
			const getPwCheck= RegExp(/([a-zA-Z0-9].*[!,@,#,$,%,^,&,*,?,_,~])|([!,@,#,$,%,^,&,*,?,_,~].*[a-zA-Z0-9])/);
			let chk1 = false, chk2 = false, chk3 = false;
			
			
			//현재 비밀번호
			$('#oldPw').on('keyup', function() {
				//비밀번호 공백 확인
				if($("#oldPw").val() === ""){
					$('#pwMsg').html('<b>비밀번호는 필수 정보입니다.</b>');
					chk1 = false;
					
				} else {
					
					const pw = $('#oldPw').val();
					
					$.ajax({
						type: "POST",
						url: "/hastagram/user/checkPw",
						headers: {
							"Content-Type": "application/json",
			                "X-HTTP-Method-Override": "POST"
						},
						data: pw,
						datatype: "json",
						success: function(result) {
							
							console.log(result);
							
							if(result === "pwConfirmOK") {
								$('#pwMsg').html('');
								chk1 = true;
							} else {
								$('#pwMsg').html('');
								chk1 = false;
							}
							
							
						},
						error : function(error) {
			                
			                console.log("error : " + error);
			            }
					});
					
				}
				
			}); //end of old password
			
			
			//새로운 비번
			$('#newPw').on('keyup', function() {
				//비밀번호 공백 확인
				if($("#newPw").val() === ""){
					$('#newPwMsg').html('<b>비밀번호는 필수 정보입니다.</b>');
					chk2 = false;
				}		         
				//비밀번호 유효성검사
				else if(!getPwCheck.test($("#newPw").val()) || $("#newPw").val().length < 8){
					$('#newPwMsg').html('<b>특수문자 포함 8자 이상 입력하세요</b>');
					chk2 = false;
				} else {
					$('#newPwMsg').html('');
					chk2 = true;
				}
				
			}); //end of new password
			
			
			//비밀번호 확인
			$('#newPwCheck').on('keyup', function() {
				
				if($("#newPwCheck").val() === "") {
					$('#newPwMsg').html('<b">비밀번호 확인은 필수 정보입니다.</b>');
					chk3 = false;
				} else if( $("#newPw").val() != $("#newPwCheck").val() ) {
					$('#newPwMsg').html('<b>비밀번호가 일치하지 않습니다.</b>');
					chk3 = false;
				} else {
					$('#newPwMsg').html('');
					chk3 = true;
				}
				
			});//end of passwordCheck
			
			
			//비밀번호 변경 요청처리하기
			$('.emailChkBtn').click(function(e) {
				
				if(chk1 == false) {
					alert('현재 비밀번호가 틀렸습니다.');	
				
				} else if(chk2 == false){
					alert('2번 틀림');
				} else if(chk3 == false){
					alert('3번 틀림');
					
				} else if(chk1 && chk2 && chk3) {
					
					const userNo = $('#userNo').val();
					const pw = $("#newPw").val();
					const email = $("#email").val();
					const id = $("#id").val();
					const name = $('#name').val();
					const user = {
						userNo: userNo,
						id: id,
			            pw: pw,
			            email: email,
			            name: name
					};
					console.log(user);
					
					$.ajax({
						type: "POST",
						url: "/hastagram/user/pw-change",
			            headers: {
			                "Content-Type": "application/json",
			                "X-HTTP-Method-Override": "POST"
			            },
			            dataType: "text",
			            data: JSON.stringify(user),
			            success: function(result) {
			            	
			            	console.log("result: " + result);
			            	if(result === "changeSuccess") {
			            		alert('비밀번호가 변경되었습니다.');
			            		location.href ="/hastagram/user/pw-change";
			            	} else {
			            		alert('현재 비밀번호가 틀렸습니다.');
			            	}
			            }
					});
					
				} else {
					alert('입력정보를 다시 확인하세요.');	
				}
			});
			
		});//end of function
		
	</script>
	
</body>
</html>