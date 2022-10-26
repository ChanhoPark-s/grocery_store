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
			if($('input[name="code1"]').val().length==0){
				alert("첫단어를 입력하세요");
				$('input[name="code1"]').focus();
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
	<h2>대분류 카테고리</h2><br>
	
<form name="f" action="addOutPro.jsp" method="post">
	<table>
		<tr>
			<td><font color="red" size="2px">※첫단어와 같은 이미지를 images 폴더에 넣어주세요</font></td>
		</tr>
		<tr>
			<td>
				<input class="insert" type="text" placeholder="  대분류의 첫단어를 입력하세요" name="code1"><br><br>
			</td>
		</tr>
		<tr>
			<td>
				<input class="insert" type="text" placeholder="  대분류 이름을 입력하세요" name="cname"><br><br>
			</td>
		</tr>
		<tr>
			<td>
				<input class="add_button" type="submit" value="대분류 추가" ><br></a>
			</td>
		</tr>
	</table>
	<br>
	<table align="center" width=50% class="inCategoryTable">
	
		<tr class="firstTr">
			<td>No.</td>
			<td>상품코드</td>
			<td>대분류이름</td>
			<td align="center">수정</td>
			<td align="center">삭제</td>
		</tr>
	<%
	CategoryDao cdao = CategoryDao.getinstance();
	ArrayList<CategoryBean> lists = cdao.getAllCategory();
	
	for(CategoryBean cb : lists){
	%>
		<tr class="contents">
			<td><%=cb.getCnum()%></td>
			<td><%=cb.getCode1()%></td>
			<td><%=cb.getCname()%></td>
			<td align="center"><a href="updateOutCate.jsp?cnum=<%=cb.getCnum()%>&code1=<%=cb.getCode1()%>">수정</a></td>
			<td align="center"><a href="deleteOutCate.jsp?cnum=<%=cb.getCnum()%>&code1=<%=cb.getCode1()%>">삭제</a></td>
		</tr>
	<%	
	}
	%>
	
	</table>
	

</form>	
</div>
<%@include file="/admin/main_bottom.jsp" %>