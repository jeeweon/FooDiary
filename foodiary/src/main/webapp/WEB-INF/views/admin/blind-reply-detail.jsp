<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
<jsp:include page="/WEB-INF/views/admin/admin_header.jsp">
	<jsp:param value="블라인드 댓글 상세" name="title" />
</jsp:include>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/css_admin/blind.css">
<!-- swiper 의존성-->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.css"/>
<script src="https://cdn.jsdelivr.net/npm/swiper@8/swiper-bundle.min.js"></script>
<style>
</style>
</head>
<body>
<div id="dashboard">
	<div class="container mb-50">
		<div class="title">
				<h2>블라인드 댓글 상세</h2>
		</div>
		
		<div class="action-btn">
			<button type="button" class="blind-clear" data-rno="${rvo.replyNo}">블라인드 해제</button>
			<button type="button" class="blind-list">목록 보기</button>	
		</div>
		
		<div class="float-container">
			<div class="row float-left float-1">
				<div class="row center">
					<h3 class="subtitle">댓글 원글</h3>
				</div>
				<div class="reply-list">
					<div class="list-item">
						<div class="reply-write-info">
							<c:choose>
								<c:when test="${rvo.pno == 0}">
									<img src="${pageContext.request.contextPath}/images/basic-profile.png" class="writer-avatar">
								</c:when>
								<c:otherwise>
									<img src="${pageContext.request.contextPath}/attach/download/${rvo.pno}" class="writer-avatar">
								</c:otherwise>
							</c:choose>
							<div class="info-text">
								<div class="nick-lev">
									<span class="writer-nick">${rvo.memNick}</span>
									<span class="writer-level">레벨 ${rvo.memLevel}</span>
								</div>
								<div class="sub-info-text">
									<span class="reply-write-time">
										<fmt:formatDate value="${rvo.replyWriteTime}" pattern="yyyy-MM-dd HH:mm:ss"/>
									</span>
								</div>
							</div>
						</div>
						<hr>
						<div class="reply-main">
							<span class="content">${rvo.replyContent}</span>
						</div>
					</div>
				</div>
			</div>
			
			<div class="row float-right float-2">
				<div class="row center">
					<h3 class="subtitle">신고 내역</h3>
				</div>
				<div class="history-list">
					<span class="report-cnt">신고 수: ${history.size()}</span>
					<table class="table table-slit history">
						<thead>
							<tr>
								<th>번호</th>
								<th>회원번호</th>
								<th>신고자</th>
								<th>신고일시</th>
							</tr>
						</thead>
						<tbody class="center">
							<c:forEach var="list" items="${history}">
								<tr>
									<td width="10%">${list.replyReportNo}</td>
									<td width="20%">${list.memNo}</td>
								    <td width="30%">${list.memNick}</td>
								    <td width="20%">
								    	<fmt:formatDate value="${list.replyReportTime}" pattern="yy-MM-dd HH:mm:ss"/>
								    </td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript">
$(function(){
    $(".blind-clear").click(function(){
    	var btn = $(this);
		var replyNo = $(this).data("rno");
		var chk = confirm("블라인드를 해제할까요?");
		if(!chk) {
			return;
		} else {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/blind/reply/clear",
	            method : "post",
			    data : {
	        	   replyNo:$(this).data("rno")
	           	},
	            success : function(resp) {
	            	if(resp) {
	            		btn.addClass("clear");
	            		btn.prop("disabled", true);
	            		alert("블라인드가 해제되었습니다.\n블라인드 댓글 목록에서 이 댓글을 더 이상 확인할 수 없습니다.");
	            	} else {
	            		alert("블라인드가 해제되지 않았습니다.\n"+replyNo+"번 댓글이 블라인드 상태인지 다시 한 번 확인 후 재시도해주세요.");
	            	}   
	            }
			});
		}
    });
    
    $(".blind-list").click(function(){
    	window.location = "${pageContext.request.contextPath}/admin/blind/reply";
    });
});
</script>
</body>
</html>