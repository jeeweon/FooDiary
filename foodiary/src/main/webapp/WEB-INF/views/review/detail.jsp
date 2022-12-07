<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<div>
		<h1>리뷰 상세</h1>
	</div>

	<div>
		번호 : ${reviewDto.reviewNo} <br>
		작성자 회원번호 : ${reviewDto.memNo} <br>
		작성일 :	<fmt:formatDate value="${reviewDto.reviewWriteTime}" pattern="yyyy.MM.dd (E) a hh:mm"/> <br>
		
		<!-- 첨부파일 -->
		<c:if test="${!attachments.isEmpty()}">
			<div>
				사진 <br>
				<c:forEach var="attachDto" items="${attachments}">
					<img src="/attach/download/${attachDto.attachNo}" width="100" height="100">
				</c:forEach>
			</div>
		</c:if>
		
		내용 :
			${reviewDto.reviewContent} <br>

		<div>
			<!-- 회원 : 자신의 글만 수정/삭제 가능하도록 처리 -->		
			<c:set var="owner" value="${loginNo == reviewDto.memNo}"></c:set>		
			<c:if test="${owner}">
			<a href="edit?reviewNo=${reviewDto.reviewNo}">수정하기</a>
			<a href="delete?reviewNo=${reviewDto.reviewNo}">삭제하기</a>
			</c:if>
			<a href="list">목록으로</a>
		</div>
	</div>
