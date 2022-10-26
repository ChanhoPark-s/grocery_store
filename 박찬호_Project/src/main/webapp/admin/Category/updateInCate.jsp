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
 <script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
<script>  
  $(document).ready(function(){
	  $('input[name="code2"]').click(function(){
			$('.pwmsg').toggle("1000"); 
			
		});
		
	}); 
</script>
  <%
  	request.setCharacterEncoding("UTF-8");
  	String cnum = request.getParameter("cnum");
	System.out.println("cnum:"+cnum);
	
	CategoryDao2 cdao2 = CategoryDao2.getinstance();
  	CategoryBean2 cb2 = cdao2.getCateByCnum(cnum);  
  %> 
<%@include file="/admin/main_top.jsp" %>

<div align="center">
<br><br>
	<h2>소분류 수정</h2><br>
	
<form name="f" action="updateInCatePro.jsp" method="post">
	
		대분류 카테고리&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select name="likeLanguage" id="" class="pl">
						<%
						CategoryDao cdao = CategoryDao.getinstance();
						ArrayList<CategoryBean>lists =  cdao.getAllCategory();
						
						for(CategoryBean cb : lists){
						%>
							<option name="code1" value="<%=cb.getCode1()%>" <%if(cb.getCode1().equals(cb2.getCode1())){%> selected <% }%>><%=cb.getCname() %>
						<%									
						}
						%>
					</select>
	<br><br>
	
	<table>
		<tr>
			<td>
				<input type="hidden" name="cnum" value="<%=cb2.getCnum()%>">
				<input class="insert" type="text" placeholder="  소분류 첫단어를 입력하세요" name="code2" value="<%=cb2.getCode2()%>"><br><br>
			</td>
			
		</tr>
		<tr height="10px">
			<td  style="display: none;" class="pwmsg">
			<ul>
				<font size=2px color="red">
					<li>※ 소분류 첫단어를 입력하세요</li>
				</font>
			</ul>
			</td>
		</tr>
		<tr>
			<td>
				<input class="insert" type="text" placeholder="  소분류 이름을 입력하세요" name="cname" value="<%=cb2.getCname()%>"><br><br>
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