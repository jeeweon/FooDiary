<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<!-- 스타일 -->
<style>
*{ padding: 0; margin: 0; }
li{ list-style: none; }

.gallery{
  width: 940px; margin: 0 auto;
  overflow: hidden;
}
.gallery h3{
  width: 100%; height: 50px;
  line-height: 50px; text-align: center;
}
.gallery li{
  float: left;
  width: 300px; height: 200px;
  margin-right: 20px;
}
.gallery li:last-child{ margin-right: 0; }

.gallery a{
  display: block; /* 영역적용위해 사용 */
  width: 100%; height: 100%;

  overflow: hidden;

  position: relative; /* absolute의 기본기준은 body로 처리 - 현재 요소로 기준변경 */
}

.gallery figure{
  width: 100%; height: 100%;
}
.gallery figcaption{
  width: 100%; height: 100%;
  background-color: rgba(0,0,0,0.7);

  position: absolute; /* 이미지와 겹치게 처리 */
  top: 0; left: 0;

  color: #fff; text-align: center;
  line-height: 200px;

  opacity: 0; /* 처음엔 안보이고 */

  transition: 0.3s;
}

.gallery a:hover figcaption, .gallery a:focus figcaption{
  /* 마우스를 올리면 보이게 처리 */
  opacity: 1;
}
		</style>
<body>
<!-- 헤더 -->
<jsp:include page="/WEB-INF/views/profilepage/myprofileheader.jsp">
	<jsp:param value="주문내역페이지" name="title"/>
</jsp:include>
<p>게시물페이지입니다.</p>
		<div class="gallery">
            <ul>
                <li>
                    <a href="#">
                        <figure>
                            <img src="https://placeimg.com/640/480/nature" alt="이미지01">
                            <figcaption>🧡23 ❤34</figcaption>
                        </figure>
                    </a>
                </li>
            </ul>
        </div>
    </body>
		
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script>
        $(function(){
        });
    </script>
</body>
</html>