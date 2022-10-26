<%@page import="Board.BoardDao"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
writeForm.jsp(입력한 5가지 넘어옴) => writePro.jsp <br>

<%request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="bb" class="Board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>
<!-- setter 5가지 호출 bb.setWriter(입력한 작성자)-->

<%
//int -21억~21억
//long -900경~900경
	//new Timestamp(3232387987)
	bb.setReg_date(new Timestamp(System.currentTimeMillis()));  // 1970년 1월 1일 0~
	
	bb.setIp(request.getRemoteAddr());
	
	/* 5+2 = 7 */ 
			
	BoardDao bdao=BoardDao.getInstance();
	int result = bdao.insertArticle(bb);
	String url;
    String msg;
    
    if(result>0){
    	msg = "글쓰기 성공";
    	url = "list.jsp";
    }
    else{
    	msg = "글쓰기 실패";
    	url = "writeForm.jsp";
    }
%>

<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>


