<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

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
/* 주소입력창 초기화 x버튼 */
	.btn-xmark {
		padding: 0px;
		border: none;
		background: none;
	}
	.fa-rectangle-xmark {
		font-size: 18px;
	}
</style>



<form class="form-submit" action="write" method="post" enctype="multipart/form-data">

	<!-- 첨부파일 -->
	<div>
		<label>첨부파일(1개당 1MB. 최대 10MB 가능)</label>
		<input type="file" name="attachments" multiple>
	</div>
	
	<!-- 별점 -->    
	별점 : <div class="star-score-edit" data-max="5"></div>
		
	<!-- summernote + 리뷰장소 -->	
	<div class="float-container">
		<!-- summernote -->
		<div class="float-left">
			<textarea name="reviewContent"></textarea>
		</div>
		
		<!-- 리뷰장소 -->
		<div class="float-left">
	    	<label>리뷰 장소</label>
	    	<br>
	        <input type="text" name="reviewAddress" placeholder=" 주소 : 지도에서 주소를 선택하세요" readonly>
		        <button class="btn-xmark" type="button">
		        	<i class="fa-regular fa-rectangle-xmark"></i>
	        	</button>
	       	<br>
	        <input type="text" name="reviewPlace" placeholder=" 장소명 : 추가 입력 가능">
			<div class="map_wrap">
		    	<div id="map" style="width:100%;height:100%;position:relative;overflow:hidden;"></div>
			    <div id="menu_wrap" class="bg_white">
			        <div class="option">
			            <div>
			                <!-- <form onsubmit="searchPlaces(); return false;">  -->
			                    <input type="text" value="당산역 맛집" id="keyword" size="15"> 
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
	</div>

</form>

<a href="list">목록으로</a> <!-- 리뷰구현 테스트용 : 리뷰구현 끝나면 삭제예정 -->


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
<!-- font-awesome -->   
<link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.1/css/all.min.css"/>
    
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
		});
		
		//별점 옵션 수정
		$(".star-score-edit").score({
            editable:true,//수정 가능하도록 설정
            zeroAvailable:true,//0 설정 가능 여부
            integerOnly:false,//정수만 가능
            display:{
                showNumber:true,//설정된 숫자 표시 가능 여부
                placeLimit:1,//소수점 자리수
                textColor:"black",//숫자 색상(기본 : 금색)
            },
            send: {
                sendable:true,//전송가능 설정
                name:"starScore"//전송 파라미터 명 설정
            }
        });
		
		//주소 : x버튼 초기화
		$(".btn-xmark").click(function(){
			$("input[name=reviewAddress]").val("");
		});
		
		//사진 없으면, 전송불가
		$(".form-submit").submit(function(e) {
			var result = true;
			if ($("input[name=attachments]").val() == "") {
				alert("사진을 선택해주세요");
				return result = false;
			}
			return result;
		});
	});
</script>