<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Board.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
list.jsp =>content.jsp <br>
<%@include file="/top.jsp"%><br>
<%

String pageSize = request.getParameter("pageSize");
String num = request.getParameter("num"); // 부모번호(선택한 글)
String pageNum = request.getParameter("pageNum"); 

System.out.println("content.jsp num:" + num+", pageNum:" +pageNum);

SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm");

BoardDao bdao = BoardDao.getInstance();

BoardBean article = bdao.getArticle(Integer.parseInt(num));/* 이 번호의 레코드를 가져온다. */

System.out.println(article.getRef()); // 부모
System.out.println(article.getRe_step());//부모
System.out.println(article.getRe_level());// 부모
 %>
<table width="500" border="1" cellspacing="0" cellpadding="0"  align="center">  
  <tr height="30">
    <td align="center" width="125">글번호</td>
    <td align="center" width="125"> <%=article.getNum()%></td>
    <td align="center" width="125" >조회수</td>
    <td align="center" width="125"> <%=article.getReadcount()%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125">작성자</td>
    <td align="center" width="125"> <%=article.getWriter()%></td>
    <td align="center" width="125" >작성일</td>
    <td align="center" width="125"> <%= sdf.format(article.getReg_date())%></td>
  </tr>
  <tr height="30">
    <td align="center" width="125">글제목</td>
    <td align="center" width="375" colspan="3"> <%=article.getSubject()%></td>
  </tr>
  <tr height="40">
    <td align="center" width="125" >글내용</td>
    <td align="left" width="375" colspan="3"><pre><%=article.getContent()%></pre>  </td>
  </tr> 						<!-- pre 태그는 글 내용에 공백을 포함(enter) 같이 출력해줌 preview 보이는대로 출력.  -->
  <tr height="40">
  	<td colspan="4" align="center" > <!-- colspan 4칸을 하나로 합처라. -->
  		<input type="button" value="글수정" onClick="location.href='updateForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>'">
  		<input type="button" value="글삭제" onClick="location.href='deleteForm.jsp?num=<%=article.getNum()%>&pageNum=<%=pageNum%>&pageSize=<%=pageSize %>'">
  		<input type="button" value="답글쓰기" onClick="location.href='replyForm.jsp?ref=<%=article.getRef()%>&re_step=<%=article.getRe_step()%>&re_level=<%=article.getRe_level() %>'">
  		<input type="button" value="글목록" onClick="location.href='list.jsp?pageNum=<%=pageNum%>'"> 
  	</td>
  </tr>
</table>  
<%@include file="/bottom.jsp"%><br>



