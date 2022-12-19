<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>푸디어리::홈</title>

<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/home.css"> <!--css 불러오는 링크--> 
 
 <style>
 	.receipt{
 		background-image: url("${pageContext.request.contextPath}/images/슬롯머신.jpg");
 	}

 	
 	.level-img {
 		width:24px;
 		margin:0;
 		margin-left: 5px;
 	}
 	
 	.nick-lev {
 		display: flex;
 		align-items:center;
 	}
 	
 	.thumbnail {
 		object-fit:cover;
 	}
 	
 	#sideP {
 		cursor: pointer;
 	}

 	.origin{
		width:50px;
		hight:50px;
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

 <div class="wrapper">
    <div class="inner">
        <header class="header">
            <div class="header1">
                <h1><a href="/home" class="logo"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="로고/홈으로"></a></h1>
                <div class="sidemenu">
                <ul id="sideP">
                    <li>
                    	<c:choose>
							<c:when test="${empty profile}">
								<img id="img1" src="${pageContext.request.contextPath}/images/basic-profile.png">
							</c:when>
							<c:otherwise>
							<c:forEach var="profile" items="${profile}">
									<img id="img1" src="${pageContext.request.contextPath}/attach/download/${profile.attachNo}">
							</c:forEach>
							</c:otherwise>		
						</c:choose>
                        ${loginNick}
                        <c:choose>
                        	<c:when test="${level.memLevel == '6  '}">
                        		<img class="level-img" src="${pageContext.request.contextPath}/images/6.피잣집.png">
							</c:when>
                        	<c:when test="${level.memLevel == '5  '}">
                        		<img class="level-img" src="${pageContext.request.contextPath}/images/5.피자콜라.png">
							</c:when>
                        	<c:when test="${level.memLevel == '4  '}">
                        		<img class="level-img" src="${pageContext.request.contextPath}/images/4.조각피자.png">
							</c:when>
                        	<c:when test="${level.memLevel == '3  '}">
                        		<img class="level-img" src="${pageContext.request.contextPath}/images/3.반죽.png">
							</c:when>
                        	<c:when test="${level.memLevel == '2  '}">
                        		<img class="level-img" src="${pageContext.request.contextPath}/images/2.밀가루.png">
							</c:when>
                        	<c:otherwise>
                        		<img class="level-img" src="${pageContext.request.contextPath}/images/1.밀.png">
                        	</c:otherwise>
                        </c:choose>
                    </li>
                </ul>
                <ul id="mainicon">
                    <li><img src="${pageContext.request.contextPath}/images/홈아이콘.png"><a href="/home">홈</a></li>
                    <li><img src="${pageContext.request.contextPath}/images/맛집 탐색.png"><a href="/search/review">맛집 탐색</a></li>
                    <li><img src="${pageContext.request.contextPath}/images/맛쟁이 탐색.png"><a href="/search/mem">맛쟁이 탐색</a></li>
                    <li><img src="${pageContext.request.contextPath}/images/알림아이콘.png"><a href="#">알림</a></li>
                    <li><img src="${pageContext.request.contextPath}/images/북마크아이콘.png"><a href="#">북마크</a></li>
                </ul>
                </div> <!--sidemenu-->
                <a href="#" class="review">리뷰하기</a>
                <div class="btnW">
                    <a href="mem/logout" class="logout"><img src="${pageContext.request.contextPath}/images/임시2.png" id="logoutimg"> 로그아웃</a>
                    <span><a href="#" class="morebtn">더보기버튼</a></span>
                </div>
            </div> <!--header1-->              
            <div class="header3">
                <div class="home-title">

                    <ul class="title-nickname">                 
                        <li id="nickname1">${loginNick}</li>님을 위한 리뷰 피드                                             
                    </ul> <!--title-nickname-->
                </div> <!--home-title-->
            
                <!-- 관심지역 설정 유도 배너 -->
                <div class="set-area-banner hide">
                </div>
            
                <!-- 리뷰 필터 버튼 -->
                <div class="filter-btn">
                    <ul>
                        <li class="label label-all">전체</li>
                        <li class="label label-follow">팔로우</li>
                    </ul>
                    <!-- 관심지역이 있으면 지역 버튼 노출 -->
                </div> <!--filter-btn-->         
            </div> <!--header3-->
        </header> <!--header-->
     	<div class="sideW">
     		<div class="feed">
       		<!-- 리뷰 목록 -->
          	<div class="review-list"></div>                         
     		</div> <!-- feed -->
     	</div> <!-- sideW -->      		
        <div class="sidebar">
            <div class="random">
            <div class="container">
                <div class="receipt">
                  <div class="title_text">
                    <h1>Today~</h1>
                    <h3>뭐 먹지?</h3>
                  </div>
                  <div class="menu_print">
                    <h2></h2>
                  </div>
                  <div class="menu_slot">
                    <div class="slot_container">
                      <ul class="slide_box">
                        <li>카레</li>
                        <li>우동</li>
                        <li>햄버거</li>
                        <li>냉면</li>
                        <li>삼겹살</li>
                        <li>쌈밥</li>
                        <li>감자탕</li>
                        <li>칼국수</li>
                        <li>짜장면</li>
                        <li>국밥</li>
                      </ul>
                    </div>
                  </div>
                  <div class="btn_area">
                    <button onclick="lunchIs()">멈 춰 !</button>
                    <button onclick="reset()">한번 더</button>
                  </div>
                </div>          
            </div>
                 <div class="follow">
                    <h3>오늘의 맛쟁이 추천</h3>
                     <ul class="follow-ul">
                     </ul>
                     <!-- <p id="follow1">이용약관 개인정보처리방침 쿠키정책</p> -->
                 </div> <!--follow-->
             </div> <!--random-->
         </div> <!--sidebar-->
    </div><!--//inner-->
</div> <!--wrapper--> 


<!-- jquery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script src="${pageContext.request.contextPath}/js/commons.js"></script>
<script>

//런치리스트 배열생성
let lunchList = ["카레", "우동", "햄버거", "냉면", "삼겹살","쌈밥","감자탕","칼국수","짜장면","국밥"]

//배열복사
let firstLunchList = [];

lunchList.forEach(function(item) {
  firstLunchList.push(item);
});


//제어할 요소선택 후 변수에 담기
let displaySlot = document.querySelector(".menu_slot"); //menu slot
let elem = document.querySelector(".menu_print > h2"); //menu print
let costTxt = document.querySelector("em"); //cost

displaySlot.style.display = "none";
let lunckPick = shuffle(lunchList)[0];        
elem.innerHTML = lunckPick;
elem.style.display = "block";



//reset check
let resetNum = 1;

//shuffle 메소드 선언
function shuffle(a) {
  for (let i = a.length - 1; i > 0; i--) {
    const j = Math.floor(Math.random() * (i + 1));
    [a[i], a[j]] = [a[j], a[i]];
  }
  return a;
}

//LunchIs 함수선언
function lunchIs() {
  //setTimeout 선언
  setTimeout(timeFunc, 900);

  function timeFunc() {
  

    //슬롯애니메이션 감추기
    displaySlot.style.display = "none";

    //shuffle 메소드를 사용하여 석은 배열에서 index[0]을 가져오기
    console.log(shuffle(lunchList));
    let lunckPick = shuffle(lunchList)[0];

    //메뉴 노출
    console.log(lunckPick);
    elem.innerHTML = lunckPick;


    //reset 되었을 경우에 숨겨진 메뉴를 다시 노출시킴
    if (resetNum == 0) {
      elem.style.display = "block";
    }
  }
}

//reset 함수선언
function reset() {
  //메뉴 숨기기
  elem.style.display = "none";

  //슬롯애니메이션 노출
  displaySlot.style.display = "block";

  //resetNum으로 reset여부를 구분하기 위해 0 할당
  resetNum = 0;
}


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
					renderList();
				}
			});
		});
		
		//리뷰 목록 출력
		function renderList(){
			if(reviewList.length != 0) {
				$.each(reviewList, function(index, value) {
					var writerAvatar;
					if(value.attachNo == 0) {
						writerAvatar = $("<img>").attr("src", "${pageContext.request.contextPath}/images/basic-profile.png");						
					} else {
						writerAvatar = $("<img>").attr("src", "${pageContext.request.contextPath}/attach/download/"+value.attachNo);
					}
					writerAvatar.addClass("writer-avatar");
					
					var writerNick = $("<span>").text(value.memNick);
					writerNick.addClass("writer-nick");
					
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
					
					var reviewCnt = $("<span>").text("리뷰 " + value.memReviewCnt);
					reviewCnt.addClass("review-cnt");
					
					var writeTime = $("<span>").text(value.reviewWriteTime);
					writeTime.addClass("write-time");
					
					var nickLev = $("<div>").append(writerNick).append(writerLevel);
					nickLev.addClass("nick-lev");
					var subInfoText = $("<div>").append(reviewCnt).append(writeTime);
					subInfoText.addClass("sub-info-text");
					var infoText = $("<div>").append(nickLev).append(subInfoText);
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
				var noReviewDiv = $("<div>").append("<span class='no-review'>최근 올라온 리뷰가 없습니다.</span>");
				noReviewDiv.addClass("no-review");
				$(".review-list").append(noReviewDiv);
			}
		};
		
		//좋아요 버튼 클릭 이벤트
		$(document).on("click", ".like-ic", function() {
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
		});
		
		//북마크 버튼 클릭 이벤트
		$(document).on("click", ".bookmark-ic", function() {
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
		});
		
		//이미지~텍스트 영역 클릭 시, 리뷰 상세로 이동
		$(document).on("click", ".review-main", function(){
			window.location = "${pageContext.request.contextPath}/review/detail?reviewNo="+$(this).data("rno");
		});
		
		//프로필 영역 클릭 시, 해당 유저 프로필로 이동
		$(document).on("click", ".review-write-info", function(){
			window.location = "${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+$(this).data("mno");
		});
		
		//사이드바 프로필 영역 클릭 시, 마이 프로필로 이동
		$(document).on("click", "#sideP", function(){
			window.location = "${pageContext.request.contextPath}/profilepage/board";
		});
		
		//맛쟁이 리스트 추천 
		memRek();
		let memRekList = [];
		function memRek() {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/profile/memrek",
				method : "get",
				dataType : "json",
				success : function(resp) {
					memRekList = resp;
					
					// 회원번호가 있으면 팔로우한 사람 제거하고 출력
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
			
// 			console.log(value);
// 			console.log(value.memNo);
			console.log(value.attachNo);
			var memImg=$("<img>").attr("src","");
			var reviewImg = $("<img>").attr("src","${pageContext.request.contextPath}/attach/downloadReviewAttach/"+value.reviewNo);
			var br=$("<br>");
			var name=$("<span>").text(value.memNick);
			var button=$("<button>").attr("data-rno",value.memNo).text("팔로우");
			var a=$("<a>").attr("data-mno",value.memNo).append(memImg).append(name).append(writerLevel);
			var li=$("<li>").append(a).append(button);
			a.click(function(){
				console.log("a클릭");
				window.location = "${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+$(this).data("mno");
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
							console.log(resp);
							if(resp){
								$(that).text("팔로잉");
							}else{
								$(that).text("팔로우");
							}
						}
					});
				});
				memImg.addClass("origin");
				
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
</body>
</html>

