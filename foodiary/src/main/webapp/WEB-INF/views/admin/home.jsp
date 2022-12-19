<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자::홈</title>
<link rel="stylesheet" type="text/css"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
<style>
.title {
	text-align: center;
	margin-top: 100px;
}

.subtitle {
	text-align: center;
	margin-top: 10px;
}

.page {
	text-align: center;
	margin: 0 auto;
	margin-top: 50px;
	width: 600px;
}

.menu-list{
    width: 100%;
    padding: 0;
    font-size: 16px;
    background-color: white;
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
}

.menu-item{
	display: inline-block;
    background-color: #FEF7F2;
    border: none;
    border-radius: 6px;
    font-size: 16px;
    width: 140px;
    height: 50px;
    padding: 0.5em;
    margin: auto;
}

.menu-item span {
    box-sizing: border-box;
    line-height: 50px;
    padding: 0.5em;
    color: #E27C5E;
    font-weight: bold;
}

.logout {
	margin: 100px auto;
	font-size: 16px;
	color: #707070;
}
</style>
</head>
<body>
<h2 class="title">안녕하세요, ${loginId}님</h2>
<h3 class="subtitle">이동할 메뉴를 선택해주세요.</h3>
<div class="page">
	<div class="menu-list">
		<div class="menu-item mem">
			<span>회원 관리</span>		
		</div>
		<div class="menu-item mail">
			<span>이메일 발송</span>		
		</div>
		<div class="menu-item blind">
			<span>블라인드 관리</span>	
		</div>	
	</div>
	
	<div class="logout">
		<span><i class="fa-solid fa-power-off"></i> 로그아웃</span>
	</div>
</div>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>
    $(function(){
    	$(".mem").click(function(){ //회원관리 주소 수정 필요
    		window.location = "${pageContext.request.contextPath}/admin/#";
    	});
    	
    	$(".mail").click(function(){
    		window.location = "${pageContext.request.contextPath}/admin/send-mail";
    	});
    	
    	$(".blind").click(function(){
    		window.location = "${pageContext.request.contextPath}/admin/review-blind";
    	});
    	
    	$(".logout").click(function(){
    		window.location = "${pageContext.request.contextPath}/admin/logout";
    	});
    });
</script>
</body>
</html>