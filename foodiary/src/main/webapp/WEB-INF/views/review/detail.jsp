<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>리뷰 상세</title>

<c:set var="member" value="${loginNo != null && loginNo != reviewDto.memNo}"></c:set>
<c:set var="owner" value="${loginNo == reviewDto.memNo}"></c:set>	
<!-- 현재 시간 구하기 -->
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<c:set var="today">
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>
</c:set>
<c:set var="current">
	<fmt:formatDate value="${reviewDto.reviewWriteTime}" pattern="yyyy-MM-dd"/>
</c:set>
<!-- toast 스타일 -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.css" /> 
<style>
/* 리뷰 관련 style */
	.level-img {
 		width:24px;
 		margin:0;
 		margin-left: 5px;
 	}
 	
/* summernote(좌측), 리뷰장소(우측) 구분용 style */
	.float-container {
		width: 850px;
	}
    .float-container::after {
        content: "";        /* 영역에 들어갈 글자 */
        display: block;   /* block형태 공간 */
        clear: both;
    }
    .float-left {
        float: left;
        width: 50%;
    }
    .clear {
        clear: both;
    }
    
    .reviewBox {
    	width: 450px;
    	border: 1px solid gray;
    	border-radius: 5px;
    }

/* 댓글목록 관련 style */
	.replyBox {
		width: 450px;
	}
	.replyListHead {
		margin-top: 6px;
		margin-left: 6px;
		font-size: 14px;
	}
	.replyListBody {
		text-align: center;
	}
	.profile {
		width: 50px;
	}
	.replyContent {
		width: 430px;
		border: 1px solid transparent;
		border-radius: 5px;
		outline: none;
		padding: 4px;
	}
	.input-reply {
		width: 370px;
	}
</style>



<!-- 글번호 -->
<input type="hidden" name="reviewNo" value="${reviewDto.reviewNo}">

<div>

	<%-- 작성자 회원번호 : ${reviewDto.memNo} <br> --%>
	<!-- 회원정보 : 프로필 사진, 닉네임, 팔로우버튼(팔로우중:팔로잉)
					- (사진,닉네임)클릭시 프로필로 이동 
	-->
	<div class="reviewWriter">
		<span class="reviewMem">
			<c:choose>
				<c:when test="${reviewWriter.attachNo == 0}">
					<img class="profile" src="${pageContext.request.contextPath}/images/basic-profile.png">
				</c:when>
				<c:otherwise>
					<img class="profile" src="${pageContext.request.contextPath}/attach/download/${reviewWriter.attachNo}">
				</c:otherwise>
			</c:choose>
			<span class="reviewWriter-memNick">${reviewWriter.memNick}</span>
		</span>
	</div>
	
	
	<!-- 작성일 -->
	<c:choose>
		<c:when test="${today == current}">
			<fmt:formatDate value="${reviewDto.reviewWriteTime}" pattern="HH:mm"/>
		</c:when>
		<c:otherwise>
			<fmt:formatDate value="${reviewDto.reviewWriteTime}" pattern="yyyy-MM-dd"/>
		</c:otherwise>
	</c:choose>	
	
	<!-- 회원 기능 
		1. 작성자 본인이 아닐 때 : 신고버튼
			- 신고버튼 (확인 팝업 노출: 취소불가능, 불이익 안내, 완료시 완료 팝업)
		2. 작성자 본인일 때 : 수정/삭제
	-->	
		<!-- 신고 -->
		<c:if test="${member}">
			<input class="btn-report" type="button" value="신고">
		</c:if>
	
		<!-- 수정, 삭제 -->
		<c:if test="${owner}">
			<a href="edit?reviewNo=${reviewDto.reviewNo}">수정</a>
			<a href="delete?reviewNo=${reviewDto.reviewNo}">삭제</a>
		</c:if>
</div>
	
<div class="float-container"> <!-- 사진(좌측)/본문(우측) 배치 -->
	<!-- 첨부파일 : 슬라이딩 기능 필요 -->
	<div class="float-left">
		<!-- 사진 --> <br>
		<c:forEach var="attachDto" items="${attachments}">
			<img src="${pageContext.request.contextPath}/attach/download/${attachDto.attachNo}" width="400" height="400">
		</c:forEach>
	</div>
	
	<div class="float-left">
		<div class="float-container">
			<div class="reviewBox">
				<div class="float-left">
				<!-- 리뷰 : 주소/장소, 별점은 있을 경우에만 출력 -->
				<!-- 별점 -->
				<c:if test="${reviewDto.starScore >0}">
					별점 <div class="star-score" data-max="5" data-rate="${reviewDto.starScore}"></div> <br>
				</c:if>
				
				<c:if test="${reviewDto.reviewAddress!=null || reviewDto.reviewPlace!=null}">
					<!-- 리뷰장소 : 위치 (본문 상단) -->
				    	<label>리뷰 장소</label>
				    	<br>
				    	<c:choose>
					    	<c:when test="${reviewDto.reviewPlace==null}">
						        <input type="text" name="reviewAddress" value="${reviewDto.reviewAddress}" readonly>
								<div class="map_wrap">
							    	<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
								    <div id="menu_wrap" class="bg_white">
								        <div class="option">
								            <div>
								                <!-- <form onsubmit="searchPlaces(); return false;">  -->
								                    <input type="text" value="${reviewDto.reviewAddress}" id="keyword" size="15" readonly> 
								                    <button type="button" class="keywordMap">검색</button> 
								                <!--  </form> -->
								            </div>
								        </div>
								        <hr>
								        <ul id="placesList"></ul>
								        <div id="pagination"></div>
								    </div>
								</div>
							</c:when>
							<c:when test="${reviewDto.reviewAddress==null}">
						        <input type="text" name="reviewPlace" value="${reviewDto.reviewPlace}" readonly>
							</c:when>
							<c:otherwise>
						        <input type="text" name="reviewAddress" value="${reviewDto.reviewAddress}" readonly>
						       	<br>
					        	<input type="text" name="reviewPlace" value="${reviewDto.reviewPlace}" readonly>
								<div class="map_wrap">
							    	<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
								    <div id="menu_wrap" class="bg_white">
								        <div class="option">
								            <div>
								                <!-- <form onsubmit="searchPlaces(); return false;">  -->
								                    <input type="text" value="${reviewDto.reviewAddress}" id="keyword" size="15" readonly> 
								                    <button type="button" class="keywordMap">검색</button> 
								                <!--  </form> -->
								            </div>
								        </div>
								        <hr>
								        <ul id="placesList"></ul>
								        <div id="pagination"></div>
								    </div>
								</div>
							</c:otherwise>
						</c:choose>
					</c:if>
				</div>
		
				<div class="clear"></div>
				<br>
				
				<!-- 본문 내용 -->
				<div class="float-left">
					<!-- 리뷰 내용 -->
					${reviewDto.reviewContent}
				</div>
				
			<div class="clear"></div>
			<br>
		</div>
		
			<div class="float-left replyBox">
				<!-- 댓글 위치 
					1. 댓글목록 : 최신순, 한번에 10개씩, 더보기클릭
						- 작성시간 출력
						- 회원 : 댓글 신고
						- 내 댓글 : 삭제 가능 (회원탈퇴시 자동삭제)
					2. 하단 위치 고정 : 좋아요, 북마크, 댓글작성란
						- 댓글 작성 : 내용없을 때 등록버튼 비활성화
				-->
				<!-- 댓글 목록 -->
				<div class="reply-list">
				</div>
					
	    		<hr>
				<!-- 댓글,좋아요,북마크 -->
				<div>
					<span>
						<i class='fa-regular fa-comment'></i>${checkRpLkBkVO.replyTotal}
					</span>
					<c:choose>
						<c:when test="${checkRpLkBkVO.likeCheck}">
							<span>
								<i class='fa-solid fa-heart like-ic' data-mno="${reviewWriter.memNo}" data-mnick="${reviewWriter.memNick}"></i>
								<span class="like-ic-count">${reviewDto.likeCnt}</span>
							</span>
						</c:when>
						<c:otherwise>
							<span>
								<i class='fa-regular fa-heart like-ic' data-mno="${reviewWriter.memNo}" data-mnick="${reviewWriter.memNick}"></i>
								<span class="like-ic-count">${reviewDto.likeCnt}</span>
							</span>
						</c:otherwise>
					</c:choose>
					<c:choose>
						<c:when test="${checkRpLkBkVO.bookmarkCheck}">
							<span><i class='fa-solid fa-bookmark bookmark-ic'></i></span>
						</c:when>
						<c:otherwise>
							<span><i class='fa-regular fa-bookmark bookmark-ic'></i></span>
						</c:otherwise>
					</c:choose>
				</div>
				<!-- 댓글 작성 -->
				<div>
					<textarea class="input-reply" name="replyContent" 
								rows="3" style="resize:none;" placeholder="내용을 입력해주세요."></textarea>
					<button class="btn-reply-Write" type="button">등록</button>
				</div>
			</div>
		</div>
	</div>
</div>

<a href="list">목록으로</a>

	
<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<!-- 별점 -->
<script src="${pageContext.request.contextPath}/js/score.min.js"></script> <!-- 수정본 js파일 : 별점단위 0.5로 변경 -->
<!-- 지도 키워드검색 -->
<link href="${pageContext.request.contextPath}/css/kakao-keyword.css" rel="stylesheet" type="text/css" >
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${appkey}&libraries=services"></script>
<script src="${pageContext.request.contextPath}/js/kakao-keyword.js"></script>
<!-- axios cdn -->
<script src="https://unpkg.com/axios/dist/axios.min.js"></script>
<!-- font-awesome -->   
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"/>

 <script src="${pageContext.request.contextPath}/js/commons.js"></script>
<!-- sockjs 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.6.1/sockjs.min.js"></script>
<!-- toast 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
<!-- moment 라이브러리 -->
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/moment.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.29.4/locale/ko.min.js"></script>

<script type="text/javascript">
	$(function(){
		//변수 저장
		//reviewNo = $("input[name=reviewNo]").val()
		let reviewNo = ${reviewDto.reviewNo}	//리뷰 글번호
		let reviewWriterNo = ${reviewWriter.memNo}	//리뷰작성자 번호
		let reviewWriterLevel = ${reviewWriter.memLevel} //리뷰작성자 레벨
		let loginNo = ${loginNo}	//로그인한 회원번호
		let loginNick = "${loginNick}" //로그인한 회원닉네임
		let reviewWriterNick = "${reviewWriter.memNick}" //리뷰작성자 닉네임
		
		reviewWriter(); //리뷰상단: 리뷰작성자 정보
		loadReplyList(); //댓글목록 출력
		
		//웹소켓 연결
		if(loginNo != null){
			connectWs();
		}
		//웹소켓
		function connectWs(){
			console.log("tttttt")
			var uri = "${pageContext.request.contextPath}/ws/sockjs";
			socket = new SockJS(uri);
		
			socket.onopen = function() {
				console.log('open');
			};
			
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

			socket.onclose = function() {
			    console.log('close');
		 	};
		};
		
		//리뷰상단 : 리뷰 작성자 정보
		function reviewWriter(){
			var memLevel;
			if(reviewWriterLevel == "6  ") { //db에 char(3)으로 넣어서 한 자리인 경우 공백 생김
				memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/6.피잣집.png");
			} else if (reviewWriterLevel == "5  ") {
				memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/5.피자콜라.png");
			} else if (reviewWriterLevel == "4  ") {
				memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/4.조각피자.png");
			} else if (reviewWriterLevel == "3  ") {
				memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/3.반죽.png");
			} else if (reviewWriterLevel == "2  ") {
				memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/2.밀가루.png");
			} else {
				memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/1.밀.png");
			}
			memLevel.addClass("level-img");
			
			var reviewMem = $(".reviewMem").append(memLevel);
			$(".reviewMem").click(function(){
				window.location = "${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+reviewWriterNo;
			});
			
			var follow=$("<button>").attr("data-rno",reviewWriterNo).text("팔로우").attr("data-mnick", reviewWriterNick);
			follow.click(function(){
				var that=$(this);
				var no = $(this).data("rno");
				var nick =  $(this).data("mnick");
				$.ajax({
					url:"${pageContext.request.contextPath}/rest/review/follow",
					method:"post",
					data :{
						 passiveMemNo : $(this).data("rno")	
					},
					success :function(resp){
						console.log(resp);
						if(resp){
							$(that).text("팔로잉");
							//알림 생성 & 전송
		            		var notiData = {
		            				callerMemNo:loginNo,
		            				receiverMemNo:no,
		            				receiverMemNick:nick,
		            				notiContent:loginNick+"님이 회원님을 팔로우하기 시작했어요 🙌",
		            				notiType:"follow",
		            				notiUrl:"${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+loginNo,
		            				notiCreateDate:moment(),
		            				memNick:loginNick
		            		};
							if(loginNo != no) {
			            		socket.send(JSON.stringify(notiData));								
							}
						}else{
							$(that).text("팔로우");
						}
					}
				});
			});
			
			$(".reviewWriter").append(reviewMem).append(follow);
		}
		
		//별점 옵션 수정
		$(".star-score").score({
			display: {
				showNumber:true,//설정된 숫자 표시 가능 여부
                placeLimit:1,//소수점 자리수
                textColor:"black",//숫자 색상(기본 : 금색)
		    }
        });
		
		//리뷰 신고버튼
		$(".btn-report").click(function(){
			//확인 팝업(경고)
			var result = confirm("정말 신고하시겠습니까?\n허위 신고시 서비스 이용제한조치를 받으실 수 있습니다.");
			var that=$(this);
			
			//신고 카운트+1
			if(result) {
				axios.post("${pageContext.request.contextPath}/rest/review/report/"+reviewNo)
				.then(function(response){
					//console.log(response);
					if(response.data) {	//response가 true일 경우
						alert("신고가 접수되었습니다.");
						$(that).prop("disabled", true);
					}
				});
			}
		});
		
		//댓글 입력
		$(".btn-reply-write").click(function(){
			var memNo = loginNo;
    		var replyContent = $(".input-reply").val();
    		if(memNo==null) {
    			alert("로그인하셔야 댓글을 등록 할 수 있습니다!");
    		}
    		else {
    			axios.post("${pageContext.request.contextPath}/rest/reply", {
    				reviewNo: reviewNo,	
    				memNo: memNo,
    				replyContent: replyContent
    			})
    			.then(function(resp){
    				//console.log(resp);
    				$(".input-reply").val("");
    				loadReplyList();
    				//알림 생성 & 전송
            		var notiData = {
            				callerMemNo:loginNo,
            				receiverMemNo:reviewWriterNo,
            				receiverMemNick:reviewWriterNick,
            				notiContent:loginNick+"님이 회원님의 리뷰에 댓글을 남겼어요 👀",
            				notiType:"reply",
            				notiUrl:"${pageContext.request.contextPath}/review/detail?reviewNo="+reviewNo,
            				notiCreateDate:moment(),
            				memNick:loginNick
            		};
    				if(loginNo != reviewWriterNo) {    					
            			socket.send(JSON.stringify(notiData));
    				}
    			});
    		}
		});
		//댓글 삭제
		$(document).on("click", ".btn-reply-delete", function(){ //생성된버튼은 해당방법 사용
    		var replyNo = $(this).siblings(".replyNo").val();

		axios.delete("${pageContext.request.contextPath}/rest/reply/"+replyNo)
			.then(function(resp){
				loadReplyList();
			});
		});
		//댓글 : 목록조회
		function loadReplyList(){
			axios.get("${pageContext.request.contextPath}/rest/reply/"+reviewNo)
			.then(function(resp){
	        	var replyListVO = resp.data;

	        	$(".reply-list").empty();	//목록 초기화
	        	$.each(replyListVO, function(index, value){
	        		var replyNo = value.replyNo;
	        		var replyMemNo = value.memNo;
	        		var replyReportCnt = value.replyReportCnt;
	        		
	        		//replyListHead
	        		//1. replyListHead-replyNoInput
	        		var replyNoInput = $("<input>").attr("type","hidden").val(replyNo).addClass("replyNo");
	        		
	        		//2. replyListHead-replyMem
	        		var profile;
	        		if(value.attachNo == 0) {
	        			profile = $("<img>").attr("src", "${pageContext.request.contextPath}/images/basic-profile.png");						
					} else {
						profile = $("<img>").attr("src", "${pageContext.request.contextPath}/attach/download/"+value.attachNo);
					}
	        		profile.addClass("profile");
	        		
	        		var memNick = $("<span>").text(value.memNick);
	        		
	        		var memLevel;
	    			if(value.memLevel == "6  ") { //db에 char(3)으로 넣어서 한 자리인 경우 공백 생김
	    				memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/6.피잣집.png");
	    			} else if (value.memLevel == "5  ") {
	    				memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/5.피자콜라.png");
	    			} else if (value.memLevel == "4  ") {
	    				memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/4.조각피자.png");
	    			} else if (value.memLevel == "3  ") {
	    				memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/3.반죽.png");
	    			} else if (value.memLevel == "2  ") {
	    				memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/2.밀가루.png");
	    			} else {
	    				memLevel = $("<img>").attr("src", "${pageContext.request.contextPath}/images/1.밀.png");
	    			}
	    			memLevel.addClass("level-img");
	    			
	    			var replyMem = $("<span>").append(profile).append(memNick).append(memLevel);
	    			replyMem.addClass("replyMem")
	    			$(".replyMem").click(function(){
	    				window.location = "${pageContext.request.contextPath}/profilepage/yourreviewlist?memNo="+value.memNo;
	    			});
	    			
	    			//3. replyListHead-replyWriteTime
	        		var replyWriteTime = $("<span>").text("\n"+value.replyWriteTime);

	        		var replyReport = $("<input>").val("신고");
        			replyReport.attr("type", "button").addClass("btn-reply-report");

        			var replyDelete = $("<input>").val("삭제");
        			replyDelete.attr("type", "button").addClass("btn-reply-delete");
        			
	        		//replyListBody
	        		var replyContent;
	        		//블라인드여부 검사
	        		if(value.replyReportCnt >=5) {
	        			replyContent = $("<input>").attr("value", " [ 블라인드 처리된 댓글입니다 ] ").prop("readonly", true);
	        		} else {
	        			replyContent = $("<input>").attr("value", value.replyContent).prop("readonly", true);
	        		}
	        		replyContent.addClass("replyContent");
	        		
	        		//reply-list
	        		var replyListHead = $("<div>").append(replyNoInput).append(replyMem).append(replyWriteTime);
	        		if(loginNo==replyMemNo) {
	        			replyListHead = $("<div>").append(replyNoInput).append(replyMem).append(replyWriteTime)
													.append(" ").append(replyDelete);
	        		}else if(loginNo!=replyMemNo){
		        		replyListHead = $("<div>").append(replyNoInput).append(replyMem).append(replyWriteTime)
		        									.append(" ").append(replyReport);
	        		}
	        		replyListHead.addClass("replyListHead");
	        		
	        		var replyListBody = $("<div>").append(replyContent);
	        		replyListBody.addClass("replyListBody");
	        		
	        		$(".reply-list").append(replyListHead).append(replyListBody);
	        	}); //$.each끝
			}); //axios끝
		} //목록조회끝
		
		//댓글 신고
		$(document).on("click", ".btn-reply-report", function(){ //생성된버튼은 해당방법 사용
			//확인 팝업(경고)
			var result = confirm("정말 신고하시겠습니까?\n허위 신고시 서비스 이용제한조치를 받으실 수 있습니다.");
			var that=$(this);
			
			var replyNo = $(this).siblings(".replyNo").val();
			
			//신고 카운트 +1
			if(result) {
				axios.post("${pageContext.request.contextPath}/rest/reply/report/"+replyNo)
				.then(function(resp){
					if(resp.data) {	//response가 true일 경우
						alert("신고가 접수되었습니다.");
						$(that).prop("disabled", true);
					}
				});
			}
		});
		
		//좋아요 버튼 클릭 이벤트
		$(document).on("click", ".like-ic", function() {
			var receiverMemNo = $(this).data("mno");
			var receiverMemNick = $(this).data("mnick");
			if(loginNo==null) {
				alert("로그인하셔야 좋아요를 선택 할 수 있습니다!");
			}
			else {
				$.ajax({
					url : "${pageContext.request.contextPath}/rest/review/like2",
	                method : "post",
				    data : {
		        	   reviewNo:reviewNo
		           	},
	                success : function(resp) {
	                	if(resp == 0) {
	                		$(".like-ic").removeClass("fa-solid").addClass("fa-regular");
	                	} else {
	                		$(".like-ic").removeClass("fa-regular").addClass("fa-solid");
	                		//알림 생성 & 전송
	                		var notiData = {
	                				callerMemNo:loginNo,
	                				receiverMemNo:receiverMemNo,
	                				receiverMemNick:receiverMemNick,
	                				notiContent:loginNick+"님에게 회원님의 리뷰가 도움됐어요 🧡",
	                				notiType:"like",
	                				notiUrl:"${pageContext.request.contextPath}/review/detail?reviewNo="+reviewNo,
	                				notiCreateDate:moment(),
	                				memNick:loginNick
	                		};
	                		if(loginNo != receiverMemNo) {
		                		socket.send(JSON.stringify(notiData));                			
	                		}
	                	}
	                	
	                	$.ajax({
	                		url : "${pageContext.request.contextPath}/rest/review/count",
	    	                method : "post",
	    				    data : {
	    		        	   reviewNo:reviewNo
	    		           	},
	    	                success : function(resp) {
	    	                	$(".like-ic-count").text(resp);    	    	                	
	    	                }
	                	});
	                }
				});
			}
		});
		
		//북마크 버튼 클릭 이벤트
		$(document).on("click", ".bookmark-ic", function() {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/review/bookmark",
                method : "post",
			    data : {
	        	   reviewNo:reviewNo
	           	},
                success : function(resp) {
                	if(resp) {
                		$(".bookmark-ic").addClass("fa-solid").removeClass("fa-regular");
                	} else {
                		$(".bookmark-ic").addClass("fa-regular").removeClass("fa-solid");
                	}   
                }
			});
		});
		
	});
</script>