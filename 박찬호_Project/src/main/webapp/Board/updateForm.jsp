<%@page import="Board.BoardBean"%>
<%@page import="Board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script type="text/javascript" src="js/jquery.js"/>
<script>
	

</script>


<%@include file="/top.jsp"%><br>
content.jsp(num) => updateForm.jsp <br>


<%
	String num = request.getParameter("num");
	String pageNum = request.getParameter("pageNum");
	System.out.println("updateForm.jsp num :"+num);

BoardDao bdao = BoardDao.getInstance();

BoardBean bb = bdao.updateGetArticle(num); 
%>

<body >
	<!-- <center> -->
		<b>글쓰기</b> <br>
		<form method="post" name="writeform" action="updatePro.jsp" onsubmit="return writeSave()"> 
			
			<input type="hidden" name="num" value="<%=bb.getNum()%>"><!--넘기기위함  -->
			
			<input type="hidden" name="pageNum" value="<%=pageNum%>"><!--수정하기창에서 수정하고 그 창으로 가기위함.  -->
			
			
			
			<table width="430" border="1" cellspacing="0" cellpadding="0"
				 align="center">
				<tr>
					<td align="right" colspan="2" >
						<a href="list.jsp"> 글목록</a>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">이 름</td>
					<td width="330" align="left">
					<input type="text" size="30" maxlength="10"	name="writer" 
							value="<%=bb.getWriter()%>"></td>
				</tr>
				
				<tr>
					<td width="100"  align="center">제 목</td>
					<td width="330" align="left">					
						<input type="text" size="50" maxlength="50" name="subject" 
								value="<%=bb.getSubject()%>">
					</td>
				</tr>
				
				<tr>
					<td width="100"  align="center">Email</td>
					<td width="330" align="left">
					<input type="text" size="50" maxlength="30"	name="email" 
							value="<%=bb.getEmail()%>"></td>
				</tr>
				
				<tr>
					<td width="100" align="center">내 용</td>
					<td width="330" align="left">
						<textarea name="content" id="abc" rows="13" cols="50" ><%=bb.getContent() %></textarea>
					</td>
				</tr>
				<tr>
					<td width="100" align="center">비밀번호</td>
					<td width="330" align="left">
						<input type="password" size="10" maxlength="12"	name="passwd"  
								value="">
					</td>
				</tr>
				<tr>
					<td colspan=2 align="center" height="30">
						<input	type="submit" value="수정하기" >  <!-- onClick="return writeSave()" -->
						<input type="reset"	value="다시작성"> 
						<input type="button" value="목록보기"	
								OnClick="window.location='list.jsp?pageNum=<%=pageNum%>'">
					</td>
				</tr>
			</table>	
		</form>
</body>

<%@include file="/bottom.jsp"%><br>