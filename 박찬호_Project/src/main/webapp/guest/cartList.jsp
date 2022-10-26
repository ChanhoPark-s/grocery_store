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
.buys{
    border-radius: 4px;
	width: 400px;
    height: 50px; 
	border:none;
	font-weight:bold; 
	color:white; 
	background-color: #8ca86e;
}
 #text{
	width: 300px;
    height: 50px;  
    border-radius: 10px;
 	border:1px solid #e1e1e1;
    outline: none;
 }
	.sotitle{
		text-align: left;
		width: 100px;
		size : 2px;
		color : #908f8f;
		font-weight: bold;
	}
	.bottomline{
		border-bottom: 1px solid black;
	}
	.im{
	padding: 30px;
	padding-top:0px;
	}
	 .buy{
    border-radius: 4px;
	width: 200px;
    height: 50px; 
	border:none;
	font-weight:bold; 
	color:white; 
	background-color: #8ca86e;
}
 .cart{
    border-radius: 4px;
	width: 200px;
    height: 50px; 
 	border:1px solid #8ca86e;
	background-color:white;
	font-weight:bold; 
	color:#8ca86e; 
}
.plus{
  border-radius: 4px;
	width: 30px;
    height: 25px; 
 	border:1px solid #8ca86e;
	background-color:white;
	font-weight:bold; 
	color:#8ca86e; 
}
.ff{
	text-align: right;
	border: none;
	font-size: 16px;
	font-weight: bold;
	color: #908f8f;
}
</style>

<body onload="init();">
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
<script language="JavaScript">
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
	
	

/* 수량변경 */
$(function(){
	$('.bseq_ea').hide();
	$('.price').hide();
});

/* 수량변경 */
 function fnCalCount(type, ths){
    var $input = $(ths).parents("td").find("input[name='pqty']");
    var $input2 = $(ths).parents("td").find("input[name='Total']");
    var tCount = Number($input.val());
    var tCount2 = Number($input2.val());
    var tEqCount = Number($(ths).parents("tr").find("td.bseq_ea").html());
    var tEqCount2 = Number($(ths).parents("tr").find("td.price").html());
    
    if(type=='p'){
        if(tCount < tEqCount ) $input.val(Number(tCount)+1);
        $input2.val(Number(tCount2)+Number(tEqCount2))
    }else{
        if(tCount >1){
        	$input.val(Number(tCount)-1)
        $input2.val(Number(tCount2)-Number(tEqCount2))    
        }
        }
}



function allSelect(){
	ck = document.form.allcheck.checked // true, false
	
	rc = document.form.rowcheck;
	
	if(ck){ 
		for(i=0;i<rc.length;i++){
			rc[i].checked = true; 
		}
	
	}
	else{ // check 해제
		for(i=0;i<rc.length;i++){ // rowcheck 갯수 []배열처리됨
			rc[i].checked = false; // check 상태로 만들어라.
		}
	}
	
}

	function selectDeleteData(){
		
		rc = document.form.rowcheck;
		flag = false;
		
		for(i=0;i<rc.length;i++){
			if(rc[i].checked){
				
				flag = true;
			}
		}
		if(flag==false){
			alert("삭제할 체크박스를 선택하세요");
			return;
		}
		
		document.form.submit();//submit 누른것처럼 동작해라 action 으로 넘어감.
	}
	
</script>


<%@include file="/top.jsp" %><br><br>
<%
id = (String)session.getAttribute("id");
System.out.println("id:"+id);
%>
<%
	request.setCharacterEncoding("UTF-8");
	
	cartListDao cartdao = cartListDao.getinstance();
	ArrayList<cartListBean> cartLists = cartdao.getCartById(id); 
	System.out.println("가져온 cartLists size :"+cartLists.size());
	
	
		
%>

<form name="form" method="get" action="buy.jsp">

<input type="hidden" name="id" value="<%=id%>">
<%
int TotalPrice=0;
%>
	<div align="center"><h2>장바구니</h2></div>
	<div ><!--큰 테두리  -->
	<%
		if(cartLists.size()>0){
	%>
	<table align="center" style="float: left;padding-left: 200px;">
		<tr>
			<td align="left">
				<input type="checkbox" name= "allcheck" onClick="allSelect()">
			</td>
			<td>
				전체선택(/<%=cartLists.size() %>개)	|
			</td>
			<td align="left" colspan="6">
				 <a href="" onclick="selectDeleteData()">선택삭제</a>
			</td>
		</tr>
			<%
			ProductDao pdao = ProductDao.getinstance();
			
			for(cartListBean cb : cartLists){
				ProductBean pb = pdao.getProductByPnum(cb.getCnum());
			%>
		<tr>
			<td><input type="checkbox" name="rowcheck" value="<%=pb.getPnum() %>" onclick="selectDelete()"></td>
			<td align="center">
			<%
				String rContext = request.getContextPath() + "/admin/images/";
				String fullPath = rContext + pb.getPimage();
				DecimalFormat df = new DecimalFormat("###,###");
			%>
				<a href="detailProduct.jsp?pnum=<%=pb.getPnum()%>"><img src="<%=fullPath%>" width="80px" height="100px"></a>
			</td>
			<td width="400px">
				<b><%=pb.getPname() %></b>
			</td>
		    <td class="bseq_ea"><%=pb.getPqty() %></td>
		    <td class="price"><%=pb.getPrice() %></td>
		    <td>
		    <%
		    int sum = cb.getCqty() * pb.getPrice();
		    TotalPrice +=sum;
		    String m="minus";
		    String p="plus";
		    %>
		    
		       <a href="updateCqty.jsp?a=<%=m%>&cnum=<%=cb.getCnum()%>"><button class="plus"type="button">-</button></a>
		       
		        <input size="2" type="text" name="pqty" value="<%=cb.getCqty() %>" readonly="readonly" style="text-align:center;border: none;"/>
		        
		        <a href="updateCqty.jsp?a=<%=p%>&cnum=<%=cb.getCnum()%>"><button class="plus"type ="button">+</button></a>
		        
		        <input class="ff" type="text" name="Total" value="<%=sum %>" readonly="readonly"/>원
		      
		      
		       <%--  <button class="plus"type="button" onclick="fnCalCount('m', this);">-</button>
		        <input size="2" type="text" name="pqty" value="<%=cb.getCqty() %>" readonly="readonly" style="text-align:center;border: none;"/>
		        <button class="plus"type ="button" onclick="fnCalCount('p',this);">+</button>
		        <input class="ff" type="text" name="Total" value="<%=sum %>" readonly="readonly"/>원 --%>
		   
		   
		    </td>
		    <td width="50px">
		    	<a href="deleteCart.jsp?cnum=<%=cb.getCnum()%>"><font size="2px">[삭제]</font></a>
		    	<input type="hidden" name="cnum"value="<%=cb.getCnum()%>"><!-- cnum을 넘기려고 -->
		    </td>
		</tr>
			<%
			}
			%>
	</table>
	<%
		}// 있으면 만들고 
		else{ //없으면
	%>
		<table align="center" style="float: left;padding-left: 200px;">
			<tr >
				<td height="150px" style="width: 900px;text-align: center;font-size: 20px;">
						장바구니에 담긴 상품이 없습니다.
				</td>
			</tr>
			<tr>
				<td align="center" height="300px">
					<img width="150px" height="150px" src="<%=request.getContextPath()%>/images/nocart.jpg">
				</td>
			</tr>
		</table>
	
	
	<%} //else%>
	<!-- 구매 칸 -->
	<table  style="padding-left: 30px; ackground-color:#f3fced;border-radius:15px; width: 500px;">
		<tr>
			<td height="50px">
				배송지
			</td>
		</tr>
		<tr>
			<td>
			<%
			mdao = MemberDao.getinstance();
			mb =mdao.getMemberById(id);
			%>
			<input id="text"type="text" name="address" value="<%=mb.getAddress()%>">
			</td>
		</tr>
		<tr>
			<td height="50px">
				상품금액
			</td>
			<td>
				<%=TotalPrice %>원
			</td>
		</tr>
		<tr>
			<td height="50px" width="200px">
				배송비
			</td>
			<td>
				<%if(TotalPrice>=50000 ||TotalPrice==0){ %>+0<%}else{%>+<%=3000 %><%} %>원
			</td>
		<tr>
			<td colspan="2" align="right" style="padding-right: 120px;">
				<font style="color: orange;">*</font><font color="#B5B5B5" size="1px;">5만원이상 구매시 배송비 무료</font></div>
			</td>
		</tr>
		</tr>
		<tr>
			<td height="100px">
				결제예정금액
			</td>
			<td>
			<%
				if(TotalPrice<50000 &&TotalPrice!=0){
					TotalPrice=TotalPrice+3000;
				}
			%>
				<input type="hidden" name="total" value="<%=TotalPrice%>">
				<%=TotalPrice %>원
			</td>
		</tr>
		<tr>
			<td colspan="2" height="150px">
				<input class="buys"type="submit" value="구매하기">
			</td>
		</tr>
	</table>
	
</div><!-- 큰테두리 -->

</form>
<%@include file="/bottom.jsp" %>