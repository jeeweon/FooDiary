<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<html>
<head>
    <title>myprofile</title>
    
    <link rel="stylesheet" type="text/css"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/board.css"> <!--css불러오는 링크-->

    <script src="http://code.jquery.com/jquery-3.6.1.js"></script>
    <script type="text/javascript"></script>   
    <script>
    	$(function(){
    		console.log(${list});
    	});
    </script>
</head>

<body>
	<div class="wrapper">
        <div class="boardF">
            <div class="inner">
                <div class="boardM">
                    <%-- <img src="${pageContext.request.contextPath}/images/프로필임시.png"> --%>
                    <img src="${pageContext.request.contextPath}/attach/downloadReviewAttach/${list.memNo}">
                </div><!--boardM-->
                <div class="boardT">
                    <ul class="boardT1">
                        <li>이름 : ${list.memNick}</li>
                        <button><a href="">프로필 편집</a></button>
                        <a href="" id="Ta1"><img src="${pageContext.request.contextPath}/images/설정icon.png" id="Timg1" alt="설정"></a>
                        <a href="/home"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="홈으로"></a>
                    </ul> <!-- boardT1 -->
                    <ul class="boardT2">

                        <li>게시물${followcnt.review}</li>
                        <li>팔로워${followcnt.follow}</li>
                        <li>팔로우${followcnt.follower}</li>


                        <li>게시물(123)</li>
                        <li><a href="">팔로워(235)</a></li>
                        <li><a href="">팔로우(433)</a></li>

                    </ul> <!-- boardT2 -->
                    <P>
                    	내용 :${list.memIntro}           
                    </P>
                </div> <!--boardT-->
                <div class="boardA">
                    <ul>
                        <li>
                            <a href="board2">게시물</a>
                            <a href="bookmark">북마크</a>
                            <a href="like">좋아요</a>
                        </li>
                    </ul>
                </div> <!-- boardA -->
            </div><!--inner-->
        </div><!--boaardF-->
	</div><!-- wrapper -->
	<hr>
	
    <script>
        $(function(){
        });
    </script>
    
</body>
</html>
