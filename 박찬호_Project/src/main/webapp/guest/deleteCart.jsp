<%@page import="my.shop.mall.cartListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String cnum = request.getParameter("cnum");
	String id = (String)session.getAttribute("id");
	
	System.out.println("id :"+id);
	System.out.println("cnum :"+cnum);
	
	
	cartListDao cdao = cartListDao.getinstance();
	cdao.deleteByIdCnum(id,cnum); 
	String url;
	String msg;
	
	url="cartList.jsp";
%>
<script>
	location.href="<%=url%>";
</script>