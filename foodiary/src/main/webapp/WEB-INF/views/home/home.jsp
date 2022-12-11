<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
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
	<%-- <c:if test="${fn:length(myAreasList) == 0}">
		<div class="set-area-banner">
			<span class="banner-title exp1">${loginNick}님의 관심지역 정보가 아직 없어요.</span>
			<span class="banner-title exp2">내 관심지역 고르러 가볼까요?</span>
			<span class="ic-go exp2"><i class="fa-solid fa-circle-chevron-right"></i></span>
		</div>
	</c:if> --%>

	<!-- 리뷰 필터 버튼 -->
	<div class="filter-btn">
        <span class="label label-all">전체</span>
        <span class="label">팔로우</span>
        <!-- 관심지역이 있으면 지역 버튼 노출 -->
    </div>
</div>
<!-- jquery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>
	$(function() {
		loadInterestArea()
		
		$(".label-all").addClass("label-selected");
		
		//뒤로가기로 돌아왔을 때, 필터 설정 초기화를 위해 새로고침
	    $(window).bind("pageshow", function (event) {
	        if (event.originalEvent.persisted || (window.performance && window.performance.navigation.type == 2)) {
	             location.href = location.href;
	        }
	    });
		
	  	//관심지역 설정 화면으로 이동(배너, 설정 버튼)
      	$(document).on("click",".set-area-banner",function() {
			window.location = "${pageContext.request.contextPath}/home/area/interest";
		});
		
		$(document).on("click",".set-area-btn",function() {
			window.location = "${pageContext.request.contextPath}/home/area/interest";
		});
		
		//클릭한 필터 버튼 활성화 표시
		$(document).on("click",".label",function() {
			$(".label").removeClass("label-selected");
			$(this).addClass("label-selected");
		});
		
		//관심지역 목록 조회
        let interestList=[];
        function loadInterestArea(){
            $.ajax({
                url : "http://localhost:8888/rest/area/interest",
                method : "get",
                dataType : "json",
                success : function(resp) {
                    interestList = resp;
                    showInterestArea();
                }
            });
        };
        
      	//관심지역 목록 출력
        function showInterestArea(){
            if(interestList.length != 0) {
            	$.each(interestList, function(index, value){
            		var span = $("<span>").text(value.areaDistrict)
            		.attr("data-address", value.areaCity+" "+value.areaDistrict);
            		span.addClass("label");
            		$(".filter-btn").append(span); //내 관심지역 목록을 filter-btn 영역에 추가
            	});
            	var btn = $("<span>").html("<i class='fa-solid fa-gear'></i>"+" 설정");
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
	});
</script>
</body>
</html>

