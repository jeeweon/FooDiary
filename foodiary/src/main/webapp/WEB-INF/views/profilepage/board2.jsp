<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:include page="/WEB-INF/views/profilepage/follow.jsp">
	<jsp:param value="주문내역페이지" name="title"/>
</jsp:include> 
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>	
<script>
	$(function(){
		reviewList();
		
		let reviewList1 = [];
		//내가 작성한 모든 리뷰 
		function reviewList() {
		$.ajax({
			url : "${pageContext.request.contextPath}/rest/profile/reviewlist",
			method : "get",
			dataType : "json",
			success : function(resp) {
				reviewList1 = resp;
				console.log(reviewList1);
			}
		});
	};
});
</script>

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

.wrapper > div.inner{
    display: flex; 
    gap: 50px;
    justify-content: space-between;
}

.feed{
    display: flex;
    flex-wrap:wrap;
    gap: 20px;
    flex: 1;
    
}

/* .gallery{
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
} */
.feedimg li:last-child{ margin-right: 0; }

.feedimg a{
  display: block; /* 영역적용위해 사용 */
  width: 100%; height: 100%;

  overflow: hidden;

  position: relative; /* absolute의 기본기준은 body로 처리 - 현재 요소로 기준변경 */
}

.feedimg figure{
  width: 100%; height: 100%;
}
.feedimg figcaption{
  width: 100%; height: 100%;
  background-color: rgba(0,0,0,0.7);

  position: absolute; /* 이미지와 겹치게 처리 */
  top: 0; left: 0;

  color: #fff; text-align: center;
  line-height: 300px;

  opacity: 0; /* 처음엔 안보이고 */
 
  transition: 0.3s;
}

.feedimg a:hover figcaption, .feedimg a:focus figcaption{
  /* 마우스를 올리면 보이게 처리 */
  opacity: 1;
}
</style> 
<%-- <c:forEach var="bookmarkdto" items="${list}">
	<a href="${pageContext.request.contextPath}/review/detail?reviewNo=${bookmarkdto.reviewNo}">
		<img src="${pageContext.request.contextPath}/attach/downloadReviewAttach/${bookmarkDto.reviewNo}" width="300" height="200">
	</a>
</c:forEach> --%>

	
         <section class="section1">
            <div class="inner">
                <div class="feed">
                	<c:forEach var="reviewDto" items="${list}">
		            	<ul>
		                	<li>
			                	<div class="feedimg">
			                    	<a href="${pageContext.request.contextPath}/review/detail?reviewNo=${reviewDto.reviewNo}">
			                        	<figure>
			                            	<img src="${pageContext.request.contextPath}/attach/downloadReviewAttach/${reviewDto.reviewNo}" width=350px; height=350px;">
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
			                    </div>	
		                	</li>
		            	</ul>
		            </c:forEach>
                </div>      
            </div>
        </section> 


