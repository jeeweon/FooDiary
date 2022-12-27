<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/login.css"> <!--css 불러오는 링크-->

<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript"></script>

<style>
	#loginX{
		font-size: 17px;
		color: 9C254D;
		padding-bottom: 20px;
	}
</style>
</head>
<body>
		<div class="wrapper">
		        <div class="Mlogin">
		            <div class="inner">
		                <div class="Lhead">
		                    <a href="${pageContext.request.contextPath}/"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="로고"></a> <!--홈으로-->
		                </div> <!--Lhead-->
		                <div class="Lbody">
		                <form action="login" method="post" autocomplete="off">
	                        <fieldset>
	                            <legend>
	                            	<input type="text" name="memEmail" placeholder="로그인">
	                            	<input type="password" name="memPw" placeholder="비밀번호">
	                            	<button type="submit">로그인</button>
	                            	<div>
										<c:if test="${param.error !=null}">
											<h2 id="loginX">입력한 정보가 올바르지 않습니다.</h2>
										</c:if>	
									</div> <!-- 정보 확인 -->
	                            </legend> <!-- legend -->
	                        </fieldset> <!-- fieldset -->
	                    </form> <!-- form -->		       
		                </div> <!--Lbody-->
		                <div class="Lfoot">
		                    <ul id="Lfootsub">
		                        <li><a href="email_check" id="a1">비밀번호 찾기</a></li>
		                        <li><a href="join" id="a2">회원가입 하기</a></li>
		                    </ul> <!--Lfootsub-->
		                </div> <!--Lfoot-->
		            </div> <!--inner-->
		        </div> <!--Mlogin-->
		    </div> <!--wrapper-->

</body>
</html>


