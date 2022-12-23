<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="login" value="${loginId != null}"></c:set>
<html>
<head>
<title>
	<c:choose>
		<c:when test="${param.title != null}">
			${param.title}
		</c:when>
		<c:otherwise>
			FooDiary admin
		</c:otherwise>
	</c:choose>
</title>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/css_admin/commons.css">
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/css_admin/layout.css">
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
<style>
.logo-div {
	text-align: center;
}
.top-logo {
	width: 100px;
}
.active {
	font-weight: bold;
}
</style>
<!-- jquery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>

<!-- moment 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>
</head>
<body>
<aside>
	<div class="row mb-30 logo-div">
		<img class="top-logo" src="${pageContext.request.contextPath}/images/Foodiary-logo.png">
	</div>
	<div class="row center">
		<i class="fa-solid fa-user-lock fa-2x"></i>
		<h3>${loginId}</h3>
	</div>
	<div class="row center mb-30">
		<span class="today"></span>
	</div>
	<%-- <div class="row mem">
		<a href="${pageContext.request.contextPath}/admin/#"><i class="fa-solid fa-user me-10"></i>회원 관리</a> <!-- 주소 수정 필요 -->
	</div> --%>
	<div class="row mail">
		<a href="${pageContext.request.contextPath}/admin/send-mail"><i class="fa-solid fa-envelope me-10"></i>메일 발송</a>
	</div>
	<div class="row sent">
		<a href="${pageContext.request.contextPath}/admin/mail-list"><i class="fa-solid fa-share me-10"></i>보낸 메일함</a>
	</div>
	<div class="row review">
		<a href="${pageContext.request.contextPath}/admin/blind/review"><i class="fa-solid fa-pen-to-square me-10"></i>블라인드 리뷰 관리</a>
	</div>
	<div class="row mb-50 reply">
		<a href="${pageContext.request.contextPath}/admin/blind/reply"><i class="fa-regular fa-comment me-10"></i>블라인드 댓글 관리</a>
	</div>
	<hr>
	<div class="row">
		<a href="${pageContext.request.contextPath}/admin/logout"><i class="fa-solid fa-power-off me-10"></i>로그아웃</a>
	</div>
</aside>
<script type="text/javascript">
	$(function(){
	    var menu = ["mem", "send-mail", "mail-list", "review", "reply"]
	    var url = location.href;
	    var getAr0 = url.indexOf(menu[0]);
	    var getAr1 = url.indexOf(menu[1]);
	    var getAr2 = url.indexOf(menu[2]);
	    var getAr3 = url.indexOf(menu[3]);
	    var getAr4 = url.indexOf(menu[4]);
	    if(getAr0 != -1){
	        $(".mem").addClass("active")
	    };
	    if(getAr1 != -1){
	    	$(".mail").addClass("active")
	    };
	    if(getAr2 != -1){
	    	$(".sent").addClass("active")
	    };
	    if(getAr3 != -1){
	    	$(".review").addClass("active")
	    };
	    if(getAr4 != -1){
	    	$(".reply").addClass("active")
	    };
	});
</script>	
<!-- 본문 
<div id="dashboard">
</div>
</body>
</html>
-->
