<%@page import="java.text.SimpleDateFormat"%>
<%@page import="Board.BoardBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Board.BoardDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<style>
	body{
		text-align: center;
	}
	table{
		margin : auto;
	}
</style>

<%@include file="/top.jsp"%><br>

<!-- 
127.0.0.1 : IPv4 형태
0:0:0:0:0:0:0:1 : IPv6 형태

1.stop
2.Run-> RunConfigrations ->Apache Tomcat -> Tomcat v9.0 Server at localhost ->
Arguments -> Arguments 내용 맨 밑에 -Djava.net.preferIPv4Stack=true 입력 run
 -->
<%
	int pageSize = 10; // 
	//날짜형식
	SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	 
	int currentPage = Integer.parseInt(pageNum);
	
	int startRow = (currentPage-1) * pageSize + 1;
	int endRow = currentPage * pageSize;
	//1페이지 => startRow:1  endRow:10 => num칼럼 값은 아니다. 
	//2페이지 => startRow:11  endRow:20
	//3페이지 => startRow:21  endRow:30
		
	BoardDao bdao = BoardDao.getInstance();
	System.out.println("bdao:" + bdao);
	
	int count = bdao.getArticleCount();
	System.out.println("list.jsp count:"+count);
	ArrayList<BoardBean> listst = null;
	
	if(count>0){
		listst = bdao.getArticles(startRow,endRow);  // 레코드 가져옴 페이지에 출력할거
	}//if
	
	int number = count - (currentPage-1) * pageSize;
%>
	<b>글목록(전체 글:<%=count %>)</b>
	
<table border="1" width="700">
	<tr>
		<td align="right">
			<a href="writeForm.jsp">글쓰기</a>
		</td>
	</tr>
</table>

<%
	if(count == 0){
%>
	<table border="1" width="700">
	<tr>
		<td align="center">
			게시글이 없습니다.
		</td>
	</tr>
</table>
<%		
	}//if
	else{
%>
	<table border="1" width="700">
	<tr>
		<td align="center">번호</td>
		<td align="center">제목</td>
		<td align="center">작성자</td>
		<td align="center">작성일</td>
		<td align="center">조회</td>
		<td align="center">IP</td>
	</tr>
<%

	for(int i=0;i<listst.size();i++){
		BoardBean bb = listst.get(i);
		
%>
		<tr>
			<td align="right"><%=number-- %></td>
			<td>
				<%
				if(bb.getRe_level()>0 ){ // 답글(1), 답글의 답글(2)
					int width = bb.getRe_level()*20; //1:20, 2:40, 3:60	
				%>
					<img src="./images/level.gif" width="<%=width %>" height="15">
					<img src = "./images/re.gif" height="15">
				<%					
				}//if					
						
					%>
			<a href="content.jsp?num=<%=bb.getNum()%>&pageNum=<%=currentPage%>&pageSize=<%=pageSize %>"><%=bb.getSubject() %></a>
			<%
				if(bb.getReadcount()>=10){
				%>
					<img src="images/hot.gif" height="15"/>
				<%
				}//if
			%>
			</td>
			<td align="center"><%=bb.getWriter() %></td>
			<td align="center"><%=sdf.format(bb.getReg_date())%></td>
			<td align="right"><%=bb.getReadcount() %></td>
			<td align="center"><%=bb.getIp() %></td>
		</tr>

<%		
	}//for
%>
		
</table>
<%		
		
	}//else
		
	if(count > 0){
		int pageCount = count / pageSize + (count % pageSize==0 ? 0 : 1);
		//pageCount : 전체 페이지 수  
		// pageCount = 37 / 10 + 0(1) = 3 + 0(1)
		
		int pageBlock = 10;
		
		int startPage = ((currentPage - 1)/pageBlock*pageBlock) + 1;
		int endPage = startPage + pageBlock - 1;
		if(endPage > pageCount)
			endPage = pageCount;
		
		if(startPage > 10){ // 11 21 31
	%>
			<a href="list.jsp?pageNum=<%=startPage-10%>">[이전]</a>
	<%			
		}//if
		
		for(int i=startPage;i<=endPage;i++){
	%>
			<a href="list.jsp?pageNum=<%=i %>">[<%=i %>]</a>
	<%			
		}//for
		
		if(endPage < pageCount){
	%>
			<a href="list.jsp?pageNum=<%=startPage+10%>">[다음]</a>
	<%			
		}//if
		
	}// if(count>0)
%>

<%@include file="/bottom.jsp"%>


