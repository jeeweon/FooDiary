<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<head>
    <title>관심지역 설정</title>
    <link rel="stylesheet" type="text/css"
   href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css" />

   <style>
    .title{
        text-align: center;
        margin-top: 50px;
    }
    /* 
        .search-view = .search-bar + .search-list
        .search-bar = .search-input + .search-btn
        .search-list = <div<li + span(.btn-add-area)>> * addressList.length
        .my-area = <div<li + span(.btn-delete-area)>> * interestList.length
    */
    .search-form {
        margin: 0;
    }
    
    .search-view{
        width: 400px; 
        margin: 0 auto;
        margin-top: 30px;
    }

    .search-bar { 
        position: relative;
        width: 100%;
        height: 40px;
        display: inline-block;
        border: 1px solid gray;
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
        cursor: pointer;
    }


    .search-list {
        margin: 0;
        padding: 0;
        list-style: none;
        width: inherit;
        border: 1px solid gray;
        border-radius: 4px;
        font-size: 16px;
        position: absolute;
        background-color: white;
        max-height: 300px;
        overflow-y: auto;
        z-index: 99;
    }

    .search-list::-webkit-scrollbar {
        width: 10px;
    }

    .search-list::-webkit-scrollbar-thumb {
        background-color: #E27C5E;
        border-radius: 10px;
        background-clip: padding-box;
        border: 2px solid transparent;
    }
    .search-list::-webkit-scrollbar-track {
        background-color: #F8F9FB;
        border-radius: 10px;
    }
    .search-list li {
        display: inline-block;
        box-sizing: border-box;
        border: none;
        border-radius: 4px;
        padding: 0.5em;
    }

    .search-list {
        display: none;
    }

    .search-list.success {
        display: block;
    }

    .search-list.success div {
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
    }

    .search-list.success div:hover {
        background-color: #FEF7F2;
    }
    .search-list.fail,
    .search-list.fail ~.no-result {
        display: block;
    }
    
    .no-result {
        display: none;
        color: gray;
        font-size: 16px;
    }

    .btn-add-area{
        font-size: 16px;
        padding-right: 0.5em;
        cursor: pointer;
    }

    .my-area{
        width:600px;
        margin: 0 auto;
        margin-top: 70px;
    }

    .my-area-list{
        margin: 0;
        padding: 0;
        list-style: none;      
        border: none;
        font-size: 16px;
        position: absolute;
        background-color: white;
        display: flex;
    }
    
    .my-area-list div{
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        background-color: #FEF7F2;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        width: 140px;
        height: 50px;
        padding: 0.5em;
        margin-right: 10px;
    }

    .my-area-list li {
        display: inline-block;
        box-sizing: border-box;
        position: relative;
        padding: 0.5em;
        color: #E27C5E;
        font-weight: bold;
    }

    .btn-delete-area{
        font-size: 16px;
        padding-right: 0.5em;
        cursor: pointer;
        color: #AAAAAA;
    }

    .my-area.none .none-interest {
        display: flex;
        align-items: center;
        justify-content: center;
    }

    .none-interest {
        display: none;
        width: 100%;
        height: 100px;
        background-color: #F8F9FB;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        text-align: center;
    }
    
    .nearby-area{
        width:600px;
        margin: 0 auto;
        margin-top: 120px;
        position: relative;
    }
    
    .nearby-area.none{
        margin-top: 50px;
    }
    
    .nearby-area.none .none-interest {
        display: flex;
        align-items: center;
        justify-content: center;
    }
    
    .nearby-list{
	    margin: 0;
	    padding: 0;
	    list-style: none;
	    width: 100%;
	    border: none;
	    font-size: 16px;
	    position: absolute;
	    background-color: white;
	    display: flex;
	    flex-wrap: wrap;
    }
    
    .nearby-list div{
        display: flex;
        flex-direction: row;
        justify-content: space-between;
        align-items: center;
        background-color: #FEF7F2;
        border: none;
        border-radius: 6px;
        font-size: 16px;
        width: 140px;
        height: 50px;
        padding: 0.5em;
        margin-right: 10px;
        margin-bottom: 10px;
    }

    .nearby-list li {
        display: inline-block;
        box-sizing: border-box;
        position: relative;
        padding: 0.5em;
        color: #E27C5E;
        font-weight: bold;
    }
    
    .sub-title {
    	display: block;
        margin-bottom: 14px;
    }
    
    .selected-area {
    	border: 2px solid #E27C5E;
    }
    
    h2 {
	    margin-bottom: 10px; 
    }
</style>
</head>
<body>
<h1 class="title">관심지역을 설정해주세요</h1>

<!-- 검색 -->
<div class="search-view">
    <form class="search-form">
        <div class="search-bar">
            <input type="text" name="keyword" class="search-input" placeholder="시/도, 시/군/구 검색(ex.영등포구)" autocomplete="off">
            <button type="submit" class="search-btn"><i class="fa-solid fa-magnifying-glass"></i></button> 
        </div>  
    </form>

    <!-- 검색 결과 화면 -->
    <ul class="search-list">
        <!-- 
            (jQuery)
            검색 결과가 있을 때, filterList의 값을 목록으로 출력함
            검색 결과가 없을 때, 검색 결과 없음 문구를 출력함
        -->
    </ul>
</div>

<!-- 홈으로 돌아가기 버튼으로 디자인 필요 -->
<div align="center">
	<br>
	<a href="${pageContext.request.contextPath}/home">홈으로 돌아가기</a>
</div>

<!-- 관심지역 목록  -->
<div class="my-area">
    <h2>내 관심지역</h2>
    <span class="sub-title">📌 자동으로 저장돼요</span>
    
    <p class="none-interest">자주 찾는 동네, 가고 싶은 여행지를 추가하고<br>
    최신 리뷰를 모아보세요!</p>

    <ul class="my-area-list">
    <!-- 관심지역이 있을 때, 지역 목록 출력 / 없을 때, 안내 문구 노출 -->
    </ul>
</div>

<!-- 인근지역 추천 목록 -->
<div class="nearby-area">
    <h2>이런 지역 어때요</h2>
    <span class="sub-title">👀 ${loginNick}님의 관심지역 주변</span>
    
	<p class="none-interest">관심지역을 추가하면<br>
	주변지역을 추천해드려요</p>
    
    <ul class="nearby-list">
    <!-- 관심지역 & 인근지역이 있을 때, 지역 목록 출력 / 없을 때, 안내 문구 노출 -->
    </ul>
</div>

<!-- jquery 라이브러리 -->
<script src="https://code.jquery.com/jquery-3.6.1.js"></script>
<script>
    $(function(){
        loadMyArea();
        
        //관심지역 목록 조회
        let interestList=[];
        function loadMyArea(){
            $.ajax({
                url : "${pageContext.request.contextPath}/rest/area/interest",
                method : "get",
                dataType : "json",
                success : function(resp) {
                    interestList = resp;
                    showMyArea();
                    if(interestList.length == 0) {
                    	$(".nearby-area").addClass("none");
                    	$(".nearby-list").hide();
                    } else  {
                    	$(".nearby-area").removeClass("none");
	                   	loadNearbyArea();                    	
                    	$(".nearby-list").show();
                    }
                }
            });
        };

		//인근지역 목록 조회
        let nearbyList=[];
        function loadNearbyArea(){
        	if(interestList.length == 0) return;
            $.ajax({
            	url : "${pageContext.request.contextPath}/rest/area/nearby",
                method : "post",
                dataType : "json",
                traditional: true,
                contentType:"application/json",
			    data:JSON.stringify(interestList),
                success : function(resp) {
                    nearbyList = resp;
                	showNearbyArea();
                }
            });
        };
        
        //관심지역 목록 출력
        function showMyArea(){
            $(".my-area-list").empty();
            $(".my-area").removeClass("none");
            if(interestList.length == 0) {
                $(".my-area").addClass("none");
            } else {
                $.each(interestList, function(index, value){
                    var li = $("<li>").text(value.areaCity+" "+value.areaDistrict)
                    .attr("data-no", value.areaNo);

                    //삭제 버튼
                    var span = $("<span>").html("<i class='fa-solid fa-xmark'></i>").attr("data-no", value.areaNo);
                    span.addClass("btn-delete-area");

                    //삭제 버튼 클릭 시, 내 관심지역에서 삭제
                    span.click(function(e){
                        e.stopPropagation(); //전파 중지

                        var areaNo = $(this).data("no");
                        deleteMyArea(areaNo);
                    });
                    var div = $("<div>").append(li).append(span); //주소, 삭제 버튼을 세트로 묶기
                    $(".my-area-list").append(div); //세트를 내 관심지역 목록 영역에 추가
                });    
            }
        };
		
        //인근지역 목록 출력
        function showNearbyArea(){
            $(".nearby-list").empty();
        	$.each(nearbyList, function(index, value){
                var li = $("<li>").text(value.areaCity+" "+value.areaDistrict)
                .attr("data-no", value.areaNo);

                //추가 버튼
                var span = $("<span>").html("<i class='fa-solid fa-plus'></i>").attr("data-no", value.areaNo);
            	span.addClass("btn-add-area");

                //추가 버튼 클릭 시, 내 관심지역에 추가
                span.click(function(e){
                    e.stopPropagation(); //전파 중지
                    
                    if(interestList.length < 3) {
                    	var areaNo = $(this).data("no");
                        addMyArea(areaNo);
                    } else {
                        alert('관심지역은 세 개까지 추가할 수 있어요'); //모달로 변경?
                    }
                });
                var div = $("<div>").append(li).append(span); //주소, 추가 버튼을 세트로 묶기
                $(".nearby-list").append(div); //세트를 인근지역 목록 영역에 추가
            });    
        };
        
        //지역 정보 목록 조회
        let addressList = [];
        $.ajax({
            url : "${pageContext.request.contextPath}/rest/area",
            method : "get",
            dataType : "json",
            success : function(resp) {
                addressList = resp;
            }
        });
    
        //지역 검색 결과
        $(".search-form").submit(e=>{
            e.preventDefault();

            const keyword = $("[name=keyword]").val();

            //키워드 유사 검색
            const filterList = addressList.filter(address=>{
                const completeAddress = address.areaCity + ' ' + address.areaDistrict;
                return completeAddress.indexOf(keyword) >= 0;
            });

            $(".search-list").empty();
            $(".search-list").removeClass("success fail");
            if(filterList.length == 0) {
                $(".search-list").addClass("fail");
                $(".search-list").append("<li class='no-result'>검색 결과가 없습니다.</li>");
            } else {
                $(".search-list").addClass("success");
            }
            
            //출력할 결과 목록 태그로 생성
            $.each(filterList, function(index, value){
                var li = $("<li>").text(
                    value.areaCity + " " + value.areaDistrict
                )
                .attr("data-no", value.areaNo);

                //추가 버튼
                var span = $("<span>").html("<i class='fa-solid fa-plus'></i>").attr("data-no", value.areaNo);
                span.addClass("btn-add-area");
                
                var div = $("<div>").attr("data-no", value.areaNo).append(li).append(span); //주소, 추가 버튼을 세트로 묶기
                $(".search-list").append(div); //세트를 결과 목록 영역에 추가
                
                //추가 버튼 클릭 시, 내 관심지역에 추가
                div.click(function(e){
                    e.stopPropagation(); //전파 중지
                    
                    if(interestList.length < 3) {
                        var areaNo = $(this).data("no");
                       	if(interestList.some(v => v.areaNo === areaNo)) {
                			alert('이미 추가된 관심지역이에요 😲'); //모달로 변경?                        		
                       	} else {
   		                    addMyArea(areaNo);                        		
                        }
                    } else {
                        alert('관심지역은 세 개까지 추가할 수 있어요.️'); //모달로 변경?
                    }
                });
                
            });    
        });

        //입력창 바깥 영역 클릭 시, 검색 결과 목록 숨기기
        $(document).click(function(e){ 
                if(!$(e.target).hasClass("search-input")) {
                    $(".search-list").removeClass("success fail");
                }    
        });

        //관심 지역 DB 등록
        function addMyArea(areaNo){
            var data = {
                areaNo:areaNo
            };

            $.ajax({
                url : "${pageContext.request.contextPath}/rest/area/interest",
                method : "post",
                contentType:"application/json",
			    data:JSON.stringify(data),
                success : function(resp) {
                    loadMyArea();
                }
            });
        };

        //관심 지역 DB 삭제
        function deleteMyArea(areaNo){
            $.ajax({
                url : "${pageContext.request.contextPath}/rest/area/interest/"+areaNo,
                method : "delete",
                success : function(resp) {
                    loadMyArea();
                }
            });
        };
    });
</script>
</body>
</html>
