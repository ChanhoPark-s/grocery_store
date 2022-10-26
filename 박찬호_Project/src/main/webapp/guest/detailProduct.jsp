<%@page import="java.text.DecimalFormat"%>
<%@page import="my.shop.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.sotitle{
		text-align: left;
		width: 100px;
		size : 2px;
		color : #908f8f;
		font-weight: bold;
	}
	.bottomline{
		border-bottom: 1px solid black;
	}
	.im{
	padding: 30px;
	padding-top:0px;
	}
	 .buy{
    border-radius: 4px;
	width: 200px;
    height: 50px; 
	border:none;
	font-weight:bold; 
	color:white; 
	background-color: #8ca86e;
}
 .cart{
    border-radius: 4px;
	width: 200px;
    height: 50px; 
 	border:1px solid #8ca86e;
	background-color:white;
	font-weight:bold; 
	color:#8ca86e; 
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
$(function(){
	$('.idhide').hide();
});
var sell_price;
var amount;

function init () {
 sell_price = document.form.sell_price.value;
 amount = document.form.pqty.value;
 document.form.price.value = sell_price;
 change();
}

function add () {
 hm = document.form.pqty;
 sum = document.form.price;
 hm.value ++ ;

 sum.value = parseInt(hm.value) * sell_price;
}

function del () {
 hm = document.form.pqty;
 sum = document.form.price;
  if (hm.value > 1) {
   hm.value -- ;
   sum.value = parseInt(hm.value) * sell_price;
  }
}

function change () {
 hm = document.form.amount;
 sum = document.form.sum;

  if (hm.value < 0) {
   hm.value = 0;
  }
 sum.value = parseInt(hm.value) * sell_price;
} 


	function cart(){
	
		var id ='<%=(String)session.getAttribute("id")%>';
		if(id=="null"){
			if(confirm("로그인이 필요한 페이지 입니다.\n 로그인 하시겠습니까?")){
				location.href="<%=request.getContextPath()%>" + "/login.jsp";
			}
		}else{	
		if(confirm("장바구니에 담으시겠습니까?")){
			var pnum = $('input[name="pnum"]').val();
	    	var pqty = $('input[name="pqty"]').val();
			$(location).attr('href', 'cartAdd.jsp?pnum='+pnum+"&pqty="+pqty);
		}
		}
	}
	function buy(){
		var id ='<%=(String)session.getAttribute("id")%>';
		if(id=="null"){
			if(confirm("로그인이 필요한 페이지 입니다.\n 로그인 하시겠습니까?")){
				location.href="<%=request.getContextPath()%>" + "/login.jsp";
			}
		}else{	
		if(confirm("상품을 구매하시겠습니까?")){
			form.submit();
		};;
		}
	}
	
	 function comma(str) {
	     str = String(str);
	     return str.replace(/(\d)(?=(?:\d{3})+(?!\d))/g, '$1,');
	 }
$(function(){
	if($('input[name="check"]').val()=="check"){
		if(confirm("장바구니로 이동하시겠습니까?")){
			location.href="cartList.jsp";
		}
	}
});
</script>


<%@include file="/top.jsp" %><br><br>
<%
System.out.println("id:"+id);
%>
<%
	request.setCharacterEncoding("UTF-8");
	String check=null; /* 장바구니 담아서 오면은 장바구니로 이동하겠냐고 띄우기위해  */
	check = request.getParameter("check");
	String pnum = request.getParameter("pnum");
	
	ProductDao pdao = ProductDao.getinstance();
	ProductBean pb = pdao.getProductByPnum(pnum);
	
%>


<form name="form" method="get" action="directBuy.jsp">

<input class="idhide" type="text" name="id" value="<%=id%>">
<input type="hidden" name="check" value="<%=check%>">
<input type="hidden" name="pnum"value="<%=pnum%>">
<table align="center" width=60% >
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
	<tr height="10px">
		<td align="left" colspan="2">
			<font size="2px;" color="908f8f">샛별배송</font>
		</td>
	<tr height="40px">
		<td colspan="2">	
			<font size="5px;"><b><%=pb.getPname() %></b></font>
		</td>
	</tr>
	<tr height="10px" class="bottomline">	
		<td colspan="2">		
			<font size="2px;" color="#908f8f"><%=pb.getPcontents() %></font>
		</td>
	</tr>
	<tr height="70px">
		<td colspan="2">
			<font size="5px;"><b><%=df.format(pb.getPrice()) %>원</b></font>
		</td>
	</tr>
	<tr class="bottomline">
		<td class="sotitle">
			유통기한
		</td>
		<td align="left">
			<font size="2px;" color="#908f8f"><%=pb.getPlife() %></font>
		</td>
	</tr>
	<tr class="bottomline">
		<td class="sotitle">판매업체</td>
		<td align="left">
			<font size="2px;" color="#908f8f"><%=pb.getPseller() %></font>
		</td>
	</tr>
	<tr class="bottomline">
		<td class="sotitle">재고수량</td>
		<td align="left">
			<font size="2px;" color="#908f8f"><%=pb.getPqty() %></font>
		</td>
	</tr>
	<tr>
		<td class="sotitle">구매수량</td>
		<td>
			<input type=hidden name="sell_price" value="<%=pb.getPrice()%>">
			<input type="button"   class="plus" value=" - " onclick="del();">
			<input type="text"  name="pqty" value="1" size="3" style="text-align: center;border: 0;" onchange="change();"readonly>
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
		<td>
			<a href="javascript:cart()"><input class="cart" type="button" value="장바구니 담기" ></a>
		</td>
		<td>
			<a href="javascript:buy()"><input class="buy" type="button" value="구매하기"></a>
		</td>
	</tr>
	
</table>

</form>
<%@include file="/bottom.jsp" %>