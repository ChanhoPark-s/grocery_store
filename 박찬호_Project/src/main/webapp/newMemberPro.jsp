<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
newMemberPro.jsp<br>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="mb" class="my.member.MemberBean"></jsp:useBean>
<jsp:setProperty property="*" name="mb"/>
<%
	System.out.println("getId :"+mb.getId());
	System.out.println("Password :"+mb.getPassword());
	System.out.println("name :"+mb.getName());
	System.out.println("email :"+mb.getEmail());
	System.out.println("phone :"+mb.getPhone());
	System.out.println("postcode :"+mb.getPostcode());
	System.out.println("address :"+mb.getAddress());
	System.out.println("detailaddress :"+mb.getDetailaddress());
	System.out.println("gender :"+mb.getGender());
	System.out.println("birth :"+mb.getBirth());
	
	MemberDao mbao = MemberDao.getinstance();
	int result = mbao.insertMember(mb);
	
	
	String url="main.jsp";
	String msg;
	if(result>0){
		msg="회원가입 성공";
	}
	else{
		msg="회원가입 실패";
	}
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>