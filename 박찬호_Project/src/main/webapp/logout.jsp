<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
webapp\logout.jsp <br>


<%
	session.invalidate();

	if(request.getProtocol().equals("HTTP/1.0")){
		response.setHeader("Pragma","no-cache");
		response.setDateHeader("Expires",0);
	}else if(request.getProtocol().equals("HTTP/1.1")){
		response.setHeader("Cache-Control","no-cache");
	}
%>
<script>
	location.href="main.jsp";

</script>

