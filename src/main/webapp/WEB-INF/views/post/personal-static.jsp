<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<!-- contentHeader : 프로필 박스 -->
<div class="contentHeader">
	<div class="profileBox">
		<div class="profilePhoto">
			<button title="프로필 사진 바꾸기" class="profileButton">
				<img class="profilePhotoImg" style="height: 100%; width: 100%;" src="<c:url value='/resources/img/none-user-img.jpg'/>">
				<%--<c:set var="len" value="${fn:length(user.profileImage.fileName) }" />
	        	<c:set var="filetype" value="${fn:toUpperCase(fn:substring(user.profileImage.fileName, len-4, len)) }" />
	        	<c:choose>
	        		<c:when test="${(filetype eq '.JPG') or (filetype eq 'JPEG') or (filetype eq '.GIF') or (filetype eq '.PNG')}">
						<img class="profilePhotoImg" style="height: 100%; width: 100%;" src="<c:url value='/user/profile/${user.userNo }'/>">
					</c:when>
					<c:otherwise>
						<img class="profilePhotoImg" style="height: 100%; width: 100%;" src="<c:url value='/resources/img/none-user-img.jpg'/>">
					</c:otherwise>
	       		</c:choose>--%>
			</button>
		</div>
	</div>
	<div class="profileDetail">
		
		<!-- 프로필 부분 -->
		<div class="profileId">
			<!-- 아이디 -->
			<c:if test=""></c:if>
			<h1 class="userId">${user.id }</h1>
			
			
			<c:if test="${login.userNo != user.userNo }">
				<!-- 팔로 버튼 -->
				<div class="isFollow">
					<span class="follow">
						<c:choose>
							<c:when test="${followCheck eq 0 }">
								<button class="followBtn" id="follow-btn">팔로우</button>
							</c:when>
							<c:otherwise>
								<button class="followBtn" id="unfollow-btn">언팔로우</button>
							</c:otherwise>
						</c:choose>
					</span>
				</div>
			</c:if>
			
			<c:if test="${login.userNo == user.userNo }">
				<!-- 프로필편집 버튼 -->
				<a class="profileEdit" href="<c:url value='/user/update'/>">
					<button type="button" class="editBtn">프로필 편집</button>
				</a>
				
				<!-- 설정 버튼 -->
				<button type="button" data-toggle="modal" data-target="#setModal" class="profileOption">
					<!-- <i class="fas fa-cog fa-2x"></i> -->
					<span class="setBtn"></span>
				</button>
			</c:if>
			
			<!-- 설정 모달 -->
			<div class="modal fade" id="setModal">
				<div class="modal-dialog m-box">
					<div class="modal-content m-content">
						<div class="modal-body m-body">
							<button class="modal-btn pwChangeBtn" tabindex="0" onclick="href.location='<c:url value="/user/pw-change" />'">비밀번호 변경</button>
							<button class="modal-btn logoutBtn" tabindex="0">로그아웃</button>
							<button class="modal-btn" data-dismiss="modal" tabindex="0">취소</button>
						</div>
					</div>
				</div>
			</div>
			
		</div>
		
		<!-- 게시물, 팔로워, 팔로우 -->
		<ul class="profileInfo">
			<li class="infoList">
				<span class="infoTitle">게시물
					<span class="infoCount">${post.size()}</span>
				</span>
			</li>
			<li class="infoList">
				<button class="infoTitle" data-toggle="modal" data-target="#followerList">팔로워
					<span id="numberOfFollower" class="infoCount">${followerList.size() }</span>
				</button>
			</li>
			<li class="infoList">
				<button class="infoTitle" data-toggle="modal" data-target="#followingList">팔로잉
					<span id="numberOfFollowing" class="infoCount">${followingList.size() }</span>
				</button>
			</li>
		</ul>
		<div class="profileMsg">
			<p class="conditionMsg">${user.name }</p>
			<br>
			<span style="font-size: 14px;">${user.intro }</span>
		</div>
		
		
		<!-- 팔로워 모달 -->
		<div class="modal fade" id="followerList">
			<div class="modal-dialog m-box">
				<div class="modal-content m-content">
					<div class="modal-body m-body">
						<div class="modal-follow-title">
							<h1 class="">팔로워</h1>
							<button class="follow-close-btn" data-dismiss="modal" tabindex="0"><i class="fas fa-times"></i></button>
						</div>
						<div class="modal-follow-list">
							<ul class="follow-ul">
								<c:if test="${followerList.size() <= 0 }">
									<p>팔로우하는 회원이 없습니다.</p>
								</c:if>
								<c:if test="${followerList.size() > 0 }">
									<c:forEach var="list" items="${followerList }">
										<li class="follow-li">
											<div class="profile-section">
												<img class="profile-photo" src="<c:url value='/resources/img/none-user-img.jpg'/>">
<%--												<c:set var="len" value="${fn:length(list.profileName) }" />--%>
<%--									        	<c:set var="filetype" value="${fn:toUpperCase(fn:substring(list.profileName, len-4, len)) }" />--%>
<%--									        	<c:choose>--%>
<%--									        		<c:when test="${(filetype eq '.JPG') or (filetype eq 'JPEG') or (filetype eq '.GIF') or (filetype eq '.PNG')}">--%>
<%--														<img class="profile-photo" src="<c:url value='/user/profile/${list.activeUser }'/>">--%>
<%--													</c:when>--%>
<%--													<c:otherwise>--%>
<%--														<img class="profile-photo" src="<c:url value='/resources/img/none-user-img.jpg'/>">--%>
<%--													</c:otherwise>--%>
<%--												</c:choose>--%>
												<p class="profile-id"><a href="<c:url value='/post/${list.activeUser.id }' />">${list.activeUser.id }</a></p>
												<!-- <button class="following-list-btn">팔로잉</button> -->
											</div>
										</li>
									</c:forEach>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>

		<!-- 팔로잉 모달 -->
		<div class="modal fade" id="followingList">
			<div class="modal-dialog m-box">
				<div class="modal-content m-content">
					<div class="modal-body m-body">
						<div class="modal-follow-title">
							<h1 class="">팔로잉</h1>
							<button class="follow-close-btn" data-dismiss="modal" tabindex="0"><i class="fas fa-times"></i></button>
						</div>
						<div class="modal-follow-list">
							<ul class="follow-ul">
								<c:if test="${followingList.size() <= 0 }">
									<p>팔로잉한 회원이 없습니다.</p>
								</c:if>
								<c:if test="${followingList.size() > 0 }">
									<c:forEach var="list" items="${followingList }">
										<li class="follow-li">
											<div class="profile-section">
												<img class="profile-photo" src="<c:url value='/resources/img/none-user-img.jpg'/>">
<%--												<c:set var="len" value="${fn:length(list.profileName) }" />--%>
<%--									        	<c:set var="filetype" value="${fn:toUpperCase(fn:substring(list.profileName, len-4, len)) }" />--%>
<%--									        	<c:choose>--%>
<%--									        		<c:when test="${(filetype eq '.JPG') or (filetype eq 'JPEG') or (filetype eq '.GIF') or (filetype eq '.PNG')}">--%>
<%--														<img class="profile-photo" src="<c:url value='/user/profile/${list.passiveUser }'/>">--%>
<%--													</c:when>--%>
<%--													<c:otherwise>--%>
<%--														<img class="profile-photo" src="<c:url value='/resources/img/none-user-img.jpg'/>">--%>
<%--													</c:otherwise>--%>
<%--												</c:choose>--%>
												<p class="profile-id"><a href="<c:url value='/post/${list.passiveUser.id }' />">${list.passiveUser.id}</a></p>
												<!-- <button class="following-list-btn">팔로잉</button> -->
											</div>
										</li>
									</c:forEach>
								</c:if>
							</ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!-- end of 프로필 박스 -->





