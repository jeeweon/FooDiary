<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>문의메일</title>
	
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
<style>

</style>
</head>
<body>
	<div>
		<h1>[문의 메일]</h1>
	</div>
	
	<form action="inquiry" method="post" class="">
		<div>
			<textarea name="text" style="resize:none;" rows="30" cols="100"></textarea>
		</div>
		<div>
			<button>메일 전송</button>
		</div>
	</form>
	
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">



</script>
</body>	
</html>