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
 
</style> 
   
  <%
  	request.setCharacterEncoding("UTF-8");
  	String cnum = request.getParameter("cnum");
	String code1 = request.getParameter("code1");
	System.out.println("code1:"+code1);
	System.out.println("cnum:"+cnum);
	
	CategoryDao cdao = CategoryDao.getinstance();
  	CategoryBean cb = cdao.getCateByCnum(cnum); 
  %>
<%@include file="/admin/main_top.jsp" %>

<div align="center">
<br><br>
	<h2>대분류 수정</h2><br>
	
<form name="f" action="updateOutCatePro.jsp" method="post">
	<table >
		<tr>
			<td>
				
				<input type="hidden" name="cnum" value="<%=cnum%>">
				<input type="hidden" name="originCode1" value="<%=code1%>">
				<input class="insert" type="text" placeholder="  대분류 첫단어를 입력하세요" name="code1" value="<%=cb.getCode1()%>"><br><br>
			</td>
		</tr>
		<tr>
			<td>
				<input class="insert" type="text" placeholder="  대분류 이름을 입력하세요" name="cname" value="<%=cb.getCname()%>"><br><br>
			</td>
		</tr>
		<tr>
			<td>
				<input class="add_button" type="submit" value="수정하기" ><br></a>
			</td>
		</tr>
	</table>

</form>	
</div>
<%@include file="/admin/main_bottom.jsp" %>