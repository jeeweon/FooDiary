<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<html>
<head>
<title>관리자::이메일 발송</title>
</head>
<body>
<h1>공지 이메일 발송</h1>
<form action="send-mail" method="post" autocomplete="off">
	<div>
		<input name="subject" placeholder="제목">	
	</div>
	<div>
		<textarea name="content" placeholder="내용" cols="100" rows="30" style="resize:none;"></textarea>
	</div>
	<div>
		<button>이메일 발송</button>
	</div>
</form>

</body>
</html>