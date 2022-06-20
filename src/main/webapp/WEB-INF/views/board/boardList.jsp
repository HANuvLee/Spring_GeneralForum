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
<link href="/resources/css/boardList.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<title>list</title>
</head>
<body>
	<div style="margin: 50px 400px 0px 400px">
		<a href="/board/Join.do" class="joinbtn">join</a>
		<span style="float: right">
			<c:if test="${user_id != null}">
				<a href="/board/boardWrite.do">�۾���</a>
				<a href="/login/Logout.do" class="logoutbtn">�α׾ƿ�</a>
			</c:if>
			<c:if test="${user_id == null}">
				<a href="/login/Login.do" class="loginbtn">login</a> 
			</c:if>
		</span>
	</div>
	<table class="table" id="boardTable">
		<tr>
			<c:if test="${user_id != null}">
				<td align="left">&nbsp;&nbsp;${user_name}</td>
			</c:if>
			<td colspan="2" style="text-align: right;"><span>total : ${totalCnt}&nbsp;&nbsp;</span></td>
		</tr>
		<tr>
			<td width="70" align="center">Type</td>
			<td width="30" align="center">No</td>
			<td width="280" align="center">Title</td>
			<td width="40" align="center">Views</td>
		</tr>
		<c:forEach items="${boardList}" var="list">
			<tr>
				<td align="center">${list.board_type}</td>
				<td align="center">${list.board_num}</td>
				<td align="center"><a href="/board/${list.board_type}/${list.board_num}/boardView.do?pageNo=${pageNo}">${list.board_title}</a></td>
				<td align="center">${list.board_view}</td>
			</tr>
		</c:forEach>
	</table>
	<form id="pageForm" method="post" action="/board/boardList.do">
		<div class="currentpage">
		<%-- 	 <c:if test="${pg.startPage > pg.pageBlock}">
				<a class="previouspage" href="/board/boardList.do?currentPage=${pg.startPage-pg.pageBlock}">[����]</a>
			</c:if> --%>
				<%-- 
			<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">	
					<a class="currentpage1" href="/board/boardList.do?currentPage=${i}">[${i}]</a>
			</c:forEach>
			<c:if test="${pg.endPage < pg.totalPage}">
				<a class="nextpage" href="/board/boardList.do?currentPage=${pg.startPage+pg.pageBlock}">[����]</a>
			</c:if> --%>
			 <c:if test="${pg.startPage > pg.pageBlock}">
				<a href="#" data-currentPage="${pg.startPage-pg.pageBlock}">[����]</a>
			</c:if>
			<c:forEach var="i" begin="${pg.startPage}" end="${pg.endPage}">	
					<a href="#" data-currentPage='${i}'>[${i}]</a>
			</c:forEach>
			<c:if test="${pg.endPage < pg.totalPage}">
				<a href="#" data-currentPage="${pg.startPage+pg.pageBlock}">[����]</a>
			</c:if>
		</div>
		<input type="hidden" name="currentPage" value="${pg.currentPage}">
	</form>
	<form method="post" action="/board/boardList.do">
		<div style="margin-left: 500px;">
			<input type="checkbox" id="allchk" value="">��ü 
			<input type="checkbox" id="chk01" name="chk" value="a01">�Ϲ� 
			<input type="checkbox" id="chk02" name="chk" value="a02">Q&A 
			<input type="checkbox" id="chk03" name="chk" value="a03">�͸�
			<input type="checkbox" id="chk04" name="chk" value="a04">���� 
			<input class="btn btn-dark" type="submit" value="��ȸ">
		</div>
	</form>
	<c:forEach items="${chkList}" var ="chklist" >
		<c:if test="${chklist != null}">
			<input type="hidden" id="chkValueList" name="chkList" value="${chklist}">
		</c:if>
	</c:forEach>
</body>
<script type="text/javascript" charset="utf-8">
//��ü üũ �ڽ� Ŭ�� �� name�� chk�� üũ�ڽ� ��� checked�� Ȱ��ȭ 
$("document").ready(function() {
	$("#allchk").click(function() {
		if ($("#allchk").is(":checked"))
			$("input[name=chk]").prop("checked", true);
		else
			$("input[name=chk]").prop("checked", false);
	})

	//üũ�ڽ��� ��ü ���̿� üũ�� üũ�ڽ��� ���̸� ������ �����Ͽ� üũ ���ο� ���� ��üüũ Ȱ��ȭ �� ��Ȱ��ȭ 
	$("input[name=chk]").click(function() {
		var total = $("input[name=chk]").length;
		var chked = $("input[name=chk]:checked").length;

		if (total != chked)
			$("#allchk").prop("checked", false);
		else
			$("#allchk").prop("checked", true);
	});
	
	//get����� ����¡ó���� post������� ����
	$(".currentpage a").on('click',function() {
		var currentPage = $(this).attr('data-currentPage');
		$('input[name=currentPage]').val(currentPage);
		$("#pageForm").submit();
	})
	
});
</script>
</html>