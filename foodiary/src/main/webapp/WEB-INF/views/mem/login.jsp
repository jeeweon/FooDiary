<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/login.css"> <!--css 불러오는 링크-->

<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript"></script>
</head>
<body>
		<div class="wrapper">
		        <div class="Mlogin">
		            <div class="inner">
		                <div class="Lhead">
		                    <a href=""><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="로고"></a> <!--홈으로-->
		                </div> <!--Lhead-->
		                <div class="Lbody">
		                    <input type="text" placeholder="이메일">
		                    <input type="text" placeholder="비밀번호">
		                    <button type="submit"><a href="">로그인</a></button>
		                </div> <!--Lbody-->
		                <div class="Lfoot">
		                    <ul id="Lfootsub">
		                        <li><a href="" id="a1">비밀번호 찾기</a></li>
		                        <li><a href="" id="a2">회원가입 하기</a></li>
		                    </ul> <!--Lfootsub-->
		                </div> <!--Lfoot-->
		            </div> <!--inner-->
		        </div> <!--Mlogin-->
		    </div> <!--wrapper-->
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
</html>


