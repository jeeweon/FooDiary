<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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
  width: 100px; height: 100px;
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

.detail-btn{ 
position:absolute; top:50%; left:50%;
  width:120px; height:30px; margin-top:-15px; margin-left:-60px;
  line-height:15px; cursor:pointer;
}

.modal{ 
  position:absolute; width:100%; height:100%; background: rgba(0,0,0,0.8); top:0; left:0; display:none;
}

.modal_content{
  width:400px; height:200px;
  background:#fff; border-radius:10px;
  position:relative; top:50%; left:50%;
  margin-top:-100px; margin-left:-200px;
  text-align:center;
  box-sizing:border-box; padding:74px 0;
  line-height:23px; cursor:pointer;
}

</style>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css" />
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<script>
	$(function(){
		
		//좋아요 
		 $(".like-btn").click(function(e){
	           e.preventDefault();
	           var that=$(this);
	           
	           $.ajax({
	           url:"${pageContext.request.contextPath}/rest/review/like",
	           method:"post",
	           data:{
	        	   reviewNo:$(this).data("review-no")
	           },
	           success:function(resp){
	        	   console.log(resp);
	        	   if(resp>0){
	               		$(that).text("♥"+resp);
	               		$(".hover-btn").text("♥"+resp);
	               		}else{
	        			$(that).text("♡");
	        			$(".hover-btn").text("♡");
	        			
	        	   }
	           }
	           })
	        });
		

	        //북마크
	        $(".bookmark-btn").click(function(e){
	     		e.preventDefault();
	     		var that=$(this);
	     		
	     		$.ajax({
					url:"${pageContext.request.contextPath}/rest/review/bookmark",
					method:"post",
					data:{
			        	   reviewNo:$(this).data("review-no"),
			           },
					success:function(resp){
						if(resp){
							
							$(that).text("북마크해제");

						}else{
							
							$(that).text("북마크");
							
						}
					}
	     		});
	        });
	});
</script>
<!-- 현재 시간 구하기 -->
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<c:set var="today">
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>
</c:set>

	<h1>리뷰</h1>

	<div>
		<a href="write">리뷰 쓰기</a>
	</div>
	
	<div>
		<c:forEach var="reviewDto" items="${list}">
			<div>
				번호 : 
					<a href="detail?reviewNo=${reviewDto.reviewNo}">
						${reviewDto.reviewNo}
					</a>
				
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
	
				<!-- 사진을 누르면 상세 페이지로 이동하도록 처리 --><%-- 
				<div>
					<a href="detail?reviewNo=${reviewDto.reviewNo}">
						<!-- 미리보기 -->
						<img src="${pageContext.request.contextPath}/attach/downloadReviewAttach/${reviewDto.reviewNo}" width="100" height="100">
					</a>
				</div> --%>
				<!-- 사진hover시 좋아요 갯수  -->
				 <div class="gallery" data-review-no="${reviewDto.reviewNo}">
            		<ul>
                		<li>
                    		<a href="detail?reviewNo=${reviewDto.reviewNo}">
                        		<figure>
                            		<img src="${pageContext.request.contextPath}/attach/downloadReviewAttach/${reviewDto.reviewNo}" width="300" height="200">
                            		<figcaption class="hover-btn">♥${reviewDto.likeCnt}</figcaption>
                        		</figure>
                    		</a>
                		</li>
            		</ul>
        		</div>
				
				
				
				
				<!-- 별점 개수 출력 -->
				<c:choose>
					<c:when test="${reviewDto.starScore ==0}">
						★-
					</c:when>
					<c:otherwise>
						★${reviewDto.starScore}
					</c:otherwise>
				</c:choose>
				<!-- 좋아요버튼(내가 눌렀는지 안눌렀는지 확인 --> 
				<c:choose>
					<c:when test="${reviewDto.likeCnt>0}">
						<a class="like-btn" data-review-no="${reviewDto.reviewNo}">♥${reviewDto.likeCnt}</a>
					</c:when>
					<c:otherwise>
						<a class="like-btn" data-review-no="${reviewDto.reviewNo}">♡</a>
					</c:otherwise>
				</c:choose>
				
				
				<!--북마크 버튼 --> 
				<a class="bookmark-btn" data-review-no="${reviewDto.reviewNo}">북마크</a>
				
				<%-- <!-- 좋아요 개수 출력 -->
				<c:if test="${reviewDto.reviewLike > 0}">
					♥ ${reviewDto.reviewLike}
				</c:if>
				
				<!-- 댓글 개수 출력 -->
				<c:if test="${reviewDto.replyCount > 0}">
					[${reviewDto.replyCount}]
				</c:if> --%>
				
			</div><br>
		</c:forEach>
	</div>
