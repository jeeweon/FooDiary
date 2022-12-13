<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
</head>
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
        	   reviewNo:$(this).data("review-no"),
        	   memNo:$(this).data("mem-no")
           },
           success:function(resp){
        	   if(resp>0){
               		$(that).text("♥"+resp);
        	   }else{
        			$(that).text("♡"+resp);
        			
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
		        	   memNo:$(this).data("mem-no")
		           },
				success:function(resp){
					if(resp){
						
						$(that).text("♥");

					}else{
						
						$(that).text("♡");
						
					}
				}
     		});
        });
        //follow 비동기 통신 
        $(".follow-btn").click(function(){
        	var that=$(this);
        	$.ajax({
        		url:"${pageContext.request.contextPath}/rest/review/follow",
        		method:"post",
        		data:{
        			activeMemNo:$(this).data("active-mem-no"),
        			passiveMemNo:$(this).data("passive-mem-no")
        		},
        		success:function(resp){
        			if(resp){
        				console.log("true");
        				$(that).text("팔로우");
        			}else{
        				console.log("false");
        				$(that).text("팔로우취소");
        			}
        		}
        	});
        });
        // 모달창 
        $(".detail-btn").click(function(){
            $(".modal").fadeIn();
          });
          
          $(".modal_content").click(function(){
            $(".modal").fadeOut();
          });
          
          $(".span-btn").click(function(){
        	  var memNo=$(this).data("mem-no");
        	  console.log(memNo);
        	  $(".modal").fadeIn();
          });
     });
    </script>
<body>

<h1>13번회원 마이페이지</h1>
팔로워 : ${follower}<br>
팔로잉 : ${following}<br>
내게시물수 :${reviewcount}<br>
<br><br>
<h1>회원 추천목록 / 팔로우 / 팔로잉</h1> 
 <table>
 	<tbody>
 		<thead>
 			<tr>
 				<td>회원번호</td>
 				<td>회원사진</td>
 				<td>회원닉네임</td>
 				<td>회원생년월일</td>
 				<td>회원레벨</td>
 			</tr>
 		</thead>
 	 <c:forEach var="memlist" items="${list}">
 		<tr>
 			<td>
 				<span class="span-btn"
 				data-mem-no="${memlist.memNo}"
 				>${memlist.memNo}</span>
 			</td>
 			<td><img src="https://placeimg.com/640/480/nature" width="50" height="50"></td>
 			<td>${memlist.memNick}</td>
 			<td>${memlist.memBirth}</td>
 			<td>${memlist.memLevel}</td>
 			<td>
 				<button class="follow-btn"
 				data-active-mem-no="13" data-passive-mem-no="${memlist.memNo}">팔로우</button>
 			</td>
 		</tr>
 	</c:forEach>
 	</tbody>
 </table>
 <h1>리뷰좋아요북마크 기능</h1>
 <table>
 	<tbody>
 		<c:forEach var="reviewlist" items="${reviewlist}">
 			<tr>
 				<td>${reviewlist.reviewNo}</td>
 				<td>
 				<button class="like-btn" data-review-no="${reviewlist.reviewNo}" data-mem-no="${reviewlist.memNo}">좋아요</button>
 				<span class="s-text"></span>
 				<span class="c-text"></span>
 				</td>
 				<td>
 				<button class="bookmark-btn" data-review-no="${reviewlist.reviewNo}" data-mem-no="${reviewlist.memNo}"><i class="fa-solid fa-bookmark" ></i></button>
 				<span class="e-text"></span>
 				<!-- <i class="fa-regular fa-bookmark"></i> -->
 				</td>
 			</tr>
 		</c:forEach>
 	</tbody>
 </table>
 		<h1>북마크한 목록</h1>
 <table>
 	<thead>
 		<tr>
 			<td>리뷰번호</td>
 			<td>리뷰컨텐트</td>
 		</tr>
 	</thead>
 	<tbody>
 		<tr>
 			<c:forEach var="list" items="${bookmarklist}">
 				<td>${list.reviewNo}</td>
 				<td>${list.reviewContent}</td>
 			</c:forEach>
	 	</tr>
	 </tbody>	
 </table>
 
 
 <h1>사진에 마우스 가져가면 좋아요 갯수 출력</h1>
 <div class="gallery">
            <ul>
                <li>
                    <a href="#">
                        <figure>
                            <img src="https://placeimg.com/640/480/nature" alt="이미지01">
                            <figcaption>🧡23 ❤34</figcaption>
                        </figure>
                    </a>
                </li>
            </ul>
        </div>
<button class="detail-btn">상세페이지</button>

 <div class="modal">
  			<div class="modal_content" 
       			title="클릭하면 창이 닫힙니다.">
    			번호 : {{memno}}<br>
  			</div>
		</div>

</body>
</html>
