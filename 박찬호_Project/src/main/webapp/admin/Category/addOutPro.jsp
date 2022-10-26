<%@page import="my.shop.CategoryDao"%>
<%@page import="my.shop.CategoryDao2"%>
<%@page import="my.shop.CategoryBean2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 <%
	request.setCharacterEncoding("UTF-8");
  %>
    

<jsp:useBean id="cb" class="my.shop.CategoryBean"></jsp:useBean>
<jsp:setProperty property="*" name="cb"/>

<%


CategoryDao cdao = CategoryDao.getinstance();

int result =cdao.insertInCate(cb);  

String url="outCategory.jsp";
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