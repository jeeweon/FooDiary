<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<jsp:include page="/WEB-INF/views/admin/admin_header.jsp">
	<jsp:param value="회원 목록" name="title" />
</jsp:include>
<style>
.container {
	width: 900px;
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
    width: 300px;
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
<div id="dashboard">
	<div class="container">
		<div class="title">
			<h2>회원 목록</h2>
		</div>
		
		<form class="search-form">
	        <div class="search-bar">
	            <input type="text" name="keyword" class="search-input" placeholder="닉네임 검색" autocomplete="off" value="${param.keyword}">
	            <button type="submit" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button> 
	        </div>  
	    </form>
		
		<div class="mt-40">
		<table class="table table-slit w-100">
			<thead>
				<tr>
					<th>회원번호</th>
					<th>닉네임</th>
					<th>메일주소</th>
					<th>생년월일</th>
					<th>레벨</th>
					<th>포인트</th>
					<th>가입일</th>
				</tr>
			</thead>
			<tbody class="center">
				<c:forEach var="list" items="${list}">
					<tr>
						<td width="200px">${list.memNo}</td>
						<td width="400px">${list.memNick}</td>
					    <td width="500px">${list.memEmail}</td>
					    <td width="400px">${list.memBirth}</td>
					    <td width="200px">${list.memLevel}</td>
					    <td width="200px">${list.memPoint}</td>
					    <td width="400px">${list.memJoinDate}</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
		</div>
	</div>
</div>
</body>
</html>