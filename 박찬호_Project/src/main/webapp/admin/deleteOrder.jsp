<%@page import="my.shop.mall.OrdersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String onum = request.getParameter("onum");
	String pnum = request.getParameter("pnum");
	
	System.out.println("Pro에서의 onum :"+onum);
	System.out.println("Pro에서의 pnum :"+pnum);
	
	OrdersDao odao = OrdersDao.getinstance();
	
	int result = odao.deleteOrder(onum,pnum);  
	
	String msg;
	String url;
	if(result>0){
		msg="주문내역 삭제 완료";
	}
	else{
		msg="주문내역 삭제 실패";
	}
	url="orderList.jsp";
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>