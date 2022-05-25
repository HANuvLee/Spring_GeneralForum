	var idPattern = /[^a-zA-Z0-9]/;
	var pwPattern = /[^a-zA-Z0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi
	var namePattern = /[^\u3131-\u318E\uAC00-\uD7A3]/;
	var phonePattern = /[^0-9-]/;
	var postNoPattern = /[^0-9-]/;
	var nameValdPattern = /[\u3131-\u318E]/;
	// 아이디 중복확인 후 아이디를 변경한다면 완료 문구 초기화
	var idChkSuccess;
	$('#user_id').change(function(){
		$('#user_id_chk_success').hide();
		idChkSuccess = 0;
	});
	// 아이디 입력 시 해당 문자 입력만 가능
	$('#user_id').on('input', function(){
		var user_id = $('#user_id').val();

		if(user_id.match(idPattern) != null){
			alert("아이디는 영문 및 숫자만 가능합니다.");
			$('#user_id').val(user_id.slice(0, -1));
			$('#user_id').focus();
			return false;
		}
	});
	//중복확인버튼 시 호출 되는 함수
	function idDupChk(){
		if($('#user_id').val() == ''){
			alert("아이디를 입력해주세요.");
			return false;
		}else if($('#user_id').val().match(idPattern) != null){
			alert("아이디는 영문 및 숫자만 가능합니다.");
			$('#user_id').val("");
			$('#user_id').focus();
			return false;
		}$.ajax({
			type: 'POST',
			url:'/board/idDupChk.do',
			data: { "user_id" : $('#user_id').val() },
			success: function(idDupRowCnt){
				if($.trim(idDupRowCnt) == 1){
					alert("이미 존재하는 아이디 입니다.");
					$('#user_id').val("");
					$('#user_id').focus();
					idChkSuccess = 0;	
					return false;
				}else{
					alert("사용 가능한 아이디 입니다.");
					idChkSuccess = 1;
					$('#user_id_chk_success').show();
					$('#user_id_chk_success').attr('color', '#199894b3');
					return true;
				}
			}
		});
	}
	// 비밀번호 입력 시 해당 문자 입력만 가능
	$('#user_pw').on('input', function(){
		var user_pw = $('#user_pw').val();
		var user_pw_chk = $('#user_pw_chk').val();
		
		if(user_pw.match(pwPattern) != null){
			alert("비밀번호는 특수문자, 영문, 숫자 6~12자리 입니다.");
			$('#userPw_Notice').html("");
			$('#user_pw').val("");
			$('#user_pw').focus();
			return false;
		}else if(user_pw.length == 0){
			$('#userPw_Notice').html("");
		}else if(user_pw.length < 6){
			$('#userPw_Notice').html("<br>비밀번호는 특수문자 포함 영문 및 숫자 6~12자리 입니다.");
			$('#userPw_Notice').attr('color', '#f82a2aa3');
		}else if(user_pw.length > 12){
			alert("비밀번호는 특수문자 포함 영문 및 숫자 6~12자리 입니다.");
			$('#userPw_Notice').html("");
			$('#userPw_chkNotice').html("");
			$('#user_pw').val("");
			$('#user_pw').focus();
		}else if(user_pw.length > 5 && user_pw.length < 13){
			$('#userPw_Notice').html('');
      		$('#userPw_Notice').attr('');
		}
		if(user_pw != user_pw_chk){
			if(user_pw.length > 0 && user_pw_chk != ''){
				$('#userPw_chkNotice').html("비밀번호가 불일치합니다.");
				$('#userPw_chkNotice').attr('color', '#f82a2aa3');
			}else{
				$('#userPw_chkNotice').html("");
				$('#userPw_chkNotice').attr('');
			}
		}else if(user_pw == user_pw_chk){
			$('#userPw_chkNotice').html("비밀번호가 일치합니다.");
      		$('#userPw_chkNotice').attr('color', '#199894b3');
		}
	});

	$('#user_pw_chk').on('input', function(){
		var user_pw = $('#user_pw').val();
		var user_pw_chk = $('#user_pw_chk').val();
		
		if(user_pw.length < 6 || user_pw.length > 12){
			alert("비밀번호를 확인해 주세요. 비밀번호는 특수문자 포함 영문 및 숫자 6~12자리 입니다.");
			$('#userPw_Notice').html("");
			$('#userPw_chkNotice').html("");
			$('#user_pw').val("");
			$('#user_pw_chk').val("");
			$('#user_pw').focus();
			return false;
		}else if(user_pw_chk.length == 0){
			$('#userPw_chkNotice').html("");
			$('#userPw_chkNotice').attr('');
		}else if(user_pw_chk != user_pw){
			$('#userPw_chkNotice').html('비밀번호가 불일치합니다.');
      		$('#userPw_chkNotice').attr('color', '#f82a2aa3');
			return false;
		}else if(user_pw_chk == user_pw){
			$('#userPw_Notice').html("");
			$('#userPw_Notice').attr('');
			$('#userPw_chkNotice').html('비밀번호가 일치합니다.');
      		$('#userPw_chkNotice').attr('color', '#199894b3');
			return true;
		}
	});
	$('#user_name').on('input', function(){
		// 인코팅 에러로 인한 유니코드 사용, 아이디 패턴은 한글만 입력 가능하게 한다.
		var user_name = $('#user_name').val();
		if(user_name.match(namePattern) != null){
			alert("이름은 한글만 가능합니다.");
			$('#user_name').val("");
			$('#user_name').focus();
			return false;
		}else if(user_name.length > 4){
			alert("이름은 4글자 이하만 가능합니다.")
			$('#user_name').val("");
			$('#user_name').focus();
			return false;
		}
	});
	//첫번째 헨드폰 번호 변경 시 2번째 3번째 번호 초기화
	$('select').on('change', function(){
		$('#user_phone2').val("");
		$('#user_phone3').val("");
		$('#user_phone2').focus();
	});
	$('#user_phone2').on('input', function(){
		var user_phone2 = $('#user_phone2').val();
		if(user_phone2.match(phonePattern) != null){
			alert("숫자만 입력가능합니다.");
			$('#user_phone2').val(user_phone2.slice(0, -1));
			$('#user_phone2').focus();
			return false;
		}else if(user_phone2.length == 4){
			$('#user_phone3').focus();
		}else if(user_phone2.length > 4){
			alert("번호는 4자리까지 입력가능합니다.");
			$('#user_phone2').val(user_phone2.slice(0, -1));
			return false;
		}
	});
	$('#user_phone3').on('input', function(){
		var user_phone2 = $('#user_phone2').val();
		var user_phone3 = $('#user_phone3').val();

		if(user_phone2.length < 4){
			alert("앞번호를 4자리를 정확히 입력해주세요.");
			$('#user_phone3').val(user_phone3.slice(0, -1));
			$('#user_phone2').focus();
			return false;
		}else if(user_phone3.match(phonePattern) != null){
			alert("숫자만 입력가능합니다.");
			$('#user_phone3').val(user_phone2.slice(0, -1));
			$('#user_phone3').focus();
			return false;
		}else if(user_phone3.length > 4){
			alert("4자리 이상 입력 불가입니다.");
			$('#user_phone3').val(user_phone3.slice(0, -1));
			$('#user_phone3').focus();
			return false;
		}else if(user_phone3.length == 0){
			$('#user_phone2').focus();
		}
	});

	$('#post_no').on('input', function(){
		var post_no = $('#post_no').val();

		if(post_no.match(postNoPattern) != null){
			alert("게시판번호는 숫자만 가능합니다.");
			$('#post_no').val(post_no.slice(0, -1));
			$('#post_no').focus();
			return false;
		}else if(post_no.length > 7){
			alert("게시판번호는 숫자 6자리까지 가능합니다.");
			$('#post_no').val(post_no.slice(0, -1));
			$('#post_no').focus();
			return false;
		//번호 3자리 입력 시 자동으로 "-" 문자 추가 
		}else{
			$('#post_no').val(post_no.replace(/^(\d{0,3})(\d{0,3})$/g, "$1-$2").replace(/\-{1,2}$/g, ""));
		}
	});

	$('#user_addr1').on('input', function(){

	});
	$('#user_company').on('input', function() {

	});

	//조인 버튼 클릭 시 양식과 빈값여부 확인 후 회원가입 진행 
	$('#joinBtn').on('click', function(){
		var user_id = $('#user_id').val();
		var user_pw = $('#user_pw').val();
		var user_pw_chk = $('#user_pw_chk').val();
		var user_name = $('#user_name').val();
		var user_phone1 = $('#user_phone1').val();
		var user_phone2 = $('#user_phone2').val();
		var user_phone3 = $('#user_phone3').val();
		var post_no = $('#post_no').val();
		
		if (user_id == null || user_id == undefined || user_id == ""){
			alert('아이디를 입력해주세요.');
			$('#user_id').focus();
			return false;
		}else if(user_id.match(idPattern) != null){
			alert("아이디 양식을 다시 확인해 주세여.");
			$('#user_id').val("");
			$('#user_id').focus();
			return false;
		}else if(idChkSuccess == 0){
			alert('아이디 중복 확인을 부탁드립니다.');
			$('#user_id').focus();
			return false;
		}else if(user_pw == null || user_pw == undefined || user_pw == ""){
			alert('비밀번호를 입력해주세요.');
			$('#user_id').focus();
			return false;
		}else if(user_pw.match(pwPattern) != null){
			alert("비밀번호 양식을 다시 확인해 주세요.");
			$('#user_pw').focus();
			return false;
		}else if(!user_pw == user_pw_chk){
			alert("두 비밀번호가 일치하지 않습니다. 확인해 주세요");
			$('#user_pw').focus();
			return false;
		}else if(user_pw_chk == null || user_pw_chk == undefined || user_pw_chk == ""){
			alert('비밀번호체크를 부탁드립니다.');
			$('#user_pw_chk').focus();
			return false;
		}else if (user_name == null || user_name == undefined || user_name == ""){
			alert('이름을 입력해주세요.');
			$('#user_name').focus();
			return false;
		}else if(user_name.match(nameValdPattern) != null){
			alert("이름 양식을 다시 확인해 주세요.");
			$('#user_id').focus();
			return false;
		}else if(user_phone1 == null || user_phone1 == undefined || user_phone1 == ""){
			alert('1번째 전화번호를 선택해주세요.');
			$('#user_phone1').focus();
			return false;
		}else if(user_phone2 == null || user_phone2 == undefined || user_phone2 == ""){
			alert('2번째 전화번호를 입력해주세요.');
			$('#user_phone2').focus();
			return false;
		}else if(user_phone2.match(phonePattern) != null){
			alert("2번째 전화번호 양식을 확인해 주세요.");
			$('#user_phone2').focus();
			return false;
		}else if(user_phone3 == null || user_phone3 == undefined || user_phone3 == ""){
			alert('3번째 전화번호를 입력해주세요.');
			$('#user_phone3').focus();
			return false;
		}else if(user_phone3.match(phonePattern) != null){
			alert("3번째 전화번호 양식을 확인해 주세요.");
			$('#user_phone3').focus();
			return false;
		}else if(post_no == null || post_no == undefined || post_no == ""){
			alert('게시판 번호를 입력해주세요.');
			$('#post_no').focus();
			return false;
		}else if(post_no.match(/\d{3}-\d{3}/) == null){
			alert('게시판 번호 양식을 확인해주세요.');
			$('#post_no').focus();
			return false;
		}else{
			$('#joinForm').submit();
		}
	});