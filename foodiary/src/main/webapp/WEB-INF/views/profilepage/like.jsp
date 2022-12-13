<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 헤더 -->
<%-- <jsp:include page="/WEB-INF/views/profilepage/myprofileheader.jsp">
	<jsp:param value="주문내역페이지" name="title"/>
</jsp:include> --%>
<p>좋아요페이지입니다.</p>
<c:forEach var="like" items="${list}">
	<img src="${pageContext.request.contextPath}/attach/downloadReviewAttach/${likeDto.reviewNo}" width="300" height="200">
</c:forEach>

</body>
</html>