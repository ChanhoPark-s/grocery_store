<%@page import="my.shop.ProductDao"%>
<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="java.io.File"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  

<%
request.setCharacterEncoding("UTF-8");
/* 파일 업로드 */
	ServletContext sContext = config.getServletContext();
	String targetLocation = sContext.getRealPath("/admin/images"); 
		
	int maxSize = 1024 * 1024 * 5; 	// 5메가
	String encType = "UTF-8"; 		// 한글이 안깨지도록
	
	MultipartRequest mr = new MultipartRequest(request, targetLocation, maxSize, encType, new DefaultFileRenamePolicy());
	
	String pimage = mr.getParameter("pimage");
	String pimage2 = mr.getParameter("pimage2");
	System.out.println("프로에서 pimage 출력 :"+pimage);
	System.out.println("프로에서 pimage2 출력 :"+pimage2);
%>
	
<% /* 기존에 존재하던 파일 삭제 */
	


if(pimage!=null){
String delPath = config.getServletContext().getRealPath("/admin/images");
System.out.println(delPath);
File delFile = new File(delPath,pimage2); 

if(delFile.exists()){  
	if(delFile.delete()){
		%>
		<script type="text/javascript">
			alert(이미지 삭제 성공);
		</script>
		<% 
	}
}
}
	System.out.println("프로에서갔다오고 pimage2 출력 :"+pimage2);
	String incategory = mr.getParameter("incategory");
	String outcategory = mr.getParameter("outcategory");
	System.out.println("프로에서 incategory 출력 :"+incategory);
	System.out.println("프로에서 outcategory 출력 :"+outcategory);
%>

<%	/* DB 수정작업 */
	ProductDao pdao = ProductDao.getinstance();
	int cnt = pdao.updateProduct(mr,pimage2); // 테이블 수정 

	String msg;
	String url;
	
	if(cnt > 0){
		msg = "상품 수정 성공";
		url = "ProductListSeach.jsp?outcategory="+outcategory+"&incategory="+incategory;
	}
	else{
		msg = "상품 수정 실패";
		url = "ProductListSeach.jsp";
	}
%>

<script type="text/javascript">
	alert("<%=msg%>");
	location.href = "<%=url%>";
</script>
		url = "ProductListSeach.jsp?outcategory="+outcategory+"&incategory="+incategory;