$("#loginBtn").on("click", function(){
 		var user_id = $("#user_id").val();
 		var user_pw = $("#user_pw").val();
 		
		if(user_id == ''){
			alert("아이디를 입력해주세요.");
			$("#user_id").focus();
			return false;
		}else if(user_pw == ''){
			alert("비밀번호를 입력해주세요.");
			$("#user_pw").focus();
			return false;
		}else{
			$("#loginAction").submit();
		}
	});