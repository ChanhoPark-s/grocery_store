<%@page import="my.shop.ProductDao"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
addProductPro.jsp<br>

<%
String sContext = application.getRealPath("/admin/images");// 업로드
System.out.println("sContext :"+ sContext);

//올릴때는 sContext
//가져올때는 rContext

int maxSize = 1024 * 1024 * 5;
String encType = "UTF-8";
MultipartRequest mr = new MultipartRequest(
									request, // 요청 받은거
									sContext, // 올릴 위치
									maxSize, // 사이즈
									encType, // 한글처리
									new DefaultFileRenamePolicy() // 안쓰면 파일 덮어쓰기 되고 쓰면 다 들어감 변경돼서.
									);
%>
상품명3 : <%= mr.getParameter("pname") %>
outcategory : <%=mr.getParameter("outcategory") %><br>
incategory : <%=mr.getParameter("incategory") %><br>
이미지 파일명 : <%=mr.getFilesystemName("pimage") %><br>

<%  	
ProductDao pdao = ProductDao.getinstance();
int result = pdao.insertProduct(mr); 

String msg;
System.out.println("돌아온 값 result :"+ result);
if(result>0){
	msg="상품 등록 성공";	
}
else{
	msg="상품 등록 실패";
}
%>
<script>
	alert("<%=msg%>");
	location.href="ProductList.jsp";
</script>


