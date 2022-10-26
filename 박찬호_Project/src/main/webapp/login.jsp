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

<div align="center">
<br><br>
	<h2>로그인</h2><br>
	
	
<form name="f" action="loginPro.jsp" method="post">
	<table>
		<tr>
			<td>
				<input class="insert" type="text" placeholder="  아이디를 입력해주세요" name="id"><br><br>
			</td>
		</tr>
		<tr>
			<td>
				<input class="insert" type="password" placeholder="  비밀번호를 입력해주세요" name="password"><br>
			</td>
		</tr>
		<tr height="40px">
			<td align="right">
				<font size="2px"><a href="findId.jsp">아이디 찾기</a> | <a href="findPassword.jsp">비밀번호 찾기</a></font>
			</td>
		</tr>
		<tr>
			<td>
				<input class="login_button" type="submit" value="로그인"><br>
			</td>
		</tr>
		<tr>
			<td>
				<a href="newlogin.jsp"><input class="newlogin_button" type="button" value="회원가입" ><br></a>
			</td>
		</tr>
	</table>

</form>	
</div>





<%@include file="bottom.jsp" %>
    