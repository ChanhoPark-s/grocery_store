<%@page import="my.shop.ProductBean"%>
<%@page import="my.shop.ProductDao"%>
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

 .add_button{
    border-radius: 4px;
	width: 400px;
    height: 50px; 
 	border:1px solid #8ca86e;
	background-color:white;
	font-weight:bold; 
	color:#8ca86e; 
}
 .firstTr{
 	background-color: #f3f6ef;
 	border-radius: 10px;
 	height: 60px;
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
 .search2{
    border-radius: 4px;
	width: 300px;
    height: 50px; 
 	border:1px solid #8ca86e;
	background-color:white;
	font-weight:bold; 
	color:#8ca86e; 
}
.inCategoryTable{
	border:2px solid #8ca86e;
	border-radius: 20px;
}
.sameOutCategory{
	border:1px solid #8ca86e;
	border-radius: 20px;
	width: 60%;
}

</style> 
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
<script>
	function update1(pnum){
		location.href="updateProduct.jsp?pnum="+pnum;
	}

	function delete1(pnum){
		var result = confirm("정말 삭제하시겠습니까?")
		if(result)
		location.href="deleteProduct.jsp?pnum="+pnum;
	}

</script>
<%@include file="/admin/main_top.jsp" %>

<%
	//검색을 눌러서 받은 대분류 소분류
	request.setCharacterEncoding("UTF-8");
	String outcategory = request.getParameter("outcategory");
	String incategory = request.getParameter("incategory");
	
	System.out.println("outcategory :"+outcategory);
	System.out.println("incategory :"+incategory);
%>


<div align="center">
<br><br>
	<h2>상품 목록</h2><br>
	
<form name="f" action="ProductListSeach.jsp" >
	<table align="center">
	<tr height="200px">
		<th width=150px align="left">대분류 카테고리</th>
		<td align="left">
			<select name="outcategory"  class="pl">
				<%
				CategoryDao cdao = CategoryDao.getinstance();
				ArrayList<CategoryBean>lists =  cdao.getAllCategory();
			
				for(CategoryBean cb : lists){
				%>
					<option value="<%=cb.getCode1()%>" <%if(outcategory!=null&&outcategory.equals(cb.getCode1())){ %>selected<% }%>><%=cb.getCname() %>
				<%
				}
				%>
			</select>
		</td>
		<th width=150px align="center">소분류 카테고리</th>
			<td>
			<select name="incategory" class="pl">
				<%
				CategoryDao2 cdao2 = CategoryDao2.getinstance();
				ArrayList<CategoryBean2>list =  cdao2.getAllCategory();
				%>
				<option value="">선택 안함
				<%					
				for(CategoryBean2 cb2 : list){
				%>
					<option value="<%=cb2.getCode2()%>"	<%if(incategory!=null&&incategory.equals(cb2.getCode2())){ %>selected<% }%>><%=cb2.getCname() %>
				<%
				}
				%>
				%>			
			</select>
			</td>
	</tr>
	<tr height="100px">
		<td colspan="4" align="center">
			<input class="search" type="submit" value="검색"><br>
		</td>
	</tr>
	<tr>	
		<td colspan="4" align="center">
			<a href="ProductAllList.jsp"><input class="search2" type="button" value="전체 목록보기"><br></a>
		</td>
	</tr>
	</table>
	
	<br><br>
	
	
	<!-- 상품 내역들 세부카테고리별로 다 보기 -->	
	<%
		ProductDao pdao = ProductDao.getinstance();
		ArrayList<ProductBean>plists = pdao.getProductByCode2(outcategory, incategory);
	%>
					<h4 align="center"><%=outcategory%> </h4>
	<%
			if(incategory!=""){
	%>			
					<h4 align="center">[<%=incategory %>] </h4><br><br>
	<%
			}
	%>
	<table align="center" width=50% class="inCategoryTable" >
		<tr class="firstTr">
			<td>No.</td>
			<td align="center">상품 이미지</td>
			<td align="center">상품명</td>
			<td align="center">판매업체</td>
			<td align="center">재고수량</td>
			<td align="center">가격</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>
	<%
		for(ProductBean pb : plists){
	%>
		<tr class="contents">
			<td align="center"><%=pb.getPnum() %></td>
			<td align="center">
			<% 
				String rContext = request.getContextPath() + "/admin/images/";
				String fullPath = rContext + pb.getPimage();
			%>
			<img width=80px height=80px src="<%=fullPath %>">
			</td>
			<td align="center"><%=pb.getPname() %></td>
			<td align="center"><%=pb.getPseller()%></td>
			<td align="center"><%=pb.getPqty()%></td>
			<td align="center"><%=pb.getPrice()%></td>
			<td><a href="javascript:update1(<%=pb.getPnum()%>)">수정</a></td>
			<td><a href="javascript:delete1(<%=pb.getPnum()%>)">삭제</a></td>
		</tr>
	<%		
		}
	%>
		</table>
	

</form>	
</div>
<%@include file="/admin/main_bottom.jsp" %>