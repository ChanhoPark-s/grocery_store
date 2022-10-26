<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.newloginhr{
		height: 1px;
	}
    #text{
	width: 200px;
    height: 50px;  
    border-radius: 10px;
 	border:1px solid #e1e1e1;
    outline: none;
 }
 .pcontents{
 	border-radius: 10px;
 	border:1px solid #e1e1e1;
    outline: none;
 }
   #button{
    	outline: none;
    	border-radius: 4px;
    	border:1px solid #8ca86e;
    	background-color: white;
    	color: #5d5d5d;
    	font-weight:bold;
    	width: 140px;
		height: 50px;   
    }
    th{
    text-align: center;
    }
    td{
    	text-align:center;
    	height: 90px;
    }
    tr>td{
    	margin-left: 50px;
    }
   input[type=file]::file-selector-button {
  width: 200px;
  height: 50px;
  background: #e5e5e5;
  border: 1px solid white;
  border-radius: 10px;
  cursor: pointer;
  &:hover {
    background: rgb(77,77,77);
    color: #fff;
  }
}
   
    
    
</style>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
<script>
$(function(){
	
 $('input[name="sub"]').click(function(){
	
		 if($('input[name="pname"]').val().length==0){
			alert("상품명을 입력하세요");
			$('input[name="pname"]').focus();
			return false;
		}
		if($('input[name="pseller"]').val().length==0){
			alert("판매업체를 입력하세요");
			$('input[name="pseller"]').focus();
			return false;
		}
		if($('input[name="pqty"]').val().length==0){
			alert("재고수량을 입력하세요");
			$('input[name="pqty"]').focus();
			return false;
		}
		if($('input[name="price"]').val().length==0){
			alert("가격을 입력하세요");
			$('input[name="price"]').focus();
			return false;
		}
		if($('input[name="plife"]').val().length==0){
			alert("유통기한을 입력하세요");
			$('input[name="plife"]').focus();
			return false;
		}
		if($('textarea[name="pcontents"]').val().length==0){
			alert("상품내용을 입력하세요");
			$('textarea[name="pcontents"]').focus();
			return false;
		}
		 
 });//빈칸
 
 
 
});//ready

function selected(){
	

 $.ajax({ // 전체 새로고침이 아니라 화면의 일부만 바꿈(시간 절약)
		url : "incategorySelect.jsp", // 요청 url
		data:{
			code1 : $('select[name="outcategory"]').val()
		},
		success : function(list){ // 응답이 왔을 때. 변수data에 url이 들어감.
			
			/* for(var i=0;i<list.size();i++){
				CategoryBean2 cb2 = list.get(i);
			$('select[name="incategory"]').append("<option>"+cb2.getCname()+"</option>");
			} */
			
		}//success
	})//ajax 
}//함수
		
</script>
    
    
<%@include file="/admin/main_top.jsp" %>

<div align="center">
<br><br>
	<h2>상품 등록</h2><br><br>
	
	
<form name="f" action="addProductPro.jsp" method="post" enctype="multipart/form-data">

	<hr color="#5d5d5d" width=40% class="newloginhr"><br>
	<table width=50% align="center">
		<tr>
			<th>상품 이름</th>
			<td align="left" width="350px">
				<input maxlength="15" type="text" id="text" name="pname" placeholder="  최대 15자 입력 가능합니다.">
			</td>
			<th>상품 이미지</th>
			<td align="left" width=300px>
				<input maxlength="15"type="file" name="pimage">
			</td>
		</tr>
		<tr>
			<th>대분류</th>
			<td>
			<select  name="outcategory" class="pl" onChange="selected();">
			<%
			CategoryDao cdao = CategoryDao.getinstance();
			ArrayList<CategoryBean>lists =  cdao.getAllCategory();
								
			for(CategoryBean cb : lists){
			%>
				<option value="<%=cb.getCode1()%>"><%=cb.getCname() %>
			<%	
			}
			%>
			</select>
			</td>
			<th>소분류</th>
			<td>
			<select name="incategory" id="" class="pl">
				<%
				CategoryDao2 cdao2 = CategoryDao2.getinstance();
				ArrayList<CategoryBean2>list =  cdao2.getAllCategory();
									
				for(CategoryBean2 cb2 : list){
				%>
					<option value="<%=cb2.getCode2()%>"><%=cb2.getCname() %>
				<%	
				}
				%>
				%>			
			</select>
			</td>
		</tr>
		<tr>
			<th>판매업체</th>
			<td>
				<input maxlength="15" type="text" id="text" name="pseller" placeholder=" 판매업체를 입력해주세요">
			</td>
			<th>재고수량</th>
			<td>
				<input maxlength="15" type="text" id="text" name="pqty" placeholder=" 재고수량을 입력해주세요">
			</td>
		</tr>
		<tr>
			<th>가격</th>
			<td>
				<input maxlength="15" type="text" id="text" name="price" placeholder=" 가격을 입력해주세요">
			</td>
			<th>스펙</th>
			<td>
				<select name="pspec" class="pl">
			<%
			String[] menubar={"","BEST","신상품","알뜰상품","기획상품"};				
			for(int i=0;i<menubar.length;i++){
			%>
				<option value="<%=menubar[i]%>"><%=menubar[i] %>
			<%	
			}
			%>
			</select>
			</td>
		</tr>
		<tr>
			<th>유통기한</th>
			<td>
				<input maxlength="15" type="text" id="text" name="plife" placeholder=" 유통기한을 입력해주세요">
			</td>
		</tr>
		<tr>
			<th>상품 내용</th>
			<td colspan="3" >
				<textarea  name="pcontents" rows="5" cols="75" placeholder="상세 내용을 입력주세요" class="pcontents"></textarea>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center">
				<input type="submit" id="button" value="상품 등록" name="sub">
			</td>
		</tr>
	</table>

</form>	
</div>



<%@include file="/admin/main_bottom.jsp" %>
    