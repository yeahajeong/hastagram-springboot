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
	<title>탈퇴하기ㆍHastagram</title>
	
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
						<a class="eachMenu hoverMenu" href="<c:url value='/user/pw-change' />">비밀번호 변경</a>
					</li>
					<li>
						<a class="eachMenu selectMenu" href="<c:url value='/user/withdrawal' />">회원 탈퇴</a>
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
					<form class="editForm" method="post">
						<div class="eachEdit">
							<aside class="eachEditText">현재 비밀번호</aside>
							<div class="eachEditForm">
								<input id="pw" class="eachEditInput" type="password" value="">
							</div>
						</div>
						<div class="eachEdit">
							<aside class="eachEditText">비밀번호 확인</aside>
							<div class="eachEditForm">
								<input id="pwCheck" class="eachEditInput" type="password" value="">
								<span class="error_next_box" id="pwMsg"></span>
							</div>
						</div>
						
						<input type="hidden" id="userNo" value="${login.userNo }">
						
						
						<div class="eachEdit" style="margin-top: 25px;">
							<aside class="eachEditText"></aside>
							<div class="eachEditForm">
								<button class="emailChkBtn" type="button" onclick="return confirm('정말 회원 탈퇴하시겠습니까?')">회원 탈퇴</button>
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
		
	</div>
	
	<script type="text/javascript">
		$(function() {
			
			let chk1 = false;
			
			$('#pw').on('keyup', function() {
				
				
			});
			
			$('#pwCheck').on('keyup', function() {
				if($("#pw").val() != $('#pwCheck').val() ){
					chk1 = false;
				} else {
					chk1 = true;
				}
			});
			
			//탈퇴 버튼 클릭 이벤트
			$('.emailChkBtn').click(function() {
				if(chk1) {
					const userNo = $('#userNo').val();
					const pw = $("#pw").val();
					const user = {
						userNo: userNo,
			            pw: pw
					};
					
					$.ajax({
						type: "POST",
						url: "/user/withdrawal",
						headers: {
			                "Content-Type": "application/json",
			                "X-HTTP-Method-Override": "POST"
			            },
						data: JSON.stringify(user),
						dataType : "text",
						success: function(result) {
							console.log("result: " + result);	
							
							if(result === "Success") {
								alert('탈퇴되었습니다. 안녕!');
								self.location = '/hastagram';
						    } else {
						    	alert('비밀번호가 틀렸습니다.')
						    }
							
						}
					});
					
				} else {
					alert('비밀번호 확인이 맞지 않습니다.');
				}
				
				
			});
			
			
		});
	
	</script>
</body>
</html>