<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
<jsp:include page="/WEB-INF/views/profilepage/my-profile-header.jsp">
	<jsp:param value="주문내역페이지" name="title"/>
</jsp:include> 

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>	
<script>
	$(function(){
		reviewList();
		
		let reviewList1 = [];
		//내가 작성한 모든 리뷰 
		function reviewList() {
		$.ajax({
			url : "${pageContext.request.contextPath}/rest/profile/bookmarklist",
			method : "get",
			dataType : "json",
			success : function(resp) {
				reviewList1 = resp;
				console.log(reviewList1);
				console.log(reviewList1[0].replyCnt);
				renderList();
			}
		});
	};
	
	//리뷰 목록 출력
	function renderList(){
			if(reviewList1.length != 0){
			$.each(reviewList1, function(index, value) {
				
				
				var reviewImg = $("<img>").attr("src","${pageContext.request.contextPath}/attach/downloadReviewAttach/"+value.reviewNo);
				$(reviewImg).hover(function(){
					$(this).addClass("feedimg");
					console.log("호버 완료");
				})
				
				
				var span2=$("<span>").text("   "+value.likeCnt+" ");
				var iheart=$("<i>").append(span2);
				iheart.addClass("fa-solid fa-heart");
				
				var span3=$("<span>").text("   "+value.replyCnt+" ");
				var imessage=$("<i>").append(span3);
				imessage.addClass("fa-solid fa-message");
				
				var span4=$("<span>").text(" ");
				
				var figure=$("<figure>").html(reviewImg);
				//var figcaption=$("<figcaption>").text("좋아요"+value.likeCnt+"사진갯수"+value.imgCnt+"댓글갯수"+value.replyCnt);
				var figcaption=$("<figcaption>").append(iheart).append(span4).append(imessage);
				var feeda = $("<a>").attr("data-rno", value.reviewNo).append(figure).append(figcaption);
				feeda.addClass("review-main");
				reviewImg.addClass("img-size");
				
				
				//var feedli=$("<li>").html(figure).append(figcaption);
				
				var feedli=$("<li>").append(feeda);
				var feedimg=$("<div>").html(feedli);
				feedimg.addClass("feedimg");
				var feedul=$("<ui>").html(feedimg);
				
				//좋아요 사진갯수 댓글갯수
				
				 
				
				//리뷰이미지 다운로드 이미지가 없으면 작성한 리뷰가 없습니다.
				//var reviewImg = $("<img>").attr("src","${pageContext.request.contextPath}/attach/downloadReviewAttach/"+value.reviewNo);
				//좋아요 갯수, 이미지 갯수, 리뷰 갯수 
				//var imgCnt=$("<span>").text("이미지 갯수"+value.imgCnt);
				//var replyCnt=$("<span>").text("댓글 갯수"+value.replyCnt);
				//var likeCnt=$("<span>").text("좋아요 갯수"+value.likeCnt);
				//var cnt=$("<div>").append(replyCnt).append(imgCnt).append(likeCnt);
				
				var main=$(".feed").append(feedul);//.append(figcaption);
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