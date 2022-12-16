<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>맛집 탐색</title>

<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

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
.sideW {
    display: flex;
    gap: 50px;
    flex: 1;
    justify-content: space-between;
}
.wrapper > div.inner{
    display: flex; 
    gap: 50px;
    justify-content: space-between;
}
.header{
    flex-shrink: 0;
    width: 300px;
    height: 800px;
}
.header1{
    position: fixed;
    top: 50px;
    width: 300px;
    height: 800px;
    box-sizing: border-box;
}
.header1 h1 {
    margin-bottom: 30px;
}
.logo{
    position: relative;
}
.logo img {
    width: 160px;
}
.header2 > div {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.header2{
    position: relative;
    left: 380px;
    top: 160px;
    background-color:#ffffff; 
}
.formdiv{
	position: fixed;
	z-index: 999;
	
}
.sidemenu {
    padding-left: 15px;
    box-sizing: border-box;
    margin-bottom: 150px;
}

.sidemenu #sideP{
    position: relative;
    bottom: 40px;
}
#sideP img{
    position: relative;
    top: 15px;
    width: 50px;
    height: 50px;
    border: 1px solid black;
    border-radius: 50%;
}
#sideP li{
    font-size: 17px;
    font-weight: bold;
}

.sidemenu ul > li > a {
    font-size: 20px;
    color: #000;
    font-weight: bold;
}
.sidemenu ul > li + li{
    margin-top: 15px;
}
.review {
    display: block;
    margin-left: 15px;
    width: 200px;
    height: 40px;
    line-height: 40px;
    color: #fff;
    text-align: center;
    font-size: 16px;
    background: #e27c5e;
    border-radius: 30px;
}
.logout {
    display: flex;
    align-items: center;
    position: absolute;
    bottom: 50px;
    left: 15px;
}
#logoutimg{
    width: 30px;
    position: relative;
}

.sidebar{
    width: 300px;
}
.sidebar .random{
    position: fixed;
    top: 50px;
    width: 300px;
    height: 800px;
    box-sizing: border-box;
}
/* 슬롯머신 */

.slot_container {
    width: 100px;
    height: 50px;
    overflow: hidden;
  }
  
  .menu_slot {
    position: absolute;
    top: 50%;
  }
  
  @keyframes slide {
    0% {
      margin-top: 0;
    }
    10% {
      margin-top: -50px;
    }
    20% {
      margin-top: -100px;
    }
    30% {
      margin-top: -150px;
    }
    40% {
      margin-top: -200px;
    }
    50% {
      margin-top: -250px;
    }
    60% {
      margin-top: -300px;
    }
    70% {
      margin-top: -350px;
    }
    80% {
      margin-top: -400px;
    }
    90% {
      margin-top: -450px;
    }
    100% {
      margin-top: -500px;
    }
  }
  
  .slide_box {
    width: 100px;
    height: 50px * 5;
    animation: slide 1.5s infinite;
    color: black;
  }
  
  .slide_box li {
    width: 100px;
    height: 50px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 20px;
    font-weight: bold;
  }
  
  .container {
    margin: auto 0;
    display: flex;
    justify-content: center;
    align-items: center;
    width: 300px;
    height: 350px;
  }
  
  .receipt {
    width: 100%;
    height: 80%;
    background-image: url("${pageContext.request.contextPath}/images/슬롯머신.jpg");
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    align-items: center;
    padding: 30px;
    position: relative;
  }
  
  .receipt .title_text {
    border-bottom: 1px dashed black;
    width: 100%;
    text-align: center;
  }
  
  .receipt .title_text h1 {
    font-size: 40px;
    margin-bottom: 30px;
  }
  
  .receipt .title_text h3 {
      margin-top: 10px;
      margin-bottom: 15px;
  }
  
  em {
    display: inline-block;
    width: 78px;
    height: 21px;
    text-align: left;
    position: absolute;
    right: 5px;
  }
  
  .menu_print {
    position: absolute;
    top: 55%;
    font-size: 20px;
    color: black;
    transition: 0.5s;
  }
  
  .btn_area {
    position: absolute;
    bottom: 50px;
  }
  
  body:before {
    content: "";
    display: inline-block;
    vertical-align: middle;
  }
  .btn_area button {
    background: gray;
    color: ivory;
    border: none;
    position: relative;
    height: 30px;
    font-size: 1.0em;
    padding: 0 1em;
    cursor: pointer;
    transition: 800ms ease all;
    outline: none;
  }
  .btn_area button:hover {
    background: #fff;
    color: black;
  }
  .btn_area button:before,
  .btn_area button:after {
    content: "";
    position: absolute;
    top: 0;
    right: 0;
    height: 2px;
    width: 0;
    background: black;
    transition: 400ms ease all;
  }
  .btn_area button:after {
    right: inherit;
    top: inherit;
    left: 0;
    bottom: 0;
  }
  .btn_area button:hover:before,
  .btn_area button:hover:after {
    width: 100%;
    transition: 800ms ease all;
  }

/* 슬롯머신 끝 */

.follow h3 {
    font-size: 18px;
    margin-top: 100px;
    margin-bottom: 50px;
    text-align: center;
}
.follow ul li{
    margin-top: 20px;
    margin-bottom: 20px;
    margin-left: 15px;
}
#follow1{
    position: relative;
    border-top: 1px dotted black;
    font-size: 17px;
    text-align: center;
    white-space: normal;
    top: 80px;  
}
.feed{
    flex: 1;
    position: relative;
    top: 400px;
}
.feedtitle{
    padding: 30px;
    box-sizing: border-box;
    width: 100%;
    height: 750px;
    margin-bottom: 40px;
}
.rowbar{
    position: fixed;
    right: 250px;
    bottom: 50px;
    font-size: 23px;
    width: 1400px; height: 80px;
    background-color: #ffe9b1;
    color: #000;
    line-height: 80px;
    text-align: center;
}
.rowbar legend{
    font-weight: lighter;
}
#btn-row{
    border: 1px solid #e27c5e;
    background-color: white;
    border-radius: 10px 10px;
    font-size: 17px;
    padding-top: 4px;
    padding-bottom: 4px;
    margin-left: 50px;
    width: 110px;
}
#btn-row a{
    color: #e27c5e;
}
#btn-row2{
    border: 1px solid #e1e1e1;
    background-color: #e27c5e;
    border-radius: 10px 10px;
    font-size: 17px;
    padding-top: 4px;
    padding-bottom: 4px;
    margin-left: 50px;
    width: 110px;
}
#btn-row2 a{
    color: white;
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
    width: 500px;
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
    cursor: pointer;
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
	border-radius : 50%;
  	border:1px black solid transparent;
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

@media screen and (max-width: 1420px) {
    .inner {
        width: 100%; 
        padding: 0 20px;
        box-sizing: border-box;
    }
}
@media screen and (max-width: 1240px) {
    .wrapper > div.inner {
        display: block;
    }
    .header {
        width: 100%;
        height: 105px;
        margin-bottom: 15px;
    }
    .feed {
        width: 100%;
    }
    .review {
        display: none;
    }
    .header1 {
        position: unset;
        padding: 0 10px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        width: 100%;
        height: 100%;
    }
    .header1 h1 {
        margin-bottom: 0;
    }
    .header3{
        position: unset;
        display: flex;
        flex-direction: row;
        justify-content: center;
        align-items: center;
        width: 100%;
        height: 100%;
    }
    .sidebar .random {
        position: relative;
    }
    .logout {
        position: unset;
    }
    .sidemenu {
        margin-bottom: 0;
        padding-left: 0;
    }
    .sidemenu > ul > li {
        display: inline-block;
    }
    .sidemenu ul > li + li {
        margin-top: 0;
        margin-left: 15px;
    }
    .sidebar {
        width: 200px;
    }
    .sidebar .random {
        width: auto;
    }
    .sideW {
        gap: 20px;
    }
    .rowbar{
        position: relative;
    }
}
@media screen and (max-width: 768px) {
    .inner {
        padding: 0 10px;
    }
    .sidebar {
        display: none;
    }
    .sidemenu {
        display: none;
    }
    .btnW {
        display: flex;
        align-items: center;
    }
    .morebtn{
        position: relative;
        display: block;
        width: 30px;
        height: 20px;
        margin-left: 30px;
    }
    .morebtn::before {
        content: '';
        position: absolute;
        top: 50%;
        left: 0;
        transform: translateY(-50%);
        width: 100%;
        height: 2px;
        background: #000;
    }
    .morebtn::after {
        content: '';
        position: absolute;
        bottom: 0;
        left: 0;
        width: 100%;
        height: 2px;
        background: #000;
    }
    .morebtn span {
        position: absolute;
        top: 0;
        left: 0;
        width: 100%;
        height: 2px;
        background: #000;
        text-indent: -9999px;
        font-size: 0;
        
    }
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

 <div class="wrapper">
        <div class="inner">
            <header class="header">
                <div class="header1">
                    <h1><a href="/search/review" class="logo"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="로고/홈으로"></a></h1>
                    <div class="sidemenu">
                    <ul>
                        <li><a href="#">맛집 탐색</a></li>
                        <li><a href="#">맛쟁이 탐색</a></li>
                    </ul>
                    </div> <!--sidemenu-->
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
                            <h1>Today~</h1>
                            <h3>뭐 먹지?</h3>
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
                            <button onclick="lunchIs()">멈 춰 !</button>
                            <button onclick="reset()">한번 더</button>
                          </div> <!--btn_area-->
                        </div> <!--receipt-->          
                    </div> <!--container-->
                         <div class="follow">
                             <p id="follow1">이용약관 개인정보처리방침 쿠키정책</p>
                         </div> <!--follow-->
                     </div> <!--random-->
                 </div> <!--sidebar-->
            <div class="rowbar">
                <form action="">
                    <fieldset>
                        <legend>
                            "로그인하여 내 주변 맛집 리뷰를 확인하고 회원님이 좋아할 만한 계정을 찾아보세요."
                            <button id="btn-row"><a href="/mem/login">로그인</a></button>
                            <button id="btn-row2"><a href="/mem/join">회원가입</a></button>
                        </legend>
                    </fieldset>
                </form>  
            </div> <!--rowbar-->
        </div><!--//inner-->
    </div> <!--wrapper-->


<!-- <div class="container">
	<form class="search-form">
        <div class="search-bar">
            <input type="text" name="keyword" class="search-input" placeholder="지역, 장소, 메뉴 검색" autocomplete="off">
            <button type="submit" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button> 
        </div>  
    </form>

    리뷰 목록
    <div class="review-list">
    </div>
    
</div> -->
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


//reset check
let resetNum = 1;

//LunchIs 함수선언
function lunchIs() {
//setTimeout 선언
setTimeout(timeFunc, 900);

function timeFunc() {
//shuffle 메소드 선언
function shuffle(a) {
for (let i = a.length - 1; i > 0; i--) {
const j = Math.floor(Math.random() * (i + 1));
[a[i], a[j]] = [a[j], a[i]];
}
return a;
}

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
			window.location = "${pageContext.request.contextPath}/profilepage/yourprofile?memNo="+$(this).data("mno");
		});
	});
</script>
</body>
</html>

