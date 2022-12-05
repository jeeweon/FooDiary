<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 현재 시간 구하기 -->
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<c:set var="today">
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>
</c:set>

	<h1>리뷰</h1>

	<div>
		<a href="write">리뷰 쓰기</a>
	</div>
	
	<div>
		<c:forEach var="reviewDto" items="${list}">
			<div>
				번호 : 
					<a href="detail?reviewNo=${reviewDto.reviewNo}">
						${reviewDto.reviewNo}
					</a>
				<!-- 사진을 누르면 상세 페이지로 이동하도록 처리 -->
				<%-- <a href="detail?reviewNo=${reviewDto.reviewNo}">
					<!-- 사진 미리보기 -->
				</a> --%>
				
				<%-- <!-- 댓글 개수 출력 -->
				<c:if test="${reviewDto.replyCount > 0}">
					[${reviewDto.replyCount}]
				</c:if>
				
				<!-- 좋아요 개수 출력 -->
				<c:if test="${reviewDto.reviewLike > 0}">
					♥ ${reviewDto.reviewLike}
				</c:if> --%>
				<c:set var="current">
					<fmt:formatDate value="${reviewDto.reviewWriteTime}" pattern="yyyy-MM-dd"/>
				</c:set>
				<c:choose>
					<c:when test="${today == current}">
						작성일 : 
						<fmt:formatDate value="${reviewDto.reviewWriteTime}" 
													pattern="HH:mm"/>
					</c:when>
					<c:otherwise>
						작성일 : 
						<fmt:formatDate value="${reviewDto.reviewWriteTime}" 
													pattern="yyyy-MM-dd"/>
					</c:otherwise>
				</c:choose>
				<%-- 조회수 : ${reviewDto.reviewRead} --%>
			</c:forEach>
		</div>
	</div>