<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>문의하기</title>
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
                    <a href="/home"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="로고"></a> <!--홈으로-->
                </div> <!--Mhead-->
                <duv class="Mbody">
                    <p>문의내용 전송이 완료되었습니다 <i class="fa-solid fa-envelope"></i></p> 
                    <p>빠른 시일내로 로그인하신 계정의 이메일로 답변드리겠습니다. </p>
                    <a href="${pageContext.request.contextPath}/home"><button>홈으로 이동</button></a>
                </duv> <!--Mbody-->
            </div> <!--inner-->
        </div> <!--Mplus-->
    </div> <!--wrapper-->
</body>
</html>