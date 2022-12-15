<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" type="text/css"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/board.css"> <!--css불러오는 링크-->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>
 	$(function(){
 		memList();
 		//회원조회
 		let profileList = [];
 		function memList() {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/profile/mem",
				method : "get",
				dataType : "json",
				success : function(resp) {
					profileList = resp;
					console.log(profileList);
					$(".mem-name").text("유저 닉네임 : "+profileList.memNick);
					$(".board-cnt").text("게시물 수 : "+profileList.reviewCnt);
					$(".follow-cnt").text("팔로워 : "+profileList.followCnt);
					$(".follower-cnt").text("팔로우 : "+profileList.followerCnt);
					$(".mem-no").text(profileList.memNo);
					$(".mem-info").text(profileList.memIntro);
				}
			});
		};
 	});
</script>
<body>
	<div class="wrapper">
        <div class="boardF">
            <div class="inner">
                <div class="boardM">
                    <%-- <img src="${pageContext.request.contextPath}/images/프로필임시.png"> --%>
                    <%-- <img src="${pageContext.request.contextPath}/attach/downloadReviewAttach/"> --%>
                     <img src="​">  
                    
                </div><!--boardM-->
                <div class="boardT">
                    <ul class="boardT1">
                        <li class="mem-name"> </li>
                        <button><a href="">프로필 편집</a></button>
                        <a href="" id="Ta1"><img src="${pageContext.request.contextPath}/images/설정icon.png" id="Timg1" alt="설정"></a>
                        <a href="/home"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="홈으로"></a>
                    </ul> <!-- boardT1 -->
                    <ul class="boardT2">
						
                        <li class="board-cnt"></li>
                        <li class="follow-cnt"></li>
                        <li class="follower-cnt"></li>

                    </ul> <!-- boardT2 -->
                    <P>	
                    	<span>자기소개</span>
                    	<span class="mem-info"></span>           
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

