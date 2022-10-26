<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String pnum = request.getParameter("pnum");
System.out.println("pnum:"+pnum);

ProductDao pdao = ProductDao.getinstance();
	int result = pdao.deleteByPnum(pnum); 
	
	String msg;
	if(result>0){
		msg = pnum+"번의 상품 삭제 성공";
	}
	else{
		msg = pnum+"번의 상품 삭제 실패";
	}
%>
<script>
	alert("<%=msg%>");
	location.href="ProductListSeach.jsp?outcategory=채소&incategory=";

</script>