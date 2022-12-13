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
   .preview{
   		border-radius : 50%;
   		border:1px black solid transparent;
   }
   .preview.preview-hover:hover{
    	opacity : 0.5;
   }
</style>

</head>
<body>
	<div>
		<h1>프로필 수정</h1>
	</div>
	<form action ="edit_profile" method="post" class="edit-form" enctype="multipart/form-data" autocomplete="off">
			<c:choose>
				<c:when test="${empty profile}">
					<img name="basic" class="preview preview-hover" src="${pageContext.request.contextPath}/images/basic-profile.png" width="100" height="100">
				</c:when>
				<c:otherwise>
				<c:forEach var="profile" items="${profile}">
						<img name="origin" class="preview preview-hover" src="${pageContext.request.contextPath}/attach/download/${profile.attachNo}" width="100" height="100">
				</c:forEach>
				</c:otherwise>		
			</c:choose>
			<button class="profile-delete" type="button"><i class="fa-solid fa-x"></i></button>
		<div>
		<div class="file">
		
		</div>
<!-- 			<input type="text" name="attachNo" hidden="true"> -->
			<input type="file" name="profile" class="profile-input" accept=".jpg, .png, .gif" hidden="true" >
		</div>
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
				<textarea class="intro" rows="5" cols="50" name="memIntro" placeholder="자기소개를 입력하세요." style="resize:none;">${memDto.memIntro}</textarea>
				(<span class="text-limit"> </span> / 100)
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
	//사진 클릭시 파일 선택창 클릭
	$(".preview").click(function(){
		$("input[name=profile]").click();
		
	});
	
	$(".profile-input").change(function(){

// 		console.log(this.files);
		if(this.files.length>0){
			$(".preview").attr("src", window.URL.createObjectURL(this.files[0]));
			
	// 서버에 비동기로 파일을 업로드하는 코드를 사용해야 함(ajax를 이용해서 multipart 전송 구현)
    // - 반드시 contentType, processData를 false로 설정해야 한다
    // - FormData 객체를 만들어 전송할 내용을 담아서 data에 설정한다
// 			var fd = new FormData();
// 			fd.append("attach",this.files[0]);

// 			$.ajax({
// 				url: "${pageContext.request.contextPath}/attach/upload",
// 				method : "post",
// 				data : fd,
// 				processData : false,
// 				contentType : false,
// 				success:function(resp){
// 					$(".preview").attr("src", resp).attr("width","200").attr("height","200");
					 
// 					var div= $("<div>");
// 					var input = $("<input>").addClass("file-no");
					 
// 					$(".file").html(div);	
// 					div.append(input);
						 
// 					var check = resp.lastIndexOf("/")//경로에서 /위치 찾기
// 					var attachNo = resp.substr(check+1);
// 					$(".file-no").val(attachNo);
// 				}
// 			});
// 			$(".preview").attr("src", window.URL.createObjectURL(this.files[0]));
		}
		else{
			
// 			$(".preview").attr("src", window.URL.createObjectURL(this.files[0]));
// 			$(".file-no").remove();
		}
	});
	
	//프로필 삭제 버튼(삭제 후엔 기본 이미지로)
	$(".profile-delete").click(function(){
		$.ajax({
			url:"${pageContext.request.contextPath}/rest/mem/profile_delete",
			method:"post",
			data: {memNo:"${sessionScope.loginNo}"},
			success:function(resp){
				$(".preview").attr("src", "${pageContext.request.contextPath}/images/basic-profile.png");
			}
		});
		
	});
	
	//input 상태객체
	var validChecker = {
			memNickValid : false, memNickRegex : /^[가-힣0-9]{2,10}$/,
			memNickTest : false
	};
	
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
		
// 		console.log("정규표현식 성공"+validChecker.memNickValid);
		
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
						validChecker.memNickTest = false;	
						$(this).removeClass("success fail").addClass("success");
// 						console.log("N");
// 						console.log(validChecker.memNickValid);
					}
					else if(resp="NNNNY"){
						$(that).addClass("NNNNY");
						validChecker.memNickTest = true;
						$(this).removeClass("success fail").addClass("fail");
// 						console.log("Y");
// 						console.log(validChecker.memNickValid);
					}
				},
				error:function(){}
			});
		}
		else{
			$(this).addClass("fail");
			validChecker.memNickTest = false;	
		}
	});
	
	//자기소개 
	$(".text-limit").text($(".intro").val().length);//자기소개 
	$(".intro").on("input",function(){		
		var text = $(this).val();
		$(this).next().text(text.length);//바로 뒤 태그 선택
		if(text.length>100){
			$(this).val(text.substring(0,99));
			$(this).next().text(text.length)--;
		}
		
	});

	
	
	$(".edit-form").submit(function(e){
		
		e.preventDefault();

		$(this).find("input, textarea, select").blur();

// 			console.log(validChecker.memNickTest);
		if(validChecker.memNickValid&&validChecker.memNickTest){
			this.submit();			
		}
	});
});



</script>
</body>	
</html>