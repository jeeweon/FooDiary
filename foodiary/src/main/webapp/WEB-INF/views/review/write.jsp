<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<form action="write" method="post" enctype="multipart/form-data">
	별점 : <div class="star-score-edit" data-max="5"></div>
	
	<div>
		<label>내용</label>
		<textarea name="reviewContent"></textarea>
	</div>
	
	<div>
		<label>첨부파일(1개당 1MB. 최대 10MB 가능)</label>
		<input type="file" name="attachments" multiple>
	</div>
	
	<div>
		<a href="list">목록으로</a>
		<button type="submit">등록하기</button>
	</div>

</form>



<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script src="${pageContext.request.contextPath}/js/score.min.js"></script> <!-- 수정본 js파일 : 별점단위 0.5로 변경 -->
<link href="${pageContext.request.contextPath}/css/summernote-lite.min.css" rel="stylesheet" type="text/css" >
<script src="${pageContext.request.contextPath}/js/summernote-lite.min.js"></script>
<script src="${pageContext.request.contextPath}/js/summernote-ko-KR.min.js"></script>

<script type="text/javascript">
	$(function(){
		//summernote 옵션 수정
		$("textarea[name=reviewContent]").summernote({
			width:700,	//가로
			height:200,	//높이
			minHeight:200,	//최소높이
			placeholder:"내용을 작성하세요",	//도움말
			lang:"ko-KR",	//언어설정
			toolbar:[	//툴바 메뉴
				["style",["style"]],
				["font",["bold","underline","clear"]],
				["fontname",["fontname"]],
			    ['fontsize', ['fontsize']],		//fontsize 추가
				["color",["color"]],
				["para",["ul","ol","paragraph"]],
				["table",["table"]],
				//["insert",["link","picture","video"]],	//이미지, 비디오 삭제
				["insert",["link"]],
				//["view",["fullscreen","codeview","help"]]]	//전체모드, code모드 삭제
				["view",["help"]]],
			fontNames: ['맑은 고딕','궁서','굴림체','굴림','돋움체','바탕체','Arial', 'Arial Black', 'Comic Sans MS', 'Courier New'],
			fontSizes: ['8','9','10','11','12','14','16','18','20','22','24','28','30','36','50','72']
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
	});
</script>