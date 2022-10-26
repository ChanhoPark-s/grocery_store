

	function writeSave(){
	
		if ($('input[name="writer"]').val().length == 0) {
			alert("이름을 입력하세요");
			$('input[name="writer"]').focus();
			return false;
		}
		if ($('input[name="subject"]').val().length == 0) {
			alert("제목을 입력하세요");
			$('input[name="subject"]').focus();
			return false;
		}
		if ($('input[name="email"]').val().length == 0) {
			alert("이메일을 입력하세요");
			$('input[name="email"]').focus();
			return false;
		}
		if ($('textarea[name="content"]').val().length == 0) {
			alert("내용을 입력하세요");
			$('textarea[name="content"]').focus();
			return false;
		}
		if ($('input[name="passwd"]').val().length == 0) {
			alert("비밀번호를 입력하세요");
			$('input[name="passwd"]').focus();
			return false;
		}
	}