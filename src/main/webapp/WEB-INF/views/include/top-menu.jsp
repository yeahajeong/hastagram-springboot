<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" type="text/css" href="<c:url value='resources/css/include/top-menu-custom.css'/>">

<!-- 상단 고정 메뉴 -->
<nav class="nav navbar-expand-md navbar-light fixed-top" style="background-color: #fff; border-bottom: 1px solid #dbdbdb; align-items: center; height: 77px;">
	<div class="container">
	
		<ul class="nav navbar-nav menu-box">
			<!-- 로고 부분 -->
			<li class="menu-content" style="width: 30%">
				<div class="row logo">
				
				<!-- 인스타그램 아이콘 -->
				<c:if test="${not empty login }">
					<a href="<c:url value='/post/list'/>" style="color: #262626;"><i class="fab fa-instagram fa-2x"></i></a>
					<!-- 가운데 선 -->
					<div class="logo-bar"></div>
					<!-- 인스타그램 로고 이미지 -->
					<div class="logo-img">
						<a href="<c:url value='/post/list'/>"><img alt="" src="<c:url value='resources/img/hastagram-logo.jpg'/>"></a>
					</div>
				</c:if>
				<c:if test="${empty login }">
					<a href="<c:url value='/'/>" style="color: #262626;"><i class="fab fa-instagram fa-2x"></i></a>
					<!-- 가운데 선 -->
					<div class="logo-bar"></div>
					<!-- 인스타그램 로고 이미지 -->
					<div class="logo-img">
						<a href="<c:url value='/'/>"><img alt="" src="<c:url value='resources/img/instagram-logo.png'/>"></a>
					</div>
				</c:if>
				</div>
			</li>
			
			<!-- 검색 부분 -->
			<li class="menu-content" style="width: 40%; height: 30px; margin-top: 2px;">
				<div class="search search-box">
					<input class="form-control input_box" type="text" placeholder="검색">
				</div>
			</li>
			
			<!-- 아이콘 메뉴 부분 : 로그인 되어있을 시에만 보이도록 -->
			<c:if test="${not empty login }">
				<li class="menu-content" style="width: 30%">
					<div class="row" style="float: right;">
						<div class="icon">
							<a href="">
								<img class="menu-icon" src="<c:url value='resources/img/menu/menu-compass.jpg'/>">
							</a>
						</div>
						<div class="icon">
							<a href="">
								<img class="menu-icon" src="<c:url value='resources/img/menu/menu-heart.jpg'/>">
							</a>
						</div>
						<div class="icon">
							<a href="<c:url value='/post/${login.id }'/>">
								<img class="menu-icon" src="<c:url value='resources/img/menu/menu-user.jpg'/>">
							</a>
						</div>
					</div>
				</li>
			</c:if>
		</ul>
	</div>
</nav>
<!-- end of 네비게이션 메뉴 -->