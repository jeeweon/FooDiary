<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>비밀번호 변경</title>
</head>
<body>
	<div>
		<h1>비밀번호 변경</h1>
	</div>
	
	<form action="email_check" method="post">
		<div>
			<label>
				비밀번호
				<i class="fa-solid fa-asterisk"></i>
			</label>
			<input type="password" class="input" name="memPw" placeholder="비밀번호">
	        <div class="success-message">사용 가능한 비밀번호입니다.</div>
	        <div class="fail-message">비밀번호는 숫자, 영문 소문자, 특수문자를 반드시 1개 이상 포함하여 8~16자로 작성해주세요.</div>		
		</div>
		
		<div>
			<label>
				비밀번호 확인
				<i class="fa-solid fa-asterisk"></i>
			</label>
			<input type="password" class="input" id="pw-re" placeholder="비밀번호 확인">
			<div class="success-message">비밀번호가 일치합니다.</div>
	        <div class="fail-message">비밀번호가 일치하지 않습니다.</div>		
		</div>
	</form>
	
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">



</script>
</body>	
</html>