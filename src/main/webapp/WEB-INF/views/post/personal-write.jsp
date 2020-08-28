<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>글쓰기ㆍHastagram</title>
	
	<jsp:include page="../include/static-head.jsp"/>
	
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/post/personal-list-custom.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/post/personal-write-custom.css'/>">
	<link rel="stylesheet" type="text/css" href="<c:url value='/resources/css/post/modal-custom.css'/>">
	
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
					<a class="post-menu" href="<c:url value='/post/${user.id }'/>">
						<span class="">
							<i class="fas fa-th"></i>
							<span class="">게시물</span>
						</span>
					</a>
					<a class="post-menu" href="<c:url value='/resources/post/personal-write'/>">
						<span class="">
							<i class="far fa-bookmark"></i>
							<span class="">저장됨</span>
						</span>
					</a>
					<a class="post-menu" href="<c:url value='/resources/post/personal-write'/>">
						<span class="">
							<i class="far fa-id-badge"></i>
							<span class="">태그됨</span>
						</span>
					</a>
					<a class="post-menu select-menu" href="<c:url value='/resources/post/personal-writer'/>">
						<span class="">
							<i class="far fa-edit"></i>
							<span class="">글쓰기</span>
						</span>
					</a>
				</div>
				<!-- end of contentMenu -->
				
				
				
				<!-- 게시물 작성 공간 -->
				<article class="write-article">
			   		<form class="write-form" action="<c:url value='/post/upload' />" method="post" enctype="multipart/form-data">
				
						<input type="hidden" name="userNo" value="${login.userNo }">
<%--						<input type="hidden" name="id" value="${login.id }">--%>
					
						<div class="write-upload">
					   		<!-- 이미지 미리보기 부분 -->
							<div class="left-side">
					   			<img id="img" class="preview-img">   
							</div>
							<!-- 게시글 내용 작성 부분 -->
							<div class="right-side">
					   			<textarea class="input-textarea" name="caption" placeholder="문구 입력..." style="resize: none;"></textarea>
					   		</div>
						</div>
					
						<div class="write-upload">
					   		<!-- 이미지 업로드 버튼 부분 -->
							<div class="left-side fileBox" style="padding-right: 80px;">
								<input type="file" id="input_img" name="file" style="width: 0; height: 0;">
							</div>
							<!-- 공유 버튼 부분 -->
							<div class="right-side">
								<input type="submit" value="공유" class="input-btn upload-btn" disabled="disabled">
							</div>
						</div>
					</form>
				
					<div class="left-side fileBox" style="padding-right: 80px;">
					      <button class="input-btn photo_find_btn">찾기</button>
					</div>
				</article>
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
					url: "/hastagram/follow/${user.id}",
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "POST"
					},
					success: function(result) {
						console.log("result : " + result);
						if(result === "FollowOK"){
							$(".follow").html('<button class="followBtn" id="unfollow-btn">언팔로우</button>');
							location.href="/hastagram/post/${user.id}";
						}
					}
				});
			} else {
				$.ajax({
					type: "POST",
					url: "/hastagram/unfollow/${user.id}",
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "POST"
					},
					success: function(result) {
						console.log("result : " + result);
						if(result === "UnFollowOK"){
							$(".follow").html('<button class="followBtn" id="follow-btn">팔로우</button>');
							location.href="/hastagram/post/${user.id}";
						}
					}
				});
			}
		}
		
		$('.pwChangeBtn').on("click", function() {
			self.location="/hastagram/user/pw-change";
		});
		$('.logoutBtn').on("click", function() {
			self.location="/hastagram/user/logout";
		});
  
		
   		var sel_file;
   
   		$('#input_img').on("change", handleImgFileSelect);
   
    
   		function handleImgFileSelect(e) {
   			
   			$('.upload-btn').attr('disabled', false);
   			
	     	var files = e.target.files;
	      	var filesArr = Array.prototype.slice.call(files);
	      
	      	filesArr.forEach(function(f){
	         	sel_file = f;
	         
	        	var reader = new FileReader();
	         	reader.onload = function(e) {
	            	$("#img").attr("src", e.target.result);
	         	}
	         	reader.readAsDataURL(f);
	      	});
	   	}

	   	$('.photo_find_btn').click(function(e) {
	      	$("input:file").click();
	   	});
	});
	</script>
</body>
</html>
