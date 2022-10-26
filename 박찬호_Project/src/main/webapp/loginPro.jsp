<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
loginPro.jsp<br>

<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String password = request.getParameter("password");
	
	MemberDao mdao = MemberDao.getinstance();
	int result = mdao.login(id,password);
	
	String url;
	String msg;
	
	if(result>0 && id.equals("admin")){
		session.setAttribute("id", id);
		url="admin/orderList.jsp";
	}
	
	else if(result>0){
		session.setAttribute("id", id);
		url="main.jsp?id="+id;
	}
	else{
		url="login.jsp";
	%>
		<script>
			alert("아이디 또는 비밀번호를 확인해주세요");
		</script>
	<%
	}
%>
<script>
	location.href="<%=request.getContextPath()%>/<%=url%>";

</script>