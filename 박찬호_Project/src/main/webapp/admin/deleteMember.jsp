<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String no = request.getParameter("no");
	
	System.out.println("deleteMember no :"+no);	
	
	MemberDao mdao = MemberDao.getinstance();
	int result = mdao.deleteMember(no); 
	String msg;
	String url;
	if(result>0){
		msg="회원 삭제 완료";
	}
	else{
		msg="회원 삭제 실패";
	}
	url="MemberList.jsp";
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>