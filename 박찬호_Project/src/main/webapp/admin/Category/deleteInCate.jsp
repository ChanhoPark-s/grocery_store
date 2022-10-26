<%@page import="my.shop.CategoryDao2"%>
<%@page import="my.shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String cnum = request.getParameter("cnum");
	System.out.println("cnum:"+cnum);
	
	CategoryDao2 cdao2 = CategoryDao2.getinstance();
	
	int result = cdao2.deleteBycnum(cnum); /* 하위 카테고리 삭제 */
	
	String url="inCategory.jsp";
	String msg;
	if(result>0){
		msg="삭제성공";
	}else{
		msg="삭제실패";
	}

%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>