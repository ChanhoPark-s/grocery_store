<%@page import="my.shop.ProductBean"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
 	.insert{
	width: 200px;
    height: 50px; 
    border-radius: 10px;
 	border:1px solid #e1e1e1;
    outline: none;
 }
 .login_button{
    border-radius: 4px;
	width: 400px;
    height: 50px; 
	border:none;
	font-weight:bold; 
	color:white; 
	background-color: #8ca86e;
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
th{
	text-align: left;
}
tr{
	height: 80px;
}
.right{
	text-align: center;
}
   input[type=file]::file-selector-button {
  width: 150px;
  height: 30px;
  background: #e5e5e5;
  border: 1px solid white;
  border-radius: 10px;
  cursor: pointer;
  &:hover {
    background: rgb(77,77,77);
    color: #fff;
  }
}
</style> 
   
  <%
  	request.setCharacterEncoding("UTF-8");
  	String pnum = request.getParameter("pnum");
	System.out.println("pnum:"+pnum);
	
	ProductDao pdao = ProductDao.getinstance();
	ProductBean pb = pdao.getProductByPnum(pnum);
  %>
<%@include file="/admin/main_top.jsp" %>

<div align="center">
<br><br>
	<h2>상품 수정</h2><br>
	
<form name="f" action="updateProductPro.jsp" method="post" enctype="multipart/form-data" accept-charset="UTF-8">
	<table align="center">
		<tr>
			<th>상품명</th>
			<td>
				<input class="insert" type="hidden" name="pnum" value="<%=pb.getPnum()%>">
				<input class="insert" type="text" placeholder="  상품명을 입력하세요" name="pname" value="<%=pb.getPname()%>">
			</td>
			
			<th class="m2">상품이미지</th>
							<td align="center">
								<% 
								String rContext = request.getContextPath() + "/admin/images/";
								String fullPath = rContext + pb.getPimage();
								System.out.println(rContext);
								System.out.println(fullPath);
								%>
								<img src="<%=fullPath%>" width="80px" height="80px"><br><br>
								<input type="file" name="pimage">
								<input type="hidden" name="pimage2" value="<%=pb.getPimage()%>"> 
								<!-- 기존 이미지 파일명. 이건 웹서버 폴더에서 지우려고. -->
							</td>
		</tr>
		<tr >
		<th width=150px align="left">대분류 카테고리</th>
		<td align="left">
			<select name="outcategory"  class="pl">
				<%
				CategoryDao cdao = CategoryDao.getinstance();
				ArrayList<CategoryBean>lists =  cdao.getAllCategory();
				pb = pdao.getProductByPnum(pnum);
				for(CategoryBean cb : lists){
				%>
					<option value="<%=cb.getCode1()%>" <%if(pb.getPcategory_fk().contains(cb.getCode1())){ %>selected<% }%>><%=cb.getCname() %>
				<%
				}
				%>
			</select>
		</td>
		<th width=150px class="right">소분류 카테고리</th>
			<td>
			<select name="incategory" class="pl">
				<%
				CategoryDao2 cdao2 = CategoryDao2.getinstance();
				ArrayList<CategoryBean2>list =  cdao2.getAllCategory();
				for(CategoryBean2 cb2 : list){
				%>
					<option value="<%=cb2.getCode2()%>"<%if(pb.getPcategory_fk().contains(cb2.getCode2())){ %>selected<% }%>><%=cb2.getCname() %><!-- 같은 code1과 같은 code2 일때 체크 -->
				<%
				}
				%>			
			</select>
			</td>
		</tr>
		<tr>
			<th>판매업체</th>
			<td>
				<input class="insert" type="text" placeholder="  판매업체를 입력하세요" name="pseller" value="<%=pb.getPseller()%>">
			</td>
			<th class="right">재고수량</th>
			<td>
				<input class="insert" type="text" placeholder="  재고수량을 입력하세요" name="pqty" value="<%=pb.getPqty()%>">
			</td>
		</tr>
		<tr>
			<th>가격</th>
			<td>
				<input class="insert" type="text" placeholder="  가격을 입력하세요" name="price" value="<%=pb.getPrice()%>">
			</td>
			
			<th class="right">스펙</th>
			<td>
				<select name="pspec" class="pl">
			<%
			String[] menubar={"","BEST","신상품","알뜰상품","기획상품"};				
			for(int i=0;i<menubar.length;i++){
			%>
				<option value="<%=menubar[i]%>"<%if(pb.getPspec().equals(menubar[i])){ %>selected<%} %>><%=menubar[i] %>
			<%	
			}
			%>
			</select>
			</td>
		</tr>
		<tr>
			<th>유통기한</th>
			<td>
				<input class="insert" type="text" placeholder="  유통기한을 입력하세요" name="plife" value="<%=pb.getPlife()%>">
			</td>
		</tr>
		<tr>
			<th>상세내용</th>
			<td colspan="2">
				<textarea class="insert" placeholder="  상세내용을 입력하세요" name="pcontents"><%=pb.getPcontents()%></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				<input class="add_button" type="submit" value="수정하기" ><br>
			</td>
		</tr>
	</table>

</form>	
</div>
<%@include file="/admin/main_bottom.jsp" %>