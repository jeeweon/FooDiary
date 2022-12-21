<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>이용감사</title>
	
	<link rel="stylesheet" type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/goodbye.css"> <!--css 불러오는 링크-->
	
</head>


<body>

<div class="wrapper">
        <div class="goodbye">
            <div class="inner">
                <div class="goodbyeH">
<%--                     <a href="/search/review"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="홈으로"></a> --%>
                    <h2>회원탈퇴가 완료되었습니다.</h2>
                    <h3>그동안 푸디어리를 이용해주셔서 감사합니다.</h3>
                </div> <!--goodbyeH-->
                <div class="goodbyeB">
                    <fieldset>
                        <legend>
                                <a href="${pageContext.request.contextPath}/search/review"><button>메인으로 이동</button></a>
                        </legend>
                    </fieldset>
                </div>
            </div> <!--inner-->
        </div> <!--goodbye-->
    </div> <!--wrapper-->
	
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">



</script>
</body>	
</html>