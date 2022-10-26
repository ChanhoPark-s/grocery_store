<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");

String id = request.getParameter("id");
System.out.println("id :"+id);

MemberDao mdao = MemberDao.getinstance();

boolean result = mdao.idcheck(id);
String str;

if(result){
	str="no";
	out.print(str);
}
else{
	str = "yes";
	out.print(str);
}
%>

