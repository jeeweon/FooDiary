<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>맛집 탐색</title>

<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

<style>
.container {
	width: 600px;
	margin: 0 auto;
}

.search-form {
        margin: 0;
}
    
.search-view{
    width: 400px; 
    margin: 0 auto;
    margin-top: 30px;
}

.search-bar { 
    position: relative;
    width: 100%;
    height: 40px;
    display: inline-block;
    border: 1px solid gray;
    border-radius: 4px;
    font-size: 16px;
}

.search-input {
    padding: 0.5em;
    padding-right: 30px;
    width: 100%;
    height: inherit;
    border: none;
    border-radius: 4px;
    outline: none;
    box-sizing: border-box;
}

.search-btn {
    position: absolute;
    top: 0;
    right: 0;
    width: 30px;
    height: inherit;
    border: none;
    outline: none;
    background-color: transparent;
    cursor: pointer;
}

.review-list {
	width: 600px;
}

.no-review {
	margin-top: 100px;
	text-align: center;
	color: gray;
}

.list-item {
	margin-top: 40px;
}

.review-write-info {
	display: flex;
	flex-direction: row;
    align-items: center;
    margin: 10px 0;
}

.info-text {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
    align-items: flex-start;
    margin-left: 10px;
}

.sub-info-text {
	display: flex;
	flex-direction: row;
	justify-content: flex-start;
	align-itmes: center;
	font-size: 14px;
	color: #707070;
	margin-top: 3px;
}

.writer-avatar {
	width: 50px;
	height: 50px;
}

.writer-nick {
	font-weight: bold;
}

.write-time {
	margin-left: 10px;
}

.place {
	font-weight: bold;
	font-size: 18px;
}

.address {
	color: #707070;
	margin-top: 3px;
}

.loca-div {
	display: flex;
	flex-direction: row;
    align-items: center;
    margin: 10px 0;
}

.loca-info {
	display: flex;
	flex-direction: column;
	justify-content: space-between;
    align-items: flex-start;
    margin-left: 10px;
    padding: 5px;
}

.place {
	font-weight: bold;
	font-size: 18px;
}

.address {
	color: #707070;
}

.img-div {
	position: relative;
	width: 300px;
}

.thumbnail {
	width: 300px;
	height: 300px;
	cursor: pointer;
	margin-top: 10px;
	border-radius: 6px;
}

.img-more {
	position: absolute;
	width: 60px;
	height:60px;
	background-color: rgba(0,0,0,0.5);
	border-radius: 4px;
	color: white;
	bottom:0;
	right:0;
	display: flex;
	justify-content: center;
	align-items: center;
	font-size: 20px;
}

.img-more-none {
	display: none;
}

.more-ic {
	margin-right: 5px;
}

.review-action {
	display: flex;
	flex-direction: row;
    justify-content: space-between;
    align-items: center;
    color: #707070;
    margin-top: 20px;
}

.score-ic {
	color: #FFC107;
	margin-right: 5px;
}

.like-ic {
	cursor: pointer;
	margin-right: 5px;
}

.like-ic > .fa-solid {
	color: #E27C5E;
}

.reply-ic {
	margin-right: 5px;
}

.bookmark-ic {
	margin-left: 350px;
	cursor: pointer;
}

.content p {
	display: inline;
}

.review-main {
	width: 600px;
	white-space: nowrap;
	overflow: hidden;
	word-break: break-all;
	text-overflow: ellipsis;  /* 말줄임 적용 */
}
</style>
</head>
<body>
<!-- 임시 로그인 메뉴 -->
<c:set var="login" value="${loginNo != null}"></c:set>
<c:choose>
	<c:when test="${login}">
		<a href="/mem/logout">로그아웃</a>
	</c:when>
	<c:otherwise>
		<a href="/mem/login">로그인</a>	
	</c:otherwise>
</c:choose>

<div class="container">
	<form class="search-form">
        <div class="search-bar">
            <input type="text" name="keyword" class="search-input" placeholder="지역, 장소, 메뉴 검색" autocomplete="off">
            <button type="submit" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button> 
        </div>  
    </form>

    <!-- 리뷰 목록 -->
    <div class="review-list">
    </div>
    
</div>
<!-- jquery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script src="${pageContext.request.contextPath}/js/commons.js"></script>
<script>
	$(function() {
		 var memNo = "<%=(Integer)session.getAttribute("loginNo")%>";
		 console.log("memNo : " + memNo);
         if(memNo == "null"){
        	 loadReviewForGuest();
         } else {
        	 loadReviewForMem();
         }

		let reviewList = [];
		//이번주 인기 리뷰 목록 조회(비회원)
		function loadReviewForGuest() {
			$(".review-list").empty();
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/search/guest/review",
				method : "get",
				dataType : "json",
				success : function(resp) {
					reviewList = resp;
					console.log(reviewList);
					renderList();
				}
			});
		};
		
		//이번주 인기 리뷰 목록 조회(회원)
		function loadReviewForMem() {
			$(".review-list").empty();
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/search/review",
				method : "get",
				dataType : "json",
				success : function(resp) {
					reviewList = resp;
					console.log(reviewList);
					renderList();
				}
			});
		};
		
		//검색 버튼 클릭 시, 검색어가 포함된 리뷰 조회
		$(".search-form").submit(e=>{
            e.preventDefault();

            const keyword = $("[name=keyword]").val();
            
			$(".review-list").empty();
			if(memNo == "null") { //비회원				
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/search/guest/review/"+ keyword,
					method : "get",
					dataType : "json",
					contentType:"application/json",
				    data:JSON.stringify(keyword),
					success : function(resp) {
						reviewList = resp;
						console.log(reviewList);
						renderList();
					}
				});
			} else { //회원
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/search/review/"+ keyword,
					method : "get",
					dataType : "json",
					contentType:"application/json",
				    data:JSON.stringify(keyword),
					success : function(resp) {
						reviewList = resp;
						console.log(reviewList);
						renderList();
					}
				});
			}
		});
		
		//리뷰 목록 출력
		function renderList(){
			if(reviewList.length != 0) {
				$.each(reviewList, function(index, value) {
					//프로필 이미지 다운로드 기능 구현 후, 주소 변경 예정(프사 있으면 다운로드, 없으면 기본 이미지)
					var writerAvatar = $("<img>").attr("src", "${pageContext.request.contextPath}/images/avatar.png");
					writerAvatar.addClass("writer-avatar");
					
					var writerNick = $("<span>").text(value.memNick);
					writerNick.addClass("writer-nick");
					
					var reviewCnt = $("<span>").text("리뷰 " + value.memReviewCnt);
					reviewCnt.addClass("review-cnt");
					
					var writeTime = $("<span>").text(value.reviewWriteTime);
					writeTime.addClass("write-time");
					
					var subInfoText = $("<div>").append(reviewCnt).append(writeTime);
					subInfoText.addClass("sub-info-text");
					var infoText = $("<div>").append(writerNick).append(subInfoText);
					infoText.addClass("info-text");
					
					var infoDiv = $("<div>").append(writerAvatar).append(infoText)
						.attr("data-mno", value.memNo);
					infoDiv.addClass("review-write-info");
					
					var thumbnail = $("<img>").attr("src", "${pageContext.request.contextPath}/attach/downloadReviewAttach/"+value.reviewNo);
					thumbnail.addClass("thumbnail");
					
					var moreIc = $("<span>").html("<i class='fa-solid fa-plus'></i>");
					moreIc.addClass("more-ic");
					var moreCnt = $("<span>").text(value.imgCnt-1);
					moreCnt.addClass("more-cnt");
					var imgMore = $("<div>").append(moreIc).append(moreCnt);
					if(value.imgCnt > 1) {
						imgMore.addClass("img-more");
					} else {
						imgMore.addClass("img-more-none")
					}
					var imgDiv = $("<div>").append(thumbnail).append(imgMore);
					imgDiv.addClass("img-div");
					
					
					var locationIc;
					if(value.reviewPlace != null || value.reviewAddress != null) {
						locationIc = $("<span>").html("<i class='fa-solid fa-location-dot fa-2x'></i>")
					}
					
					var place;
					if(value.reviewPlace != null) {
						place = $("<span>").text(value.reviewPlace);
						place.addClass("place");
					}
					
					var address;
					if(value.reviewAddress != null) {
						address = $("<span>").text(value.reviewAddress);
						address.addClass("address");
					}
					
					var locaInfoDiv = $("<div>").append(place).append(address);
					var locationDiv = $("<div>").append(locationIc).append(locaInfoDiv);
					locaInfoDiv.addClass("loca-info");
					locationDiv.addClass("loca-div");
					
					var content;
					if(value.reviewContent != null) {
						content = $("<span>").html(value.reviewContent);
						content.addClass("content"); //영역 넘치면 첫 줄에서 말줄임표로 자르기(.review-main)
					}
					
					var mainDiv = $("<div>").append(imgDiv).append(locationDiv).append(content)
						.attr("data-rno", value.reviewNo);
					mainDiv.addClass("review-main");
					
					var scoreIc = $("<span>").html("<i class='fa-solid fa-star'></i>");
					var score;
					if(value.starScore == 0) {
						score = $("<span>").text("-");
					} else {
						score = $("<span>").text(value.starScore);
					}
					scoreIc.addClass("score-ic");
					score.addClass("score");
					
					var scoreDiv = $("<div>").append(scoreIc).append(score); //별점 아이콘, 별점 묶기
					
					var likeIc;					
					if(value.likeCheck) {
						likeIc = $("<span>").html("<i class='fa-solid fa-heart'></i>");
					} else {						
						likeIc = $("<span>").html("<i class='fa-regular fa-heart'></i>");
					}
					likeIc.attr("data-rno", value.reviewNo);
					var likeCnt = $("<span>").text("도움됐어요"+ " " +value.likeCnt);
					likeIc.addClass("like-ic")
					likeCnt.addClass("like-cnt");
					
					var likeDiv = $("<div>").append(likeIc).append(likeCnt); //좋아요 아이콘, 좋아요 수 묶기
					
					var replyIc = $("<span>").html("<i class='fa-regular fa-comment'></i>");
					var replyCnt = $("<span>").text(value.replyCnt);
					replyIc.addClass("reply-ic");
					replyCnt.addClass("reply-cnt");
					
					var replyDiv = $("<div>").append(replyIc).append(replyCnt)
						.attr("data-rno", value.reviewNo); //댓글 아이콘, 댓글 수 묶기
					
					var bookmarkIc;
					if(value.bookmarkCheck) {
						bookmarkIc = $("<span>").html("<i class='fa-solid fa-bookmark'></i>");
					} else {
						bookmarkIc = $("<span>").html("<i class='fa-regular fa-bookmark'></i>")						
					}
					bookmarkIc.attr("data-rno", value.reviewNo);
					bookmarkIc.addClass("bookmark-ic");
					
					var actionDiv = $("<div>").append(scoreDiv).append(likeDiv).append(replyDiv).append(bookmarkIc);
					actionDiv.addClass("review-action");
					
					var itemDiv = $("<div>").append(infoDiv).append(mainDiv).append(actionDiv);
					itemDiv.addClass("list-item");
					$(".review-list").append(itemDiv);
				});
				
			} else {
				var noReviewDiv = $("<div>").append("<span class='no-review'>작성된 리뷰가 없습니다.</span>");
				noReviewDiv.addClass("no-review");
				$(".review-list").append(noReviewDiv);
			}
		};
		
		//좋아요 버튼 클릭 이벤트
		$(document).on("click", ".like-ic", function() {
			if(memNo == "null") {//비회원
				alert("로그인이 필요한 기능입니다."); //모달로 변경 -> 취소, 로그인하러가기				
			} else {//회원
				var clickedHeart = $(this);
				var no = $(this).data("rno");
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/review/like2",
	                method : "post",
				    data : {
		        	   reviewNo:no
		           	},
	                success : function(resp) {
	                	if(resp == 0) {
	                		clickedHeart.find("i").removeClass("fa-solid").addClass("fa-regular");
	                	} else {
	                		clickedHeart.find("i").removeClass("fa-regular").addClass("fa-solid");
	                	}
	                	
	                	$.ajax({
	                		url : "${pageContext.request.contextPath}/rest/review/count",
	    	                method : "post",
	    				    data : {
	    		        	   reviewNo:no
	    		           	},
	    	                success : function(resp) {
			                	clickedHeart.next().text("도움됐어요"+ " " +resp);    	    	                	
	    	                }
	                	});
	                }
				});
			}
		});
		
		//북마크 버튼 클릭 이벤트
		$(document).on("click", ".bookmark-ic", function() {
			if(memNo == "null") {
				alert("로그인이 필요한 기능입니다."); //모달로 변경 -> 취소, 로그인하러가기				
			} else {
				var clickedBm = $(this);
				var reviewNo = $(this).data("rno");
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/review/bookmark",
	                method : "post",
				    data : {
		        	   reviewNo:$(this).data("rno")
		           	},
	                success : function(resp) {
	                	if(resp) {
	                		clickedBm.find("i").addClass("fa-solid").removeClass("fa-regular");
	                	} else {
	                		clickedBm.find("i").addClass("fa-regular").removeClass("fa-solid");
	                	}   
	                }
				});
			}
		});
		
		//이미지~텍스트 영역 클릭 시, 리뷰 상세로 이동
		$(document).on("click", ".review-main", function(){
			window.location = "${pageContext.request.contextPath}/review/detail?reviewNo="+$(this).data("rno");
		});
		
		//프로필 영역 클릭 시, 해당 유저 프로필로 이동
		$(document).on("click", ".review-write-info", function(){
			//회원번호 붙여서 프로필로 이동
		});
	});
</script>
</body>
</html>

