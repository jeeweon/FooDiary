<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" type="text/css"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/board.css"> <!--css불러오는 링크-->
    <head>
    	<title>프로필</title>
    </head>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<style>
        #modal {
          display: none;
          position: absolute;   
          bottom: 10px;         
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
          bottom: 10px;         
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
        	width:50px;
        	height:50px;
        }
          .level-img {
 		width:10px;
 		height:50px;
 		}
 		.level-img2 {
 		width:30px;
 		height:30px;
 		}
 		.mem-info-text{
        font-weight:bold; 
        font-size: 20px;
        }
 </style>
<script>
 	$(function(){
 		memList();
 		followCert();	
 		followMem();
 		followerMem();
 		
 		//회원번호 확인
        var memNo = "<%=(Integer)session.getAttribute("loginNo")%>";
 		console.log(memNo);
 		
 		//회원조회
 		let profileList = [];
 		function memList() {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/profile/yourprofile?memNo="+${memNo},
				method : "get",
				dataType : "json",
				success : function(resp) {
					profileList = resp;
					console.log(profileList);
					//$(".mem-name").text("유저 닉네임 : "+profileList.memNick);
					$(".board-cnt").text("게시물 수 : "+profileList.reviewCnt);
					$(".follow-cnt").text("팔로워 : "+profileList.followCnt);
					$(".follower-cnt").text("팔로우 : "+profileList.followerCnt);
					$(".mem-no").text(profileList.memNo);
					$(".mem-info").text(profileList.memIntro);
					
					 //게시판 팔로우 팔로잉 호버시 포커스
					 	$(".board-cnt").hover(function(){
					 		$(this).css("cursor","zoom-in");
					 	})
		               $(".follow-cnt").hover(function(){
		             	  $(this).css("cursor","zoom-in"); 
		                });
					 
		               $(".follower-cnt").hover(function(){
		             	  $(this).css("cursor","zoom-in"); 
		                });
					
					
					
					//회원레벨 이미지
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
		
		//팔로우 했는지 안했는지 확인 
		
		 function followCert(){
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/profile/followcert?memNo="+${memNo},
				method : "get",
				dataType : "json",
				success : function(resp) {
					if(resp){
						$(".follow-cert").text("팔로잉");
					}else{
						$(".follow-cert").text("#");
					}
				}
			});
		} 
		
		// 팔로우버튼 클릭시 
		$(".follow-cert").click(function(){
			$.ajax({
				url:"${pageContext.request.contextPath}/rest/review/follow",
				method:"post",
				data:{
					passiveMemNo : ${memNo}	
				},
				success:function(resp){
					if(resp){
						$(".follow-cert").text("팔로잉");
					}else{
						$(".follow-cert").text("팔로우");
					}
					$.ajax({
						url:"${pageContext.request.contextPath}/rest/profile/followcnt",
						method:"post",
						data:{
							passiveMemNo : ${memNo}
						},
						success:function(resp){
								$(".follow-cnt").text("팔로워 : "+resp);
						}
					});
				}
			});
		});
		
		//팔로우멤버 조회
		var followMemList = [];
		function followMem(){
			$.ajax({
				url:"${pageContext.request.contextPath}/rest/profile/yourfollowmem?memNo="+${memNo},
				method :"get",
				dataType:"json",
				success:function(resp){
					followMemList=resp;
					renderfollowList()
					console.log("팔로우 멤버");
					console.log(followMemList);
				}
			}); 
		};
		
		//팔로우 목록 출력
		function renderfollowList(){
			 if(followMemList.length != 0) {
				$.each(followMemList, function(index, value) {
					
					
					//팔로우 레벨 이미지
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
					if(memNo != value.memNo){
						var a=$("<a>").attr("href","${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+value.memNo).append(img).append(span).append(writerLevel);
					}else{
						var a=$("<a>").attr("href","${pageContext.request.contextPath}/profilepage/my-profile-header").append(img).append(span).append(b).append(writerLevel);
					}
					var hr=$("<hr>");
					
					img.addClass("follow-img");
					//팔로우가 되어있는 상태인지 아닌지확인
					var buttonFollow;
					if(value.followCheck){
						var buttonFollow=$("<button>").text("팔로잉");
					}else{
						var buttonFollow=$("<button>").text("팔로우");
					}
					//팔로우 버튼을 클릭했을 때 이벤트 발생
		               $(buttonFollow).click(function(){
		            	   var that=$(this);
		            	 $.ajax({
		            		 url:"${pageContext.request.contextPath}/rest/review/follow",
		     				method:"post",
		     				data:{
		     					passiveMemNo : value.memNo	
		     				},
		     				success:function(resp){
		     					if(resp){
		     						$(that).text("팔로잉");			
		     					}else{
		     						$(that).text("팔로우");
		     					}
		     				}
		            	 }); 
		               });
		             //사진 번호가 있는지 없는지. 
					console.log("팔로우 이미지 넘버");
					console.log(value.attachNo);
		               
					//사진 번호가 있는지 없는지. 
					if(value.attachNo != 0){
						$(img).attr("src","${pageContext.request.contextPath}/attach/download/"+value.attachNo);
					}else{
						$(img).attr("src","${pageContext.request.contextPath}/images/basic-profile.png");
					}
					$(".modal_content").css("display","block");
					$(".modal_content").append(a).append(buttonFollow).append(hr).append(br);
				});
			}else{
			
				var span=$("<span>").text("선택된 팔로우가 없습니다.")
				$(".modal_content").append(span);
			}
		};
		
		//팔로워멤버 조회
		var followerMemList=[];
		function followerMem(){
			$.ajax({
				url:"${pageContext.request.contextPath}/rest/profile/yourfollowermem?memNo="+${memNo},
				method :"get",
				dataType:"json",
				success:function(resp){
					followerMemList=resp;
					renderfollowerList();
					console.log("팔로워 멤버");
					console.log(followerMemList);
				}
			}); 
		};
		
		//팔로워 목록 출력
		function renderfollowerList(){
			 if(followerMemList.length != 0) {
				$.each(followerMemList, function(index, value) {
					//팔로워 레벨 이미지
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
					if(memNo != value.memNo){
						var a=$("<a>").attr("href","${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+value.memNo).append(img).append(span).append(writerLevel);
					}else{
						var a=$("<a>").attr("href","${pageContext.request.contextPath}/profilepage/my-profile-header").append(img).append(span).append(b).append(writerLevel);
					}
					var hr=$("<hr>");
					
					img.addClass("follow-img");
					//팔로우가 되어있는 상태인지 아닌지확인
					var buttonFollow;
					if(value.followCheck){
						var buttonFollow=$("<button>").text("팔로잉");
					}else{
						var buttonFollow=$("<button>").text("팔로우");
					}
					//팔로우 버튼을 클릭했을 때 이벤트 발생
		               $(buttonFollow).click(function(){
		            	   var that=$(this);
		            	 $.ajax({
		            		 url:"${pageContext.request.contextPath}/rest/review/follow",
		     				method:"post",
		     				data:{
		     					passiveMemNo : value.memNo	
		     				},
		     				success:function(resp){
		     					if(resp){
		     						$(that).text("팔로잉");			
		     					}else{
		     						$(that).text("팔로우");
		     					}
		     				}
		            	 }); 
		               });
		               
					//사진 번호가 있는지 없는지. 
					console.log("팔로워 이미지 넘버");
					console.log(value.attachNo);
					if(value.attachNo != 0){
						$(img).attr("src","${pageContext.request.contextPath}/attach/download/"+value.attachNo);
					}else{
						$(img).attr("src","${pageContext.request.contextPath}/images/basic-profile.png");
					}
					
					$(".modal_content2").append(a).append(buttonFollow).append(hr).append(br);
				});
			}else{
				var span2=$("<span>").text("선택된 팔로우가 없습니다.");
				$(".modal_content2").append(span2);
			} 
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
                	 <img name="origin" class="preview preview-hover">  
                    
                </div><!--boardM-->
                <div class="boardT">
                    <ul class="boardT1">
                        <li class="mem-name">
                        
                         </li>
                        <button class="follow-cert"></button>
                        <a href="/home"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="홈으로"></a>
                    </ul> <!-- boardT1 -->
                    <ul class="boardT2">
                    <a href="${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo=${memNo}">
                        <li class="board-cnt"></li>
                    </a>
                        <li class="follow-cnt"></li>
                        <li class="follower-cnt"></li>

                    </ul> <!-- boardT2 -->
                    <P>	
                    	<span class="mem-info-text">자기소개</span><br><br>
                    	<span class="mem-info"></span>           
                    </P>
                </div> <!--boardT-->
                <div class="boardA">
                    <ul>
                        <li>
                            <a href="yourreviewlist?memNo=${memNo}">게시물</a>
                        </li>
                    </ul>
                </div> <!-- boardA -->
            </div><!--inner-->
        </div><!--boaardF-->
	</div><!-- wrapper -->
	</body>
	<!-- 팔러우  모달 --> 
 <div id="modal">
    <div class="modal_content">
        <h2 class="follow-btn">팔로우</h2>
        <hr> 
    </div>
    <div class="modal_layer"></div>
</div>

<!-- 팔로워모달 --> 
 <div id="modal2">
    <div class="modal_content2">
        <h2 class="follower-btn">팔로워</h2>
        <hr>
    </div>
    <div class="modal_layer"></div>
</div>
	
    <script>
  
    $(".follower-cnt").click(function(){
    	$("#modal").fadeIn();
    });
   	$(".follow-btn").click(function(){
	  $("#modal").fadeOut(); 
	  location.reload();
   	});
   
   	$(".follow-cnt").click(function(){
   	 	  $("#modal2").fadeIn();
   	});
  	$(".follower-btn").click(function(){
		  $("#modal2").fadeOut();
		  location.reload();
  	});
  	$(".modal_layer").click(function(){
  		$("#modal").fadeOut();
  	  	$("#modal2").fadeOut();
  	  	location.reload();
  	});
</script>
    
</html>
