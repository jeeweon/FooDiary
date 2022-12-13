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
	<div>비밀번호 변경을 하려면 비밀번호 확인이 필요합니다</div>
	
	<form action="check_pw" method="post">
		<div>
			<input name="beforePw" type="password" placeholder="현재 비밀번호">
		</div>
		<div>
			<c:if test="${param.error !=null}">
				비밀번호가 일치하지 않습니다.
			</c:if>				
		</div>
		<div>
			<button>확인</button>
		</div>
		<div>
	
		</div>
	</form>
	
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">



</script>
</body>	
</html>