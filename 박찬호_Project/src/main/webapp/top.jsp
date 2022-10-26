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
  width: 300px;
  margin-left: 400px; 
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
.main1>li:hover:last-child {
  border-bottom: white; /* 장바구니 밑에 색없애기위해. */
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
	function ClickCartList(){
		var id ='<%=(String)session.getAttribute("id")%>';
		if(id=="null"){
			if(confirm("로그인이 필요한 페이지 입니다.\n 로그인 하시겠습니까?")){
				location.href="<%=request.getContextPath()%>" + "/login.jsp";
			}
		}
		else{
			   location.href="<%=request.getContextPath()%>" + "/guest/cartList.jsp";
			}
		
}

</script>

 <head> <!-- notosans 폰트 적용 -->
 	 <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
<body>
<%
	/*id 에 해당하는 이름 가져오기  */
	String id =(String)session.getAttribute("id");
	
	MemberDao mdao = MemberDao.getinstance();
	MemberBean mb = mdao.getMemberById(id); 
%>

<form>
	<input type="hidden" name="id"value="<%=id %>">
</form>
<div class="top" align="right">
	<ul>
		<%
			if(id!=null){
		%>
			<li><a class="newlogin" href="<%=request.getContextPath() %>/mypage.jsp?id=<%=mb.getId()%>"><font color="#8ca86e"><%=mb.getName() %>님</font> <font color="#5d5d5d">마이페이지</font></a></li>
			<li><a href="<%=request.getContextPath()%>/logout.jsp">로그아웃</a></li>
		<%	
		}
			else{
		%>
			<li><a class="newlogin" href="<%=request.getContextPath() %>/newlogin.jsp">회원가입</a></li>
			<li><a href="<%=request.getContextPath() %>/login.jsp">로그인</a></li>
		<%	
		}
		%>
			<li><a href="<%=request.getContextPath() %>/Board/list.jsp">고객센터</a></li>
	</ul>
		
</div>

<!-- 로고  -->

<div align="center" class="logo">
	<a href="<%=request.getContextPath() %>/main.jsp"><img src="<%=request.getContextPath()%>/images/logo.jpg" width=400 height=150></a>
</div>
<br>



<!--상단 메뉴바  -->


<!-- 일반 사용자일때 메뉴바 -->
<div id="menu">
  <ul class="main1">
    <li style="border: none;"><a href="#"><b style="font-size: 20px;"><span style="font-size: 20px;">≡</span> 카테고리</b></a>
      <ul class="main2">
        
            <%
        CategoryDao cdao = CategoryDao.getinstance();
      	CategoryDao2 cdao2 = CategoryDao2.getinstance();
        
      	ArrayList<CategoryBean>lists = cdao.getAllCategory(); 
      	ArrayList<CategoryBean2>list = null;
        
      	System.out.println("CategoryBean list:"+lists.size());
		System.out.println("CategoryBean2 list:"+lists.size());
        for(CategoryBean cb : lists){
        %>
    <li><a href="<%=request.getContextPath() %>/guest/outCategory.jsp?code1=<%=cb.getCode1()%>"><img width="30px" height="30px" src="<%=request.getContextPath()%>/images/<%=cb.getCode1()%>.png">&nbsp;&nbsp;<%=cb.getCname() %></a>
      <ul class="main3">
      			 <%
      			 	list = cdao2.getAllCategory(cb.getCode1()); 
      			 	for(CategoryBean2 cb2 : list){
      			 %>
        			<li><a href="<%=request.getContextPath() %>/guest/inCategory.jsp?code1=<%=cb2.getCode1()%>&code2=<%=cb2.getCode2()%>"><%=cb2.getCname() %></a></li>
        		<%
      			 	}//CategoryBean2
        		%>
      </ul>
   	</li>
   		 <%
   		 }//CategoryBean 
   		 %>
      </ul>
    </li>
    <%
		String[] menubar={"BEST","신상품","알뜰상품","기획상품"};				
		for(int i=0;i<menubar.length;i++){
		%>
			    <li><a href="<%=request.getContextPath() %>/guest/mainmenu.jsp?pspec=<%=menubar[i]%>"><%=menubar[i] %></a></li>
		<%	
		}
		%>
    <li><a href="<%=request.getContextPath() %>/coupon.jsp">특가 / 혜택</a></li>
    <li style="margin-left: 50px;padding-bottom: 0;"><a href="javascript:ClickCartList()"><img width="35px" height="35px" src="<%=request.getContextPath()%>/images/cart.png"></a></li>
    </ul>
</div>


<hr width=80% class="categoryhr">
