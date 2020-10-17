<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<title>ㆍHastagram</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	
	<jsp:include page="../include/static-head.jsp"/>
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/board/content-custom.css'/>">
</head>
<body>
	<!-- 전체화면 -->
	<div class="container-fluid" style="background-color: #fafafa;">
		<!-- contentBox -->
		<div class="contentBox">
		
			<!-- 게시글 전체 감싸는 곳 -->
			<article class="content-article">
				<header class="content-profile">
					<div class="">
						<a class="" href="" style="width: 32px; height: 32px;">
							<img src="<c:url value='/resources/img/none-user-img.jpg'/>">
						</a>
					</div>
					<div class="">
						<div class="">
							<div class="">
								<a class="" tilte="" href=#>eun__chuuu___</a>
							</div>
							<div class="">
								<span class="">ㆍ</span>
								<button class="" type="button">팔로잉</button>
							</div>
						</div>
						<div class="">
							
						</div>
					</div>
				</header>
				<div class="content-total">
					<img src="<c:url value='/resources/img/upload-photo-img3.jpg'/>">
				</div>
				<div class="content-comment">
					<!-- 아이콘 부분 -->
					<section class=""></section>
					<!-- 좋아요 갯수 부분 -->
					<section class=""></section>
					<!-- 댓글 창 부분 -->
					<div class=""></div>
					<!-- 올린 시간 부분 -->
					<div class=""></div>
					<!-- 댓글 달기 부분 -->
					<section class=""></section>
				</div>
			</article>
		
		</div>
		<!-- end of contentBox -->
	
	
		<!-- 네비게이션 메뉴 -->
		<jsp:include page="../include/top-menu.jsp"/>
		
		<!-- footer -->
		<jsp:include page="../include/footer.jsp"/>
		
	</div>
	<!-- end of 전체 화면 -->
	
	
	
	
</body>
</html>
