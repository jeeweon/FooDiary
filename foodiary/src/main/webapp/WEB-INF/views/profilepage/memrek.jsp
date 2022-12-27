<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" type="text/css"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/board.css"> <!--css불러오는 링크-->
<style>
	.orign{
		width:50px;
		hight:50px;
	}
	.level-img {
 		width:24px;
 		margin:0;
 		margin-left: 5px;
 	}
 	#relative{
 		width:300px;
 		height:300px;
 		background-color:green;
 		position:relative;
 		top:100px;
 		left:100px;
 	}
 	#absolute2{
 		width:100px;
 		height:100px;
 		background-color:red;
 		position:absolute;
 		top:200px;
 		left:200px;
 	}
 	.relative { width: 400px; height: 400px; position: relative; background-color: yellow;}
	.absolute { width: 100px; height: 100px; position: absolute; left: 300px; top: 300px; background-color:red;}
 	
			
</style>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>	
<script>
	$(function(){
		memRek();
		let memRekList = [];
		function memRek() {
		$.ajax({
			url : "${pageContext.request.contextPath}/rest/profile/memrek",
			method : "get",
			dataType : "json",
			success : function(resp) {
				memRekList = resp;
				// 회원번호가 있으면 팔로우한 사람제거 하고 출력
					threeMem();
			}
		});
	};
	function threeMem(){
		$.each(memRekList, function(index, value) {
			
			var writerLevel;
			if(value.memLevel == "6  ") { //db에 char(3)으로 넣어서 한 자리인 경우 공백 생김
				writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/6.피잣집.png");
			} else if (value.memLevel == "5  ") {
				writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/5.피자콜라.png");
			} else if (value.memLevel == "4  ") {
				writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/4.조각피자.png");
			} else if (value.memLevel == "3  ") {
				writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/3.반죽.png");
			} else if (value.memLevel == "2  ") {
				writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/2.밀가루.png");
			} else {
				writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/1.밀.png");
			}
			writerLevel.addClass("level-img");
			var memImg=$("<img>").attr("src","");
			var reviewImg = $("<img>").attr("src","${pageContext.request.contextPath}/attach/downloadReviewAttach/"+value.reviewNo);
			var br=$("<br>");
			var name=$("<span>").text(value.memNick);
			var button=$("<button>").attr("data-rno",value.memNo).text("팔로우");
			var a=$("<a>").attr("data-mno",value.memNo).append(memImg).append(name).append(writerLevel);
			var li=$("<li>").append(a).append(button);
			a.click(function(){
				window.location = "${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+$(this).data("mno");
			});
			
			button.click(function(){
				var that=$(this);
				$.ajax({
					url:"${pageContext.request.contextPath}/rest/review/follow",
					method:"post",
					data :{
						 passiveMemNo : $(this).data("rno")	
					},
					success :function(resp){
						if(resp){
							$(that).text("팔로잉");
						}else{
							$(that).text("팔로우");
						}
					}
				});
			});
			memImg.addClass("orign");
			//사진이 있는지 없는지 확인
		   if(value.attachNo > 0){
			   	memImg.attr("src","${pageContext.request.contextPath}/attach/download/"+value.attachNo);
			}else{
				memImg.attr("src","${pageContext.request.contextPath}/images/basic-profile.png");
			} 
			
			$(".follow-ul").append(li);	
		});
	};
});
</script>

<div class="follow">
	<h3>먹는거 좋아하는 사람</h3>
	<ul class="follow-ul">
	</ul>
</div>

<div class="relative">
	<img class="relative"
		src="${pageContext.request.contextPath}/images/6.피잣집.png">
	<p class="absolute">adsfas</p>
</div>