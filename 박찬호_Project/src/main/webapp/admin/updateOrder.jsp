<%@page import="my.shop.ProductDao"%>
<%@page import="my.shop.ProductBean"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="my.shop.mall.OrdersBean"%>
<%@page import="my.shop.mall.OrdersDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
 	.insert{
	width: 400px;
    height: 50px; 
    border-radius: 4px;
 	border:1px solid #e1e1e1;
    outline: none;
 }
th{
	text-align: left;
}
tr{
	height: 80px;
}
.right{
	text-align: center;
}

 .up{
    border-radius: 4px;
	width: 150px;
    height: 50px; 
	border:none;
	font-weight:bold; 
	color:white; 
	background-color: #8ca86e;
}
 .back{
    border-radius: 4px;
	width: 150px;
    height: 50px; 
	border:1px solid #8ca86e;
	font-weight:bold; 
	color:#8ca86e; 
	background-color: white;
}
.plus{
  border-radius: 4px;
	width: 30px;
    height: 25px; 
 	border:1px solid #8ca86e;
	background-color:white;
	font-weight:bold; 
	color:#8ca86e; 
}
</style> 
<body onload="init();">
 <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
<script language="JavaScript">

var sell_price;
var amount;

function init () {
 sell_price = document.f.sell_price.value;
 amount = document.f.pqty.value;
 document.f.price.value = sell_price *amount;
 change();
}

function add () {
 hm = document.f.pqty;
 sum = document.f.price;
 hm.value ++ ;

 sum.value = parseInt(hm.value) * sell_price;
}

function del () {
 hm = document.f.pqty;
 sum = document.f.price;
  if (hm.value > 1) {
   hm.value -- ;
   sum.value = parseInt(hm.value) * sell_price;
  }
}

function change () {
 hm = document.f.amount;
 sum = document.f.sum;

  if (hm.value < 0) {
   hm.value = 0;
  }
 sum.value = parseInt(hm.value) * sell_price;
} 

function update(){
	if($('input[name="address"]').val().length==0){
		alert("배송지를 입력하세요");
	}
	else{
		document.f.submit();		
	}
}

</script>
<%@include file="/admin/main_top.jsp" %>
  <%
  	request.setCharacterEncoding("UTF-8");
  	String onum = request.getParameter("onum");
  	String pnum = request.getParameter("pnum");
  	id = request.getParameter("id");
	System.out.println("onum:"+onum);
	System.out.println("pnum:"+pnum);
	
	OrdersDao odao = OrdersDao.getinstance();
	ProductDao pdao = ProductDao.getinstance();
	
	OrdersBean ob = odao.getOderByOnumPnum(onum,pnum); 
	ProductBean pb =pdao.getProductByPnum(pnum);
  %>

<div align="center">
<br><br>
	<h2>상품 수정</h2><br>
	
<form name="f" action="updateOrderPro.jsp">
	<input type="hidden" name="id" value="<%=id%>">
	<input type="hidden" name="onum" value="<%=onum%>">
	<input type="hidden" name="pnum" value="<%=pnum%>">
	
	<table align="center" >
		<tr>
		<td rowspan="11" width="50%" align="center" class="im">
		<%
				String rContext = request.getContextPath() + "/admin/images/";
				String fullPath = rContext + pb.getPimage();
				DecimalFormat df = new DecimalFormat("###,###");
		%>
		<img src="<%=fullPath%>" width="360px" height="410px"></a><br>
		</td>
	</tr>	
	<tr height="40px">
		<td colspan="2">	
			<font size="5px;"><b><%=pb.getPname() %></b></font>
		</td>
	</tr>
	<tr height="70px">
		<td colspan="2">
			<font size="5px;"><b><%=df.format(pb.getPrice()) %>원</b></font>
		</td>
	</tr>
	<tr class="bottomline">
		<td class="sotitle">재고수량</td>
		<td align="left">
			<font size="2px;" color="#908f8f"><%=pb.getPqty() %></font>
		</td>
	</tr>
	<tr class="bottomline">
		<td class="sotitle">배송지</td>
		<td align="left" width="">
			<input class="insert" name="address"type="text" value="<%=ob.getAddress()%>" size="40px">
		</td>
	</tr>
	<tr>
		<td class="sotitle">구매수량</td>
		<td>
			<input type=hidden name="sell_price" value="<%=pb.getPrice()%>">
			<input type="button"   class="plus" value=" - " onclick="del();">
			<input type="text"  name="pqty" value="<%=ob.getQty() %>" size="3" style="text-align: center;border: 0;" onchange="change();"readonly>
			<input type="button"  class="plus" value=" + " onclick="add();"><br>
		</td>
	</tr>
	<tr>
		<td colspan="2">
			<b>총 상품금액</b>
			<input type="text" style="text-align:right; border: 0; font-size: 40px;color: #6f8a52;" name="price" size="11" readonly>원
		</td>
	</tr>
	<tr>
		<td colspan="" align="center">
			<a href="orderList.jsp"><input class="back" type="button" value="목록보기"></a>
		</td>
		<td colspan="" align="center">
			<a href="javascript:update()"><input class="up" type="button" value="수정하기"></a>
		</td>
	</tr>
	</table>

</form>	
</div>
<%@include file="/admin/main_bottom.jsp" %>