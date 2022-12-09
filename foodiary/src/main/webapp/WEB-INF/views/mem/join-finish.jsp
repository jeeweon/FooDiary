<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/join-finish.css"> <!--css불러오는 링크-->

<script src="http://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript"></script>
</head>
<body>
	<div class="wrapper">
        <div class="Mplus">
            <div class="inner">
                <div class="Mhead">
                    <a href=""><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="로고"></a> <!--홈으로-->
                </div> <!--Mhead-->
                <duv class="Mbody">
                    <p>회원가입이 완료되었습니다</p>
                    <p>로그인 후 더 다양한 맛집을 탐색해보세요!!</p>
                    <button><a href="login">로그인 화면으로 이동</a></button>
                </duv> <!--Mbody-->
            </div> <!--inner-->
        </div> <!--Mplus-->
    </div> <!--wrapper-->
</body>
</html>