<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/admin/admin_header.jsp">
	<jsp:param value="이메일 상세" name="title" />
</jsp:include>
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
</head>
<body>
<div class="container">
		<div class="title">
			<h2>이메일 상세</h2>
		</div>
<table class="table table-slit w-100">
	<tbody>
	  <tr>
	    <th class="tg-0pky" width="10%">번호</th>
	    <td class="tg-0pky">${emailDto.emailNo}</td>
	    <th class="tg-0pky" width="10%">날짜</th>
	    <td class="tg-0lax">${emailDto.emailWhen}</td>
	  </tr>
	  <tr>
	    <th class="tg-0pky">제목</th>
	    <td class="tg-0lax" colspan="3">${emailDto.emailSubject}</td>
	  </tr>
	  <tr>
	    <th class="tg-0pky" >내용</th>
	    <td class="tg-0pky" colspan="3">${emailDto.emailContent }</td>
	  </tr>
	</tbody>
	</table>
</div>

</body>
</html>