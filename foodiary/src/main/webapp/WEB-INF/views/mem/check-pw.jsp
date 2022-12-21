<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>비밀번호 확인</title>
	
	<link rel="stylesheet" type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    
    <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
	<script type="text/javascript"></script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/check-pw.css"> <!--css 불러오는 링크-->
	    
</head>
<body>	
	<div class="wrapper">
        <div class="PW">
            <div class="inner">
                <div class="PWchange">
                    <a href="${pageContext.request.contextPath}/home"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="홈으로"></a>
                    <h1>비밀번호 확인</h1>
                    <h3>비밀번호 변경을 하려면 비밀번호 확인이 필요합니다.</h3>
                </div> <!--PWchange-->
                <div class="PWtext">
                <fieldset>
                    <legend>
                        <form action="check_pw" method="post">
                            <input name="beforePw" type="password" placeholder="현재 비밀번호">
                            <div id=pwx>
					<c:if test="${param.error !=null}">
						비밀번호가 일치하지 않습니다.
					</c:if>				
				</div>
				<div>
                            <button>확인</button>
                        	</div>
                        </form>
                    </legend>
                </fieldset>
            </div> <!--PWchange-->
        </div> <!--inner-->
    </div> <!--PW-->
</div> <!--wrapper-->
		
</body>	
</html>