<%@page import="my.shop.ProductDao"%>
<%@page import="my.shop.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <style>
body{
    margin: 0px;
}
#carousel_section{
    width: 100%;
    background-color: gray;
}
#carousel_section > ul{
    margin: 0px;
    padding: 0px;
    width: 100%;
    height: 100%;
    position: relative;
    overflow: hidden;
}
#carousel_section > ul > li{
    list-style: none;
    width: 100%;
    height: 100%;
    position: absolute;
}
#carousel_section > ul > li >img{
    list-style: none;
    width: 100%;
    height: 100%;
    object-fit: cover;
}

 </style>   
 <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
<script>
var time; // 슬라이드 넘어가는 시간
var $carouselLi;
var carouselCount; // 캐러셀 사진 갯수
var currentIndex; // 현재 보여지는 슬라이드 인덱스 값
var caInterval;
 
//사진 연결
var imgW; // 사진 한장의 너비    
$(document).ready(function(){
 
    carouselInit(350, 4000);
});
 
$(window).resize(function(){
    carousel_setImgPosition();
});
 
/* 초기 설정 */
function carouselInit( height, t ){
    /*
     * height : 캐러셀 높이
     * t : 사진 전환 간격 
    */
 
    time = t;
    $("#carousel_section").height(height); // 캐너셀 높이 설정
    $carouselLi = $("#carousel_section > ul >li");
    carouselCount = $carouselLi.length; // 캐러셀 사진 갯수
    currentIndex = 0; // 현재 보여지는 슬라이드 인덱스 값
    carousel_setImgPosition();
    carousel();
}
 
function carousel_setImgPosition(){
 
    imgW = $carouselLi.width(); // 사진 한장의 너비    
    // 이미지 위치 조정
    for(var i = 0; i < carouselCount; i++)
    {
        if( i == currentIndex)
        {
            $carouselLi.eq(i).css("left", 0);
        }
        else
        {
            $carouselLi.eq(i).css("left", imgW);
        }
    }
}
 
function carousel(){
 
    // 사진 넘기기
    // 사진 하나가 넘어간 후 다시 꼬리에 붙어야함
    // 화면에 보이는 슬라이드만 보이기
    caInterval = setInterval(function(){
        var left = "-" + imgW;
 
        //현재 슬라이드를 왼쪽으로 이동 ( 마이너스 지점 )
        $carouselLi.eq(currentIndex).animate( { left: left }, function(){
            // 다시 오른쪽 (제자리)로 이동
            $carouselLi.eq(currentIndex).css("left", imgW);
 
            if( currentIndex == ( carouselCount - 1 ) )
            {
                currentIndex = 0;
            }
            else
            {
                currentIndex ++;
            }
        } );
 
        // 다음 슬라이드 화면으로
        if( currentIndex == ( carouselCount - 1 ) )
        {
            // 마지막 슬라이드가 넘어갈땐 처음 슬라이드가 보이도록
            $carouselLi.eq(0).animate( { left: 0 } );
        }
        else
        {
            $carouselLi.eq(currentIndex + 1).animate( { left: 0 } );
        }
    }, time);
}
$carouselLi.eq(currentIndex).animate( { left: left }, function(){
    // 다시 오른쪽 (제자리)로 이동
    $carouselLi.eq(currentIndex).css("left", imgW);

    if( currentIndex == ( carouselCount - 1 ) )
    {
        currentIndex = 0;
    }
    else
    {
        currentIndex ++;
    }
} );
$(window).resize(function(){
    carousel_setImgPosition();
});

</script>
 
<html>
<head>
	<title></title>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript" src="../js/carousel.js"></script>
	<link rel="stylesheet" type="text/css" href="../css/carousel.css">
</head>
 
<%@include file="top.jsp" %>

<body>
	<div id="carousel_section">
		<ul>
			<li> <img src="./images/1.png"> </li>
			<li> <img src="./images/2.png"> </li>
			<li> <img src="./images/3.png"> </li>
			<li> <img src="./images/4.png"> </li>
		</ul>
	</div>
</body>
</html>

<%@include file="bottom.jsp" %>
