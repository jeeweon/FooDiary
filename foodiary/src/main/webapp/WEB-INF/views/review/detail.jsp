<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 현재 시간 구하기 -->
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<c:set var="today">
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>
</c:set>

<style>
/* summernote(좌측), 리뷰장소(우측) 구분용 style */
	.float-container {
		width: 850px
	}
    .float-container::after {
        content: "";        /* 영역에 들어갈 글자 */
        display: block;   /* block형태 공간 */
        clear: both;
    }
    .float-left {
        float: left;
        width: 50%
    }
    .clear {
        clear: both;
    }
</style>



<div>
	<h1>리뷰 상세</h1>
</div>

<!-- 글번호 : ${reviewDto.reviewNo} <br> -->
작성자 회원번호 : ${reviewDto.memNo} <br>
<!-- 회원정보 : 프로필 사진, 닉네임, 팔로우버튼(팔로우중:팔로잉)
				- (사진,닉네임)클릭시 프로필로 이동 
-->

<!-- 작성일 -->
<c:set var="current">
	<fmt:formatDate value="${reviewDto.reviewWriteTime}" pattern="yyyy-MM-dd"/>
</c:set>
<c:choose>
	<c:when test="${today == current}">
		작성일 : 
		<fmt:formatDate value="${reviewDto.reviewWriteTime}" pattern="HH:mm"/>
	</c:when>
	<c:otherwise>
		작성일 : 
		<fmt:formatDate value="${reviewDto.reviewWriteTime}" pattern="yyyy-MM-dd"/>
	</c:otherwise>
</c:choose>	

<!-- 회원 기능 
	1. 작성자 본인이 아닐 때 : 신고버튼
		- 신고버튼 (확인 팝업 노출: 취소불가능, 불이익 안내, 완료시 완료 팝업)
	2. 작성자 본인일 때 : 수정/삭제
-->		
<div>
	<c:set var="owner" value="${loginNo == reviewDto.memNo}"></c:set>		
	<c:if test="${owner}">
		<a href="edit?reviewNo=${reviewDto.reviewNo}">수정</a>
		<a href="delete?reviewNo=${reviewDto.reviewNo}">삭제</a>
	</c:if>
</div>
	
<div class="float-container"> <!-- 사진(좌측)/본문(우측) 배치 -->
	<!-- 첨부파일 : 슬라이딩 기능 필요 -->
	<div class="float-left">
		사진 <br>
		<c:forEach var="attachDto" items="${attachments}">
			<img src="${pageContext.request.contextPath}/attach/download/${attachDto.attachNo}" width="400" height="400">
		</c:forEach>
	</div>
	
	<div class="float-left">
		<div class="float-container">
			<div class="float-left">
			(리뷰 : 주소/장소, 별점은 있을 경우에만 출력) <br>
			<!-- 별점 -->
			<c:if test="${reviewDto.starScore >0}">
				별점 <div class="star-score" data-max="5" data-rate="${reviewDto.starScore}"></div> <br>
			</c:if>
			
			<c:if test="${reviewDto.reviewAddress!=null || reviewDto.reviewPlace!=null}">
				<!-- 리뷰장소 : 위치 (본문 상단) -->
			    	<label>리뷰 장소</label>
			    	<br>
			    	<c:choose>
				    	<c:when test="${reviewDto.reviewPlace==null}">
					        <input type="text" name="reviewAddress" value="${reviewDto.reviewAddress}" readonly>
							<div class="map_wrap">
						    	<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
							    <div id="menu_wrap" class="bg_white">
							        <div class="option">
							            <div>
							                <!-- <form onsubmit="searchPlaces(); return false;">  -->
							                    <input type="text" value="${reviewDto.reviewAddress}" id="keyword" size="15" readonly> 
							                    <button type="button" class="keywordMap">검색</button> 
							                <!--  </form> -->
							            </div>
							        </div>
							        <hr>
							        <ul id="placesList"></ul>
							        <div id="pagination"></div>
							    </div>
							</div>
						</c:when>
						<c:when test="${reviewDto.reviewAddress==null}">
					        <input type="text" name="reviewPlace" value="${reviewDto.reviewPlace}" readonly>
						</c:when>
						<c:otherwise>
					        <input type="text" name="reviewAddress" value="${reviewDto.reviewAddress}" readonly>
					       	<br>
				        	<input type="text" name="reviewPlace" value="${reviewDto.reviewPlace}" readonly>
							<div class="map_wrap">
						    	<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
							    <div id="menu_wrap" class="bg_white">
							        <div class="option">
							            <div>
							                <!-- <form onsubmit="searchPlaces(); return false;">  -->
							                    <input type="text" value="${reviewDto.reviewAddress}" id="keyword" size="15" readonly> 
							                    <button type="button" class="keywordMap">검색</button> 
							                <!--  </form> -->
							            </div>
							        </div>
							        <hr>
							        <ul id="placesList"></ul>
							        <div id="pagination"></div>
							    </div>
							</div>
						</c:otherwise>
					</c:choose>
				</c:if>
			</div>
	
			<div class="clear"></div>
			<br>
			
			<!-- 본문 내용 -->
			<div class="float-left">
				(내용)${reviewDto.reviewContent}
			</div>
			
			<!-- 댓글 위치 
				1. 댓글목록 : 최신순, 한번에 10개씩, 더보기클릭
					- 작성시간 출력
					- 회원 : 댓글 신고
					- 내 댓글 : 삭제 가능 (회원탈퇴시 자동삭제)
				2. 하단 위치 고정 : 좋아요, 북마크, 댓글작성란
					- 댓글 작성 : 내용없을 때 등록버튼 비활성화
			-->
		</div>
	</div>
</div>

<a href="list">목록으로</a>

	
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<!-- 별점 -->
<script src="${pageContext.request.contextPath}/js/score.min.js"></script> <!-- 수정본 js파일 : 별점단위 0.5로 변경 -->
<!-- 지도 키워드검색 -->
<link href="${pageContext.request.contextPath}/css/kakao-keyword.css" rel="stylesheet" type="text/css" >
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${appkey}&libraries=services"></script>
<script src="${pageContext.request.contextPath}/js/kakao-keyword.js"></script>

<script type="text/javascript">
	$(function(){
		//별점 옵션 수정
		$(".star-score").score({
			display: {
				showNumber:true,//설정된 숫자 표시 가능 여부
                placeLimit:1,//소수점 자리수
                textColor:"black",//숫자 색상(기본 : 금색)
		    }
        });
	});
</script>