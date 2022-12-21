<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>회원탈퇴</title>
<style>
   .success-message,
   .fail-message { 
           display: none;
        }
   .input.success ~ .success-message{
   		display : block;
   }	
    .input.fail ~ .fail-message { 
            display: block;
        }	
</style>

	
	<link rel="stylesheet" type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/leave.css"> <!--css 불러오는 링크-->
	

</head>
<body>

<div class="wrapper">
        <div class="leave">
            <div class="inner">
                <div class="leaveH">
                    <a href=""><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="홈으로"></a>
                    <h1>회원 탈퇴</h1>
                    <h3>회원 탈퇴를 위해 비밀번호 확인이 필요합니다.</h3>
                </div> <!--leaveH-->
                <div class="leaveB">
                    <fieldset>
                        <legend>
                            <div>
								<input name="memPw" class="input" type="password" placeholder="비밀번호">
								<div class="success-message">비밀번호가 일치합니다.</div>
					        	<div class="fail-message">비밀번호가 확인되지 않습니다.</div>	
							</div>
							<div>
								<button type="button" class="check-pw">비밀번호 확인</button>
							</div>
							<div>
								<c:if test="${param.error !=null}">
									비밀번호가 확인되지 않습니다.
								</c:if>				
							</div>
						<form action="leave" method="post" class="goodbye-form">
							
							<div>	
								<button id="out" class="goodbye"  disabled>회원탈퇴</button>
							</div>
						</form>
                        </legend>
                    </fieldset>
                </div>
            </div> <!--inner-->
        </div> <!--leave-->
    </div> <!--wrapper-->
	
		
	
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
$(function(){
	$(".check-pw").click(function(){
		var memPw = $("input[name=memPw]").val();
		$.ajax({
			url :"${pageContext.request.contextPath}/rest/mem/leave_pw",
			method : "post",
			data : {
				memPw : memPw
			},
			success:function(resp){
				if(resp){
					$(".goodbye").prop("disabled",false);
					$("input[name=memPw]").removeClass("success fail").addClass("success");
				}
				else{
					$(".goodbye").prop("disabled",true);
					$("input[name=memPw]").removeClass("success fail").addClass("fail");
				}
			},
			error : function(){}
		});	
		
	});
	
	$(".goodbye-form").submit(function(e){
		e.preventDefault();
		var result = confirm("정말 회원 탈퇴하시겠습니까?"); 
		if(!result){
			return false;
		}
		else{
			this.submit();
		}
	});
	
});


</script>
</body>	
</html>