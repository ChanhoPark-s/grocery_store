<%@page import="my.shop.mall.cartListDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pnum = request.getParameter("pnum");
	String pqty = request.getParameter("pqty");
	
	System.out.println("pnum :"+pnum);
	System.out.println("pqty :"+pqty);
	
	String id = (String)session.getAttribute("id");
	System.out.println("id :"+id);
	
	cartListDao cdao = cartListDao.getinstance();
	int result = cdao.insertCart(pnum,pqty,id); 
	String check="check";
	String url;
	String msg;
	
	if(result>0){
		msg="장바구니에 담았습니다.";
		url="detailProduct.jsp?pnum="+pnum+"&check="+check;
		
	}
	else{
		msg="장바구니에 담지 못하였습니다.";
		url="cartList.jsp?pnum="+pnum;
	}
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>