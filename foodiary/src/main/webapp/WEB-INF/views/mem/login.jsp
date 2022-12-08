<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<head>
    <title>로그인</title>
</head>
<body>
		<div>
			<h1>로그인</h1>
		</div>
		
	<form action="login" method="post" autocomplete="off">
		<div>
			<input type="text" name="memEmail" placeholder="이메일">
		</div>
		<div>
			<input type="password" name="memPw" placeholder="비밀번호">
		</div>
		<div>
			<button type="submit">로그인</button>
		</div>
		<div>
			<c:if test="${param.error !=null}">
				<h2>입력한 정보가 올바르지 않습니다</h2>
			</c:if>	
		</div>
	</form>
		<hr>
		<p><a href="#">비밀번호 찾기</a>ㅣ<a href="#">회원가입 하기</a></p>

</body>


