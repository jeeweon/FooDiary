<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<jsp:include page="/WEB-INF/views/admin/admin_header.jsp">
	<jsp:param value="공지 이메일 발송" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/css_admin/blind.css">
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

.input {
    padding: 0.5em;
    padding-right: 30px;
    width: 100%;
    height: inherit;
    border: 1px solid lightGray;
    border-radius: 4px;
    outline: none;
    box-sizing: border-box;
}

</style>
<body>
<div id="dashboard">
	<div class="container">
		<div class="title">
			<h2>공지 이메일 발송</h2>
		</div>
		<form action="send-mail" method="post" autocomplete="off">
			<div>
				<input class="w-100 input" name="subject" placeholder="제목" required="required">	
			</div>
			<div class="mt-10">
				<pre><textarea class="w-100 input" name="content" placeholder="내용" cols="100" rows="30" style="resize:none;" required="required"></textarea></pre>
			</div>
			<div class="row center">
				 <button type="submit" class="send-btn"> 이메일 발송 <i class="fa-solid fa-envelope me-10"></i> </button> 
			</div>
		</form>
	</div>
</div>

</body>
</html>