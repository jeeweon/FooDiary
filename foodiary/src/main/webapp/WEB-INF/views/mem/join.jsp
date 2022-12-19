<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
    <title>회원가입</title>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>

    <!--lightpick 사용을 위한 CDN 추가-->
    <link rel="stylesheet" type="text/css" href="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/css/lightpick.css">
    <script src="https://cdn.jsdelivr.net/npm/moment@2.29.4/moment.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/lightpick@1.6.2/lightpick.min.js"></script>

<style>
   .success-message,
   .fail-message,
   .NNNNN-message,
   .NNNNY-message,
   .wait-message { 
           display: none;
        }
   .input.success ~ .success-message{
   		display : block;
   }	
   .input.fail ~ .fail-message {
            display: block;
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
   .input.NNNNY ~ .success-message{
   		display : block;
   }	   
   .input.NNNNN ~ .NNNNN-message{
   		display : block;
   }
   .input.NNNNN ~ .success-message{
   		display : none;
   }
	           
</style>
</head>
<body>
	
    

	<div>
		<h1>회원가입</h1>
	</div>

<form action="join" class="join-form" method="post" autocomplete="off">
	<div>
		<label>
			이메일
			<i class="fa-solid fa-asterisk"></i>
		</label>
		<input type="text" class="input" name="memEmail" placeholder="사용 가능한 이메일을 입력해주세요">
        <div class="success-message">사용 가능한 이메일입니다. 인증번호를 전송해주세요.</div>
        <div class="fail-message">올바르지 않은 이메일 형식입니다.</div>
        <div class="NNNNN-message">이미 사용중인 이메일입니다.</div>
		<div><button class="send-btn" type="button" disabled>인증번호 보내기</button></div>
		<div class="wait-message">인증번호 전송중</div>
	</div>
	
        <div class="email-check">
	        <div id="success-message">인증번호가 확인되었습니다.</div>
	     	<div id="fail-message">인증번호가 확인되지 않았습니다.</div>
        </div>
        <div class="email-check-btn"></div>

	
	<div>
		<label>
			비밀번호
			<i class="fa-solid fa-asterisk"></i>
		</label>
		<input type="password" class="input" name="memPw" placeholder="비밀번호">
        <div class="success-message">사용 가능한 비밀번호입니다.</div>
        <div class="fail-message">비밀번호는 숫자, 영문 소문자, 특수문자를 반드시 1개 이상 포함하여 8~16자로 작성해주세요.</div>		
	</div>
	
	<div>
		<label>
			비밀번호 확인
			<i class="fa-solid fa-asterisk"></i>
		</label>
		<input type="password" class="input" id="pw-re" placeholder="비밀번호 확인">
		<div class="success-message">비밀번호가 일치합니다.</div>
        <div class="fail-message">비밀번호가 일치하지 않습니다.</div>		
	</div>
	
	<div>
		<label>
			닉네임
			<i class="fa-solid fa-asterisk"></i>
		</label>
		<input type="text" class="input" name="memNick" placeholder="닉네임" >
		<div class="success-message">사용 가능한 닉네임입니다.</div>
        <div class="fail-message">닉네임은 한글과 숫자를 이용하여 2~10글자로 작성해주세요.</div>
        <div class="NNNNN-message">이미 사용중인 닉네임입니다.</div>		
	</div>
	
	<div>
		<label>
			생일
			<i class="fa-solid fa-asterisk"></i>
		</label>		
		<input type="text" class="input single-date-picker" name="memBirth" id="memBirth" placeholder="생년월일">
		<div class="birth">만 14세 이상만 가입이 가능하며 생년월일은 수정이 불가능하오니 정확한 정보를 입력해주세요.</div>
        <div class="fail-message">생년월일을 선택해주세요.</div>
	</div>
	
	<div>
		<button type="submit" id="form-button">가입하기</button>
	</div>		
</form>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

$(function(){
	
	//본인 인증 확인
	var judge = {
			memEmailValid : false,
	};
	
	//input 상태객체
	var validChecker = {
			memEmailValid : false, memEmailRegex : /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/,
			memPwValid : false, memPwRegex : /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[a-zA-Z0-9!@#$]{8,16}$/,
			memPwReValid : false,
			memNickValid : false, memNickRegex : /^[가-힣0-9]{2,10}$/,
			memBirthValid : false, memBirthRegex : /([0-9]{2}(0[1-9]|1[0-2])(0[1-9]|[1,2][0-9]|3[0,1]))/,
			
			isAllValid : function(){
				return this.memEmailValid
					&& this.memPwValid
					&& this.memPwReValid
					&& this.memNickValid
					&& this.memBirthValid
			}
	};
	
	//name이 있는 창들 블러 이벤트-> 정규표현식 검사
	$("[name]").blur(function(){
		var name = $(this).attr("name");
		var value = $(this).val();
		var regex = validChecker[name+"Regex"];
		if(regex.test(value)) {
			validChecker[name+"Valid"] = true;
			$(this).removeClass("success fail").addClass("success");
		}
        else {
            validChecker[name+"Valid"] = false;
            $(this).removeClass("success fail").addClass("fail");
        }
		
	});
	
	//이메일 input창 검사(정규표현식 검사->이메일 중복 검사)
	$("input[name=memEmail]").blur(function(){
		var memEmail = $(this).val();
		$(this).removeClass("success fail NNNNN NNNNY");
		
		if(validChecker.memEmailValid){//정규표현식 검사 성공 -> 이메일 중복 검사
			var that = this;//this 보관
			
			$.ajax({//이메일 중복 검사
				url:"${pageContext.request.contextPath}/rest/mem/email",
				method:"post",
				data:{
					memEmail:memEmail
				},
				success:function(resp){
					if(resp=="NNNNN"){//이메일 중복이면 인증번호 보내기 버튼 잠금상태
						$(that).addClass("NNNNN");
						validChecker.memEmailValid = false;	
						$(this).removeClass("success fail").addClass("NNNNN");
						$(".send-btn").prop("disabled",true);
					}
					else if(resp="NNNNY"){
						$(that).addClass("NNNNY");
						validChecker.memEmailValid = true;
						$(this).removeClass("success fail").addClass("success");
						$(".send-btn").prop("disabled",false);
					}
				},
				error:function(){}
			});
		}
		else{//정규표현식 검사에서 실패시 인증번호 보내기 버튼 잠금상태
			$(this).addClass("fail");
			validChecker.memEmailValid = false;
			$(".send-btn").prop("disabled",true);
		}
		
		
	});
	
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
	
	//인증번호 보내기 버튼 클릭 시 -> 이메일 발송
	$(".send-btn").click(function(){
		var email = $("[name=memEmail]").val();
		if(email.length==0) return;
		
		var btn =$(this);
		btn.prop("disabled",true);
		
		var waitMessage=$(".wait-message"); //인증번호 전송중 메세지
		waitMessage.css("display","block");
		
		$.ajax({//이메일 전송
			url : "${pageContext.request.contextPath}/rest/mem/email_check1",
			method: "post",
			data : {who:email},
			success : function(){
				btn.prop("disabled",false);
			
			waitMessage.css("display","none");	
			
			//이메일 전송 시 인증번호 창 생김
			var div = $("<div>");
			var div2= $("<div>");
			var div3= $("<div>");
			var span= $("<span>");
			var input = $("<input>").addClass("serial input").attr("placeholder","인증번호");
			var successMessage = $("#success-message");
			var failMessage = $("#fail-message");
			var button = $("<button>").attr("type","button").text("인증번호 확인");
			
			//인증번호 input,button 생성
			$(".email-check").html(div);	
			div.append(input);
			$(".email-check-btn").html(div2);
			div2.append(button);
			div3.append(span);
			span.text("인증번호 유효시간 : 05:00").addClass("timer");
			
			//인증번호 5분 타이머
			var minutes = 5;
			var fiveMinutes = (60*minutes) - 1,
				display = document.querySelector('.timer');
			startTimer(fiveMinutes,display);
				
				//인증번호 확인 클릭시
				button.click(function(){
					var serial = input.val(); //변수 input의 value 값 
					if(serial.length !=6) 
					return  $(".serial").addClass("fail").after(failMessage);//6자리 아니면 리턴
					
					$.ajax({//인증번호 검사
						url : "${pageContext.request.contextPath}/rest/mem/email_check2",
						method : "post",
						data : {
							who : email, //바깥에 있는 email
							serial : serial //지금 불러온 serial
						},
						success:function(resp){
							judge.memEmailValid = resp; //검사 성공 시 이메일인증 상태 true
							
							if(resp) {//성공 시 이메일 인증버튼, 인증번호 보내기 버튼 잠금처리 
								$(".serial").removeClass("success fail").addClass("input success");
								$(".serial").after(successMessage);
								button.prop("disabled",true);
								btn.prop("disabled",true);
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
	
	$("input[name=memNick]").blur(function(){
		var memNick = $(this).val();
		$(this).removeClass("fail NNNNN NNNNY");
		$(this).removeClass("success fail")
		
		if(validChecker.memNickValid){
			var that = this;//this 보관
			
			$.ajax({
				url:"${pageContext.request.contextPath}/rest/mem/nick",
				method:"post",
				data:{
					memNick:memNick
				},
				success:function(resp){
					if(resp=="NNNNN"){
						$(that).addClass("NNNNN");
						validChecker.memNickValid = false;	
						$(this).removeClass("success fail").addClass("success");
					}
					else if(resp="NNNNY"){
						$(that).addClass("NNNNY");
						validChecker.memNickValid = true;
						$(this).removeClass("success fail").addClass("fail");
					}
				},
				error:function(){}
			});
		}
		else{
			$(this).addClass("fail");
			validChecker.memNickValid = false;	
		}
	});
	
	$("input[name=memPw]").blur(function(){
		var pw = $(this).val();
		$(this).removeClass("fail success");
		
		if(validChecker.memPwValid){
			$(this).addClass("success");
			pwReValid = true;
		}
		else{
			$(this).addClass("fail");
			pwReValid = false;
		}
	});
	
	$("#pw-re").blur(function(){
		var origin = $("input[name=memPw]").val();
		var repeat = $(this).val();
		$(this).removeClass("success fail");
		if(origin==repeat){
			validChecker.memPwReValid = true;
			$(this).addClass("success");
		}
		else{
			validChecker.memPwReValid = false;
			$(this).addClass("fail");
		}
		
	});
	
	var moment = new Date();//오늘 날짜
	var year = moment.getFullYear()-14; //만 14세 이상만 가입가능
	
	function limit(){
		var yyyy = year
		var mm = moment.getMonth()+1;
		var dd = moment.getDate();
		return yyyy+'-'+mm+'-'+dd;
	}

	var picker = new Lightpick({
		field : document.querySelector(".single-date-picker"),
		format : "YYYY-MM-DD",
		maxDate : limit(),
		numberOfMonths:2,
		startDate : limit()
	});
	
	
	$("input[name=memBirth]").blur(function(){
		var memBirth = $(this).val();
		$(this).removeClass("success fail");
		if(memBirth.length>0){
			validChecker.memBirthValid = true;
		}
		else{
			validChecker.memBirthValid = false;
			$(this).addClass("fail");
		}
	});
	
	
	
	$(".join-form").submit(function(e){
		e.preventDefault();
		
		if(!judge.memEmailValid) return alert('이메일 인증을 완료해주세요'); //모달로 바꾸기(?)
		$(this).find("input, textarea, select").blur();

		if(validChecker.isAllValid()&&judge.memEmailValid){
			this.submit();			
		}
		
	});
});

</script>
</body>	
</html>
