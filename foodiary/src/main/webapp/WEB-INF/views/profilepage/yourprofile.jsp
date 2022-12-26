<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
    
    <link rel="stylesheet" type="text/css"href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/vs-css/board.css"> <!--css불러오는 링크-->
    <!-- toast 스타일 -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" /> 
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
        .modal_content a span{
        	position: relative;
        	top: 7px;
        	margin-right: 5px;
        	margin-left: 5px;
        }
        .modal_content .level-img2{
        	position: relative;
        	width: 24px;
        	height: 24px;
        	top: 12px;
        }
        .modal_content button{
        	position: relative;
        	bottom: 13px;
        	font-size: 15px;
        	border: none;
        	background: none;
        	outline: none;
        	color: #0095f6;
        }
        
        .modal_content .follow-img{
        	position: relative;
        	top: 15px;
        	border-radius: 50%;
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
        .modal_content2 a span{
        	position: relative;
        	bottom: 15px;
        	margin-left: 10px;
        	margin-right: 10px;
        }
       
        .modal_content2 .follow-img{
        	position: relative;
        	width: 30px;
        	height: 30px;
        	border-radius: 50%;
        	top: 1px;
        	margin-top: 10px;
        	margin-bottom: 10px;
        	margin-left: 10px;
        }
        .modal_content2 button{
        	position: relative;
        	border: none;
        	background: none;
        	outline: none;
        	color: #0095f6;
        	bottom: 14px;
        	left: 20px;
        	font-size: 15px;
        }
        .modal_content2 .level-img2{
        	position: relative;
        	width: 24px;
        	height: 24px;
        	bottom: 11px;
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
 		.mem-info-text{
        font-weight:bold; 
        font-size: 20px;
        }
        .yourF{
        	width: 875px;
        	border-bottom: 1px solid black;
        }
        .yourF ul{
        	text-align: center;
        }
 </style>
 <script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<!-- sockjs 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<!-- toast 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<!-- moment 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>
<script>
 	$(function(){
 		memList();
 		followCert();	
 		followMem();
 		followerMem();
 		
 		//회원번호 확인
        var memNo = "<%=(Integer)session.getAttribute("loginNo")%>";
        var memNick = "<%=(String)session.getAttribute("loginNick")%>";
 		
      	//웹소켓 연결
    	if(memNo != null){
    		connectWs();
    	}
    	
    	//웹소켓
    	function connectWs(){
    		var uri = "${pageContext.request.contextPath}/ws/sockjs";
    		socket = new SockJS(uri);
  
    		toastr.options = {
    		  "closeButton": false,
    		  "debug": false,
    		  "newestOnTop": false,
    		  "progressBar": false,
    		  "positionClass": "toast-top-right",
    		  "preventDuplicates": false,
    		  "onclick": null,
    		  "showDuration": "100",
    		  "hideDuration": "2000",
    		  "timeOut": "1500",
    		  "extendedTimeOut": "1000",
    		  "showEasing": "swing",
    		  "hideEasing": "linear",
    		  "showMethod": "fadeIn",
    		  "hideMethod": "fadeOut"
    		}
    		
    		socket.onmessage = function(e){
    			//수신된 e.data는 JSON 문자열
    			var data = JSON.parse(e.data);
    			toastr.info(data.notiContent);
    		};
    	};
        
 		//회원조회
 		let profileList = [];
 		function memList() {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/profile/yourprofile?memNo="+${memNo},
				method : "get",
				dataType : "json",
				success : function(resp) {
					profileList = resp;
					$(".board-cnt").text("리뷰 "+profileList.reviewCnt);
					$(".follow-cnt").text("팔로워 "+profileList.followCnt);
					$(".follower-cnt").text("팔로우 "+profileList.followerCnt);
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
					
					
					
					var span=$("<span>").text(profileList.memNick);
					$(".follow-cert").attr("data-mnick", profileList.memNick);
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
						$(".follow-cert").text("팔로우");
					}
				}
			});
		} 
		
		// 팔로우버튼 클릭시 
		$(".follow-cert").click(function(){
			var receiverMemNo = $(this).data("mno");
			var receiverMemNick = $(this).data("mnick");
			$.ajax({
				url:"${pageContext.request.contextPath}/rest/review/follow",
				method:"post",
				data:{
					passiveMemNo : ${memNo}	
				},
				success:function(resp){
					if(resp){
						$(".follow-cert").text("팔로잉");
						
						//알림 생성 & 전송
	            		var notiData = {
	            				callerMemNo:memNo,
	            				receiverMemNo:receiverMemNo,
	            				receiverMemNick:receiverMemNick,
	            				notiContent:memNick+"님이 회원님을 팔로우하기 시작했어요 🙌",
	            				notiType:"follow",
	            				notiUrl:"${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+memNo,
	            				notiCreateDate:moment(),
	            				memNick:memNick
	            		};
	            		socket.send(JSON.stringify(notiData));
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
								$(".follow-cnt").text("팔로워  "+resp);
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
				}
			}); 
		};
		
		//팔로우 목록 출력
		function renderfollowList(){
			 if(followMemList.length != 0) {
				$.each(followMemList, function(index, value) {
					
					
					//팔로우 레벨 이미지
					var writerLevel;
					if( value.memLevel== "6  ") { //db에 char(3)으로 넣어서 한 자리인 경우 공백 생김
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
					writerLevel.addClass("level-img2");
					
					
					var span=$("<span>").text(value.memNick);
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
						var buttonFollow=$("<button>").text("팔로잉")
					}else{
						var buttonFollow=$("<button>").text("팔로우");
					}
					buttonFollow.attr("data-mno", value.memNo).attr("data-mnick", value.memNick);
					//팔로우 버튼을 클릭했을 때 이벤트 발생
		               $(buttonFollow).click(function(){
		            	   var receiverMemNo = $(this).data("mno");
		       				var receiverMemNick = $(this).data("mnick");
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
			     						
			     						//알림 생성 & 전송
			    	            		var notiData = {
			    	            				callerMemNo:memNo,
			    	            				receiverMemNo:receiverMemNo,
			    	            				receiverMemNick:receiverMemNick,
			    	            				notiContent:memNick+"님이 회원님을 팔로우하기 시작했어요 🙌",
			    	            				notiType:"follow",
			    	            				notiUrl:"${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+memNo,
			    	            				notiCreateDate:moment(),
			    	            				memNick:memNick
			    	            		};
			    	            		socket.send(JSON.stringify(notiData));
			     					}else{
			     						$(that).text("팔로우");
			     					}
			     				}
			            	 }); 
			               });
		             //사진 번호가 있는지 없는지. 
		               
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
				}
			}); 
		};
		
		//팔로워 목록 출력
		function renderfollowerList(){
			 if(followerMemList.length != 0) {
				$.each(followerMemList, function(index, value) {
					//팔로워 레벨 이미지
					var writerLevel;
					if( value.memLevel== "6  ") { //db에 char(3)으로 넣어서 한 자리인 경우 공백 생김
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
					writerLevel.addClass("level-img2");
					
					var span=$("<span>").text(value.memNick);
					var img=$("<img>").attr("src","");
					var br=$("<br>");
					if(memNo != value.memNo){
						var a=$("<a>").attr("href","${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+value.memNo).append(img).append(span).append(writerLevel);
					}else{
						var a=$("<a>").attr("href","${pageContext.request.contextPath}/profilepage/my-profile-header").append(img).append(span).append(writerLevel);
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
					buttonFollow.attr("data-mno", value.memNo).attr("data-mnick", value.memNick);
					//팔로우 버튼을 클릭했을 때 이벤트 발생
		               $(buttonFollow).click(function(){
		            	   var that=$(this);
		            	   var receiverMemNo = $(this).data("mno");
		       				var receiverMemNick = $(this).data("mnick");
		            	 $.ajax({
		            		 url:"${pageContext.request.contextPath}/rest/review/follow",
		     				method:"post",
		     				data:{
		     					passiveMemNo : value.memNo	
		     				},
		     				success:function(resp){
		     					if(resp){
		     						$(that).text("팔로잉");		
		     						//알림 생성 & 전송
		    	            		var notiData = {
		    	            				callerMemNo:memNo,
		    	            				receiverMemNo:receiverMemNo,
		    	            				receiverMemNick:receiverMemNick,
		    	            				notiContent:memNick+"님이 회원님을 팔로우하기 시작했어요 🙌",
		    	            				notiType:"follow",
		    	            				notiUrl:"${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+memNo,
		    	            				notiCreateDate:moment(),
		    	            				memNick:memNick
		    	            		};
		    	            		socket.send(JSON.stringify(notiData));
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
	<c:set var="login" value="${loginNo != null}"></c:set>

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
                         <c:if test = "${login}">
                        <button class="follow-cert" data-mno="${memNo}"></button>
                        </c:if>
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
                    	<span class="mem-info-text"></span><br><br>
                    	<span class="mem-info"></span>           
                    </P>
                </div> <!--boardT-->
                <div class="boardA">
                	<div class="yourF">
                    <ul>
                        <li>
                            <a href="yourreviewlist?memNo=${memNo}">게시물</a>
                        </li>
                    </ul>
                    </div>
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
