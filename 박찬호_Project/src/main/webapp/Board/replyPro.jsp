<%@page import="Board.*"%>
<%@page import="java.sql.Timestamp"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
replyForm.jsp => replyPro.jsp<br>
<!-- 
넘어오는 값 : 입력한 5가지 + 부모 3가지 hidden(ref,re_step,re_level) => 8가지

8가지 + 2가지(작성일, IP주소)=>10가지 객체로 만들어서 
dao replyArticle() 로 보내서
update, insert 
-->

<%
request.setCharacterEncoding("UTF-8");
%>
<jsp:useBean id="bb" class="Board.BoardBean"/>
<jsp:setProperty property="*" name="bb"/>
<%

System.out.println(bb.getWriter());
System.out.println(bb.getRef());
System.out.println(bb.getRe_step());
System.out.println(bb.getRe_level());

bb.setReg_date(new Timestamp(System.currentTimeMillis()));
bb.setIp(request.getRemoteAddr());

BoardDao bdao = BoardDao.getInstance();
int cnt = bdao.replyArticle(bb);  

System.out.println("cnt:"+cnt);
	String url;
    String msg;
    
    if(cnt>0){
    	msg = "답글쓰기 성공";
    	url = "list.jsp";
    }
    else{
    	msg = "답글쓰기 실패";
    	url="replyForm.jsp?ref="+bb.getRef()+"&re_step="+bb.getRe_step()+
				"&re_level="+bb.getRe_level();

    }
%>

<script>
	alert("<%=msg%>");
	location.href="<%=url%>";
</script>


