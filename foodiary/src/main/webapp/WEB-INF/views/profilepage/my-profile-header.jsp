<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" type="text/css"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/board.css"> <!--css불러오는 링크-->
    <head>
    	<title>프로필</title>
    </head>
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
          bottom: 10px;         
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
        .mem-info-text{
        	font-weight:bold; 
        	font-size: 20px;
        }
        .menu-margin{
        	margin-top: 10px;
        	margin-bottom: 10px;
        }
        .orign{
		width:50px;
		hight:50px;
	}
	.level-img {
 		width:24px;
 		margin:0;
 		margin-left: 5px;
 	}	
 	.relative { 
 		width: 350px;
 		height: 350px;
 		position: relative;
 		}
	.absolute {
	 	width: 50px; 
	 	height: 50px;
	 	position: absolute;
	 	left: 300px;
	 	top: 300px;
	 	background-color:gray;
	 	opacity: 0.5;
	 	text-align: center;
	 	font-size:35px;"src/main/webapp/WEB-INF/views/profilepage/board.jsp"
	 	}
	 	 #modal4 {
          display: none;
          position: absolute;         
          bottom: 10px;
          width:100%;
          height:100%;
          z-index:1;
        }
        
        #modal4 h2 {
          margin:0;
          text-align: center;
        }
        #modal4 button {
          display:inline-block;
          width:100px;
          margin-left:calc(100% - 100px - 10px);
        }
        
        #modal4 .modal_content4 {
          width:300px;
          margin:100px auto; 
          padding:20px 10px;
          background:#fff;
          border:10px solid #666;
        }
        
        #modal4 .modal_layer {
          position:fixed;
          top:0;
          left:0;
          width:100%;
          height:100%;
          background:rgba(0, 0, 0, 0.5);
          z-index:-1;
        } 
	object-fit:cover; 
      
</style> 
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>
    $(function(){
       memList();
       followMem();
       followerMem()
       
       //회원번호 확인
       var memNo = "<%=(Integer)session.getAttribute("loginNo")%>";
		console.log(memNo);       
    
       //리뷰리스트 조회 
       let reviewList1 = [];
       
       //초기 리뷰리스트 설정 
       reviewList();
       function reviewList() {
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/profile/reviewlist",
					method : "get",
					dataType : "json",
					success : function(resp) {
						reviewList1 = resp;
						renderList();
					}
				});
			};
       
		
		//게시물 버튼 선택시 조회 
		$(".board-btn").click(function(e){
			$(".feed").empty();
			reviewList();
			e.preventDefault();
			function reviewList() {
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/profile/reviewlist",
					method : "get",
					dataType : "json",
					success : function(resp) {
						reviewList1 = resp;
						renderList();
					}
				});
			};
		});
		//북마크 리스트 조회 
		$(".bookmark-btn").click(function(e){
			$(".feed").empty();
			reviewList();
			e.preventDefault();
		function reviewList() {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/profile/bookmarklist",
				method : "get",
				dataType : "json",
				success : function(resp) {
					reviewList1 = resp;
					renderList();
			}
		});
		};
	});
	
	//좋아요 리스트 조회
	$(".like-btn").click(function(e){
		$(".feed").empty();
		reviewList();
		e.preventDefault();
		function reviewList() {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/profile/likelist",
				method : "get",
				dataType : "json",
				success : function(resp) {
					reviewList1 = resp;
					renderList();
				}
			});
		};
	});
		 
		
	//리뷰 목록 출력
	function renderList(){
			if(reviewList1.length != 0){
			$.each(reviewList1, function(index, value) {
				
				// 사진갯수가 0 이상이라면 
				if(value.imgCnt>1){
				
				var imgspan=$("<p>").text("+"+(value.imgCnt-1));
				imgspan.addClass("absolute");
				var reviewImg = $("<img>").attr("src","${pageContext.request.contextPath}/attach/downloadReviewAttach/"+value.reviewNo);
				reviewImg.addClass("relative");
				var imgDiv=$("<div>").append(reviewImg).append(imgspan);
				imgDiv.addClass("relative");
				
				$(reviewImg).hover(function(){
					$(this).addClass("feedimg");
				
				});
				
				var span2=$("<span>").text("   "+value.likeCnt+" ");
				var iheart=$("<i>").append(span2);
				iheart.addClass("fa-solid fa-heart");
				
				var span3=$("<span>").text("   "+value.replyCnt+" ");
				var imessage=$("<i>").append(span3);
				imessage.addClass("fa-solid fa-message");
				
				var span4=$("<span>").text(" ");
				
				var figure=$("<figure>").html(imgDiv);
				//var figcaption=$("<figcaption>").text("좋아요"+value.likeCnt+"사진갯수"+value.imgCnt+"댓글갯수"+value.replyCnt);
				var figcaption=$("<figcaption>").append(iheart).append(span4).append(imessage);
				
				var feeda = $("<a>").attr("data-rno", value.reviewNo).append(figure).append(figcaption);
				feeda.addClass("review-main");
				reviewImg.addClass("img-size");
				
				
				//var feedli=$("<li>").html(figure).append(figcaption);
				var feedli=$("<li>").append(feeda);
				var feedimg=$("<div>").html(feedli);
				feedimg.addClass("feedimg");
				var feedul=$("<ui>").html(feedimg);
				}else{
					var reviewImg = $("<img>").attr("src","${pageContext.request.contextPath}/attach/downloadReviewAttach/"+value.reviewNo);
					$(reviewImg).hover(function(){
						$(this).addClass("feedimg");
						
					});
					
					var span2=$("<span>").text("   "+value.likeCnt+" ");
					var iheart=$("<i>").append(span2);
					iheart.addClass("fa-solid fa-heart");
					
					var span3=$("<span>").text("   "+value.replyCnt+" ");
					var imessage=$("<i>").append(span3);
					imessage.addClass("fa-solid fa-message");
					
					var span4=$("<span>").text(" ");
					
					var figure=$("<figure>").html(reviewImg);
					figure.addClass("relative");
					//var figcaption=$("<figcaption>").text("좋아요"+value.likeCnt+"사진갯수"+value.imgCnt+"댓글갯수"+value.replyCnt);
					var figcaption=$("<figcaption>").append(iheart).append(span4).append(imessage);
					
					var feeda = $("<a>").attr("data-rno", value.reviewNo).append(figure).append(figcaption);
					feeda.addClass("review-main");
					reviewImg.addClass("img-size");
					
					
					//var feedli=$("<li>").html(figure).append(figcaption);
					
					var feedli=$("<li>").append(feeda);
					var feedimg=$("<div>").html(feedli);
					feedimg.addClass("feedimg");
					var feedul=$("<ui>").html(feedimg);
					var main=$(".feed").append(feedul);//.append(figcaption);
				};
				
	
				
				var main=$(".feed").append(feedul);//.append(figcaption);
				});
			}else{
				var noReview = $("<div>").append("<span class='no-review'>작성한 리뷰가 없습니다.</span>");
				$(".main").append(noReview);
			}
	};		
	//이미지~텍스트 영역 클릭 시, 리뷰 상세로 이동
	$(document).on("click", ".review-main", function(){
		window.location = "${pageContext.request.contextPath}/review/detail?reviewNo="+$(this).data("rno");
	});
       //회원조회
       let profileList = [];
       function memList() {
         $.ajax({
            url : "${pageContext.request.contextPath}/rest/profile/mem",
            method : "get",
            dataType : "json",
            success : function(resp) {
               profileList = resp;
               //$(".mem-name").text("유저 닉네임 : "+profileList.memNick);
               $(".board-cnt").text("게시물 수 : "+profileList.reviewCnt);
               $(".follow-cnt").text("팔로워 : "+profileList.followCnt);
               $(".follower-cnt").text("팔로우: "+profileList.followerCnt);
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
               //게시물/북마크/좋아요 hover시 css 진하게
               $(".board-btn").hover(
	            	function(){$(this).text("게시물").css("font-weight","bolder")},
    	        	function(){$(this).text("게시물").css("font-weight","bold")}
        	    	);
               $(".bookmark-btn").hover(
                   	function(){$(this).text("북마크").css("font-weight","bolder")},
                   	function(){$(this).text("북마크").css("font-weight","bold")}
                   	);
               $(".like-btn").hover(
                   	function(){$(this).text("좋아요").css("font-weight","bolder")},
                   	function(){$(this).text("좋아요").css("font-weight","bold")}
                   	);
               
             
               
            
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
               var iInfo=$("<i>");
               iInfo.addClass("fa-sharp fa-solid fa-circle-info");
               $(".mem-name").append(span).append(writerLevel).append(iInfo);            
               var imgClass=$("[name=orgin]");
               //사진이 있는지 없는지 확인
               if(profileList.attachNo != 0){
                  $("[name=origin]").attr("src","${pageContext.request.contextPath}/attach/download/"+profileList.attachNo);
               }else{
                  $("[name=origin]").attr("src","${pageContext.request.contextPath}/images/basic-profile.png");
               }
               //iInfo 버튼을 눌렀을 때 
               $(".fa-circle-info").click(function(){
            	  $("#modal4").fadeIn(); 
               });
               
               var mypoint=profileList.memPoint;
               $(".get-point").text("나의 포인트 :"+mypoint);
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
      
          if(followMemList.length != 0) {
            $.each(followMemList, function(index, value) {
               
               //팔로우 레벨 이미지 
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
               if(memNo != value.memNo){
			   var a=$("<a>").attr("href","${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+value.memNo).append(img).append(span).append(writerLevel);
				}else{
					var a=$("<a>").attr("href","${pageContext.request.contextPath}/profilepage/my-profile-header").append(img).append(span).append(b).append(writerLevel);
				}
               img.addClass("follow-img");
               var hr=$("<hr>");
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
               if(value.attachNo != 0){
                  $(img).attr("src","${pageContext.request.contextPath}/attach/download/"+value.attachNo);
               }else{
                  $(img).attr("src","${pageContext.request.contextPath}/images/basic-profile.png");
               }
               $(".modal_content").css("display","block");
               $(".modal_content").append(a).append(buttonFollow).append(hr).append(br);
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
               //팔로우가 되어있는 상태인지 아닌지확인
               var buttonFollow;
               if(value.followCheck){
                  var buttonFollow=$("<button>").text("팔로잉");
                  buttonFollow.addClass("follow-cert");
               }else{
                  var buttonFollow=$("<button>").text("팔로우");
                  buttonFollow.addClass("follow-cert");
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
               
               
               var span=$("<span>").text(value.memNick + value.attachNo);
               var img=$("<img>").attr("src","");
               var br=$("<br>");
               var hr=$("<hr>");
               if(memNo != value.memNo){
    			   var a=$("<a>").attr("href","${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+value.memNo).append(img).append(span).append(writerLevel);
    				}else{
    					var a=$("<a>").attr("href","${pageContext.request.contextPath}/profilepage/my-profile-header").append(img).append(span).append(b).append(writerLevel);
    				}
               img.addClass("follow-img");
               //사진 번호가 있는지 없는지. 
               if(value.attachNo != 0){
                  $(img).attr("src","${pageContext.request.contextPath}/attach/download/"+value.attachNo);
               }else{
                  $(img).attr("src","${pageContext.request.contextPath}/images/basic-profile.png");
               }
               
               $(".modal_content2").append(a).append(buttonFollow).append(hr).append(br);
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
                        <a href="${pageContext.request.contextPath}/mem/edit_profile"><i class="fa-solid fa-pencil fa-lg"></i></a>
                        <img class="menu" src="${pageContext.request.contextPath}/images/설정icon.png" id="Timg1" alt="설정">
                        <a href="/home"><img src="${pageContext.request.contextPath}/images/Foodiary-logo.png" alt="홈으로"></a>
                    </ul> <!-- boardT1 -->
                    <ul class="boardT2">            
                        
                           <li class="board-cnt board-btn"></li>
                       
                        <a href="#"><li class="follow-cnt"></li></a>
                        <a href="#"><li class="follower-cnt"></li></a>
                    </ul> <!-- boardT2 -->
                    <P>   
                       <span class="mem-info-text">자기소개</span><br><br>
                       <span class="mem-info"></span>           
                    </P>
                </div> <!--boardT-->
                <div class="boardA">
                    <ul>
                        <li>
                            <a href="board" class="board-btn">게시물</a>
                            <a href="bookmark" class="bookmark-btn">북마크</a>
                            <a href="like" class="like-btn">좋아요</a>
                        </li>
                    </ul>
                </div> <!-- boardA -->
            </div><!--inner-->
        </div><!--boaardF--
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
         <span class="menu-margin">비밀번호 변경</span>
         </a>
      </h2>
      <hr>
      <h2 class="menu-top">
         <a href="${pageContext.request.contextPath}/mem/leave">
            <span class="menu-margin">탈퇴하기</span>
         </a>
      </h2>
      <hr>
      <h2 class="menu-top">
         <a href="${pageContext.request.contextPath}/mem/inquiry">
            <span class="menu-margin">문의하기</span>
         </a>
      </h2>
      <hr>
      <h2 class="menu-btn menu-top menu-margin">취소</h2>
    </div>
    <div class="modal_layer"></div>
</div>

<!-- 회원 인포 모달 --> 
 <div id="modal4">
    <div class="modal_content4">
    <h2 class="level-condition">레벨 조건</h2>
    <span class="get-point"></span> <hr>
    <img class="level-img2" src="${pageContext.request.contextPath}/images/1.밀.png"> 회원 점수 : 0~24점 <hr>
    <img class="level-img2" src="${pageContext.request.contextPath}/images/2.밀가루.png"> 회원 점수 : 25~49점<hr>
    <img class="level-img2" src="${pageContext.request.contextPath}/images/3.반죽.png"> 회원 점수 : 50~99점<hr>
    <img class="level-img2" src="${pageContext.request.contextPath}/images/4.조각피자.png"> 회원 점수 : 100~299점<hr>
    <img class="level-img2" src="${pageContext.request.contextPath}/images/5.피자콜라.png"> 회원 점수 : 300~999점<hr>
    <img class="level-img2" src="${pageContext.request.contextPath}/images/6.피잣집.png"> 회원 점수 : 1000~<hr>
    리뷰작성시 +5점 <br>
    좋아요 +1점 
    </div>
    <div class="modal_layer"></div>
</div>
<section class="section1">	
		<div class="feed"></div>	
</section>
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
     location.reload();
  });  
</script>
</html>
