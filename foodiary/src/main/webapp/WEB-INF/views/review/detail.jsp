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
		내용 :
			${reviewDto.reviewContent} <br>

		<%-- <c:if test="${attachmentList != null}">
			첨부파일
				<c:forEach var="attachmentDto" items="${attachmentList}">
					${attachmentDto.attachmentName} 
					(${attachmentDto.attachmentSize} bytes) 
					- 
					[${attachmentDto.attachmentType}]
					<a href="/attachment/download/${attachmentDto.attachmentNo}"><img src="/image/download.png" width="15" height="15"></a>
				</c:forEach>
		</c:if> --%>

		<div>
			<!-- 회원 : 자신의 글만 수정/삭제 가능하도록 처리 -->		
			<c:set var="owner" value="${loginNo == reviewDto.memNo}"></c:set>		
			<c:if test="${owner}">
			<a href="edit?reviewNo=${reviewDto.reviewNo}">수정하기</a>
			<a href="delete?reviewNo=${reviewDto.reviewNo}">삭제하기</a>
			</c:if>
			<a href="list">목록으로</a>
		</div>
