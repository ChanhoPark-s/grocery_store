<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean class="my.member.MemberBean" id="mb" ></jsp:useBean>
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
 int result = mbao.updateMember(mb);
	String msg;
	String url;
	if(result>0){
		msg="회원정보 수정 완료";
	}
	else{
		msg="회원정보 수정 실패";
	}
	url="MemberList.jsp";
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>