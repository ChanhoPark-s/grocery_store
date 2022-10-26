<%@page import="my.shop.mall.cartListDao"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
	String cnum = request.getParameter("cnum");
	String a = request.getParameter("a");	
	
	cartListDao cdao = cartListDao.getinstance();
	int result = cdao.updateCqty(id,a,cnum);
	
String url;
	
	if(result>0){
		url="cartList.jsp";
		
	}
	else{
		url="cartList.jsp";
	}
%>
<script>

	location.href="<%=url%>";
</script>