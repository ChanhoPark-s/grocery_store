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
 .newlogin_button{
    border-radius: 4px;
	width: 400px;
    height: 50px; 
 	border:1px solid #8ca86e;
	background-color:white;
	font-weight:bold; 
	color:#8ca86e; 
}

 
</style> 
    
<%@include file="top.jsp" %>

<%
	request.setCharacterEncoding("UTF-8");
	
%>
<div align="center">
<br><br>
	<h2>마이페이지</h2><br>
	
	
<form name="f" action="loginPro.jsp" method="post">
	

</form>	
</div>





<%@include file="bottom.jsp" %>