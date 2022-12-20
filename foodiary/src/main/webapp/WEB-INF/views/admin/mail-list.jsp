<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>관리자::이메일 리스트</title>
<style>
        .table > thead > tr > th,
        .table > thead > tr > td,
        .table > tbody > tr > th,
        .table > tbody > tr > td,
        .table > tfoot > tr > th,
        .table > tfoot > tr > td {  
           border : 1px solid lightgray;
        }
</style>
</head>
<body>
<h1>공지 이메일 리스트</h1>

<div>
	<table class="table" width="800px" >
		<thead>
		  <tr align="center">
		    <th class="tg-c3ow">번호</th>
		    <th class="tg-baqh">제목</th>
		    <th class="tg-baqh">날짜</th>
		  </tr>
		</thead>
	<c:forEach var="emailDto" items="${list}">
			<tbody>
			  <tr align="center">
			    <td class="tg-0lax">${emailDto.emailNo}</td>
			   <td class="tg-0lax"> <a href="mail-detail?emailNo=${emailDto.emailNo}">${emailDto.emailSubject}</a></td>
			    <td class="tg-0lax">${emailDto.emailWhen }</td>
			  </tr>
			</tbody>
	</c:forEach> 
	</table>
</div>

<div class="row center">
	<ul class="pagination">
		<c:choose>
			<c:when test="${not vo.isFirst()}">
				<li><a href="mail-list?p=${vo.firstBlock()}&${vo.parameter()}">&laquo; </a></li>
			</c:when>
			<c:otherwise>
				<li><a href="#">&laquo;</a></li>
			</c:otherwise>
		</c:choose>
		
		<!-- 이전을 누르면 이전 구간의 마지막 페이지로 안내 -->
		
		<c:choose>
			<c:when test="${vo.hasPrev()}">
				<li><a href="mail-list?p=${vo.prevBlock()}&${vo.parameter()}">&lt;</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="#">&lt;</a></li>
			</c:otherwise>
		</c:choose>
		
		
		
		<c:forEach var="i"  begin="${vo.startBlock()}" end="${vo.endBlock()}" step="1">
			<c:choose>
					<c:when test="${vo.p == i}">
						<li class="on"><a href="#">${i}</a></li>
					</c:when>
					<c:otherwise>
						<li><a href="mail-list?p=${i}&${vo.parameter()}">${i}</a></li>
					</c:otherwise>
				</c:choose>
		</c:forEach>
		
		<!-- 다음을 누르면 다음 구간의 첫 페이지로 안내 -->
		
		<c:choose>
			<c:when test="${vo.hasNext()}">
				<li><a href="mail-list?p=${vo.nextBlock()}&${vo.parameter()}">&gt;</a></li>
			</c:when>
			<c:otherwise>
				<li><a href="#">&gt;</a></li>
			</c:otherwise>
		</c:choose>
		
		<c:choose>
			<c:when test="${not vo.isLast()}">
				<li><a href="mail-list?p=${vo.lastBlock()}&${vo.parameter()}">&raquo; </a></li>
			</c:when>
			<c:otherwise>
				<li><a href="#">&raquo;</a></li>
			</c:otherwise>
		</c:choose>
		</ul>
		</div>
		
		<!-- 검색창 -->
	<div class="row center mt-30" >
		<form action="mail-list" method="get" autocomplete="off">

			<input class="solid-lines input-list-search" type="search" name="keyword" placeholder="제목 검색" value = "${param.keyword}">
			<button class="btn btn-positive" type="submit">검색</button>
		</form>
	</div>



</body>
</html>