<%@page import="Board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

    updateForm.jsp(6가지) => updatePro.jsp<br>
 <%
 	request.setCharacterEncoding("UTF-8");
 %>
   <jsp:useBean id="bb" class="Board.BoardBean"></jsp:useBean> 
   <jsp:setProperty property="*" name="bb"/>
 <%
 	String pageNum = request.getParameter("pageNum");
 
 	BoardDao bdao = BoardDao.getInstance();
 
 	int result =bdao.updateArticle(bb); 
 	System.out.println("돌아온 result 값 :"+result);
 	String msg;
 	String url;
 	if(result>0){
 		msg="수정 성공";
 		url="list.jsp?pageNum="+pageNum;
 	}
 	else if(result==-2){
 		msg="비밀번호가 맞지 않음";
 		//url="updateForm.jsp?num="+bb.getNum();
 		url="goback";
 	}
 	else{
 		msg ="수정 실패";
 		url="updateForm.jsp?num="+bb.getNum();
 	}
 %>
 <script>
 	alert("<%=msg%>");
 	
 	if("<%=url%>"=='goback'){
 		history.go(-1);  // 수정 실패해도 입력한 것들을 살리기 위하여
 	}
 	else{ 
 	location.href="<%=url%>";
 		
 	
 
 </script>