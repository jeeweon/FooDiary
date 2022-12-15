<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>비밀번호 찾기</title>
</head>
<body>
	<div>
		<h1>비밀번호 찾기</h1>
	</div>
	
	<form action="email_check" method="post" autocomplete="off">
		
		<div>
			<input name="memEmail" placeholder="이메일">
		</div>
	
		<div>
			<button type="submit">다음</button>
		</div>

		<div>
			<c:if test="${param.error !=null}">
				<h2>일치하는 계정이 없습니다.</h2>
			</c:if>	
		</div>		
	</form>
	
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">



</script>
</body>	
</html>