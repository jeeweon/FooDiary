<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
<title>관리자::이메일 상세</title>
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
<h1>이메일 상세</h1>
<div>
<table class="table" width="800px";>
	<tbody>
	  <tr>
	    <th class="tg-0pky" width="10%">번호</th>
	    <td class="tg-0pky">${emailDto.emailNo}</td>
	    <th class="tg-0pky" width="10%">날짜</th>
	    <td class="tg-0lax">${emailDto.emailWhen}</td>
	  </tr>
	  <tr>
	    <th class="tg-0pky">제목</th>
	    <td class="tg-0lax" colspan="3">${emailDto.emailSubject}</td>
	  </tr>
	  <tr>
	    <th class="tg-0pky" >내용</th>
	    <td class="tg-0pky" colspan="3">${emailDto.emailContent }</td>
	  </tr>
	</tbody>
	</table>
</div>

</body>
</html>