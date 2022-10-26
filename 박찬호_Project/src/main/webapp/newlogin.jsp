<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>
	.newloginhr{
		height: 1px;
	}
    .essencial{
    	margin-left: 570px;
    	font-size: 12px;
    }
    .im{
    	color: orange;
    }
   
    #text,#postcode,#detailaddress,#address{
	width: 350px;
    height: 50px;  
    border-radius: 4px;
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
    tr{
    	height: 70px;
    }
    tr:nth-child(2),tr:nth-child(4),tr:nth-child(6),tr:nth-child(10){
    	height: 20px;
    }
   
    
    
</style>
<script src="http://dmaps.daum.net/map_js_init/postcode.v2.js?autoload=false"></script>
<script type="text/javascript" src="<%=request.getContextPath() %>/js/jquery.js"></script>
<script>
$(document).ready(function(){
	$('input[name="id"]').focus();
	
	
	$('input[name="password"]').click(function(){
		$('.pwmsg').toggle("1000"); 
		
	});
	$('input[name="repassword"]').click(function(){
		$('.repwmsg').toggle("1000"); 
	});
	
	var use;
	var isCheck = false;
	var isChange = false;
	var isBlank = false;
	
	$('input[name="idcheck"]').click(function(){
		
		isCheck = true;
		isChange = false;
		
		if($('input[name="id"]').val()==""){
			alert("아이디를 입력하세요");
			isBlank = true;
			return;
		}
		
		isBlank = false;
		
		 $.ajax({ // 전체 새로고침이 아니라 화면의 일부만 바꿈(시간 절약)
			url : "idcheck.jsp", // 요청 url
			data:{
				id : $('.idch').val()
			},
			success : function(data){ // 응답이 왔을 때. 변수data에 url이 들어감.
				/* alert("data: "+$.trim(data)) */
				if($.trim(data)=="no"){
					$('#message1').html("<font color=red>이미 사용중인 아이디입니다.</font>");
					$('#message1').show();
					use = "impossible";
				}
				else{
					$('#message1').html("<font color=green>사용 가능합니다.</font>");
					$('#message1').show();
					use = "possible";
				}
			}
		}) 
	});//idcheck click 
	
	$('input[name="id"]').keydown(function(){ // 키가 눌렸을 때.
		//alert(4);
		$('#message1').css('display','none'); // 안보이게해라.
		isChange = true; // 글자가 바꼈다.
		use=""; // 새로운 데이터가 들어오면 use는 "" 해서 중복체크 먼저하게 만들기.
	});
	
$('input[name="sub"]').click(function(){
		
	
		if($('input[name="id"]').val().length==0){
			alert("아이디를 입력하세요");
			$('input[name="id"]').focus();
			return false;
		}
		if(use=="impossible"){
			alert("이미 사용중인 아이디입니다.");
			return false;
		}
		else if(isCheck == false || isChange== true){
			alert("중복체크를 확인하세요");
			return false;
		}
		else if(isBlank == true){
			alert("아이디를 입력하세요");
			return false;
		}
		if($('input[name="password"]').val().length==0){
			alert("비밀번호를 입력하세요");
			$('input[name="password"]').focus();
			return false;
		}
		let check = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[$@$!%*#?&])[A-Za-z\d$@$!%*#?&]{10,}$/;
		
		if(!check.test($('input[name="password"]').val())){
			alert("비밀번호 형식이 올바르지 않습니다.");
			$('input[name="password"]').focus();
			return false;
		}
		if($('input[name="repassword"]').val().length==0){
			alert("비밀번호를 입력하세요");
			$('input[name="repassword"]').focus();
			return false;
		}
		if($('input[name="repassword"]').val()!=$('input[name="password"]').val()){
			alert("비밀번호가 같지 않습니다.");
			$('input[name="repassword"]').focus();
			return false;
		}
		if($('input[name="name"]').val().length==0){
			alert("이름을 입력하세요");
			$('input[name="name"]').focus();
			return false;
		}
		if($('input[name="email"]').val().length==0){
			alert("이메일을 입력하세요");
			$('input[name="email"]').focus();
			return false;
		}
		var regEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/;
	    
		if (regEmail.test($('input[name="email"]').val())==false) {
	          alert('이메일 형식이 올바르지 않습니다.');
	          return false;
	      }
		if($('input[name="phone"]').val().length==0){
			alert("휴대폰 번호를 입력하세요");
			$('input[name="phone"]').focus();
			return false;
		}
		if(isNaN($('input[name="phone"]').val())){
			alert("휴대폰 번호는 숫자만 입력 가능합니다.");
			$('input[name="phone"]').focus();
			return false;
		}
		if($('input[name="address"]').val().length==0){
			alert("주소를 입력하세요");
			$('input[name="address"]').focus();
			return false;
		}
		if($('input[name="postcode"]').val().length==0){
			alert("주소를 입력하세요");
			return false;
		}
		if($('input[name="detailaddress"]').val().length==0){
			alert("상세 주소를 입력하세요");
			$('input[name="detailaddress"]').focus();
			return false;
		}
		
})
	
});//ready
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
    
    
<%@include file="top.jsp" %>

<div align="center">
<br><br>
	<h2>회원가입</h2><br><br>
	
	
<form name="f" action="newMemberPro.jsp" method="post">

	<div class="essencial"><font style="color: orange;">*</font>필수입력사항</div>
	<hr color="#5d5d5d" width=40% class="newloginhr">
	<table width=37% class="newlogintable">
		<tr>
			<td><b>아이디</b><span class="im">*</span></td>
			<td align="center">
				<input class="idch" maxlength="15" height=20px type="text" id="text" name="id" placeholder="  최대 15자 입력 가능합니다.">
			</td>
			<td align="center">
				<input type="button" id="button" name="idcheck" value="중복확인" ">
			</td>
		</tr>
		<tr height=30>
			<td></td>
			<td>
				<span id="message1"></span>
			</td>
			<td></td>
		</tr>
		<tr>
			<td><b>비밀번호</b><span class="im">*</span></td>
			<td align="center">
				<input type="password" id="text" name="password" placeholder="  비밀번호를 입력해주세요">
			</td>
		</tr>
		<tr>
			<td></td>
			<td  style="display: none;" class="pwmsg">
			<ul>
				<font size=2px>
					<li>8자 이상 입력</li>
					<li>영문/숫자/특수문자(공백 제외)만 허용하며, 2개 이상 조합</li>
				</font>
			</ul>
			</td>
			<td></td>
		</tr>
		<tr>
			<td width="150px"><b>비밀번호확인</b><span class="im">*</span></td>
			<td align="center">
				<input type="password" id="text" name="repassword" placeholder="  비밀번호를 입력해주세요">
			</td>
		</tr>
		<tr>
			<td></td>
			<td  style="display: none;" class="repwmsg">
			<ul>
				<font size=2px>
					<li>동일한 비밀번호를 입력해주세요.</li>
				</font>
			</ul>
			</td>
			<td></td>
		</tr>
		<tr>
			<td><b>이름</b><span class="im">*</span></td>
			<td align="center">
				<input type="text" id="text" name="name" placeholder="  이름을 입력해주세요">
			</td>
		</tr>
		<tr>
			<td><b>이메일</b><span class="im">*</span></td>
			<td align="center">
				<input type="text" id="text" name="email" placeholder="예 : abcd123@yelmiya.com">
			</td>
		</tr>
		<tr>
			<td><b>휴대폰</b><span class="im">*</span></td>
			<td align="center">
				<input maxlength="11" type="text" id="text" name="phone" placeholder="  숫자만 입력해주세요">
			</td>
		</tr>
		<tr></tr>
			<tr>
				<!-- 주소칸 -->
				<td><b>주소</b><span class="im">*</span></td>
				<td align="center">
					<div>
						<div>
							<input type="text" name="postcode" id="postcode" placeholder="  우편번호" readonly />
						</div>
						<div>
							<input type="text" name="address" id="address" placeholder="  주소" readonly />
						</div>
						<div>
							<input type="text" name="detailaddress" id="detailaddress" placeholder="  상세주소" required />
						</div>
					</div>
				</td>
				<td>
					<div>
						<button  id="button" type="button" id="button"
							onclick="execDaumPostcode()">우편번호 찾기</button>
					</div>
				</td>
			</tr>
		<tr>
			<td><b>성별</td>
			<td align="center">
				<input type="radio" name="gender" value="남">남
				&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
				<input type="radio" name="gender" value="여">여
			</td>
		</tr>
		<tr>
			<th align="left">생년월일</th>
			<td align="center">
				<input type="date" id="text" name="birth" placeholder="생년월일을 선택해주세요">
			</td>
		</tr>
		<tr>
			<td colspan="3" align="center">
				<input type="submit" id="button" name="sub" value="회원가입">
			</td>
		</tr>
	</table>

</form>	
</div>



<%@include file="bottom.jsp" %>
    