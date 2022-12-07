<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<div>
		<h1>로그인</h1>
	</div>
	
<form action="login" method="post">
	<div>
		<input name="memEmail">
	</div>
	<div>
		<input name="memPw">
	</div>
	<div>
		<button type="submit">로그인</button>
	</div>
</form>

	<c:if test="${param.error !=null}">
		<h2>입력한 정보가 올바르지 않습니다</h2>
	</c:if>
