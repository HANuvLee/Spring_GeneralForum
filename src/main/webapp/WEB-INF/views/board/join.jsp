<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
.table {
	margin: 0px auto 10px !important;
	width: 500px;
	border-top: 2px solid #D2D2D2;
	border-bottom: 2px solid #D2D2D2;
}

.joinBtn {
	text-align: right;
}

.user_id{
	padding-top: 13px !important;
}
.pw_check{
	padding-top: 11px !important;
}
.user_name{
	padding-top: 10px !important;
}

.address{
	padding-top: 10px !important;
}

#user_phone2{
	width:60px;
	height:20px;
	font-size:inherit;
}

#user_phone3{
	width:60px;
	height:20px;
	font-size:inherit;
}
</style>
<title>boardView</title>
</head>
<body>
	<div style="margin: 50px 0px 0px 400px">
		<a href="/board/boardList.do">List</a>
	</div>
	<form id="joinForm" action="/board/joinAction.do" method="post">
		<table class="table" id="boardTable">
			<tr>
				<td width="80" align="center" class="user_id">id</td>
				<td width="340"><input type="text" id="user_id" name="user_id">
					<button type="button" class="btn btn-dark" onclick="idDupChk();">�ߺ�Ȯ��</button>
					<font id="user_id_chk_success" size="2" style="display: none;"><br>��밡���� ���̵��Դϴ�.</font>
				</td>
			</tr>
			<tr>
				<td width="80" align="center">pw</td>
				<td width="340">
					<input type="password" id="user_pw" name="user_pw">
					<font id="userPw_Notice" size="2"></font>
				</td>
			</tr>
			<tr>
				<td width="80" align="center" class="pw_check">pw check</td>
				<td width="340"><input type="password" id="user_pw_chk">
					<font id="userPw_chkNotice" size="2"></font>
				</td>
			</tr>
			<tr>
				<td width="80" align="center" class="user_name">name</td>
				<td width="340"><input type="text" id="user_name" name="user_name"></td>
			</tr>
			<tr>
				<td width="80" align="center">phone</td>
				<td width="340">
				<select name="user_phone1" id="user_phone1">
						<c:forEach items="${phoneNum}" var="phoneNumList" varStatus="code_id">
							<option value="${code_id.count}">${phoneNumList.code_name}</option>
						</c:forEach>
				</select>
				-&nbsp;&nbsp;<input type="text" id="user_phone2" name="user_phone2" size="4">
				-&nbsp;&nbsp;<input type="text" id="user_phone3" name="user_phone3" size="4">
				</td>
			</tr>
			<tr>
				<td width="80" align="center">postNo</td>
				<td width="340"><input type="text" id="post_no" name="user_addr1"></td>
			</tr>
			<tr>
				<td width="80" align="center" class="address">address</td>
				<td width="340"><input type="text" id="user_addr1" name="user_addr2"></td>
			</tr>
			<tr>
				<td width="80" align="center" class="company">company</td>
				<td width="340"><input type="text" id="user_company" name="user_company"></td>
			</tr>
		</table>
	</form>
	<div style="margin: 0px 0px 0px 840px">
		<a href="#" id="joinBtn">join</a>
	</div>
</body>
<script type="text/javascript">
	var idPattern = /[^a-zA-Z0-9]/;
	var pwPattern = /[^a-zA-Z0-9\{\}\[\]\/?.,;:|\)*~`!^\-_+<>@\#$%&\\\=\(\'\"]/gi
	var namePattern = /[^\u3131-\u318E\uAC00-\uD7A3]/;
	var phonePattern = /[^0-9-]/;
	var postNoPattern = /[^0-9-]/;
	var nameValdPattern = /[\u3131-\u318E]/;
	// ���̵� �ߺ�Ȯ�� �� ���̵� �����Ѵٸ� �Ϸ� ���� �ʱ�ȭ
	var idChkSuccess;
	$('#user_id').change(function(){
		$('#user_id_chk_success').hide();
		idChkSuccess = 0;
	});
	// ���̵� �Է� �� �ش� ���� �Է¸� ����
	$('#user_id').on('input', function(){
		var user_id = $('#user_id').val();

		if(user_id.match(idPattern) != null){
			alert("���̵�� ���� �� ���ڸ� �����մϴ�.");
			$('#user_id').val(user_id.slice(0, -1));
			$('#user_id').focus();
			return false;
		}
	});
	//�ߺ�Ȯ�ι�ư �� ȣ�� �Ǵ� �Լ�
	function idDupChk(){
		if($('#user_id').val() == ''){
			alert("���̵� �Է����ּ���.");
			return false;
		}else if($('#user_id').val().match(idPattern) != null){
			alert("���̵�� ���� �� ���ڸ� �����մϴ�.");
			$('#user_id').val("");
			$('#user_id').focus();
			return false;
		}$.ajax({
			type: 'POST',
			url:'/board/idDupChk.do',
			data: { "user_id" : $('#user_id').val() },
			success: function(idDupRowCnt){
				if($.trim(idDupRowCnt) == 1){
					alert("�̹� �����ϴ� ���̵� �Դϴ�.");
					$('#user_id').val("");
					$('#user_id').focus();
					idChkSuccess = 0;	
					return false;
				}else{
					alert("��� ������ ���̵� �Դϴ�.");
					idChkSuccess = 1;
					$('#user_id_chk_success').show();
					$('#user_id_chk_success').attr('color', '#199894b3');
					return true;
				}
			}
		});
	}
	// ��й�ȣ �Է� �� �ش� ���� �Է¸� ����
	$('#user_pw').on('input', function(){
		var user_pw = $('#user_pw').val();
		var user_pw_chk = $('#user_pw_chk').val();
		
		if(user_pw.match(pwPattern) != null){
			alert("��й�ȣ�� Ư������, ����, ���� 6~12�ڸ� �Դϴ�.");
			$('#userPw_Notice').html("");
			$('#user_pw').val("");
			$('#user_pw').focus();
			return false;
		}else if(user_pw.length == 0){
			$('#userPw_Notice').html("");
		}else if(user_pw.length < 6){
			$('#userPw_Notice').html("<br>��й�ȣ�� Ư������ ���� ���� �� ���� 6~12�ڸ� �Դϴ�.");
			$('#userPw_Notice').attr('color', '#f82a2aa3');
		}else if(user_pw.length > 12){
			alert("��й�ȣ�� Ư������ ���� ���� �� ���� 6~12�ڸ� �Դϴ�.");
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
				$('#userPw_chkNotice').html("��й�ȣ�� ����ġ�մϴ�.");
				$('#userPw_chkNotice').attr('color', '#f82a2aa3');
			}else{
				$('#userPw_chkNotice').html("");
				$('#userPw_chkNotice').attr('');
			}
		}else if(user_pw == user_pw_chk){
			$('#userPw_chkNotice').html("��й�ȣ�� ��ġ�մϴ�.");
      		$('#userPw_chkNotice').attr('color', '#199894b3');
		}
	});

	$('#user_pw_chk').on('input', function(){
		var user_pw = $('#user_pw').val();
		var user_pw_chk = $('#user_pw_chk').val();
		
		if(user_pw.length < 6 || user_pw.length > 12){
			alert("��й�ȣ�� Ȯ���� �ּ���. ��й�ȣ�� Ư������ ���� ���� �� ���� 6~12�ڸ� �Դϴ�.");
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
			$('#userPw_chkNotice').html('��й�ȣ�� ����ġ�մϴ�.');
      		$('#userPw_chkNotice').attr('color', '#f82a2aa3');
			return false;
		}else if(user_pw_chk == user_pw){
			$('#userPw_Notice').html("");
			$('#userPw_Notice').attr('');
			$('#userPw_chkNotice').html('��й�ȣ�� ��ġ�մϴ�.');
      		$('#userPw_chkNotice').attr('color', '#199894b3');
			return true;
		}
	});
	$('#user_name').on('input', function(){
		// ������ ������ ���� �����ڵ� ���, ���̵� ������ �ѱ۸� �Է� �����ϰ� �Ѵ�.
		var user_name = $('#user_name').val();
		if(user_name.match(namePattern) != null){
			alert("�̸��� �ѱ۸� �����մϴ�.");
			$('#user_name').val("");
			$('#user_name').focus();
			return false;
		}else if(user_name.length > 4){
			alert("�̸��� 4���� ���ϸ� �����մϴ�.")
			$('#user_name').val("");
			$('#user_name').focus();
			return false;
		}
	});
	//ù��° ����� ��ȣ ���� �� 2��° 3��° ��ȣ �ʱ�ȭ
	$('select').on('change', function(){
		$('#user_phone2').val("");
		$('#user_phone3').val("");
		$('#user_phone2').focus();
	});
	$('#user_phone2').on('input', function(){
		var user_phone2 = $('#user_phone2').val();
		if(user_phone2.match(phonePattern) != null){
			alert("���ڸ� �Է°����մϴ�.");
			$('#user_phone2').val(user_phone2.slice(0, -1));
			$('#user_phone2').focus();
			return false;
		}else if(user_phone2.length == 4){
			$('#user_phone3').focus();
		}else if(user_phone2.length > 4){
			alert("��ȣ�� 4�ڸ����� �Է°����մϴ�.");
			$('#user_phone2').val(user_phone2.slice(0, -1));
			return false;
		}
	});
	$('#user_phone3').on('input', function(){
		var user_phone2 = $('#user_phone2').val();
		var user_phone3 = $('#user_phone3').val();

		if(user_phone2.length < 4){
			alert("�չ�ȣ�� 4�ڸ��� ��Ȯ�� �Է����ּ���.");
			$('#user_phone3').val(user_phone3.slice(0, -1));
			$('#user_phone2').focus();
			return false;
		}else if(user_phone3.match(phonePattern) != null){
			alert("���ڸ� �Է°����մϴ�.");
			$('#user_phone3').val(user_phone2.slice(0, -1));
			$('#user_phone3').focus();
			return false;
		}else if(user_phone3.length > 4){
			alert("4�ڸ� �̻� �Է� �Ұ��Դϴ�.");
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
			alert("�Խ��ǹ�ȣ�� ���ڸ� �����մϴ�.");
			$('#post_no').val(post_no.slice(0, -1));
			$('#post_no').focus();
			return false;
		}else if(post_no.length > 7){
			alert("�Խ��ǹ�ȣ�� ���� 6�ڸ����� �����մϴ�.");
			$('#post_no').val(post_no.slice(0, -1));
			$('#post_no').focus();
			return false;
		//��ȣ 3�ڸ� �Է� �� �ڵ����� "-" ���� �߰� 
		}else{
			$('#post_no').val(post_no.replace(/^(\d{0,3})(\d{0,3})$/g, "$1-$2").replace(/\-{1,2}$/g, ""));
		}
	});

	$('#user_addr1').on('input', function(){

	});
	$('#user_company').on('input', function() {

	});

	//���� ��ư Ŭ�� �� ��İ� �󰪿��� Ȯ�� �� ȸ������ ���� 
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
			alert('���̵� �Է����ּ���.');
			$('#user_id').focus();
			return false;
		}else if(user_id.match(idPattern) != null){
			alert("���̵� ����� �ٽ� Ȯ���� �ּ���.");
			$('#user_id').val("");
			$('#user_id').focus();
			return false;
		}else if(idChkSuccess == 0){
			alert('���̵� �ߺ� Ȯ���� ��Ź�帳�ϴ�.');
			$('#user_id').focus();
			return false;
		}else if(user_pw == null || user_pw == undefined || user_pw == ""){
			alert('��й�ȣ�� �Է����ּ���.');
			$('#user_id').focus();
			return false;
		}else if(user_pw.match(pwPattern) != null){
			alert("��й�ȣ ����� �ٽ� Ȯ���� �ּ���.");
			$('#user_pw').focus();
			return false;
		}else if(!user_pw == user_pw_chk){
			alert("�� ��й�ȣ�� ��ġ���� �ʽ��ϴ�. Ȯ���� �ּ���");
			$('#user_pw').focus();
			return false;
		}else if(user_pw_chk == null || user_pw_chk == undefined || user_pw_chk == ""){
			alert('��й�ȣüũ�� ��Ź�帳�ϴ�.');
			$('#user_pw_chk').focus();
			return false;
		}else if (user_name == null || user_name == undefined || user_name == ""){
			alert('�̸��� �Է����ּ���.');
			$('#user_name').focus();
			return false;
		}else if(user_name.match(nameValdPattern) != null){
			alert("�̸� ����� �ٽ� Ȯ���� �ּ���.");
			$('#user_id').focus();
			return false;
		}else if(user_phone1 == null || user_phone1 == undefined || user_phone1 == ""){
			alert('1��° ��ȭ��ȣ�� �������ּ���.');
			$('#user_phone1').focus();
			return false;
		}else if(user_phone2 == null || user_phone2 == undefined || user_phone2 == ""){
			alert('2��° ��ȭ��ȣ�� �Է����ּ���.');
			$('#user_phone2').focus();
			return false;
		}else if(user_phone2.match(phonePattern) != null){
			alert("2��° ��ȭ��ȣ ����� Ȯ���� �ּ���.");
			$('#user_phone2').focus();
			return false;
		}else if(user_phone3 == null || user_phone3 == undefined || user_phone3 == ""){
			alert('3��° ��ȭ��ȣ�� �Է����ּ���.');
			$('#user_phone3').focus();
			return false;
		}else if(user_phone3.match(phonePattern) != null){
			alert("3��° ��ȭ��ȣ ����� Ȯ���� �ּ���.");
			$('#user_phone3').focus();
			return false;
		}else if(post_no == null || post_no == undefined || post_no == ""){
			alert('�Խ��� ��ȣ�� �Է����ּ���.');
			$('#post_no').focus();
			return false;
		}else if(post_no.match(/\d{3}-\d{3}/) == null){
			alert('�Խ��� ��ȣ ����� Ȯ�����ּ���.');
			$('#post_no').focus();
			return false;
		}else{
			$('#joinForm').submit();
		}
	});
</script>
</html>