<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<jsp:include page="/WEB-INF/views/admin/admin_header.jsp">
	<jsp:param value="이메일 리스트" name="title" />
</jsp:include>
<style>
.container {
	width: 600px;
	margin: 0 auto;
	display: flex;
	flex-direction: column;
  	justify-content : center;
}

.title {
	text-align: center;
	margin: 50px auto 20px auto;
}

.search-form {
   	margin: auto;
}

.search-bar { 
    position: relative;
    width: 400px;
    height: 40px;
    display: inline-block;
    border: 1px solid #18253D;
    border-radius: 4px;
    font-size: 16px;
}

.search-input {
    padding: 0.5em;
    padding-right: 30px;
    width: 100%;
    height: inherit;
    border: none;
    border-radius: 4px;
    outline: none;
    box-sizing: border-box;
}

.search-btn {
    position: absolute;
    top: 0;
    right: 0;
    width: 30px;
    height: inherit;
    border: none;
    outline: none;
    background-color: transparent;
    color: #18253D;
    cursor: pointer;
}

input:focus {
	outline: none;
}

td > a {
	color: #E27C5E;
	font-weight: bold;
}

th > a {
	color: black;
	font-weight: bold;
}

td > a,
th > a {
	text-decoration: none;
}

th > a:visited {
	color: black;
	font-weight: bold;
}

td > a:visted {
	color: #E27C5E;
	font-weight: bold;
}
</style>
</head>
<body>

<!-- 테스트용 데이터 출력 -->

<div class="container">
	<div class="title">
		<h2>공지 이메일 목록</h2>
	</div>
	<table class="table table-slit w-100" >
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
		<form class="search-form" action="mail-list" method="get" autocomplete="off">
			 <div class="search-bar">
				<input class="search-input solid-lines input-list-search" type="search" name="keyword" placeholder="제목 검색" value = "${param.keyword}">
				 <button type="submit" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button> 
			</div>  
		</form>
	</div>
</div>


</body>
</html>