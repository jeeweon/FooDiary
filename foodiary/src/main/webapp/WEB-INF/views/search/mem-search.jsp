<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<head>
<title>맛쟁이 탐색</title>

<link rel="stylesheet" type="text/css"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/mem-search.css"> <!--css 불러오는 링크--> 
<!-- toast 스타일 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" /> 
<style>
.receipt{
 		background-image: url("${pageContext.request.contextPath}/images/슬롯머신.jpg");
 	}
.noti-cnt {
	width:18px;
	height:18px;
	padding: 5px 10px;
	border-radius: 50%;
	text-align: center;
	font-size: 14px;
	color: #ffffff;
	background-color: #E27C5E;
    line-height: 18px;
    margin: 0 10px;
	}
</style>
</head>
<body>


<c:set var="login" value="${loginNo != null}"></c:set>


<div class="wrapper">
   <div class="inner">
       <header class="header">
           <div class="header1">
               <h1><a href="/home" class="logo"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="로고/홈으로"></a></h1>
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
                  <li><img src="${pageContext.request.contextPath}/images/알림아이콘.png"><a href="${pageContext.request.contextPath}/mem/noti">알림</a><span class="noti-cnt">${cnt}</span></li>
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
            <div class="header4">
               	<div class="formdiv">	               
					<form class="search-form">
						<fieldset>
							<legend class="search-bar">							
			            		<input type="text" name="keyword" class="search-input" placeholder="닉네임 검색" autocomplete="off">
			            		<button type="submit" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button> 				        		  
							</legend>
						</fieldset>					        
				    </form>	
			    </div>								   				    					
               </div> <!-- header4 -->
            </header> <!--header-->
            <div class="sideW">
             <div class="mem-list"></div>	
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
                         <div class="follow">
                            <!--  <p id="follow1">이용약관 개인정보처리방침 쿠키정책</p> -->
                         </div> <!--follow-->
                     </div> <!--random-->
                 </div> <!--sidebar-->


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
    let lunckPick = shuffle(lunchList)[0];

    //메뉴 노출
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
			loadGuestSameInterestList();
        } else {
        	loadInterestArea();
        	//웹소켓 연결
        	connectWs();
        }
        loadPointTopList();
		
    	//웹소켓
    	function connectWs(){
    		var uri = "${pageContext.request.contextPath}/ws/sockjs";
    		socket = new SockJS(uri);
    	
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
    	};
        
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
		$(".search-form").submit(e=>{
            e.preventDefault();
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
					memFollow.attr("data-mno", value.memNo).attr("data-mnick", value.memNick);
					
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
		
		//팔로우 버튼 클릭 이벤트
		$(document).on("click", ".mem-follow-ic", function() {
			if(memNo == "null") {//비회원
				alert("로그인이 필요한 기능입니다."); //모달로 변경 -> 취소, 로그인하러가기				
			} else {//회원
				var clickedBtn = $(this);
				var no = $(this).data("mno");
				var nick =  $(this).data("mnick");
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/review/follow",
	                method : "post",
				    data : {
				    	passiveMemNo:no
		           	},
	                success : function(resp) {
	                	if(resp) {
	                		clickedBtn.find("i").removeClass("fa-user-plus").addClass("fa-user-minus");
	                		//알림 생성 & 전송
		            		var notiData = {
		            				callerMemNo:memNo,
		            				receiverMemNo:no,
		            				receiverMemNick:nick,
		            				notiContent:memNick+"님이 회원님을 팔로우하기 시작했어요 🙌",
		            				notiType:"follow",
		            				notiUrl:"${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+memNo,
		            				notiCreateDate:moment(),
		            				memNick:memNick
		            		};
	                		if(memNo != no) {
			            		socket.send(JSON.stringify(notiData));	                			
	                		}
	                	} else {
	                		clickedBtn.find("i").removeClass("fa-user-minus").addClass("fa-user-plus");
	                	}
	                }
				});
			}
		});
		
		//프로필 영역 클릭 시, 해당 유저 프로필로 이동
		$(document).on("click", ".mem-info", function(){
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
	});
</script>
</body>
</html>

