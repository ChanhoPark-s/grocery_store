<%@page import="my.shop.CategoryDao2"%>
<%@page import="my.shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String cnum = request.getParameter("cnum");
	String code1 = request.getParameter("code1");
	System.out.println("code1:"+code1);
	System.out.println("cnum:"+cnum);
	
	CategoryDao cdao = CategoryDao.getinstance();
	CategoryDao2 cdao2 = CategoryDao2.getinstance();
	
	int result = cdao.deleteBycnum(cnum); /* 상위 카테고리 삭제 */
	int cnt = cdao2.deleteByCode1(code1); /* 동시에 하위 카테고리 삭제 */ 
	
	String url="outCategory.jsp";
	String msg;

	if(result>0 && cnt>=0){
		msg="삭제성공";
	}
	else if(result>0 && cnt<0){
		msg="대분류 삭제 / 소분류 실패";
	}
	else if(result<0 && cnt>0){
		msg="대분류 실패 / 소분류 삭제";
	}
	else{
		msg="삭제실패";
	}
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>