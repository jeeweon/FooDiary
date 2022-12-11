<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

	<div>
		<h1>리뷰 상세</h1>
	</div>

	<div>
		번호 : ${reviewDto.reviewNo} <br>
		작성자 회원번호 : ${reviewDto.memNo} <br>
		작성일 :	<fmt:formatDate value="${reviewDto.reviewWriteTime}" pattern="yyyy.MM.dd (E) a hh:mm"/> <br>
		
		<!-- 첨부파일 -->
		<c:if test="${!attachments.isEmpty()}">
			<div>
				사진 <br>
				<c:forEach var="attachDto" items="${attachments}">
					<img src="${pageContext.request.contextPath}/attach/download/${attachDto.attachNo}" width="100" height="100">
				</c:forEach>
			</div>
		</c:if>
		
		내용 :
			${reviewDto.reviewContent} <br>

		별점 : <div class="star-score" data-max="5" data-rate="${reviewDto.starScore}"></div> <br>
		<div>
			<!-- 회원 : 자신의 글만 수정/삭제 가능하도록 처리 -->		
			<c:set var="owner" value="${loginNo == reviewDto.memNo}"></c:set>		
			<c:if test="${owner}">
			<a href="edit?reviewNo=${reviewDto.reviewNo}">수정하기</a>
			<a href="delete?reviewNo=${reviewDto.reviewNo}">삭제하기</a>
			</c:if>
			<a href="list">목록으로</a>
		</div>
	</div>


	
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script src="${pageContext.request.contextPath}/js/score.min.js"></script> <!-- 수정본 js파일 : 별점단위 0.5로 변경 -->

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