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

function delete1(no){
	
	var result = confirm("정말 삭제하시겠습니까?")
	if(result)
	location.href="deleteMember.jsp?no="+no; 
}

	
</script>

<%@include file="/admin/main_top.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
id = (String)session.getAttribute("id");

ArrayList<MemberBean>lists = mdao.getAllMember();

%>
<div align="center">
<br><br>
	<h2>회원관리</h2><br>
	
<form name="f" action="MemberSearchById.jsp">
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
			<td align="center">회원아이디</td>
			<td align="center">회원명</td>
			<td align="center">이메일</td>
			<td align="center">전화번호</td>
			<td align="center">성별</td>
			<td>수정</td>
			<td>삭제</td>
		</tr>
	<%
		if(lists.size()==0){
		%>
			<tr class="contents">
			<td align="center" colspan="9">회원이 없습니다.</td>
			</tr>
		<% 
		}
		else{
		for(MemberBean mbean : lists){
		%>
		<tr class="contents">
			<td align="center"><%=mbean.getId() %></td>
			<td align="center"><%=mbean.getName()%></td>
			<td align="center"><%=mbean.getEmail()%></td>
			<td align="center"><%=mbean.getPhone()%></td>
			<td align="center"><%=mbean.getGender()%></td>
			<td align="center"><a href="updateMember.jsp?no=<%=mbean.getNo()%>">[수정]</a></td>
			<td align="center"><a href="javascript:delete1(<%=mbean.getNo()%>)">[삭제]</a></td>
		</tr>
		<%
		}//else
	}//for
		%>
		
	</table>
	

</div>
<%@include file="/admin/main_bottom.jsp" %>