<%@page import="my.shop.CategoryDao2"%>
<%@page import="my.shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
	request.setCharacterEncoding("UTF-8");
    %>
<jsp:useBean id="cb2" class="my.shop.CategoryBean2"></jsp:useBean>
<jsp:setProperty property="*" name="cb2"/>

<%
String code1 = request.getParameter("likeLanguage");
cb2.setCode1(code1);
System.out.println("여기부터 보기");
System.out.println("name :"+cb2.getCname());
System.out.println("code1 :"+cb2.getCode1());
System.out.println("code2 :"+cb2.getCode2());
System.out.println("cnum :"+cb2.getCnum());
System.out.println("여기까지 보기");


	CategoryDao2 cdao2 = CategoryDao2.getinstance();
	
	int result = cdao2.updateBycnum(cb2);  /* 동시에 하위 카테고리 수정 */ 
	
	String url="inCategory.jsp";
	String msg;

	 if(result>0){
		msg="수정성공";
	}
	
	else{
		msg="수정실패";
	} 
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>