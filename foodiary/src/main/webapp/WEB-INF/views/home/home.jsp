<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<h1>home</h1>
<a href="home/area/interest"><h2>관심지역 설정하기</h2></a>

<c:set var="login" value="${loginNo != null}"></c:set>
<c:choose>
	<c:when test="${login}">
		<a href="mem/logout">로그아웃</a>
	</c:when>
	<c:otherwise>
		<a href="mem/login">로그인</a>	
	</c:otherwise>
</c:choose>

<!-- 세션 정보 -->
<%-- loginNo : ${sessionScope.loginNo}<br> --%>
<%-- loginNick : ${sessionScope.loginNick}<br> --%>