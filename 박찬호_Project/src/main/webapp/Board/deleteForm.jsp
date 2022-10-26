<%@page import="Board.BoardDao"%>
<%@page import="Board.BoardBean"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
deleteForm.jsp <br>
<%
	request.setCharacterEncoding("UTF-8");

	String pageSize = request.getParameter("pageSize");
	String pageNum = request.getParameter("pageNum");
	String num = request.getParameter("num");
	
	System.out.println("pageNum:"+pageNum);
	System.out.println("num:"+num);
%>

<script>
	
	function deleteCheck(){
		if(document.delForm.passwd.value==""){ // forms[0]==delForm
			alert('비밀번호를 입력하세요');
			return false;
		}
	}

</script>

<%@include file="/top.jsp"%><br>

<form method="post" name="delForm" action="deletePro.jsp?pageNum=<%=pageNum%>&pageSize=<%=pageSize %>" onsubmit="return deleteCheck()" align="center">
	<b>글삭제</b>
	<table border="1"  align="center" width="500" height="120">
		<tr>
			<th>비밀번호를 입력해 주세요</th>
		</tr>
		<tr>
			<td align="center">
			비밀번호 : <input type="text" name="passwd" size="10">
					<input type="hidden" name="num" value="<%=num %>">
			</td>
		</tr>
		<tr>
			<td align="center">
			<input type="submit" value="글삭제">
			<input type="button" value="글목록" onClick="location.href='list.jsp?pageNum=<%=pageNum%>'"> 
			</td>
		</tr>
	</table>


</form>

<%@include file="/bottom.jsp"%><br>