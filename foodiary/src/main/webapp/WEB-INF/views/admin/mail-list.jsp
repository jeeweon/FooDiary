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


</body>
</html>