<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<title>리뷰 수정</title>

<!-- 현재 시간 구하기 -->
<jsp:useBean id="now" class="java.util.Date"></jsp:useBean>
<c:set var="today">
	<fmt:formatDate value="${now}" pattern="yyyy-MM-dd"/>
</c:set>

<style>
/* summernote(좌측), 리뷰장소(우측) 구분용 style */
	.float-container {}
    .float-container::after {
        content: "";        /* 영역에 들어갈 글자 */
        display: block;   /* block형태 공간 */
        clear: both;
    }
    .float-left {
        float: left;
    }
    .clear {
        clear: both;
    }
</style>



<form action="edit" method="post">
	<input type="hidden" name="reviewNo" value="${reviewDto.reviewNo}">
	
	<!-- 첨부파일 불러오기(미리보기) -->
	<div>
		사진 <br>
		<c:forEach var="attachDto" items="${attachments}">
			<img src="${pageContext.request.contextPath}/attach/download/${attachDto.attachNo}" width="150" height="150">
		</c:forEach>
	</div>
	
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
	<br>
		
	<!-- 별점 -->
	별점 <div class="star-score" data-max="5" data-rate="${reviewDto.starScore}"></div> <br>
	
	<!-- summernote + 리뷰장소 -->	
	<div class="float-container">
		<!-- summernote -->
		<div class="float-left">
			<textarea name="reviewContent" class="reviewContent">${reviewDto.reviewContent}</textarea>
		</div>
		
		<!-- 리뷰장소 -->
		<div class="float-left">
	    	<label>리뷰 장소</label>
	    	<br>
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
		</div>
	</div>
		
	<div>
		<button type="submit">등록하기</button>
		<br>
		<a href="detail?reviewNo=${reviewDto.reviewNo}">취소</a>
	</div>

</form>



<!-- jQuery -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<!-- 별점 -->
<script src="${pageContext.request.contextPath}/js/score.min.js"></script> <!-- 수정본 js파일 : 별점단위 0.5로 변경 -->
<!-- summernote -->
<link href="${pageContext.request.contextPath}/css/summernote-lite.min.css" rel="stylesheet" type="text/css" >
<script src="${pageContext.request.contextPath}/js/summernote-lite.min.js"></script>
<script src="${pageContext.request.contextPath}/js/summernote-ko-KR.min.js"></script>
<!-- 지도 키워드검색 -->
<link href="${pageContext.request.contextPath}/css/kakao-keyword.css" rel="stylesheet" type="text/css" >
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=${appkey}&libraries=services"></script>
<script src="${pageContext.request.contextPath}/js/kakao-keyword.js"></script>


<script type="text/javascript">
	$(function(){
		//summernote 옵션 수정
		$("textarea[name=reviewContent]").summernote({
			width:500,	//가로
			height:300,	//높이
			minHeight:200,	//최소높이
			placeholder:"내용을 작성하세요",	//도움말
			lang:"ko-KR",	//언어설정
			toolbar:[	//툴바 메뉴
				["style",["style"]],
				["font",["bold","underline","clear"]],
				["color",["color"]],
				["para",["ul","ol","paragraph"]],
				["table",["table"]],
				//["insert",["link","picture","video"]],	//이미지, 비디오 삭제
				["insert",["link"]],
				//["view",["fullscreen","codeview","help"]]]	//전체모드, code모드 삭제
				["view",["help"]]],
				callbacks: {
					onChange:function(contents){ //텍스트 글자수
		                setContentsLength(contents, 0);
		            }
				}
		});
		//글자수 체크
		var changeText = $('.reviewContent').summernote('code'); //글자수 초과직전의 내용 미리저장
		function setContentsLength(str, index) { //글자수 체크
		    var textCnt = 0; //총 글자수
		    var maxCnt = 1000; //최대 글자수
		    var editorText = f_SkipTags_html(str); //에디터에서 태그를 삭제하고 내용만 가져오기
		    editorText = editorText.replace(/\s/gi,""); //줄바꿈 제거
		    editorText = editorText.replace(/&nbsp;/gi, ""); //공백제거

	        textCnt = editorText.length;
	        //console.log(textCnt+" / "+maxCnt);
	        
		    if(textCnt == maxCnt) {
		    	changeText = $('.reviewContent').summernote('code');
		    	//console.log("저장중"+changeText);
		    } 
		    if(textCnt > maxCnt) {
        		alert("등록오류 : 글자수는 최대 "+maxCnt+"까지 등록이 가능합니다.");
		    	//console.log("돌아가"+changeText);
                $('.reviewContent').summernote('code', changeText);
		    }
		}
		//summernote 내용 태그 제거
		function f_SkipTags_html(input, allowed) {
			// 허용할 태그는 다음과 같이 소문자로 넘겨받음 (<a><b><c>)
		    allowed = (((allowed || "") + "").toLowerCase().match(/<[a-z][a-z0-9]*>/g) || []).join('');
		    var tags = /<\/?([a-z][a-z0-9]*)\b[^>]*>/gi,
		    commentsAndPhpTags = /<!--[\s\S]*?-->|<\?(?:php)?[\s\S]*?\?>/gi;
		    return input.replace(commentsAndPhpTags, '').replace(tags, function ($0, $1) {
		        return allowed.indexOf('<' + $1.toLowerCase() + '>') > -1 ? $0 : '';
		    });
		}
		
		//별점 옵션 수정
		$(".star-score").score({
			display: {
				showNumber:true,//설정된 숫자 표시 가능 여부
                placeLimit:1,//소수점 자리수
                textColor:"black",//숫자 색상(기본 : 금색)
		    }
        });
	});
</script>