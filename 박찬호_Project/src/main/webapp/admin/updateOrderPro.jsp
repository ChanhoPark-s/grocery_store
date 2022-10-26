<%@page import="my.shop.mall.OrdersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");

	String id = request.getParameter("id");
	String onum = request.getParameter("onum");
	String pnum = request.getParameter("pnum");
	String address = request.getParameter("address");
	String pqty = request.getParameter("pqty");
	String price = request.getParameter("price");
	
	System.out.println("Pro에서의 id :"+id);
	System.out.println("Pro에서의 onum :"+onum);
	System.out.println("Pro에서의 pnum :"+pnum);
	System.out.println("Pro에서의 address :"+address);
	System.out.println("Pro에서의 pqty :"+pqty);
	System.out.println("Pro에서의 price :"+price);
	
	OrdersDao odao = OrdersDao.getinstance();
	
	int result = odao.updateOrder(onum,pnum,address,pqty,price); 
	
	String msg;
	String url;
	if(result>0){
		msg="주문내역 수정 완료";
	}
	else{
		msg="주문내역 수정 실패";
	}
	url="updateOrder.jsp?onum="+onum+"&pnum="+pnum;
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>