<%@page import="Board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

deleteForm.jsp(3가지 pageNum,num,passwd) => deletePro.jsp<br>

<jsp:useBean id="bb" class="Board.BoardBean"></jsp:useBean>
<jsp:setProperty property="*" name="bb"/>

<%
	request.setCharacterEncoding("UTF-8");
	
	int pageSize = Integer.parseInt(request.getParameter("pageSize"));
	int pageNum = Integer.parseInt(request.getParameter("pageNum"));
	
	System.out.print("pageNum :"+pageNum);
	System.out.print("bb.getnum() :"+bb.getNum());

	BoardDao bdao = BoardDao.getInstance();
	
	int result = bdao.deleteBoard(bb); 
	
	int count = bdao.getArticleCount();
	
	
	
	String msg;
 	String url;
 	
	int needPage = count/pageSize+(count % pageSize == 0 ?0 :1); // 11개면 2개 필요하니 
 	
	if(result>0){
 		msg="삭제 성공";
 		if(needPage < pageNum){// 필요한 페이지수 < 내가 보고있는page num // 총 페이지수가 5페이지인데 내가 보고있는 페이지는 3페이지일때는 그냥 3페이지로 가려고
 			pageNum= (pageNum-1);
 		}
 		url="list.jsp?pageNum="+pageNum;
 	}
 	else{
 		msg="비밀번호가 맞지 않음";
 		url="deleteForm.jsp?num="+bb.getNum()+"&pageNum="+pageNum+"&pageSize="+pageSize;
 	}
 	
 %>
 <script>
 	alert("<%=msg%>");
 	location.href="<%=url%>";
 		
 	
 
 </script>
