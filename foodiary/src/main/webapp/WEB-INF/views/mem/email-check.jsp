<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>비밀번호 찾기</title>
	
	<link rel="stylesheet" type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/email-check.css"> <!--css 불러오는 링크-->
    
	
</head>
<body>
	<div class="wrapper">
        <div class="PWfind">
            <div class="inner">
                <div class="PWlog">
                    <a href="${pageContext.request.contextPath}/home"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="홈으로"></a>
                    <h1>비밀번호 찾기</h1>
                </div> <!--PWFlog-->
                <div class="PWT">
                    <fieldset>
                        <legend>
                            <form action="email_check" method="post" autocomplete="off">
                                <div>
                                	<input name="memEmail" placeholder="이메일">
                                </div>
                                <div>
                                	<button type="submit">다음</button>                                
                                </div>
                                <div>
									<c:if test="${param.error !=null}">
										<h3>일치하는 계정이 없습니다.</h3>
									</c:if>	
								</div>		
                            </form>
                        </legend>
                    </fieldset>
                </div> <!--PWT-->
            </div> <!--inner-->
        </div> <!--PWfind-->
    </div> <!--wrapper-->
		
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">



</script>
</body>	
</html>