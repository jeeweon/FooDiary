<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>맛쟁이 탐색</title>

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

.title-div {
	margin-top: 30px;
	font-size: 20px;
	font-weight: bold;
}

.title-area {
	color: #E27C5E;
}

.title2 {
	color: #18253D;
}

.title {
	display: block;
	margin-top: 30px;
	color: #18253D;
	font-size: 20px;
	font-weight: bold;
}

.subtitle {
	display: block;
	margin-top: 5px;
	color: #707070;
	font-size: 14px;
}

.mem-list {
	width: 600px;
	margin-top: 40px;
	margin-bottom: 60px;
}

.no-mem {
	margin-top: 100px;
	text-align: center;
	color: gray;
}

.list-item {
	display: flex;
	flex-direction: row;
	justify-content: space-between;
    align-items: center;
    margin-top: 10px;
}

.mem-info {
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

.mem-avatar {
	width: 50px;
	height: 50px;
	border-radius : 50%;
  	border:1px black solid transparent;
}

.mem-nick {
	font-weight: bold;
}

.review-cnt {
	font-size: 14px;
	color: #707070;
	margin-top: 3px;
}

.mem-follow-ic {
	color: #E27C5E;
	cursor: pointer;
}

.fa-user-minus {
	color: #AAAAAA;
}

.mem-me { /* 맛쟁이 top5에 내가 있으면 클릭 x(팔로우 불가) */
	padding: 5px 10px;
	border: 2px solid #E27C5E;
	border-radius: 20px;
	font-weight: bold;
	color: #E27C5E;
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
            <input type="text" name="keyword" class="search-input" placeholder="닉네임 검색" autocomplete="off">
            <button type="button" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button> 
        </div>  
    </form>

    <div class="mem-list"></div>
    
</div>
<!-- jquery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script src="${pageContext.request.contextPath}/js/commons.js"></script>
<script>
	$(function() {
		//세션에서 회원 번호 가져오기 
		var memNo = "<%=(Integer)session.getAttribute("loginNo")%>";
		if(memNo == "null"){
			loadGuestSameInterestList();
        } else {
        	loadInterestArea();
        }
        loadPointTopList();
		
        let memList = [];
		//관심지역 같은 유저 조회(비회원)
		function loadGuestSameInterestList(){
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/search/mem/same-interest/guest",
				method : "get",
				dataType : "json",
				success : function(resp) {
					memList = resp;
					var titleArea = $("<span>").text("서울");
					titleArea.addClass("title-area");
					var title2 = $("<span>").text(" 맛쟁이");
					title2.addClass("title2");
					
					var titleDiv = $("<div>").append(titleArea).append(title2);
					titleDiv.addClass("title-div");
					
					var subtitle = $("<span>").text("활동 점수와 최근 로그인 시간이 반영돼요.");
					subtitle.addClass("subtitle");

					$(".mem-list").append(titleDiv).append(subtitle);
					renderList();
				}
			});
		};
		
		//첫 번째 관심지역 조회 
		let interestList = [];
        let interestArea;
		function loadInterestArea() {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/area/interest",
				method : "get",
				dataType : "json",
				success : function(resp) {
					interestList = resp;
					if(interestList.length == 0) {
						interestArea = "서울";
					} else {
						interestArea = resp[0].areaCity;						
					}
					loadMemSameInterestList(interestArea);
				}
			});
		};
		
		//관심지역 같은 유저 조회(회원)
		function loadMemSameInterestList(keyword){
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/search/mem/same-interest/"+keyword,
				method : "get",
				dataType : "json",
				contentType:"application/json",
			    data:JSON.stringify(keyword),
				success : function(resp) {
					memList = resp;
					var titleArea = $("<span>").text(keyword);
					titleArea.addClass("title-area");
					var title2 = $("<span>").text(" 맛쟁이");
					title2.addClass("title2");
					
					var titleDiv = $("<div>").append(titleArea).append(title2);
					titleDiv.addClass("title-div");
					
					var subtitle = $("<span>").text("나와 관심지역이 같은 사용자를 추천받을 수 있어요.");
					subtitle.addClass("subtitle");

					$(".mem-list").append(titleDiv).append(subtitle);
					
					if(memList.length != 0) {
						renderList();
					} else {
						var noMemDiv = $("<div>").append("<span class='no-mem'>"+keyword+"맛쟁이가 아직 없어요.</span>");
						noMemDiv.addClass("no-mem");
						$(".mem-list").append(noMemDiv);
					}
				}
			});
		};
		
		//활동 점수 높은 유저 top 5 조회
		function loadPointTopList(){
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/search/mem/point-top",
				method : "get",
				dataType : "json",
				success : function(resp) {
					memList = resp;
					var title = $("<span>").text("맛쟁이 Top5");
					var subtitle = $("<span>").text("활동 점수와 최근 로그인 시간이 반영돼요.");
					title.addClass("title");
					subtitle.addClass("subtitle");
					$(".mem-list").append(title).append(subtitle);
					renderList();
				}
			});
		};
		
		//검색 버튼 클릭 시, 검색어가 닉네임에 포함된 유저 조회
		$(document).on("click", ".search-btn", function() {
            const keyword = $("[name=keyword]").val();
            
			$(".mem-list").empty();
			if(!keyword){
				if(memNo == "null"){
					loadGuestSameInterestList();
		        } else {
		        	loadInterestArea();
		        }
				loadPointTopList();
			} else {				
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/search/mem/"+ keyword,
					method : "get",
					dataType : "json",
					contentType:"application/json",
				    data:JSON.stringify(keyword),
					success : function(resp) {
						memList = resp;
						var title = $("<span>").text("닉네임 검색 결과");
						title.addClass("title");
						$(".mem-list").append(title);
						renderList();
					}
				});
			}
		});
		
		//유저 목록 출력
		function renderList(){
			if(memList.length != 0) {
				$.each(memList, function(index, value) {
					var memAvatar;
					if(value.attachNo == 0) {
						memAvatar = $("<img>").attr("src", "${pageContext.request.contextPath}/images/basic-profile.png");						
					} else {
						memAvatar = $("<img>").attr("src", "${pageContext.request.contextPath}/attach/download/"+value.attachNo);
					}
					memAvatar.addClass("mem-avatar");
					
					var memNick = $("<span>").text(value.memNick);
					memNick.addClass("mem-nick");
					
					var memLevel;
					if(value.memLevel == "6  ") { //db에 char(3)으로 넣어서 한 자리인 경우 공백 생김
						memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/6.피잣집.png");
					} else if (value.memLevel == "5  ") {
						memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/5.피자콜라.png");
					} else if (value.memLevel == "4  ") {
						memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/4.조각피자.png");
					} else if (value.memLevel == "3  ") {
						memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/3.반죽.png");
					} else if (value.memLevel == "2  ") {
						memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/2.밀가루.png");
					} else {
						memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/1.밀.png");
					}
					memLevel.addClass("level-img");
					
					var reviewCnt = $("<span>").text("리뷰 " + value.memReviewCnt);
					reviewCnt.addClass("review-cnt");
					
					var nickLev = $("<div>").append(memNick).append(memLevel);
					nickLev.addClass("nick-lev");
					
					var infoText = $("<div>").append(nickLev).append(reviewCnt);
					infoText.addClass("info-text");
					
					var memFollow; 
					if(value.followCheck) {
						memFollow = $("<span>").html("<i class='fa-solid fa-user-minus fa-2x'></i>");
						memFollow.addClass("mem-follow-ic");
					} else if(value.memNo == memNo) { //맛쟁이 top5에 내가 있으면 클릭 x(팔로우 불가)					
						memFollow = $("<span>").text("ME");
						memFollow.addClass("mem-me");
					} else {
						memFollow = $("<span>").html("<i class='fa-solid fa-user-plus fa-2x'></i>");
						memFollow.addClass("mem-follow-ic");
					}
					memFollow.attr("data-mno", value.memNo);
					
					var infoDiv = $("<div>").append(memAvatar).append(infoText)
						.attr("data-mno", value.memNo);
					infoDiv.addClass("mem-info");
					
					var listItem = $("<div>").append(infoDiv).append(memFollow);
					listItem.addClass("list-item");
					
					$(".mem-list").append(listItem);
				});
			} else {
				var noMemDiv = $("<div>").append("<span class='no-mem'>닉네임 검색 결과가 없습니다.</span>");
				noMemDiv.addClass("no-mem");
				$(".mem-list").append(noMemDiv);
			}
		};
		
		//팔로우 버튼 클릭 이벤트 -> rest API 나오면 수정 예정
		$(document).on("click", ".mem-follow-ic", function() {
			if(memNo == "null") {//비회원
				alert("로그인이 필요한 기능입니다."); //모달로 변경 -> 취소, 로그인하러가기				
			} else {//회원
				var clickedBtn = $(this);
				var no = $(this).data("mno");
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/review/follow",
	                method : "post",
				    data : {
				    	passiveMemNo:no
		           	},
	                success : function(resp) {
	                	if(resp) {
	                		clickedBtn.find("i").removeClass("fa-user-plus").addClass("fa-user-minus");
	                	} else {
	                		clickedBtn.find("i").removeClass("fa-user-minus").addClass("fa-user-plus");
	                	}
	                }
				});
			}
		});
		
		//프로필 영역 클릭 시, 해당 유저 프로필로 이동
		$(document).on("click", ".mem-info", function(){
			window.location = "${pageContext.request.contextPath}/profilepage/yourprofile?memNo="+$(this).data("mno");
		});
	});
</script>
</body>
</html>

