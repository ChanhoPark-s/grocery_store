<%@page import="my.shop.CategoryDao2"%>
<%@page import="my.shop.CategoryBean2"%>
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

CategoryDao2 cdao2 = CategoryDao2.getinstance();

int result =cdao2.insertInCate(cb2); 

String url="inCategory.jsp";
String msg;
if(result>0){
	msg="삽입성공";
}else{
	msg="삽입실패";
}

%>
<script>
alert("<%=msg%>");
location.href="<%=url%>";
</script>
%>