<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/profilepage/yourprofile.jsp">
	<jsp:param value="유저 프로필" name="title"/>
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
  object-fit:cover;
  width: 100%; height: 100%;
  background-color: rgba(0,0,0,0.7);

  position: absolute; /* 이미지와 겹치게 처리 */
  top: 0; left: 0;

  color: #fff; text-align: center;
  line-height: 260px;

  opacity: 0; /* 처음엔 안보이고 */
 
  transition: 0.3s;
}

.feedimg a:hover figcaption, .feedimg a:focus figcaption{
  /* 마우스를 올리면 보이게 처리 */
  opacity: 1;
}
.img-size{
	width :250px;
	height :250px;
}
.relative { 
 	width: 250px;
 	height: 250px;
 	position: relative;
 	}
.absolute {
	width: 50px; 
 	height: 50px;
 	position: absolute;
 	left: 200px;
 	top: 200px;
 	background-color:gray;
 	opacity: 0.5;
 	text-align: center;
 	color:white;
 	font-size:35px;
	 	}
	object-fit:cover; 
</style> 

<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>
	$(function(){
		reviewList();
		
		let reviewList1 = [];
		//내가 작성한 모든 리뷰 
		function reviewList() {
		$.ajax({
			url : "${pageContext.request.contextPath}/rest/profile/yourreviewlist?memNo="+${memNo},
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
			if(reviewList1.length != 0 && reviewList1[0].reviewNo != 0){
			$.each(reviewList1, function(index, value) {
				if(value.reviewReportCnt>=5){
				}else{
				if(value.imgCnt>1){
				 //var imgP=$("<p>").text("+"+(value.imgCnt-1));
				var moreIc=$("<p>").html("<i class='fa-solid fa-plus fa-xs'></i>"+(value.imgCnt-1));
				moreIc.addClass("absolute"); 
				
				var reviewImg = $("<img>").attr("src","${pageContext.request.contextPath}/attach/downloadReviewAttach/"+value.reviewNo);
				reviewImg.addClass("relactive");
				var imgDiv=$("<div>").append(reviewImg).append(moreIc);
				imgDiv.addClass("relative");
				
				$(reviewImg).hover(function(){
					$(this).addClass("feedimg");
					
				});
				
				
				var figure=$("<figure>").html(imgDiv);
				//var figcaption=$("<figcaption>").text("좋아요"+value.likeCnt+"사진갯수"+value.imgCnt+"댓글갯수"+value.replyCnt);
				var span2=$("<span>").text("   "+value.likeCnt+" ");
				var iheart=$("<i>").append(span2);
				iheart.addClass("fa-solid fa-heart");
				
				var span3=$("<span>").text("   "+value.replyCnt+" ");
				var imessage=$("<i>").append(span3);
				
				var span4=$("<span>").text(" ");
				
				imessage.addClass("fa-solid fa-message");
				var figcaption=$("<figcaption>").append(iheart).append(span4).append(imessage);
				var feeda = $("<a>").attr("data-rno", value.reviewNo).append(figure).append(figcaption);
				feeda.addClass("review-main");
				reviewImg.addClass("img-size");
				
				
				//var feedli=$("<li>").html(figure).append(figcaption);
				
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
				};
				};
				
				
				
				var main=$(".feed").append(feedul);//.append(figcaption);
				});
			}else{
				var noReview = $("<div>").append("<span class='no-review'>작성한 리뷰가 없습니다.</span>");
				$(".feed").append(noReview);
			}
			
	};		
	//이미지~텍스트 영역 클릭 시, 리뷰 상세로 이동
	$(document).on("click", ".review-main", function(){
		window.location = "${pageContext.request.contextPath}/review/detail?reviewNo="+$(this).data("rno");
	});
});
</script>

<section class="section1">
		<div class="feed">
		</div>
</section>

