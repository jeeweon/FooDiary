<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<!-- 헤더 -->
<%-- <jsp:include page="/WEB-INF/views/profilepage/myprofileheader.jsp">
	<jsp:param value="주문내역페이지" name="title"/>
</jsp:include> --%>
<!-- 스타일 -->
<style>
*{ padding: 0; margin: 0; }
li{ list-style: none; }

.gallery{
  width: 940px; margin: 0 auto;
  overflow: hidden;
}
.gallery h3{
  width: 100%; height: 50px;
  line-height: 50px; text-align: center;
}
.gallery li{
  float: left;
  width: 300px; height: 200px;
  margin-right: 20px;
}
.gallery li:last-child{ margin-right: 0; }

.gallery a{
  display: block; /* 영역적용위해 사용 */
  width: 100%; height: 100%;

  overflow: hidden;

  position: relative; /* absolute의 기본기준은 body로 처리 - 현재 요소로 기준변경 */
}

.gallery figure{
  width: 100%; height: 100%;
}
.gallery figcaption{
  width: 100%; height: 100%;
  background-color: rgba(0,0,0,0.7);

  position: absolute; /* 이미지와 겹치게 처리 */
  top: 0; left: 0;

  color: #fff; text-align: center;
  line-height: 200px;

  opacity: 0; /* 처음엔 안보이고 */

  transition: 0.3s;
}

.gallery a:hover figcaption, .gallery a:focus figcaption{
  /* 마우스를 올리면 보이게 처리 */
  opacity: 1;
}
</style> 

<p>내가 올린 게시물</p>
<%-- <c:forEach var="bookmarkdto" items="${list}">
	<a href="${pageContext.request.contextPath}/review/detail?reviewNo=${bookmarkdto.reviewNo}">
		<img src="${pageContext.request.contextPath}/attach/downloadReviewAttach/${bookmarkDto.reviewNo}" width="300" height="200">
	</a>
</c:forEach> --%>

	<div class="gallery">
		<c:forEach var="reviewDto" items="${list}">
            	<ul>
                	<li>
                    	<a href="${pageContext.request.contextPath}/review/detail?reviewNo=${reviewDto.reviewNo}">
                        	<figure>
                            	<img src="${pageContext.request.contextPath}/attach/downloadReviewAttach/${reviewDto.reviewNo}" width="300" height="200">
                            		<c:choose>
                            			<c:when test="${reviewDto.likeCnt>0}">
                            				<figcaption>🧡${reviewDto.likeCnt}</figcaption>
                            			</c:when>
                            		<c:otherwise>
                            			<figcaption>♡</figcaption>
                            		</c:otherwise>                    
                            	</c:choose>
                        	</figure>
                    	</a>
                	</li>
            	</ul>
            </c:forEach>
        </div> 
</body>
</html>