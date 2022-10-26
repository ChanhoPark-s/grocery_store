<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<style>

.category input{ /* 검색어 */
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
	margin: 5px 0px 5px 0px;
}

.top ul li:first-child { /* 로그인버튼 */
	border-left: none;
}
a{
	text-decoration: none;
	color: #565656; /* #5d5d5d */
}
.login{
	color: #72aa37;
}
.top{
	margin-left :1000px;
	font-size:12px;
	width: 300px;
	height: 30px;
}
.logo{	/* 로고 */
	margin-left: 500px;
}
body {	/* 전체 글꼴 */
	font-family: 'Noto Sans KR', sans-serif;
}
.category>li{	/* 카테고리안에것들 */
	color: #5d5d5d;
	list-style-type: none;
	float: left;
	margin-left: 130px; 
} 
.category>li:first-child{
	margin-left : 180px;
	margin-right: 40px;
}
.category>li{
	display: inline;
}
 
.incategory>li{
	list-style-type: none;
}
.incategory{
	
}
.bottom{
	color: #5d5d5d;
}
.categoryhr{
	height: 2px;
} 
/*===============================  */


/*body 초기화*/
body {
  margin: 0;
  padding: 0;
  display: flex;
  flex-flow: column nowrap;
  justify-content: center;
  align-items: center;
  overflow-x: hidden;  
}


nav {
  width: 100%;
  display: flex;
  justify-content: center;
  position: relative;
}

ul, li {
  margin: 0;
  padding: 0;
  list-style: none;
}

.category > li {
  float: left;
  position: relative;
}

.category > li > a {
  font-size: 0.85rem;
  color: rgba(255,255,255,0.85);
  text-align: center;
  text-decoration: none;
  letter-spacing: 0.05em;
  display: block;
  padding: 14px 36px;
  border-right: 1px solid rgba(0,0,0,0.15);
  text-shadow: 1px 1px 1px rgba(0,0,0,0.2);
}

.category > li:nth-child(1) > a {
  border-left: 1px solid rgba(0,0,0,0.15);
}

.incategory {
  position: absolute;
  background: white;
  opacity: 0;
  visibility: hidden;
  transition: all 0.15s ease-in;
}

.incategory > li {
  padding: 16px 28px;
  border-bottom: 1px solid rgba(0,0,0,0.15);
}

.incategory > li >  a {
  color: #5d5d5d;
  text-decoration: none;
}

.category > li:hover .incategory {
  opacity: 1;
  visibility: visible;
}

.incategory > li >  a:hover {
 text-decoration: underline;
}
 

/*===============================  */

</style>


<!-- ==================jquery ==================================================== -->


<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
<script>
</script>
 <head> <!-- notosans 폰트 적용 -->
 	 <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
 </head>

<body>


<div class="top">
	<ul>
		<li><a class="login" href="login.jsp"><img width=50 height=30 src="<%=request.getContextPath()%>/images/login.jpg">로그인</a></li>
		<li><a href="newlogin.jsp">회원가입</a></li>
		<li><a href="help.jsp">고객센터</a></li>
	</ui>
		
</div>

<!-- 로고  -->
<div align="center" class="logo">
	<a href="main.jsp"><img src="<%=request.getContextPath()%>/images/logo.jpg" width=400 height=150></a>
</div>
<br>


<!--상단 메뉴바  -->
<nav role="navigation">
		<ul class="category">
			<li class="firstcategory">
				<a href="">카테고리</a>
				<ul class="incategory" ><!-- li에 for문으로 카테고리 들어가야함. -->
					<li><a href="" aria-label="subemnu">카테고리1</a></li>
					<li><a href="" aria-label="subemnu">카테고리1</a></li>
					<li><a href="" aria-label="subemnu">카테고리1</a></li>
					<li><a href="" aria-label="subemnu">카테고리1</a></li>
				</ul>
			</li>
			<li ><a href="new.jsp">신상품</a></li>
			<li ><a href="best.jsp">베스트</a></li>
			<li ><a href="new.jsp">기획전</a></li>
			<li ><a href="good.jsp">혜택 / 쿠폰</a></li>
			<li><input type="text" placeholder=" 검색어를 입력해주세요"  style="width:150px;height:30px;font-size:10px; border: 1px solid #565656; "></li>
		</ul>
	
</nav><br>
<!--  -->

<hr width=80% class="categoryhr">
<div>
	 <%-- <%@include file="image.jsp" %> --%>
</div>



<!-- bottom -->
<br>
<hr width=80% class="categoryhr">

<table border="1px" width=80% align="center">
	<tr>
		<td>
			<table class="bottom" width=40%> <!-- 왼쪽편 -->
				<tr>
					<th>고객센터</th>
				</tr>
				<tr>
					<td>사업자등록번호 123-456-00000 통신판매업신고번호 0000-인천-0123호
대표이사 박찬호 인천시 95, NAVER 0000, 12345
전화 1588-0000이메일 chanho159@naver.com사업자등록정보 확인</td>
				</tr>
			</table>
		</td>
		<td>
			<table width=30% border="1px">
			
			</table>
		</td>
	</tr>
	<tr>
		<td>
			<table width=30% border="1px">
			
			</table>
		</td>
	</tr>
</table>
</body>


