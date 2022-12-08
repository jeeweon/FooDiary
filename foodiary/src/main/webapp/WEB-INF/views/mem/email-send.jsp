<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>비밀번호 찾기</title>
<style>
   .success-message,
   .fail-message,
   .wait-message { 
           display: none;
        }
   #success-message,
   #fail-message { 
           display: none;
        }
   .input.success ~ #success-message{
   		display : block;
   }
   .input.fail ~ #fail-message{
   		display : block;
   }
</style>
</head>
<body>
<form action="email_send" class="email-form" method="post">
	<div>
		계정에 연결된 다음 정보가 확인 되었습니다.
	</div>
	<div>
		이메일 : ${param.memEmail}
	<input class="input" name="memEmail" hidden="true" value="${param.memEmail}">
	</div>
	<div>
		<button type="submit" class="send-btn">인증번호 보내기</button>
		<div class="wait-message">인증번호 전송중</div>
	</div>
	
    <div class="email-check">
	    <div id="success-message">인증번호가 확인되었습니다.</div>
	    <div id="fail-message">인증번호가 확인되지 않았습니다.</div>
    </div>	
    
    <div>
    	<button>다음</button>
    </div>
</form>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
$(function(){
	
	//본인 인증 확인
	var judge = {
			memEmailValid : false,
	};
	
	
	$(".send-btn").click(function(){
			var email = $("input[name=memEmail]").val();

			var btn =$(this);
			btn.prop("disabled",true);
			
			var waitMessage=$(".wait-message");
			waitMessage.css("display","block");
			
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/mem/email_check1",
				method: "post",
				data : {who:email},
				success : function(){
					btn.prop("disabled",false);
				
				waitMessage.css("display","none");	
				var div = $("<div>");
				var input = $("<input>").addClass("serial input").attr("placeholder","인증번호");
				var successMessage = $("#success-message");
				var failMessage = $("#fail-message");
				var button = $("<button>").attr("type","button").text("인증번호 확인");
				var ment = $("<p>").text("이메일을 확인해보세요!")
				var ment2 =$("<p>").text("인증번호를 입력 후 비밀번호를 재설정할 수 있습니다.")
								
				button.click(function(){
					var serial = input.val(); //변수 input의 value 값 
					if(serial.length !=6) 
					return  $(".serial").addClass("fail").after(failMessage);
					
					$.ajax({
						url : "${pageContext.request.contextPath}/rest/mem/email_check2",
						method : "post",
						data : {
							who : email, //바깥에 있는 email
							serial : serial //지금 불러온 serial
						},
						success:function(resp){
							judge.memEmailValid = resp;
							
							if(resp) {
								$(".serial").removeClass("success fail").addClass("input success");
								$(".serial").after(successMessage);
								button.prop("hidden",true);
								btn.prop("hidden",true);
							}
					        else {
					            $(".serial").removeClass("success fail").addClass("input fail");
					            $(".serial").after(failMessage);
					        }
						}
					});
				});
				
				$(".email-check").html(div);		
				div.append(ment).append(ment2).append(input).append(button);
				}
			});
		});
	
	$(".email-form").submit(function(e){
		e.preventDefault();
		
		if(!judge.memEmailValid) return alert('이메일 인증을 완료해주세요'); //모달로 바꾸기(?)

		if(judge.memEmailValid){
			this.submit();			
		}
		
	});
});
</script>
</body>
</html>