<%@page import="java.lang.reflect.Member"%>
<%@page import="my.shop.mall.cartListBean"%>
<%@page import="my.shop.mall.cartListDao"%>
<%@page import="java.text.DecimalFormat"%>
<%@page import="my.shop.ProductBean"%>
<%@page import="java.util.ArrayList"%>
<%@page import="my.shop.ProductDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<style>
.buys {
	border-radius: 4px;
	width: 400px;
	height: 50px;
	border: none;
	font-weight: bold;
	color: white;
	background-color: #8ca86e;
}

#text {
	width: 300px;
	height: 50px;
	border-radius: 10px;
	border: 1px solid #e1e1e1;
	outline: none;
}
#postcode, #detailaddress, #address {
	width: 300px;
	height: 50px;
	border-radius: 10px;
	border: 1px solid #e1e1e1;
	outline: none;
}
#text2 {
	width: 100px;
	height: 30px;
	border-radius: 10px;
	border: 1px solid #e1e1e1;
	outline: none;
}

</style>

	<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
	<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
	<script>
/* 우편번호찾기 */
/** 우편번호 찾기 */
	function execDaumPostcode() {
	    daum.postcode.load(function(){
	        new daum.Postcode({
	            oncomplete: function(data) {
	              // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분입니다.
	              $("#postcode").val(data.zonecode);
	              $("#address").val(data.roadAddress);
	            }
	        }).open();
	    });
	}

</script>


	<%@include file="/top.jsp"%><br>
	<br>
	<%
	id = (String)session.getAttribute("id");
	System.out.println("id:"+id);
	mdao = MemberDao.getinstance();
	mb = mdao.getMemberById(id);
	
	
	request.setCharacterEncoding("UTF-8");
	String pnum = request.getParameter("pnum");
	int pqty = Integer.parseInt(request.getParameter("pqty"));
	System.out.println("pnum:"+pnum);
	
	ProductDao pdao = ProductDao.getinstance();
	ProductBean pb = pdao.getProductByPnum(pnum);	
		
%>

	<form name="form" method="get" action="directBuyPro.jsp">

		<input type="hidden" name="pnum" value="<%=pnum%>">
		<input type="hidden" name="id" value="<%=id%>">
		<%
int TotalPrice=0;
%>
		<div align="center">
			<h2>바로 구매하기</h2>
		</div>
		<div>
			<!--큰 테두리  -->
			<table align="center" style="height:52%; float: left; margin-left: 200px;">
				<tr>
					<td align="center">
						<%
				String rContext = request.getContextPath() + "/admin/images/";
				String fullPath = rContext + pb.getPimage();
				DecimalFormat df = new DecimalFormat("###,###");
			%> <a href="detailProduct.jsp?pnum=<%=pb.getPnum()%>"><img
							src="<%=fullPath%>" width="80px" height="100px"></a>
					</td>
					<td width="400px"><b><%=pb.getPname() %></b></td>
					<td>수량</td>
					<td>
						<input name="qty"class="qty" type="text" value="<%=pqty%>">
					</td>
					<td width="150px" align="center">상품 합계</td>
					<%
		    int sum = pqty * pb.getPrice();
		    TotalPrice +=sum;
		    %>
					<td width="150px" align="center"><%=TotalPrice %>원</td>

					</td>
				</tr>
			</table>
			<!-- 구매 칸 -->
			<table style="padding-left: 30px; background-color: #f3fced; border-radius: 15px; width: 500px;">
				<tr>
					<td height="50px">배송지</td>
				</tr>
				<tr>
				<tr>
				<!-- 주소칸 -->
				<td align="center">
					<div>
						<div>
							<input type="text" name="postcode" id="postcode" value=<%=mb.getPostcode() %> readonly />
						</div>
						<div>
							<input type="text" name="address" id="address" value="<%=mb.getAddress()%>" readonly />
						</div>
						<div>
							<input type="text" name="detailaddress" id="detailaddress" value="<%=mb.getDetailaddress()%>" required />
						</div>
					</div>
				</td>
				<td>
					<div>
						<button  id="text2" type="button" id="button"
							onclick="execDaumPostcode()">우편번호 찾기</button>
					</div>
				</td>
			</tr>

				

				<!--  -->
				</tr>
				<tr>
				</tr>
				<tr>
					<td height="50px">상품금액</td>
					<td><%=TotalPrice %>원</td>
				</tr>
				<tr>
					<td height="50px" width="200px">배송비</td>
					<td>
						<%if(TotalPrice>=50000 ||TotalPrice==0){ %>+0<%}else{%>+<%=3000 %>
						<%} %>원
					</td>
				<tr>
					<td colspan="2" align="right" style="padding-right: 120px;"><font
						style="color: orange;">*</font><font color="#B5B5B5" size="1px;">5만원이상
							구매시 배송비 무료</font>
					</div></td>
				</tr>
				</tr>
				<tr>
					<td height="100px">결제예정금액</td>
					<td>
						<%
				if(TotalPrice<50000 &&TotalPrice!=0){
					TotalPrice=TotalPrice+3000;
				}
			%> <input type="hidden" name="total" value="<%=TotalPrice%>">
						<%=TotalPrice %>원
					</td>
				</tr>
				<tr>
					<td colspan="2" height="150px"><input class="buys"
						type="submit" value="구매하기"></td>
				</tr>
			</table>

		</div>
		<!-- 큰테두리 -->

	</form>
	<%@include file="/bottom.jsp"%>