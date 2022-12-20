<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<html>
<head>
	<title>프로필 수정</title>
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/edit-profile.css"> <!--css 불러오는 링크-->

</head>
<body>
	<div class="wrapper">
	        <div class="profile-change">
	            <div class="inner">
	                <div class="profileH">
	                    <a href="/home"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="홈으로"></a>
	                    <h1>프로필 수정</h1>
	                </div> <!--profileH-->
	                <div class="profileT">
                    <fieldset>
                       <legend>	                           
                           <form action ="edit_profile" method="post" class="edit-form" enctype="multipart/form-data" autocomplete="off">
						<c:choose>
						<c:when test="${empty profile}">
							<img name="basic" class="preview preview-hover" src="${pageContext.request.contextPath}/images/basic-profile.png" >
						</c:when>
						<c:otherwise>
						<c:forEach var="profile" items="${profile}">
								<img name="origin" class="preview preview-hover" src="${pageContext.request.contextPath}/attach/download/${profile.attachNo}" >
						</c:forEach>
						</c:otherwise>		
					</c:choose>
					<button id=btn-top class="profile-delete" type="button"><i class="fa-solid fa-trash"></i> 프로필 초기화</button>
                             <div>
					<div class="file"></div>
						<!--<input type="text" name="attachNo" hidden="true"> -->
						<input type="file" name="profile" class="profile-input" accept=".jpg, .png, .gif" hidden="true" >
					</div>
					<div id=editT>
						<label>
							닉네임
							<i class="fa-solid fa-asterisk"></i>
						</label>
						<input type="text" class="input" name="memNick" value="${memDto.memNick}" placeholder="닉네임">
						<div class="success-message">사용 가능한 닉네임입니다.</div>
				        <div class="fail-message">닉네임은 한글과 숫자를 이용하여 2~10글자로 작성해주세요.</div>
				        <div class="NNNNN-message">이미 사용중인 닉네임입니다.</div>			
					</div>
					<div id=editT>
						<label>자기소개</label>
						<textarea class="intro" rows="5" cols="50" name="memIntro" placeholder="자기소개를 입력하세요." style="resize:none;">${memDto.memIntro}</textarea>
						<span class="text-limit"> </span>
					</div>
					<div id=PT>
					<p>(</p><p>/ 100)</p>
					</div>
					<div id=editT>
						<button id="btn-profile">프로필 수정</button>
					</div>														
					<div>
						<c:if test="${param.error !=null}">
							<h2>프로필 수정에 실패하였습니다.</h2>
						</c:if>	
					</div>	
					</form>					                             
                    </legend>
                </fieldset>
            </div>
        </div>
    </div>
</div>
			
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script type="text/javascript">			

$(function(){
	//사진 클릭시 파일 선택창 클릭
	$(".preview").click(function(){
		$("input[name=profile]").click();
		
	});
		
	//프로필 인풋 창에 변화가 있을 때
	$(".profile-input").change(function(){
		if(this.files.length>0){
			$(".preview").attr("src", window.URL.createObjectURL(this.files[0]));	
		}
		else{
			$(".preview").attr("src", "${pageContext.request.contextPath}/images/basic-profile.png");
		}
	});
	
	//프로필 삭제 버튼(삭제 후엔 기본 이미지로)
	$(".profile-delete").click(function(){
		
		//프로필 이미지를 선택했다가 삭제 버튼 누르면 val값 공란
		$(".profile-input").val("");
		$(".preview").attr("src", "${pageContext.request.contextPath}/images/basic-profile.png");
		
		//원래 프로필 이미지 삭제
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
		
		var nowNick = "${memDto.memNick}"
		
		//지금 닉네임과 다를 때 정규표현식, 중복검사
		if(memNick!=nowNick){
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
		}
		else{
			validChecker.memNickValid = true;
			validChecker.memNickTest = true;
// 			console.log(validChecker.memNickValid);
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