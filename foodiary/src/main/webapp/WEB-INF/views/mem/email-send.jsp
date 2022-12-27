<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>비밀번호 찾기</title>
	
	<link rel="stylesheet" type="text/css"
    href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/email-send.css"> <!--css 불러오는 링크-->
	
</head>
<body>

<div class="wrapper">
        <div class="PWfind2">
            <div class="inner">
                <div class="PWlog">
                    <a href="${pageContext.request.contextPath}/home"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="홈으로"></a>
                </div> <!--PWlog-->
                <div class="PWT">
                    <fieldset>
                        <legend>
                            <form action="email_send" class="email-form" method="post">
								<div class="m1">
								<i class="fa-solid fa-magnifying-glass"></i>	계정에 연결된 다음 정보가 확인 되었습니다.
								</div>
								<div class="m2">
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
							    
							    <div class="email-check-btn"></div>
							    
							    <div>
							    	<button class="next-btn">다음</button>
							    </div>
							</form>
                        </legend>
                    </fieldset>
                </div> <!--PWT-->
            </div> <!--inner-->
        </div> <!--PWfind2-->
    </div> <!--wrapper-->


<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
$(function(){
	
	//본인 인증 확인
	var judge = {
			memEmailValid : false,
	};

	//인증번호 5분 타이머 세팅
	function startTimer(duration, display){
		var timer = duration, minutes, seconds;
		var interval = setInterval(function(){
			minutes = parseInt(timer/60,10)
			seconds = parseInt(timer%60,10);
			
			minutes = minutes < 10 ? "0" + minutes : minutes;
			seconds = seconds < 10 ? "0" + seconds : seconds;
			
			display.textContent = "인증번호 유효시간 : " + minutes + ":" + seconds;
			if(--timer<0){
				timer = duration;
			}
			if(timer ==0){
				clearInterval(interval);
				display.textContent = "인증번호 입력 시간이 만료되었습니다.";
			}
		},1000);
	}
	
	
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
				var div2= $("<div>");
				var span= $("<span>");
				var input = $("<input>").addClass("serial input").attr("placeholder","인증번호");
				var successMessage = $("#success-message");
				var failMessage = $("#fail-message");
				var button = $("<button>").attr("type","button").text("인증번호 확인");
				var ment = $("<p>").text("이메일을 확인해보세요!")
				var ment2 =$("<p>").text("인증번호를 입력 후 비밀번호를 재설정할 수 있습니다.")
				
				//인증번호 input,button 생성
				$(".email-check").html(div);	
				div.append(ment).append(ment2).append(input);
				$(".email-check-btn").html(div2);
				div2.append(button).append(span);		
				span.text("인증번호 유효시간 : 05:00").addClass("timer");
				button.addClass("serial-btn");
				
				//인증번호 5분 타이머
				var minutes = 5;
				var fiveMinutes = (60*minutes) - 1,
					display = document.querySelector('.timer');
				startTimer(fiveMinutes,display);
				
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
								$(".next-btn").css("display","block");
					            ment.remove();
					            ment2.remove();
					            $(".timer").remove();
							}
					        else {
					            $(".serial").removeClass("success fail").addClass("input fail");
					            $(".serial").after(failMessage);
					        }
						}
					});
				});
				}
			});
		});
	
	$(".email-form").submit(function(e){
		e.preventDefault();
		
		if(!judge.memEmailValid) return alert('이메일 인증을 완료해주세요');

		if(judge.memEmailValid){
			this.submit();			
		}
		
	});
});
</script>
</body>
</html>