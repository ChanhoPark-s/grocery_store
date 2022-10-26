<%@page import="my.shop.mall.cartListBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.shop.mall.cartListDao"%>
<%@page import="my.shop.mall.OrdersDao"%>
<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	
	String id = (String)session.getAttribute("id");
	String[] cnum =request.getParameterValues("cnum");
	
	for(int i=0;i<cnum.length;i++){
		System.out.println("cnum"+cnum[i]);
	}
	
	cartListDao cdao = cartListDao.getinstance();
	OrdersDao odao = OrdersDao.getinstance();
	
	
	int result = odao.insertCart(id);  
	
	String url;
	String msg;
	
	if(result>0){
		cdao.deleteByIdCnumArray(id, cnum); 
		msg="저희 제품을 이용해주셔서 감사합니다.";
		url="../main.jsp";
	}
	else{
		msg="구매 실패하셨습니다.";
		url="cartList.jsp";
	}
%>
<script>
	alert("<%=msg%>")
	location.href="<%=url%>";

</script>