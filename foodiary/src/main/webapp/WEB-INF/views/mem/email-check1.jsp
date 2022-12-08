<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
	<div>
		<h1>회원가입 이메일 인증</h1>
	</div>

<form action="join" class="email-form" method="get" autocomplete="off">
	<div>
		<input type="text" name="email" placeholder="?">
		<label>
			이메일
			<i class="fa-solid fa-asterisk"></i>
		</label>
	</div>
	<div>
		<button class="send-btn" type="button">인증번호 보내기</button>
	</div>
		<div class="valid-feedback">올바른 이메일 형식입니다</div>
        <div class="invalid-feedback">영문 소문자로 시작하고 숫자가 포함된 8~20자로 작성하세요</div>
        <div class="email-check"></div>
	<div>
       <button type="submit">다음 단계</button>
	</div>
</form>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

	$(function(){
		var judge = {
				emailValid : false,
		};
		
		//이메일 발송
		$(".send-btn").click(function(){
			var email = $("[name=email]").val();
			if(email.length==0) return;
			
			var btn =$(this);
			btn.prop("disabled",true);
			
			$.ajax({
				url : "${pageContext.request.contextPath}/mem/email_check2",
				method: "post",
				data : {who:email},
				success : function(){
					btn.prop("disabled",false);
					
				var div = $("<div>");
				var input = $("<input>");
				var button = $("<button>").attr("type","button").text("인증번호 확인")
				
				button.click(function(){
					var serial = input.val(); //변수 input의 value 값 
					if(serial.length !=6) return;
					
					$.ajax({
						url : "${pageContext.request.contextPath}/mem/email_check3",
						method : "post",
						data : {
							who : email, //바깥에 있는 email
							serial : serial //지금 불러온 serial
						},
						success:function(resp){
							judge.emailValid = resp;
							btn.prop("disabled",true);
						}
					});
				});
				
				div.append(input).append(button);
				$(".email-check").html(div);		
				}
			});
		});
		
		$(".email-form").submit(function(){
			this.submit();
		});
	});

</script>
