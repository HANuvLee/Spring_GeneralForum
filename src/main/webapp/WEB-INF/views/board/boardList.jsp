<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
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
.joinbtn {
	text-align: left;
}

.table {
	margin: 0px auto 10px !important;
	width: 500px;
	border-top: 2px solid #D2D2D2;
	border-bottom: 2px solid #D2D2D2;
}
</style>
<title>list</title>
</head>
<body>
	<div style="margin: 50px 0px 0px 400px">
		<a href="/board/Join.do" class="joinbtn">join</a>	
	</div>
	<table class="table" id="boardTable">
		<tr>
			<c:if test="${res.user_id != null}">
				<td align="left">&nbsp;&nbsp;${res.user_name}</td>
			</c:if>
			<td colspan="2" style="text-align: right;"><span>total : ${totalCnt}&nbsp;&nbsp;</span></td>
		</tr>
		<tr>
			<td width="80" align="center">Type</td>
			<td width="40" align="center">No</td>
			<td width="300" align="center">Title</td>
		</tr>
		<c:forEach items="${boardList}" var="list">
			<tr>
				<td align="center">${list.board_type}</td>
				<td>${list.board_num}</td>
				<td><a href="/board/${list.board_type}/${list.board_num}/boardView.do?pageNo=${pageNo}">${list.board_title}</a></td>
			</tr>
		</c:forEach>
	</table>
	<c:if test="${res.user_id != null}">
		<div style="margin-left: 780px;">
			<a href="/board/boardWrite.do">�۾���</a>
			<a href="/login/Logout.do" class="logoutbtn">�α׾ƿ�</a>
		<c:if test="${res.user_id == null}">
			<a href="/login/Login.do" class="loginbtn">login</a> 
		</c:if>
		</div>
	</c:if>
	<div style="margin-left: 500px;">
		<form method="get" action="/board/boardList.do">
			<input type="checkbox" id="allchk" value="">��ü 
			<input type="checkbox" id="chk01" name="chk" value="a01">�Ϲ� 
			<input type="checkbox" id="chk02" name="chk" value="a02">Q&A 
			<input type="checkbox" id="chk03" name="chk" value="a03">�͸�
			<input type="checkbox" id="chk04" name="chk" value="a04">���� 
			<input class="btn btn-dark" type="submit" value="��ȸ">
		</form>
	</div>
</body>
<script type="text/javascript">
	//��ü üũ �ڽ� Ŭ�� �� name�� chk�� üũ�ڽ� ��� checked�� Ȱ��ȭ 
	$("document").ready(function() {
		$("#allchk").click(function() {
			if ($("#allchk").is(":checked"))
				$("input[name=chk]").prop("checked", true);
			else
				$("input[name=chk]").prop("checked", false);
		});

		//üũ�ڽ��� ��ü ���̿� üũ�� üũ�ڽ��� ���̸� ������ �����Ͽ� üũ ���ο� ���� ��üüũ Ȱ��ȭ �� ��Ȱ��ȭ 
		$("input[name=chk]").click(function() {
			var total = $("input[name=chk]").length;
			var chked = $("input[name=chk]:checked").length;

			if (total != chked)
				$("#allchk").prop("checked", false);
			else
				$("#allchk").prop("checked", true);
		});
	});
</script>
</html>