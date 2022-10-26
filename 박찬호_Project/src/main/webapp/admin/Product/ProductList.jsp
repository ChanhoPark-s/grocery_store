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

</style> 


<%@include file="/admin/main_top.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
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
					<option  value="<%=cb.getCode1()%>"><%=cb.getCname() %>
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
					<option value="<%=cb2.getCode2()%>"><%=cb2.getCname() %>
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
	<tr height="30px">
		<td colspan="4" align="center">
			<a href="ProductAllList.jsp"><input class="search2" type="button" value="전체 목록보기"><br></a>
		</td>
	</tr>
	</table>

</form>	
</div>
<%@include file="/admin/main_bottom.jsp" %>