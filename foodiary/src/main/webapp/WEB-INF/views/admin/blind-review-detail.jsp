<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<jsp:include page="/WEB-INF/views/admin/admin_header.jsp">
	<jsp:param value="블라인드 리뷰 상세" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/css_admin/blind.css">
<!-- swiper 의존성-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
<style>
</style>
</head>
<body>
<div id="dashboard">
	<div class="container mb-50">
		<div class="title">
				<h2>블라인드 리뷰 상세</h2>
		</div>
		
		<div class="action-btn">
			<button type="button" class="blind-clear" data-rno="${rvo.reviewNo}">블라인드 해제</button>
			<button type="button" class="blind-list">목록 보기</button>	
		</div>
		
		<div class="float-container">
			<div class="row float-left float-1">
				<div class="row center">
					<h3 class="subtitle">리뷰 원글</h3>
				</div>
				<div class="review-list">
					<div class="list-item">
						<div class="review-write-info">
							<c:choose>
								<c:when test="${rvo.pno == 0}">
									<img src="${pageContext.request.contextPath}/images/basic-profile.png" class="writer-avatar">
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/attach/download/${rvo.pno}" class="writer-avatar">
								</c:otherwise>
							</c:choose>
							<div class="info-text">
								<div class="nick-lev">
									<span class="writer-nick">${rvo.memNick}</span>
									<span class="writer-level">레벨 ${rvo.memLevel}</span>
								</div>
								<div class="sub-info-text">
									<span class="review-cnt">리뷰 ${rvo.memReviewCnt}</span>
									<span class="write-time">
										<fmt:formatDate value="${rvo.reviewWriteTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</span>
								</div>
							</div>
						</div>
						<hr>
						<div class="review-main">
							<div class="img-div">
								<!-- Slider main container -->
					            <div class="swiper">
					                <div class="swiper-wrapper">
										<c:forEach var="img" items="${attaches}">
						                	<div class="swiper-slide"><img class="thumbnail" src="${pageContext.request.contextPath}/attach/download/${img.attachNo}"></div>
										</c:forEach>
					                </div>
					                <div class="swiper-pagination"></div>
					            </div>
				                <div class="swiper-button-prev"></div>
				                <div class="swiper-button-next"></div>
							</div>
							<div class="loca-div">
								<span><i class="fa-solid fa-location-dot fa-2x"></i></span>
								<div class="loca-info">
									<span class="place">${rvo.reviewPlace}</span>
									<span class="address">${rvo.reviewAddress}</span>
								</div>
							</div>
							<span class="content">${rvo.reviewContent}</span>
						</div>
						<hr>
						<div class="review-action">
							<div>
								<span class="score-ic">
									<i class="fa-solid fa-star"></i>
								</span>
								<span class="score">${rvo.starScore}</span>
							</div>
							<div>
								<span class="like-ic">
									<i class="fa-regular fa-heart"></i>
								</span>
								<span class="like-cnt">도움됐어요 ${rvo.likeCnt}</span>
							</div>
							<div>
								<span class="reply-ic">
									<i class="fa-regular fa-comment"></i>
								</span>
								<span class="reply-cnt">${rvo.replyCnt}</span>
							</div>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row float-right float-2">
				<div class="row center">
					<h3 class="subtitle">신고 내역</h3>
				</div>
				<div class="history-list">
					<span class="report-cnt">신고 수: ${history.size()}</span>
					<table class="table table-slit history">
						<thead>
							<tr>
								<th>번호</th>
								<th>회원번호</th>
								<th>신고자</th>
								<th>신고일시</th>
							</tr>
						</thead>
						<tbody class="center">
							<c:forEach var="list" items="${history}">
								<tr>
									<td width="10%">${list.reviewReportNo}</td>
									<td width="20%">${list.memNo}</td>
								    <td width="30%">${list.memNick}</td>
								    <td width="20%">
								    	<fmt:formatDate value="${list.reviewReportTime}" pattern="yy-MM-dd HH:mm:ss"/>
								    </td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
    var swiper = new Swiper('.swiper', {
        direction: 'horizontal', //슬라이드 방향
        loop: true, //반복 여부

        // Pagination
        pagination: {
            el: '.swiper-pagination', //페이징 대상
            type: 'bullets' //페이징 도구 모양
        },

        // Navigation arrows
        navigation: {
            nextEl: '.swiper-button-next',
            prevEl: '.swiper-button-prev',
        },

        //페이지 전환 효과
        effect: "slide" //기본 슬라이드 효과
    });
    
    $(".blind-clear").click(function(){
    	var btn = $(this);
		var reviewNo = $(this).data("rno");
		var chk = confirm("블라인드를 해제할까요?");
		if(!chk) {
			return;
		} else {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/blind/review/clear",
	            method : "post",
			    data : {
	        	   reviewNo:$(this).data("rno")
	           	},
	            success : function(resp) {
	            	if(resp) {
	            		btn.addClass("clear");
	            		btn.prop("disabled", true);
	            		alert("블라인드가 해제되었습니다.\n블라인드 리뷰 목록에서 이 리뷰를 더 이상 확인할 수 없습니다.");
	            	} else {
	            		alert("블라인드가 해제되지 않았습니다.\n"+reviewNo+"번 리뷰가 블라인드 상태인지 다시 한 번 확인 후 재시도해주세요.");
	            	}   
	            }
			});
		}
    });
    
    $(".blind-list").click(function(){
    	window.location = "${pageContext.request.contextPath}/admin/blind/review";
    });
});
</script>
</body>
</html>