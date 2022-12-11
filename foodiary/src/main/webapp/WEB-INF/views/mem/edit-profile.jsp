<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>프로필 수정</title>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
<style>
   .success-message,
   .fail-message,
   .NNNNN-message,
   .NNNNY-message { 
           display: none;
        }
   .input.success ~ .success-message{
   		display : block;
   }	
   .input.fail ~ .fail-message {
            display: block;
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
		<h1>프로필 수정</h1>
	</div>

	<form action ="edit_profile" method="post" class="edit-form">
		
		<div>
			<label>
				닉네임
				<i class="fa-solid fa-asterisk"></i>
			</label>
				<input type="text" class="input" name="memNick" value="${memDto.memNick}" placeholder="닉네임">
				<div class="success-message">사용 가능한 닉네임입니다.</div>
		        <div class="fail-message">닉네임은 한글과 숫자를 이용하여 2~10글자로 작성해주세요.</div>
		        <div class="NNNNN-message">이미 사용중인 닉네임입니다.</div>			
		</div>
		<div>
			<label>자기소개</label>
				<textarea rows="8" cols="70" name="memIntro" placeholder="자기소개" style="resize:none;">${memDto.memIntro}</textarea>
		</div>
		<div>
			<button>프로필 수정</button>
		</div>
		
		<div>
			<c:if test="${param.error !=null}">
				<h2>프로필 수정에 실패하였습니다.</h2>
			</c:if>	
		</div>	
	</form>

	
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">

$(function(){
	//input 상태객체
	var validChecker = {
			memNickValid : false, memNickRegex : /^[가-힣0-9]{2,10}$/
	};
	
	//비밀번호창 블러 이벤트-> 정규표현식 검사
	$("input[name=memNick]").blur(function(){
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
	
	$(".edit-form").submit(function(e){
		e.preventDefault();

		$(this).find("input, textarea, select").blur();

		if(validChecker.memNickValid){
			this.submit();			
		}
	});
});



</script>
</body>	
</html>