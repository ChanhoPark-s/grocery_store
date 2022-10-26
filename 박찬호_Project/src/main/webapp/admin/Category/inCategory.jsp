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
 


</style> 
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
<script>
	$(function(){
		$('.add_button').click(function(){
			if($('input[name="code2"]').val().length==0){
				alert("첫단어를 입력하세요");
				$('input[name="code2"]').focus();
				return false;
			}
			if($('input[name="cname"]').val().length==0){
				alert("대분류 이름을 입력하세요");
				$('input[name="cname"]').focus();
				return false;
			}
			
		});
		
	});

</script> 
<%@include file="/admin/main_top.jsp" %>

<div align="center">
<br><br>
	<h2>소분류 카테고리</h2><br>
	
<form name="f" action="addInPro.jsp" method="post">
	
	대분류 카테고리
	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<select name="likeLanguage" id="" class="pl">
						<%
						CategoryDao cdao = CategoryDao.getinstance();
						ArrayList<CategoryBean>lists =  cdao.getAllCategory();
						
						for(CategoryBean cb : lists){
						%>
							<option name="code1" value="<%=cb.getCode1()%>"><%=cb.getCname() %>
						<%	
						}
						%>
					</select>
	<br><br>
	<table>
		
		<tr>
			<td>
				<input class="insert" type="text" placeholder="  소분류 첫단어를 입력하세요" name="code2"><br><br>
			</td>
		</tr>
		<tr>
			<td>
				<input class="insert" type="text" placeholder="  소분류 이름을 입력하세요" name="cname"><br><br>
			</td>
		</tr>
		<tr>
			<td>
				<input class="add_button" type="submit" value="소분류 추가" ><br></a>
			</td>
		</tr>
	</table>
	<br>
	
	<%
		for(CategoryBean cb : lists){
	%>
	<h3 align="center"><%=cb.getCname() %></h3>
	<br>
	
	<table align="center" width=50% class="inCategoryTable">
		<tr class="firstTr">
			<td>No.</td>
			<td align="center">상품코드</td>
			<td align="center">소분류이름</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>
		<%
		System.out.println("cb.getCode1 :"+cb.getCode1());
		CategoryDao2 cdao2 = CategoryDao2.getinstance();
		ArrayList<CategoryBean2>list =  cdao2.getAllCategory(cb.getCode1());
		for(CategoryBean2 cb2 : list){
		%>
		<tr class="contents">
			<td><%=cb2.getCnum() %></td>
			<td align="center"><%=cb2.getCode2() %></td>
			<td align="center"><%=cb2.getCname() %></td>
			<td><a href="updateInCate.jsp?cnum=<%=cb2.getCnum()%>">수정</a></td>
			<td><a href="deleteInCate.jsp?cnum=<%=cb2.getCnum()%>">삭제</a></td>
		</tr>
		
		<%
		}
		%>
		
	</table>
		<br><br>
		<hr style="size: 1px; width: 40%;">
		<br><br>
	<%		
		}
	%>
	

</form>	
</div>
<%@include file="/admin/main_bottom.jsp" %>