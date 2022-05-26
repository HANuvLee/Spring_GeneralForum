<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link href="/resources/css/join.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>join</title>
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
					<button type="button" class="btn btn-dark" onclick="idDupChk();">중복확인</button>
					<font id="user_id_chk_success" size="2" style="display: none;"><br>사용가능한 아이디입니다.</font>
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
<script type="text/javascript" src="/resources/js/join.js"  charset="utf-8">"
</script>
</html>