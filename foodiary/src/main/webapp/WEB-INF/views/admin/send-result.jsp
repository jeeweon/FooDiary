<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<jsp:include page="/WEB-INF/views/admin/admin_header.jsp">
	<jsp:param value="공지 이메일 발송 완료" name="title" />
</jsp:include>
</head>
<style>
.container {
	width: 600px;
	margin: 0 auto;
	display: flex;
	flex-direction: column;
  	justify-content : center;
}

.title {
	text-align: center;
	margin: 50px auto 20px auto;
}
</style>
<body>
	<div class="container">
		<div class="title">
			<h2>공지 이메일 발송</h2>
		</div>
	<div class="row center">
		<p>이메일 발송이 완료되었습니다.</p>
	</div>
	<div class="row center mt-50">
		<a href="${pageContext.request.contextPath}/" style="text-decoration: none; color:black;"> 홈으로 <i class="fa-solid fa-house"></i></a>
	</div>
</div>
</body>
</html>