<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
content.jsp(부모 3가지) => replyForm.jsp <br>

<style>
	body{
		text-align: center;
	}
	table{
		margin : auto;
	}
</style>    
<!-- jQuery -->
<script type="text/javascript" src="js/jquery.js"></script>
<script type="text/javascript" src="script.js"></script>

<%@include file="/top.jsp"%><br>
<%
// 부모의 정보가 넘어온다.
String ref = request.getParameter("ref");
String re_step = request.getParameter("re_step");
String re_level = request.getParameter("re_level");
System.out.println(ref); 
System.out.println(request.getParameter("re_step"));
System.out.println(request.getParameter("re_level"));

%>
<body>
	<!-- <center> -->
		<b>답글쓰기</b> <br>
		<form method="post" name="writeform" action="replyPro.jsp?" onsubmit="return writeSave()">
			<input type="hidden" name="ref" value="<%=ref%>"> 
			<input type="hidden" name="re_step" value="<%=re_step%>"> 
			<input type="hidden" name="re_level" value="<%=re_level%>">
		 
			<table width="430" border="1" cellspacing="0" cellpadding="0"
				 align="center">
				<tr>
					<td align="right" colspan="2" >
						<a href="list.jsp"> 글목록</a>
					</td>
				</tr>
				<tr>
					<td width="100"  align="center">이 름</td>
					<td width="330" align="left">
					<input type="text" size="30" maxlength="10"	name="writer" 
							value="홍길동"></td>
				</tr>
				
				<tr>
					<td width="100" align="center">제 목</td>
					<td width="330" align="left">					
						<input type="text" size="50" maxlength="50" name="subject" 
								value="[답글]어떤글">
					</td>
				</tr>
				
				<tr>
					<td width="100" align="center">Email</td>
					<td width="330" align="left">
					<input type="text" size="50" maxlength="30"	name="email" 
							value="aa@xx.com"></td>
				</tr>
				
				<tr>
					<td width="100" align="center">내 용</td>
					<td width="330" align="left">
						<textarea name="content" id="abc" rows="13" cols="50">호호호</textarea>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">비밀번호</td>
					<td width="330" align="left">
						<input type="password" size="10" maxlength="12"	name="passwd"  
								value="1234">
					</td>
				</tr>
				<tr>
					<td colspan=2 align="center" height="30">
						<input	type="submit" value="답글쓰기" >  <!-- onClick="return writeSave()" -->
						<input type="reset"	value="다시작성"> 
						<input type="button" value="목록보기"	
								OnClick="window.location='list.jsp'">
					</td>
				</tr>
			</table>	
		</form>
</body>

<%@include file="/bottom.jsp"%><br>