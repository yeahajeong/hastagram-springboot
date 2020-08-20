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
	<title>Hastagram</title>
	
	<jsp:include page="../include/static-head.jsp"/>
	
	<link rel="stylesheet" type="text/css" href="<c:url value='resources/css/post/list-custom.css'/>">
</head>
<body>
	<!-- 전체화면 -->
	<div class="container-fluid" style="background-color: #fafafa;">
		<!-- contentBox -->
		<div class="contentBox">
		
		
			<!-- container 스토리랑 게시물 감쌈-->
			<div class="container totalBox">
			
				<!-- 스토리 상자 구현안함-->
				<div class="storiesBox"></div>
					
				<!-- 게시물 들어가는 곳 -->
				<div class="eachContent">
					<div style="flex-direction: column;">
						
						<!-- 게시글 각각 하나 -->
						<c:forEach var="p" items="${post }">
						<article class="contentArticle">
							<header class="contentHeader">
								<!-- 컨텐츠 헤더 프로필 사진 -->
								<div class="contentHeaderProfilePhoto" role="button">
									<canvas class="" style="position: absolute; top: -5px; left: -5px; width: 42px; height: 42px;"></canvas>
									<span class="profilePhoto" style="width: 32px; height: 32px;">
										<c:set var="len" value="${fn:length(p.profileName) }" />
							        	<c:set var="filetype" value="${fn:toUpperCase(fn:substring(p.profileName, len-4, len)) }" />
							        	<c:choose>
							        		<c:when test="${(filetype eq '.JPG') or (filetype eq 'JPEG') or (filetype eq '.GIF') or (filetype eq '.PNG')}">
												<img class="profilePhotoImg" style="height: 100%; width: 100%;" src="<c:url value='/post/profile/${p.userNo }'/>">
											</c:when>
											<c:otherwise>
												<img class="profilePhotoImg" style="height: 100%; width: 100%;" src="<c:url value='resources/img/none-user-img.jpg'/>">
											</c:otherwise>
							       		</c:choose>
									</span>
								</div>
								<!-- 컨텐츠 헤더 프로필 아이디 -->
								<div class="contentHeaderProfileId">
									<div class="profileId">
										<a class="contentHeaderProfileIdATag" href="<c:url value='/post/${p.id}' />">${p.id }</a>
									</div>
								</div>
								
								<!-- 더보기 버튼 ... -->
								<div class="moreBtn" style="float: right;">
									<button class="noButton more-btn-btn">
										<i class="fas fa-ellipsis-h"></i>
									</button>
								</div>
												
							</header>
							
							<!-- 게시글 사진 -->
							<div id="demo" class="carousel slide thumbnail-wrapper" data-ride="carousel" data-interval="false"><!-- 자동으로 넘어가지 않도록  설정 data-interval="false"-->
								<!-- 게시물 -->
								<c:set var="len" value="${fn:length(p.fileName) }" />
		        				<c:set var="filetype" value="${fn:toUpperCase(fn:substring(p.fileName, len-4, len)) }" />
								<div class="carousel-inner thumbnail">
									<div class="carousel-item active centered">
										<c:if test="${(filetype eq '.JPG') or (filetype eq 'JPEG') or (filetype eq '.GIF') or (filetype eq '.PNG')}">
											<img alt="" class="" src="<c:url value='/post/file/${p.postNo}'/>">
										</c:if>
									</div>
								</div>
							</div>
							
							<!-- 댓글 리스트 -->
							<div class="commentList">
								<!-- 댓글 버튼 아이콘 -->
								<section class="buttonIcon">
									<!-- 좋아요 아이콘 -->
									<span class="allIcon">
										<button class="iconButton noButton">
											<%-- <i class="far fa-heart fa-2x"></i> --%>
											<img class="icon-common" src="<c:url value='resources/img/like.jpg'/>">
										</button>
									</span>
									<!-- 댓글 아이콘 -->
									<span class="allIcon">
										<button class="iconButton noButton">
											<%-- <i class="far fa-comment fa-2x"></i> --%>
											<img class="icon-common" src="<c:url value='resources/img/reply.jpg'/>">
										</button>
									</span>
									<!-- 공유 아이콘 -->
									<span class="allIcon">
										<button class="iconButton noButton">
											<%--<i class="fas fa-sign-out-alt fa-2x"></i>--%>
											<img class="icon-common" alt="" src="<c:url value='resources/img/sharing.jpg'/>">
										</button>
									</span>
									<!-- 북마크 아이콘 -->
									<span class="allIcon" style="float: right">
										<button class="iconButton noButton">
											<%--<i class="far fa-bookmark fa-2x"></i>--%>
											<img class="icon-common" src="<c:url value='resources/img/bookmark.jpg'/>">
										</button>
									</span>
								</section>
								
								<!-- 좋아요 갯수 표시 -->
								<section class="likeCount">
									<div>
										<button class="noButton likeCountButton" type="button">
											<span style="font-weight: 600;">0명</span>이 좋아합니다
										</button>
									</div>
								</section>
								
								<!-- 내용과 댓글 창 -->
								<div class="contentComment">
									<ul style="padding-left: 6px;">
										<!-- 게시글 내용 부분 -->
										<li class="postContent">
											<a class="postContentId" title="" href="#">${p.id}</a>
											<span>
												<span>${p.caption }</span>
												<span>
													<!-- ...&nbsp;<button class="noButton moreButton">더 보기</button> -->
												</span>
											</span>
										</li>
										<!-- 댓글 리스트 -->
										<li class="postReply">
											<button class="noButton replyMoreButton" data-toggle="collapse" data-target="#reply" type="button">
												댓글 <span>0</span>개 모두 보기
											</button>
											<div id="reply" class="collapse">
												<a class="" title="" href="">아이디</a>
												<span>댓글 내용</span>
											</div>
											
											
										</li>
									</ul>
								</div>
								
								<!-- 게시글 올린시간 -->
								<div class="uploadTime">
									<a class="uploadTimeDetail" style="color: #999"><fmt:formatDate pattern="yyyy-MM-dd" value="${p.regDate}" /></a>
								</div>
								
								<!-- 댓글 달기 창 -->
								<section class="commentReply">
									<div class="commentBox">
										<form class="commentForm" method="post">
											<input type="hidden" id="postNo" value="${p.postNo }">
											<input type="hidden" id="userNo" value="${p.userNo }">
											<textarea id="content" class="commentTextarea" placeholder="댓글 달기..." autocomplete="off"></textarea>
											<button id="replyBtn" class="commentSubmitButton">게시</button>
										</form>
									</div>
								</section>
							</div>
							
						</article>
						</c:forEach>
						<!-- end of article -->
						
						
					</div>	
				</div>
			</div>
			<!-- end of container -->
		</div>
		<!-- end of contentBox -->
	
	
		<!-- 네비게이션 메뉴 -->
		<jsp:include page="../include/top-menu.jsp"/>
		
		<!-- footer -->
		<jsp:include page="../include/footer.jsp"/>
		
	</div>
	<!-- end of 전체 화면 -->
	
	
	
	<script type="text/javascript">
	
		$(function() {
			
			//댓글 등록 버튼 클릭 이벤트
			$("#replyBtn").on("click", function() {
				
				
				
				const postNo = $("#postNo").val();
				const userNo = $("#userNo").val();
				const content = $("#content").val();
				
				if(content === "") {
					
				} else {
					//통신
					$.ajax({
						type: "POST",
						url: "/myapp/replies",
						headers: {
							"Content-Type": "application/json",
							"X-HTTP-Method-Override": "POST"
						},
						dataType: "text",
						data: JSON.stringify({
							postNo: postNo,
							userNo: userNo,
							content: content
						}),
						success: function(result) {
							console.log("result : " + result);
							if(result === "regSuccess") {
								self.location = "/myapp/post/list";
							} else {
								alret("댓글 달기 실패!");
							}
						}
						
					}); //통신끝
					
				}
				
			});
			
		});
	
	</script>
	
	
</body>
</html>
