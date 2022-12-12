<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>홈</title>

<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

<style>
.container {
	width: 600px;
	margin: 0 auto;
}

.set-area-banner.hide {
	display: none;
}

.set-area-banner {
	width: 100%;
	border: 1px solid #18253D;
	border-radius: 6px;
	color: #18253D;
	position: relative;
	margin-top: 30px;
	cursor: pointer;
}

.banner-title {
	display: block;
}

.exp1 {
	font-size: 14px;
	margin: 10px;
}

.exp2 {
	font-size: 16px;
	font-weight: bold;
	margin: 10px;
}

.ic-go {
	position: absolute;
	padding: 0.5em;
	top: 10%;
	right: 0;
}

.home-title {
	margin-top: 30px;
	color: #18253D;
	font-size: 20px;
	font-weight: bold;
}

.title-nickname {
	color: #E27C5E;
}

.filter-btn {
	position: relative;
	top: 20px;
	display: flex;
	flex-wrap: wrap;
	justify-content: flex-start;
	align-items: center;
}

.label {
	border: none;
	width: auto;
	height: 30px;
	font-weight: bold;
	border-radius: 4px;
	font-size: 16px;
	padding: 0.5em 1em;
	margin: 10px;
	margin-left: 0;
	background-color: #FBE9DD;
	color: #E27C5E;
	text-align: center;
	display: inline-block;
	line-height: 30px;
	vertical-align: middle;
	cursor: pointer;
}

.label-selected {
	background-color: #E27C5E;
	color: white;
}

.writer-avatar {
	width: 50px;
	height: 50px;
}

.thumbnail {
	width: 100px;
	height: 100px;
}

.like-ic {
	cursor: pointer;
}
</style>
</head>
<body>
<!-- 임시 로그인 메뉴 -->
<c:set var="login" value="${loginNo != null}"></c:set>
<c:choose>
	<c:when test="${login}">
		<a href="mem/logout">로그아웃</a>
	</c:when>
	<c:otherwise>
		<a href="mem/login">로그인</a>	
	</c:otherwise>
</c:choose>

<div class="container">
	<div class="home-title">
		<span class="title-nickname">${loginNick}</span><span>님을 위한 리뷰 피드</span>
	</div>

	<!-- 관심지역 설정 유도 배너 -->
	<div class="set-area-banner hide">
	</div>

	<!-- 리뷰 필터 버튼 -->
	<div class="filter-btn">
        <span class="label label-all">전체</span>
        <span class="label label-follow">팔로우</span>
        <!-- 관심지역이 있으면 지역 버튼 노출 -->
    </div>
    
    <!-- 리뷰 목록 -->
    <div class="review-list">
    </div>
    
</div>
<!-- jquery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>
	$(function() {
		loadInterestArea();
		loadReviewAll();

		$(".label-all").addClass("label-selected");

		//뒤로가기로 돌아왔을 때, 필터 설정 초기화를 위해 새로고침
		$(window).bind("pageshow", function(event) {
			if (event.originalEvent.persisted || (window.performance && window.performance.navigation.type == 2)) {
				location.href = location.href;
			}
		});

		//관심지역 설정 화면으로 이동(배너, 설정 버튼)
		$(document).on("click", ".set-area-banner", function() {
			window.location = "${pageContext.request.contextPath}/home/area/interest";
		});

		$(document).on("click", ".set-area-btn", function() {
			window.location = "${pageContext.request.contextPath}/home/area/interest";
		});

		//관심지역 목록 조회
		let interestList = [];
		function loadInterestArea() {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/area/interest",
				method : "get",
				dataType : "json",
				success : function(resp) {
					interestList = resp;
					showInterestArea();
				}
			});
		};

		//관심지역 목록 출력
		function showInterestArea() {
			if (interestList.length != 0) {
				$.each(interestList, function(index, value) {
					var span = $("<span>").text(value.areaDistrict)
					.attr("data-address", value.areaCity + " " + value.areaDistrict);
					span.addClass("label label-area");
					$(".filter-btn").append(span); //내 관심지역 목록을 filter-btn 영역에 추가
				});
				var btn = $("<span>").html("<i class='fa-solid fa-gear'></i>" + " 설정");
				btn.addClass("label set-area-btn");
				$(".filter-btn").append(btn); //설정 버튼을 filter-btn 영역에 추가
			} else {
				$(".set-area-banner").removeClass("hide");
				var exp1 = $("<span>").text("관심지역을 추가하면 최신 리뷰를 모아보기 쉬워져요.");
				var exp2 = $("<span>").text("내 관심지역 고르러 가볼까요?");
				exp1.addClass("banner-title exp1");
				exp2.addClass("banner-title exp2");

				var btnGo = $("<span>").html("<i class='fa-solid fa-circle-chevron-right'></i>");
				btnGo.addClass("ic-go exp2");

				$(".set-area-banner").append(exp1).append(exp2).append(btnGo);
			}
		};
	
		let reviewList = [];
		//리뷰 전체 목록 조회
		function loadReviewAll() {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/home/review",
				method : "get",
				dataType : "json",
				success : function(resp) {
					reviewList = resp;
					console.log(reviewList);
					renderList();
				}
			});
		};

		//클릭한 필터 버튼 활성화 표시
		$(document).on("click", ".label", function() {
			$(".label").removeClass("label-selected");
			$(this).addClass("label-selected");
		});
		
		//전체 버튼 클릭 시, 리뷰 목록 조회
		$(document).on("click", ".label-all", function() {
			$(".review-list").empty();
			loadReviewAll();
		});
		
		//클릭한 관심지역 리뷰 목록 조회
		$(document).on("click", ".label-area", function() {
			$(".review-list").empty();
			let interestArea = $(this).data("address");
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/home/review/"+ interestArea,
				method : "get",
				dataType : "json",
				success : function(resp) {
					reviewList = resp;
					console.log(reviewList);
					renderList();
				}
			});
		});

		//내 팔로워 리뷰 목록 조회
		$(document).on("click", ".label-follow", function() {
			$(".review-list").empty();
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/home/review/follow",
				method : "get",
				dataType : "json",
				success : function(resp) {
					reviewList = resp;
					console.log(reviewList);
					renderList();
				}
			});
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
					
					var infoDiv = $("<div>").append(writerAvatar).append(writerNick).append(reviewCnt).append(writeTime);
					infoDiv.addClass("review-write-info");
					
					var thumbnail = $("<img>").attr("src", "${pageContext.request.contextPath}/attach/downloadReviewAttach/"+value.reviewNo);
					thumbnail.addClass("thumbnail");
					
					var moreIc;
					var moreCnt;
					var imgMore;
					if(value.imgCnt > 1) {
						moreIc = $("<span>").html("<i class='fa-solid fa-plus'></i>");
						moreCnt = $("<span>").text(value.imgCnt-1);
						imgMore = $("<div>").append(moreIc).append(moreCnt);
						imgMore.addClass("img-more");
					}
					
					var address;
					if(value.reviewPlace != null) {
						address = $("<span>").text(value.reviewPlace);
						address.addClass("address");
					}
					
					var content;
					if(value.reviewContent != null) {
						content = $("<span>").text(value.reivewContent);
						content.addClass("content"); //text-overflow: ellipsis 옵션 설정 필요						
					}
					
					var mainDiv = $("<div>").append(thumbnail).append(imgMore).append(address).append(content);
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
					
					var likeIc = $("<span>").html("<i class='fa-regular fa-heart'></i>")
						.attr("data-rno", value.reviewNo);; //내가 좋아요 눌렀는지 확인 필요
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
					
					var bookmarkIc = $("<span>").html("<i class='fa-regular fa-bookmark'></i>")
						.attr("data-rno", value.reviewNo); //내가 북마크 눌렀는지 확인 필요
					bookmarkIc.addClass("bookmark-ic");
					
					var actionDiv = $("<div>").append(scoreDiv).append(likeDiv).append(replyDiv).append(bookmarkIc);
					actionDiv.addClass("review-action");
					$(".review-list").append(infoDiv).append(mainDiv).append(actionDiv);
				});
			} else {
				$(".review-list").append("<span class='no-review'>최근 올라온 리뷰가 없습니다.</span>");
			}
		};
		
		//좋아요 버튼 클릭 이벤트 -> 아이콘 활성화 여부 적용 필요
		$(document).on("click", ".like-ic", function() {
			var clickedHeart = $(this);
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/review/like",
                method : "post",
			    data : {
	        	   reviewNo:$(this).data("rno")
	           	},
                success : function(resp) {
                	clickedHeart.next().text("도움됐어요"+ " " +resp);    
                }
			});
		});
		
		//북마크 버튼 클릭 이벤트 -> 수정 필요(현재 동작 안함) 
		$(document).on("click", ".bookmark-ic", function() {
			var reviewNo = $(this).data("rno");
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/review/like",
                method : "post",
			    data : {
	        	   reviewNo:reviewNo
	           	},
                success : function(resp) {
                	if(resp) {
                		$(this).html("<i class='fa-solid fa-bookmark'></i>")
                			.attr("data-rno", reviewNo);
                	} else {
                		$(this).html("<i class='fa-regular fa-bookmark'></i>")
                			.attr("data-rno", reviewNo);
                	}   
                }
			});
		});
	});
</script>
</body>
</html>

