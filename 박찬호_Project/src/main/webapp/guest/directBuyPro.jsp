<%@page import="my.shop.mall.cartListBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.shop.mall.cartListDao"%>
<%@page import="my.shop.mall.OrdersDao"%>
<%@page import="my.member.MemberDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean class="my.member.MemberBean" id="mb"></jsp:useBean>
<jsp:setProperty property="*" name="mb"/>
<%
	String id = (String)session.getAttribute("id");
	String pnum = request.getParameter("pnum");
	String qty = request.getParameter("qty");

System.out.println("id :"+id); 
System.out.println("pnum :"+pnum); 
System.out.println("address :"+mb.getAddress());
System.out.println("detailaddress :"+mb.getDetailaddress());
System.out.println("qty :"+qty);
	

	OrdersDao odao = OrdersDao.getinstance();
	int result = odao.insertDirect(id,pnum,mb,qty);
	
	String url;
	String msg;
	
	if(result>0){
		msg="저희 제품을 이용해주셔서 감사합니다.";
		url="../main.jsp";
	}
	else{
		msg="구매 실패하셨습니다.";
		url="history.go(-1)";
	} 
%>
<script>
	alert("<%=msg%>")
	location.href="<%=url%>";

</script>