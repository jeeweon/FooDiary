<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>맛집 탐색</title>

<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/review-search.css"> <!--css 불러오는 링크--> 
<!-- toast 스타일 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" /> 
<style>
.receipt{
	background-image: url("${pageContext.request.contextPath}/images/슬롯머신.jpg");
}

</style>
</head>
<body>

<c:set var="login" value="${loginNo != null}"></c:set>

 <div class="wrapper">
        <div class="inner">
            <header class="header">
                <div class="header1">
                    <h1><a href="/search/review" class="logo"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="로고/홈으로"></a></h1>
                    <div class="sidemenu">
                    <c:if test = "${login}">
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
	                </c:if>
                    <ul id="mainicon">
                    	<c:if test = "${login}">
	                    <li><img src="${pageContext.request.contextPath}/images/홈아이콘.png"><a href="${pageContext.request.contextPath}/home">홈</a></li>
	                    </c:if>
	                    <li><img src="${pageContext.request.contextPath}/images/맛집 탐색.png"><a href="${pageContext.request.contextPath}/search/review">맛집 탐색</a></li>
	                    <li><img src="${pageContext.request.contextPath}/images/맛쟁이 탐색.png"><a href="${pageContext.request.contextPath}/search/mem">맛쟁이 탐색</a></li>
	                    <c:if test = "${login}">
	                    <li><img src="${pageContext.request.contextPath}/images/알림아이콘.png"><a href="${pageContext.request.contextPath}/mem/noti">알림</a></li>
	                    </c:if>
	                </ul>            
                    </div> <!--sidemenu-->
                     <c:if test = "${login}">
                    <a href="${pageContext.request.contextPath}/review/write" class="review">리뷰하기</a>
	                <div class="btnW">
	                    <a href="${pageContext.request.contextPath}/mem/logout" class="logout"><img src="${pageContext.request.contextPath}/images/임시2.png" id="logoutimg"> 로그아웃</a>
	                </div>
	                </c:if>
                </div> <!--header1-->
                <div class="header2">
                    <div class="formdiv">                      
                        <form action="" class="search-form">
                            <fieldset>
                                <legend class="search-bar">                         
                                    <input type="text" name="keyword" class="search-input" placeholder="지역, 장소, 메뉴 검색" autocomplete="off">
            						<button type="submit" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button>                             
                                </legend>
                            </fieldset>
                        </form>
                    </div> <!--//formdiv-->
                </div> <!--header2-->
            </header> <!--header-->
            <div class="sideW">
                <div class="feed">
                    <!-- 리뷰 목록 -->
    				<div class="review-list"></div>
                </div> <!--feed-->
                </div> <!--sideW-->
                <div class="sidebar">
                    <div class="random">
                    <div class="container">
                        <div class="receipt">
                          <div class="title_text">
                            <h1>오늘 뭐 먹 지 ?</h1>
                            <h3>일단골라.</h3>
                          </div> <!--title_text-->
                          <div class="menu_print">
                            <h2></h2>
                          </div> <!--menu_print-->
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
                              </ul> <!--slide_box-->
                            </div> <!--slot_container-->
                          </div> <!--menu_slot-->
                          <div class="btn_area">
                            <button onclick="lunchIs()">멈춰!</button>
                            <button onclick="reset()">추천해줘!</button>
                          </div> <!--btn_area-->
                        </div> <!--receipt-->          
                    </div> <!--container-->
                    	<c:if test = "${login}">
                         <div class="follow">                        	
		                   <h3>오늘의 맛쟁이 추천 <i class="fa-solid fa-user-group"></i></h3>
		                    <ul class="follow-ul">
		                    </ul>
		                    <!-- <p id="follow1">이용약관 개인정보처리방침 쿠키정책</p> -->                            
                         </div> <!--follow-->
                         </c:if>
                     </div> <!--random-->
                 </div> <!--sidebar-->
            <c:if test = "${!login}">
            <div class="rowbar">
                <form action="">
                    <fieldset>
                        <legend>
                            "로그인하여 내 주변 맛집 리뷰를 확인하고 회원님이 좋아할 만한 계정을 찾아보세요."
                            <button  id="btn-row"><a href="${pageContext.request.contextPath}/mem/login">로그인</a></button>
                            <button id="btn-row2"><a href="${pageContext.request.contextPath}/mem/join">회원가입</a></button>
                        </legend>
                    </fieldset>
                </form>  
            </div> <!--rowbar-->
            </c:if>
        </div><!--//inner-->
        <div class="footer"></div>
    </div> <!--wrapper-->

<!-- jquery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script src="${pageContext.request.contextPath}/js/commons.js"></script>
<!-- sockjs 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<!-- toast 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<!-- moment 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>
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
		//세션에서 회원 번호 가져오기
		var memNo = "<%=(Integer)session.getAttribute("loginNo")%>";
		var memNick = "<%=(String)session.getAttribute("loginNick")%>";
        if(memNo == "null"){
        	loadReviewForGuest();
        } else {
        	loadReviewForMem();
        	//웹소켓 연결
        	connectWs();
        }

      //웹소켓
    	function connectWs(){
    		console.log("tttttt")
    		var uri = "${pageContext.request.contextPath}/ws/sockjs";
    		socket = new SockJS(uri);
    	
    		socket.onopen = function() {
    			console.log('open');
    		};
    		
    		toastr.options = {
    		  "closeButton": false,
    		  "debug": false,
    		  "newestOnTop": false,
    		  "progressBar": false,
    		  "positionClass": "toast-top-right",
    		  "preventDuplicates": false,
    		  "onclick": null,
    		  "showDuration": "100",
    		  "hideDuration": "2000",
    		  "timeOut": "1500",
    		  "extendedTimeOut": "1000",
    		  "showEasing": "swing",
    		  "hideEasing": "linear",
    		  "showMethod": "fadeIn",
    		  "hideMethod": "fadeOut"
    		}
    		
    		socket.onmessage = function(e){
    			//수신된 e.data는 JSON 문자열
    			var data = JSON.parse(e.data);
    			toastr.info(data.notiContent);
    		};

    		socket.onclose = function() {
    		    console.log('close');
    	 	};
    	};
        
		let reviewList = [];
		//이번주 인기 리뷰 목록 조회(비회원)
		function loadReviewForGuest() {
			$(".review-list").empty();
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/search/review/guest",
				method : "get",
				dataType : "json",
				success : function(resp) {
					reviewList = resp;
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
					url : "${pageContext.request.contextPath}/rest/search/review/guest/"+ keyword,
					method : "get",
					dataType : "json",
					contentType:"application/json",
				    data:JSON.stringify(keyword),
					success : function(resp) {
						reviewList = resp;
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
						renderList();
					}
				});
			}
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
					
					var today = moment().format('yyyy-MM-dd');
					var origin = value.reviewWriteTime;
					var reviewDate = moment(origin).format('yyyy-MM-dd');
					
					var writeTime;
					if(reviewDate == today) {
						writeTime = $("<span>").html(moment(origin).format('HH:mm'));
					} else {
						writeTime = $("<span>").html(moment(origin).format('yyyy-MM-DD'));
					}
					
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
					likeIc.attr("data-writer-no", value.memNo);
					likeIc.attr("data-writer-nick", value.memNick);
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
				var receiverMemNo = $(this).data("writer-no");
				var receiverMemNick = $(this).data("writer-nick");
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
	                		//알림 생성 & 전송
	                		var notiData = {
	                				callerMemNo:memNo,
	                				receiverMemNo:receiverMemNo,
	                				receiverMemNick:receiverMemNick,
	                				notiContent:memNick+"님에게 회원님의 리뷰가 도움됐어요 🧡",
	                				notiType:"like",
	                				notiUrl:"${pageContext.request.contextPath}/review/detail?reviewNo="+no,
	                				notiCreateDate:moment(),
	                				memNick:memNick
	                		};
	                		if(memNo != receiverMemNo) {
		                		socket.send(JSON.stringify(notiData));	                			
	                		}
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
			var clickMemNo = $(this).data("mno");
			if(clickMemNo == memNo) {
				window.location = "${pageContext.request.contextPath}/profilepage/my-profile-header";
			} else {
				window.location = "${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+$(this).data("mno");				
			}
		});
		
		//사이드바 프로필 영역 클릭 시, 마이 프로필로 이동
		$(document).on("click", "#sideP", function(){
			window.location = "${pageContext.request.contextPath}/profilepage/my-profile-header";
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

