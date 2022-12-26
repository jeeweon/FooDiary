<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/profilepage/my-profile-header.jsp">
	<jsp:param value="좋아요" name="title"/>
</jsp:include> 
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
 	.relative { 
 		width: 350px;
 		height: 350px;
 		position: relative;
 		}
	.absolute {
	 	width: 50px; 
	 	height: 50px;
	 	position: absolute;
	 	left: 300px;
	 	top: 300px;
	 	background-color:gray;
	 	opacity: 0.5;
	 	text-align: center;
	 	font-size:35px;
	 	}
</style>

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>	
<script>
	$(function(){
		reviewList();
		
		let reviewList1 = [];
		//내가 작성한 모든 리뷰 
		function reviewList() {
		$.ajax({
			url : "${pageContext.request.contextPath}/rest/profile/likelist",
			method : "get",
			dataType : "json",
			success : function(resp) {
				reviewList1 = resp;
				renderList();
			}
		});
	};
	
	//리뷰 목록 출력
	function renderList(){
			if(reviewList1.length != 0){
			$.each(reviewList1, function(index, value) {
				
				// 사진갯수가 0 이상이라면 
				if(value.imgCnt>1){
				
				var imgspan=$("<p>").text("+"+(value.imgCnt-1));
				imgspan.addClass("absolute");
				var reviewImg = $("<img>").attr("src","${pageContext.request.contextPath}/attach/downloadReviewAttach/"+value.reviewNo);
				reviewImg.addClass("relative");
				var imgDiv=$("<div>").append(reviewImg).append(imgspan);
				imgDiv.addClass("relative");
				
				$(reviewImg).hover(function(){
					$(this).addClass("feedimg");
				});
				
				var span2=$("<span>").text("   "+value.likeCnt+" ");
				var iheart=$("<i>").append(span2);
				iheart.addClass("fa-solid fa-heart");
				
				var span3=$("<span>").text("   "+value.replyCnt+" ");
				var imessage=$("<i>").append(span3);
				imessage.addClass("fa-solid fa-message");
				
				var span4=$("<span>").text(" ");
				
				var figure=$("<figure>").html(imgDiv);
				var figcaption=$("<figcaption>").append(iheart).append(span4).append(imessage);
				
				var feeda = $("<a>").attr("data-rno", value.reviewNo).append(figure).append(figcaption);
				feeda.addClass("review-main");
				reviewImg.addClass("img-size");
				var feedli=$("<li>").append(feeda);
				var feedimg=$("<div>").html(feedli);
				feedimg.addClass("feedimg");
				var feedul=$("<ui>").html(feedimg);
				}else{
					var reviewImg = $("<img>").attr("src","${pageContext.request.contextPath}/attach/downloadReviewAttach/"+value.reviewNo);
					$(reviewImg).hover(function(){
						$(this).addClass("feedimg");
					});
					
					var span2=$("<span>").text("   "+value.likeCnt+" ");
					var iheart=$("<i>").append(span2);
					iheart.addClass("fa-solid fa-heart");
					
					var span3=$("<span>").text("   "+value.replyCnt+" ");
					var imessage=$("<i>").append(span3);
					imessage.addClass("fa-solid fa-message");
					
					var span4=$("<span>").text(" ");
					
					var figure=$("<figure>").html(reviewImg);
					figure.addClass("relative");
					var figcaption=$("<figcaption>").append(iheart).append(span4).append(imessage);
					
					var feeda = $("<a>").attr("data-rno", value.reviewNo).append(figure).append(figcaption);
					feeda.addClass("review-main");
					reviewImg.addClass("img-size");
					var feedli=$("<li>").append(feeda);
					var feedimg=$("<div>").html(feedli);
					feedimg.addClass("feedimg");
					var feedul=$("<ui>").html(feedimg);
					var main=$(".feed").append(feedul);
				};
				var main=$(".feed").append(feedul);
				});
			}else{
				var noReview = $("<div>").append("<span class='no-review'>작성한 리뷰가 없습니다.</span>");
				$(".main").append(noReview);
			}
	};		
	//이미지~텍스트 영역 클릭 시, 리뷰 상세로 이동
	$(document).on("click", ".review-main", function(){
		window.location = "${pageContext.request.contextPath}/review/detail?reviewNo="+$(this).data("rno");
	});
});
</script>

<section class="section1">
		<div class="feed"></div>
</section>

