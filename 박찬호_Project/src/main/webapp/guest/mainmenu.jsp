<%@page import="java.text.DecimalFormat"%>
<%@page import="my.shop.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.1{
		font-size: 2px;
	}

</style>
<%@include file="/top.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");

	String pspec = request.getParameter("pspec");
	System.out.println("pspec :"+pspec);

	ProductDao pdao = ProductDao.getinstance();
	
	ArrayList<ProductBean>plists =  pdao.getProductByPspec(pspec);  
	
%>
<table align="center" width=35%>
	<tr align="center">
	<%
	if(plists.size()==0){
	%>
		<td>
			<img width="800px" height="400px" alt="준비중입니다." src="<%=request.getContextPath()%>/images/ready.png">
		</td>
	</tr>
	<%	
	}
	else{
	%>
	
	<tr align="center">
		<td align="center" colspan="3" height="100px">
		<h2><%=pspec %></h2>
		</td>
	</tr>
	<tr>
		<td colspan="3" style="text-align: left; margin-left: 50px;">
		<font size="2px;"><b><%if(plists.size()!=0){%>총<%=plists.size() %>건<%} %></b></font>
		</td>
	</tr>
	<%
	%>
		<tr>
				<%
				if(plists.size()==0){
				%>
					<td>
						<h2>준비중입니다</h2>
					</td>
				<%	
				}
				int i=1;
				for(ProductBean pb : plists){
				String rContext = request.getContextPath() + "/admin/images/";
				String fullPath = rContext + pb.getPimage();
				DecimalFormat df = new DecimalFormat("###,###");
				%>
			<td style="padding: 20px">
				
				<a href="detailProduct.jsp?pnum=<%=pb.getPnum()%>"><img src="<%=fullPath%>" width="360px" height="410px"></a><br>
				
				<font size="2px;" color="908f8f">샛별배송</font><br>
				
				<font ><%=pb.getPname() %></font><br>
				
				<b><%=df.format(pb.getPrice()) %>원</b><br>
				
				<font size="2px;" color="908f8f"><%=pb.getPcontents() %></font>
			</td>
				<%		
				if(i%3==0){
				%>
		</tr>
				<%
				}//if
				i++;
				
			}//제목 BEST 신상품
				
	}//맨위 else 준비중입니다.
		%>
	<tr height="350px">
		<td>
		</td>
	</tr>
</table>

<%@include file="/bottom.jsp" %>