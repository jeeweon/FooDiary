<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>비밀번호 변경</title>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
<style>
   .success-message,
   .fail-message 
   		{ 
           display: none;
        }
   .input.success ~ .success-message{
   		display : block;
   }	
   .input.fail ~ .fail-message {
            display: block;
        }
</style>
</head>
<body>
	<div>
		<h1>비밀번호 변경</h1>
	</div>
	<form action="edit_pw" method="post" class="pw-form">
		<div>
			<input name="memNo" value="${memNo}" hidden="true">
		</div>
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
		<button>비밀번호 변경</button>
		
		<div>
			<c:if test="${param.error !=null}">
				<h2>비밀번호 재설정에 실패하였습니다.</h2>
			</c:if>	
		</div>		
	</form>
	
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">
$(function(){
	//input 상태객체
	var validChecker = {
			memPwValid : false, memPwRegex : /^(?=.*[a-z])(?=.*[0-9])(?=.*[!@#$])[a-zA-Z0-9!@#$]{8,16}$/,
			memPwReValid : false,

			isAllValid : function(){
				return this.memPwValid
					&& this.memPwReValid
			}
	};
	
	//비밀번호창 블러 이벤트-> 정규표현식 검사
	$("input[name=memPw]").blur(function(){
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
	
	$(".pw-form").submit(function(e){
		e.preventDefault();

		$(this).find("input, textarea, select").blur();

		if(validChecker.isAllValid()){
			this.submit();			
		}
	});
});


</script>
</body>	
</html>