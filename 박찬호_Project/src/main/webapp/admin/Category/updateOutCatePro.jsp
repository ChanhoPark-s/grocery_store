<%@page import="my.shop.CategoryDao2"%>
<%@page import="my.shop.CategoryDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String cnum = request.getParameter("cnum");
	String code1 = request.getParameter("code1");
	String cname = request.getParameter("cname");
	String originCode1 = request.getParameter("originCode1");
	
	System.out.println("code1:"+code1);
	System.out.println("cnum:"+cnum);
	System.out.println("cname:"+cname);
	System.out.println("originCode1:"+originCode1);
	
	CategoryDao cdao = CategoryDao.getinstance();
	CategoryDao2 cdao2 = CategoryDao2.getinstance();
	
	int result = cdao.updateBycnum(cnum,cname,code1); /* 상위 카테고리 수정 */ 
	int cnt = cdao2.updateBycnum(originCode1,code1);  /* 동시에 하위 카테고리 수정 */
	
	String url="outCategory.jsp";
	String msg;

	if(result>0 && cnt>0){
		msg="수정성공";
	}
	else if(result>0 && cnt<0){
		msg="대분류 수정 / 소분류 실패";
	}
	else if(result<0 && cnt>0){
		msg="대분류 실패 / 소분류 수정";
	}
	else{
		msg="수정실패";
	} 
%>
<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>