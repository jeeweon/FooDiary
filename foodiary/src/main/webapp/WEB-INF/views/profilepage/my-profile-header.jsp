<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" type="text/css"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/board.css"> <!--css불러오는 링크-->
    <style>
        #modal {
          display: none;
          position: absolute;         
          width:100%;
          height:100%;
          z-index:1;
        }
        
        #modal h2 {
          margin:0;
          text-align: center;
        }
        #modal button {
          display:inline-block;
          width:100px;
          margin-left:calc(100% - 100px - 10px);
        }
        
        #modal .modal_content {
          width:300px;
          margin:100px auto; 
          padding:20px 10px;
          background:#fff;
          border:10px solid #666;
        }
        
        #modal .modal_layer {
          position:fixed;
          top:0;
          left:0;
          width:100%;
          height:100%;
          background:rgba(0, 0, 0, 0.5);
          z-index:-1;
        }  
 		#modal2 {
          display: none;
          position: absolute;         
          width:100%;
          height:100%;
          z-index:1;
        }
        
        #modal2 h2 {
          margin:0;
          text-align: center;
        }
        #modal button2 {
          display:inline-block;
          width:100px;
          margin-left:calc(100% - 100px - 10px);
        }
        
        #modal2 .modal_content2 {
          width:300px;
          margin:100px auto;
          padding:20px 10px;
          background:#fff;
          border:10px solid #666;
        }
        
        #modal2 .modal_layer {
          position:fixed;
          top:0;
          left:0;
          width:100%;
          height:100%;
          background:rgba(0, 0, 0, 0.5);
          z-index:-1;
        }  
        .follow-img{
        	width:30px;
        	height:30px;
        } 
        .level-img {
 		width:10px;
 		height:50px;
 		}
 		
 		.level-img2 {
 		width:30px;
 		height:30px;
 		}
 		#modal3 {
          display: none;
          position: absolute;         
          width:100%;
          height:100%;
          z-index:1;
        }
        
        #modal3 h2 {
          margin:0;
          text-align: center;
        }
        #modal3 button {
          display:inline-block;
          width:100px;
          margin-left:calc(100% - 100px - 10px);
        }
        
        #modal3 .modal_content3 {
          width:500px;
          margin:100px auto;
          padding:20px 10px;
          background:#fff;
          border:10px solid #666;
        }
        
        #modal3 .modal_layer {
          position:fixed;
          top:0;
          left:0;
          width:100%;
          height:100%;
          background:rgba(0, 0, 0, 0.5);
          z-index:-1;
        }  
        .menu-top{
       	margin-top:50em;
        }
      
</style> 
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>
 	$(function(){
 		memList();
 		followMem();
 		followerMem()

 		//회원조회
 		let profileList = [];
 		function memList() {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/profile/mem",
				method : "get",
				dataType : "json",
				success : function(resp) {
					profileList = resp;
					console.log("회원"+resp);
					console.log("회원 레벨"+profileList.memLevel);
					//$(".mem-name").text("유저 닉네임 : "+profileList.memNick);
					$(".board-cnt").text("게시물 수 : "+profileList.reviewCnt);
					$(".follow-cnt").text("팔로워 : "+profileList.followCnt);
					$(".follower-cnt").text("팔로우: "+profileList.followerCnt);
					$(".mem-no").text(profileList.memNo);
					$(".mem-info").text(profileList.memIntro);
					
					
					
					var writerLevel;
					if( profileList.memLevel== "6  ") { //db에 char(3)으로 넣어서 한 자리인 경우 공백 생김
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/6.피잣집.png");
					} else if (profileList.memLevel == "5  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/5.피자콜라.png");
					} else if (profileList.memLevel == "4  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/4.조각피자.png");
					} else if (profileList.memLevel == "3  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/3.반죽.png");
					} else if (profileList.memLevel == "2  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/2.밀가루.png");
					} else {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/1.밀.png");
					}
					writerLevel.addClass("level-img");
					
					
					var span=$("<span>").text("유저 닉네임 : "+profileList.memNick);
					var img=$("<img>").attr("src", "${pageContext.request.contextPath}/images/6.피잣집.png");
					img.addClass("level-img");
					$(".mem-name").append(span).append(writerLevel);
					
					var imgClass=$("[name=orgin]");
					//사진이 있는지 없는지 확인
					if(profileList.attachNo != 0){
						$("[name=origin]").attr("src","${pageContext.request.contextPath}/attach/download/"+profileList.attachNo);
					}else{
						$("[name=origin]").attr("src","${pageContext.request.contextPath}/images/basic-profile.png");
					}
				}
			});
 		};
		//팔로우멤버 조회
		var followMemList = [];
		function followMem(){
			$.ajax({
				url:"${pageContext.request.contextPath}/rest/profile/followmem",
				method :"get",
				dataType:"json",
				success:function(resp){
					followMemList=resp;
					console.log(followMemList);
					renderfollowList();
				}
			}); 
		};
		//팔로우 목록 출력
		function renderfollowList(){
			console.log("팔로우 목록 출력");
			 if(followMemList.length != 0) {
				$.each(followMemList, function(index, value) {
					
					//팔로워 레벨 이미지 
					var writerLevel;
					if( followerMemList.memLevel== "6  ") { //db에 char(3)으로 넣어서 한 자리인 경우 공백 생김
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/6.피잣집.png");
					} else if (followMemList.memLevel == "5  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/5.피자콜라.png");
					} else if (followMemList.memLevel == "4  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/4.조각피자.png");
					} else if (followMemList.memLevel == "3  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/3.반죽.png");
					} else if (followMemList.memLevel == "2  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/2.밀가루.png");
					} else {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/1.밀.png");
					}
					writerLevel.addClass("level-img2");
					
					var span=$("<span>").text(value.memNick + value.attachNo);
					var img=$("<img>").attr("src","");
					var br=$("<br>");
					//a+img+span
					var a=$("<a>").attr("href","${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+value.memNo).append(img).append(span).append(writerLevel);
					img.addClass("follow-img");
					var hr=$("<hr>");
					//사진 번호가 있는지 없는지. 
					if(value.attachNo != 0){
						$(img).attr("src","${pageContext.request.contextPath}/attach/download/"+value.attachNo);
					}else{
						$(img).attr("src","${pageContext.request.contextPath}/images/basic-profile.png");
					}
					$(".modal_content").css("display","block");
					$(".modal_content").append(a).append(hr).append(br);
				});
			}else{
				$(".follow-span").text("선택된 팔로우가 없습니다.");
			} 
		};
		
		//팔로워멤버 조회
		var followerMemList=[];
		function followerMem(){
			$.ajax({
				url:"${pageContext.request.contextPath}/rest/profile/followermem",
				method :"get",
				dataType:"json",
				success:function(resp){
					followerMemList=resp;
					console.log(followerMemList);
					renderfollowerList()
				}
			}); 
		};
	
		//팔로워 목록 출력
		function renderfollowerList(){
			console.log("팔로우 목록 출력");
			 if(followerMemList.length != 0) {
				$.each(followerMemList, function(index, value) {
					
					//팔로 레벨 이미지
					var writerLevel;
					if( followerMemList.memLevel== "6  ") { //db에 char(3)으로 넣어서 한 자리인 경우 공백 생김
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/6.피잣집.png");
					} else if (followerMemList.memLevel == "5  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/5.피자콜라.png");
					} else if (followerMemList.memLevel == "4  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/4.조각피자.png");
					} else if (followerMemList.memLevel == "3  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/3.반죽.png");
					} else if (followerMemList.memLevel == "2  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/2.밀가루.png");
					} else {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/1.밀.png");
					}
					writerLevel.addClass("level-img2");
					
					
					var span=$("<span>").text(value.memNick + value.attachNo);
					var img=$("<img>").attr("src","");
					var br=$("<br>");
					var hr=$("<hr>");
					var a=$("<a>").attr("href","${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+value.memNo).append(img).append(span).append(writerLevel);
					img.addClass("follow-img");
					//사진 번호가 있는지 없는지. 
					if(value.attachNo != 0){
						$(img).attr("src","${pageContext.request.contextPath}/attach/download/"+value.attachNo);
					}else{
						$(img).attr("src","${pageContext.request.contextPath}/images/basic-profile.png");
					}
					
					$(".modal_content2").append(a).append(hr).append(br);
				});
			}else{
				$(".follower-span").text("선택된 팔로워가 없습니다.");
			}  
		};
		
		
		
 	});
</script>
<body class="body">
	<div class="wrapper">
        <div class="boardF">
            <div class="inner">
                <div class="boardM">
                    <%-- <img src="${pageContext.request.contextPath}/images/프로필임시.png"> --%>
                    <%-- <img src="${pageContext.request.contextPath}/attach/downloadReviewAttach/"> --%>
                <img name="origin" class="preview preview-hover">                
                </div><!--boardM-->
                <div class="boardT">
                    <ul class="boardT1">
                        <li class="mem-name">
                        
                         </li>    
                        <button><a href="${pageContext.request.contextPath}/mem/edit_profile">프로필 편집</a></button>
                        <img class="menu" src="${pageContext.request.contextPath}/images/설정icon.png" id="Timg1" alt="설정">
                        <a href="/home"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="홈으로"></a>
                    </ul> <!-- boardT1 -->
                    <ul class="boardT2">				
                        <a href="${pageContext.request.contextPath}/profilepage/board">
    	                    <li class="board-cnt"></li>
	                    </a>
                        <a href="#"><li class="follow-cnt"></li></a>
                        <a href="#"><li class="follower-cnt"></li></a>
                    </ul> <!-- boardT2 -->
                    <P>	
                    	<span>자기소개</span><br><br>
                    	<span class="mem-info"></span>           
                    </P>
                </div> <!--boardT-->
                <div class="boardA">
                    <ul>
                        <li>
                            <a href="board">게시물</a>
                            <a href="bookmark">북마크</a>
                            <a href="like">좋아요</a>
                        </li>
                    </ul>
                </div> <!-- boardA -->
            </div><!--inner-->
        </div><!--boaardF-->
	</div><!-- wrapper -->	
	
	
<!-- 팔러우  모달 --> 
 <div id="modal">
   
    <div class="modal_content">
        <h2 class="follow-btn">팔로우</h2>
        <hr> 
        <span class="follow-span"></span>
        <hr>
        <!-- <h2 class="follow-btn">취소</h2> -->
    </div>
    <div class="modal_layer"></div>
</div>

<!-- 팔로워모달 --> 
 <div id="modal2">
    <div class="modal_content2">
        <h2 class="follower-btn">팔로워</h2>
        <hr>
        <span class="follower-span"></span>
        <hr>
        <!-- <h2 class="follower-btn">취소</h2> -->
    </div>
    <div class="modal_layer"></div>
</div>

<!-- 설정창 -->
 <div id="modal3">
    <div class="modal_content3">
      <h2 class="menu-top">
      	<a href="${pageContext.request.contextPath}/mem/check_pw">
      	비밀번호 변경
      	</a>
      </h2>
      <hr>
      <h2 class="menu-top">
      	<a href="${pageContext.request.contextPath}/mem/leave">
      		탈퇴하기
      	</a>
      </h2>
      <hr>
      <h2 class="menu-top">
      	<a href="${pageContext.request.contextPath}/mem/inquiry">
     	 	문의
     	 </a>
      </h2>
      <hr>
      <h2 class="menu-btn menu-top">취소</h2>
    </div>
    <div class="modal_layer"></div>
</div>


</body>
<script>
    $(".follower-cnt").click(function(){
    	$("#modal").fadeIn();
    });
   $(".follow-btn").click(function(){
	  $("#modal").fadeOut(); 
   });
   
   $(".follow-cnt").click(function(){
   	$("#modal2").fadeIn();
   });
  $(".follower-btn").click(function(){
	  $("#modal2").fadeOut(); 
  });
  
  $(".menu").click(function(){
  	$("#modal3").fadeIn();
   });
  $(".menu-btn").click(function(){
     $("#modal3").fadeOut(); 
	  });
    $(".modal_layer").click(function(){
	  $("#modal").fadeOut(); 
	  $("#modal2").fadeOut();
	  $("#modal3").fadeOut();
  });  
</script>
</html>


					<%-- var writerLevel;
					if(value.memLevel == "6  ") { //db에 char(3)으로 넣어서 한 자리인 경우 공백 생김
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/6.피잣집.png");
					} else if (value.memLevel == "5  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/5.피자콜라.png");
					} else if (value.memLevel == "4  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/4.조각피자.png");
					} else if (value.memLevel == "3  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/3.반죽.png");
					} else if (value.memLevel == "2  ") {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/2.밀가루.png");
					} else {
						writerLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/1.밀.png");
					}
					writerLevel.addClass("level-img"); --%>

