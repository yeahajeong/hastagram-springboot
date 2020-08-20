<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>${user.name }(@${user.id })ㆍHastagram</title>
	
	<jsp:include page="../include/static-head.jsp"/>
	
	<link rel="stylesheet" type="text/css" href="<c:url value='resources/css/post/personal-list-custom.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='resources/css/post/modal-custom.css'/>">
</head>
<body>
	<!-- 전체화면 -->
	<div class="container-fluid" style="background-color: #fafafa;">
		
		<!-- contentBox -->
		<div class="contentBox">
			<div class="container">
				
				
				
				<jsp:include page="personal-static.jsp"/>
				
				
				
				
				<!-- contentMenu : 컨텐트 메뉴 바  -->
				<div class="contentMenu">
				
					<a class="post-menu select-menu" href="<c:url value='/post/${user.id }'/>">
						<span class="">
							<i class="fas fa-th"></i>
							<span class="">게시물</span>
						</span>
					</a>
					<a class="post-menu" href="<c:url value='/post/'/>">
						<span class="">
							<i class="far fa-bookmark"></i>
							<span class="">저장됨</span>
						</span>
					</a>
					<a class="post-menu" href="<c:url value='/post/'/>">
						<span class="">
							<i class="far fa-id-badge"></i>
							<span class="">태그됨</span>
						</span>
					</a>
					
					<c:if test="${login.userNo == user.userNo }">
					<a class="post-menu" href="<c:url value='/post/${user.id}/personal-write'/>">
						<span class="">
							<i class="far fa-edit"></i>
							<span class="">글쓰기</span>
						</span>
					</a>
					</c:if>
					
					
				</div>
				<!-- end of contentMenu -->
				
				
				
				<!-- content모음 : 게시글이 들어가는곳 -->
				<div class="container">
					<div class="row">
						<c:if test="${post.size() <=0 }">
							<div class="nonePost">
								<i class="fas fa-exclamation-circle fa-5x" style="margin-bottom: 20px; color: #dbdbdb;"></i>
								<c:if test="${login.userNo == user.userNo }">
									<p>게시물이 없습니다!<br>게시물을 올려주세요.</p>
								</c:if>
								<c:if test="${login.userNo != user.userNo }">
									<p>게시물이 없습니다!<br>게시물을 올려주세요.</p>
								</c:if>
								
							</div>
						</c:if>
						<c:if test="${post.size() >0 }">
							<c:forEach var="p" items="${post }">
								<form role="form" method="post">
									<input type="hidden" name="postNo" value="${p.postNo }">				
									<input type="hidden" name="id" value="${p.id }">				
								</form>
								
								<div class="col-md-4 upload-item">
									<a class="upload-link" data-toggle="modal" href="#postModal">
										<div class="upload-hover">
											<ul class="hover-content">
												<li class="hover-content-detail">
													<span class="hover-icon"><i class="fas fa-heart"></i></span>
													<span></span>
												</li>
												<li class="hover-content-detail">
													<span class="hover-icon"><i class="fas fa-comment"></i></span>
													<span></span>
												</li>
											</ul>
										</div>
										
										<c:set var="len" value="${fn:length(p.fileName) }" />
			        					<c:set var="filetype" value="${fn:toUpperCase(fn:substring(p.fileName, len-4, len)) }" />
			        					<c:if test="${(filetype eq '.JPG') or (filetype eq 'JPEG') or (filetype eq '.GIF') or (filetype eq '.PNG')}">
			        					<div class="thumbnail-wrapper">
			        						<div class="thumbnail">
			        							<div class="centered">
													<img class="img-thumnail img-fluid" src="<c:url value='/post/file/${p.postNo }'/>" >
												</div>
											</div>
										</div>
										</c:if>
									</a>
								</div>
							</c:forEach>
						</c:if>
					</div>
				
				</div>
				
				<!-- 게시글 모달 -->
				<div class="modal fade" id="postModal">
					<div class="modal-dialog m-box">
						<div class="modal-content m-content">
							<div class="modal-body m-body">
								<c:if test="${login.userNo == user.userNo }">
								<button class="modal-btn deleteBtn" tabindex="0" >게시물 삭제</button>
								</c:if>
								<button class="modal-btn" data-dismiss="modal" tabindex="0">취소</button>
							</div>
						</div>
					</div>
				</div>
							
							
							
				<!-- end of 게시글이 들어가는곳 -->
				
				
			</div>
		</div>
		<!-- end of contentBox -->
	
		<!-- 네비게이션 메뉴 -->
		<jsp:include page="../include/top-menu.jsp"/>
		
		<!-- footer -->
		<jsp:include page="../include/footer.jsp"/>
		
	</div>
	
	
	<script>
		$(document).ready(function () {
			
			$('#follow-btn').on('click', function() {
				follow(true);
			});
			
			$('#unfollow-btn').on('click', function() {
				follow(false);
			});
			
			function follow(check) {
				if(check) {
					$.ajax({
						type: "POST",
						url: "/myapp/follow/${user.id}",
						headers: {
							"Content-Type": "application/json",
							"X-HTTP-Method-Override": "POST"
						},
						success: function(result) {
							console.log("result : " + result);
							if(result === "FollowOK"){
								$(".follow").html('<button class="followBtn" id="unfollow-btn">언팔로우</button>');
								location.href="/myapp/post/${user.id}";
							}
						}
					});
				} else {
					$.ajax({
						type: "POST",
						url: "/myapp/unfollow/${user.id}",
						headers: {
							"Content-Type": "application/json",
							"X-HTTP-Method-Override": "POST"
						},
						success: function(result) {
							console.log("result : " + result);
							if(result === "UnFollowOK"){
								$(".follow").html('<button class="followBtn" id="follow-btn">팔로우</button>');
								location.href="/myapp/post/${user.id}";
							}
						}
					});
				}
			}
			
			$('.pwChangeBtn').on("click", function() {
				self.location="/myapp/user/pw-change";
			});
			$('.logoutBtn').on("click", function() {
				self.location="/myapp/user/logout";
			});
			
			const formObj = $("form[role='form']");
			$('.deleteBtn').on("click", function() {
				formObj.attr("method", "post");
				formObj.attr("action", "delete");
				formObj.submit();
			});
			
			
		});
	</script>
</body>
</html>
