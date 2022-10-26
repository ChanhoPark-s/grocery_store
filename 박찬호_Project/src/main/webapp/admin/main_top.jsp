<%@page import="my.shop.CategoryBean2"%>
<%@page import="my.shop.CategoryDao2"%>
<%@page import="my.shop.CategoryBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.shop.CategoryDao"%>
<%@page import="my.member.MemberBean"%>
<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>

 /* select */
.pl{
    width: 200px;
    border: 1px solid #C4C4C4;
    box-sizing: border-box;
    border-radius: 10px;
    padding: 12px 13px;
    font-family: 'Roboto';
    font-style: normal;
    font-weight: 400;
    font-size: 14px;
    line-height: 16px;
}

.pl:focus{
    border: 1px solid #e8f4db;
    box-sizing: border-box;
    border-radius: 10px;
    outline: 3px solid #e8f4db;
    border-radius: 10px;
}
 /* select */
 
 
 
 
hr{
		border-bottom: none;
		border-left: none;
		border-right: none;
}

nav input{ /* 검색어 */
	border-color: #565656;
	background-image: url("<%=request.getContextPath()%>/images/search.jpg");
	background-repeat: no-repeat;
	background-position: right;
	border-radius: 15px;
	background-size: 25px;
	outline: none;
}  

.top ul { /* 로그인 칸*/
	list-style-type: none;
	/* 좌측 여백 없애기 */
	padding-left: 0px;
	/* 우측 정렬 하기 */
	float: right;
}

.top ul li { /* 로그인칸 */
	display: inline;
	border-left: 1px solid;
	padding: 0px 10px 0px 10px;
}

.top ul li:first-child { /* 로그인버튼 */
	border-left: none;
}
a{
	text-decoration: none;
	color: #565656; /* #5d5d5d */
}
.top{
	font-size:12px;
	width: 300px;
	height: 30px;
}
.newlogin{
	color: #72aa37;
} 
body {	/* 전체 글꼴 */
	font-family: 'Noto Sans KR', sans-serif;
	color: #5d5d5d;
}

.bottom{
	color: #5d5d5d;
}
/*====================================  */ 

*{ 
  list-style: none;
}
a {
  text-decoration: none;
  color: #57523E;
}

#menu{
  position:relative; 
  z-index: 99; 
  background-color: white;
  height: 50px;
  text-align: center;
}
 
[class*="main"] {
  background-color: white;
  border-radius: 5px 5px 5px 5px;
}

[class*="main"] ul {
  border-radius: 5px 5px 5px 5px;
  border: 1px solid #57523E;
}
.main1{
  padding-left: 0px;
   height: 100%;
  width: 1000px;
  margin: 0 auto;
  display: inline-block;
}
.main1>li {
  float: left;
  width: 13%;
  line-height: 50px;
  position: relative;
}
.main1>li:hover .main2 {
  left: 0;
}
.main1>li a {
  display: block;
}
.main1>li a:hover {
  font-weight: bold;
}
.main2 {
	text-align:left;
  width:170%;
  position: absolute;
  top: 50px;
  left: -9999px;
  padding: 0px;
}
.main1>li:hover {
  border-bottom: 3px solid #8ca86e;
}
.main2 li:hover {
  border-left: 4px solid #8ca86e;
}

.main2>li {
  position: relative;
}
.main2>li:hover .main3 {
  left: 100%;
}
.main2>li a, .main3>li a {
  border-radius: 10px;
  margin: 10px;
}  
.main3 {
  position: absolute;
  top: -10px;
  width: 100%;
  left: -9999px;
  padding: 0px;
}
.main3>li a:hover {
  color: #5d5d5d;
}
nav {
  margin-top: 20px;
}
</style>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
<script>

</script>
 <head> <!-- notosans 폰트 적용 -->
 	 <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
 </head>

<body>

<%
	String id = request.getParameter("id");
	/*id 에 해당하는 이름 가져오기  */
	session.setAttribute("id", id);
	MemberDao mdao = MemberDao.getinstance();
	MemberBean mb = mdao.getMemberById(id); 
	String Path = request.getContextPath();
%>

<div class="top" align="right">
	<ul>
		
			<li><a class="newlogin" href="mypage.jsp?id=admin"><font color="#8ca86e">관리자님</font> <font color="#5d5d5d">마이페이지</font></a></li>
			<li><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></li>
		
	</ul>
		
</div>

<!-- 로고  -->

<div align="center" class="logo">
	<a href="<%=Path %>/admin/orderList.jsp"><img src="<%=request.getContextPath()%>/images/logo.jpg" width=400 height=150></a>
</div>
<br>


<div id="menu">
  <ul class="main1">
    <li style="border: none;"><a href="#">카테고리</a>
       <ul class="main2">
        <li><a href="<%=Path%>/admin/Category/outCategory.jsp">대분류 카테고리</a></li>
        <li><a href="<%=Path%>/admin/Category/inCategory.jsp">소분류 카테고리</</a></li>
      </ul>
    </li>
    <li style="border: none;"><a href="<%=Path%>/admin/Product/ProductAllList.jsp">상품</a>
       <ul class="main2">
        <li><a href="<%=Path%>/admin/Product/addProduct.jsp">상품 등록</a></li>
        <li><a href="<%=Path%>/admin/Product/ProductList.jsp">상품내역</a></li>
      </ul>
     </li>
    <li><a href="<%=Path %>/admin/orderList.jsp">주문 내역</a></li>
    <li><a href="<%=Path %>/admin/MemberList.jsp">회원 관리</a></li>
    </ul>
</div>

