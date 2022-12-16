<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
<jsp:include page="/WEB-INF/views/profilepage/my-profile-header.jsp">
	<jsp:param value="주문내역페이지" name="title"/>
</jsp:include> 
<style>
* {
    margin: 0;
    padding: 0;
}

fieldset {
    border: 0;
}

a {
    text-decoration: none;
    color: black;
}

li {
    list-style: none;
}

.inner {
    position: relative;
    width: 1400px;
    margin: 0 auto;
}

.wrapper > div.inner{
    display: flex; 
    gap: 50px;
    justify-content: space-between;
}

.feed{
    display: flex;
    flex-wrap:wrap;
    gap: 20px;
    flex: 1;
    
}

/* .gallery{
  width: 940px; margin: 0 auto;
  overflow: hidden;
}
.gallery h3{
  width: 100%; height: 50px;
  line-height: 50px; text-align: center;
}
.gallery li{
  float: left;
  width: 300px; height: 200px;
  margin-right: 20px;
} */
.feedimg li:last-child{ margin-right: 0; }

.feedimg a{
  display: block; /* 영역적용위해 사용 */
  width: 100%; height: 100%;

  overflow: hidden;

  position: relative; /* absolute의 기본기준은 body로 처리 - 현재 요소로 기준변경 */
}

.feedimg figure{
  width: 100%; height: 100%;
}
.feedimg figcaption{
  width: 100%; height: 100%;
  background-color: rgba(0,0,0,0.7);

  position: absolute; /* 이미지와 겹치게 처리 */
  top: 0; left: 0;

  color: #fff; text-align: center;
  line-height: 300px;

  opacity: 0; /* 처음엔 안보이고 */
 
  transition: 0.3s;
}

.feedimg a:hover figcaption, .feedimg a:focus figcaption{
  /* 마우스를 올리면 보이게 처리 */
  opacity: 1;
}
.img-size{
	width :350px;
	height :350px;
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
			url : "${pageContext.request.contextPath}/rest/profile/reviewlist",
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
				var figure=$("<figure>").html(reviewImg);
				var figcaption=$("<figcaption>").text("좋아요"+value.likeCnt+"사진갯수"+value.imgCnt+"댓글갯수"+value.replyCnt);
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
	<div class="inner">
		<div class="feed">
		</div>
	</div>
</section>

