<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>문의하기</title>
	
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/inquiry.css"> <!--css 불러오는 링크-->

</head>
<body>
	<div class="wrapper">
        <div class="inquiry">
            <div class="inner">
                <div class="inquiryH">
                    <h1>[문의하기]</h1>
                    <a href="/search/review"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="홈으로"></a>
                </div> <!--inauiryH-->
                <div class="inquiryB">
                    <fieldset>
                        <legend>
                            <form action="inquiry" method="post">
								<div>
									<textarea name="text" style="resize:none;" rows="30" cols="100"></textarea>
								</div>
								<div>
									<button>등록</button>
								</div>
							</form>
                        </legend>
                    </fieldset>
                </div>
            </div> <!--inner-->          
        </div> <!--inquiry-->
    </div> <!--wrapper-->
	
	
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">



</script>
</body>	
</html>