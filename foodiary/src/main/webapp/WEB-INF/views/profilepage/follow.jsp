<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>
 	$(function(){
 		memList();
 		//회원조회
 		let reviewList = [];
 		function memList() {
			$.ajax({
				url : "${pageContext.request.contextPath}/rest/profile/mem",
				method : "get",
				dataType : "json",
				success : function(resp) {
					reviewList = resp;
					console.log(reviewList);
					renderList();
				}
			});
		};
 	});
</script>
