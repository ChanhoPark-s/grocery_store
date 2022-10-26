<%@page import="java.text.DecimalFormat"%>
<%@page import="my.shop.mall.OrdersBean"%>
<%@page import="my.shop.mall.OrdersDao"%>
<%@page import="my.shop.ProductBean"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
 	.idtext{
	width: 200px;
    height: 50px; 
    border-radius: 4px;
 	border:1px solid #e1e1e1;
    outline: none;
 }
 .firstTr{
 	background-color: #f3f6ef;
 	border-radius: 20px;
 	height: 60px;
 	width:300px;
 	font-weight: bold;
 }
 .contents{
 	height: 50px;
 }
   .search{
    border-radius: 4px;
	width: 300px;
    height: 50px; 
	border:none;
	font-weight:bold; 
	color:white; 
	background-color: #8ca86e;
}

.inCategoryTable{
	border:2px solid #8ca86e;
	border-radius: 10px;
}


</style> 
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
<script>
function idCheck(){
	
	if($('input[name="id"]').val().length==0){
		alert("아이디를 입력해주세요");
	}
	else{
		f.submit();
	}
}

function delete1(onum,pnum){
	var result = confirm("정말 삭제하시겠습니까?")
	if(result)
	location.href="deleteOrder.jsp?onum="+onum+"&pnum="+pnum;
}

	
</script>

<%@include file="/admin/main_top.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
id = (String)session.getAttribute("id");

OrdersDao odao = OrdersDao.getinstance();


ArrayList<OrdersBean>lists = odao.getAllOrder();

%>
<div align="center">
<br><br>
	<h2>주문 내역</h2><br>
	
<form name="f" action="OrderSearchById.jsp">
	<table align="center">
	<tr height="200px">
		<th width=150px align="left">회원 아이디</th>
		<td align="left">
			<input class="idtext" type="text" name="id" placeholder="  아이디를 입력해주세요">
		</td>
	</tr>
	<tr height="100px">
		<td colspan="4" align="center">
			<input class="search" type="button" value="검색" onClick="idCheck()"><br>
		</td>
	</tr>
	</table>
	
</form>	
<!-- 상품 내역들 세부카테고리별로 다 보기 -->	
	<table align="center" width=50% class="inCategoryTable" >
		<tr class="firstTr">
			<td align="center">주문번호</td>
			<td align="center">회원아이디</td>
			<td align="center">상품이미지</td>
			<td align="center">상품명</td>
			<td align="center">주소지</td>
			<td align="center">수량</td>
			<td align="center">결제금액</td>
			<td align="center">구매일</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>
	<%
		if(lists.size()==0){
		%>
			<tr class="contents">
			<td align="center" colspan="9">주문 내역이 없습니다.</td>
			</tr>
		<% 
		}
		else{
		for(OrdersBean ob : lists){
		%>
		<tr class="contents">
			<td align="center"><%=ob.getOnum() %></td>
			<td align="center"><%=ob.getMid() %></td>
			<td align="center">
			<% 
				
				ProductDao pdao = ProductDao.getinstance();
				ProductBean pb = pdao.getProductByPnum(String.valueOf(ob.getPnum()));
				String rContext = request.getContextPath() + "/admin/images/";
				String fullPath = rContext + pb.getPimage();
				System.out.println(rContext);
				System.out.println(fullPath);
				DecimalFormat df = new DecimalFormat("###,###");
			%>
			<img width=80px height=80px src="<%=fullPath %>">
			</td>
			<td align="center"><%=pb.getPname()%></td>
			<td align="center"><%=ob.getAddress()%></td>
			<td align="center"><%=ob.getQty()%></td>
			<td align="center"><%=df.format(ob.getAmount())%>원</td>
			<td align="center"><%=ob.getOrderDate()%></td>
			<td><a href="updateOrder.jsp?onum=<%=ob.getOnum()%>&pnum=<%=pb.getPnum()%>">[수정]</a></td>
			<td><a href="javascript:delete1(<%=ob.getOnum()%>,<%=pb.getPnum()%>)">[삭제]</a></td>
		</tr>
		<%
		}//else
	}//for
		%>
		
	</table>
	

</div>
<%@include file="/admin/main_bottom.jsp" %>