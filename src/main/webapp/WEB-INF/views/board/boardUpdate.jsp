<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<style type="text/css">
input {
	border: 0 solid black;
}

input:focus {
	outline: none;
}
</style>
<title>boardView</title>
</head>
<body>
	<form id="updateForm" action="/board/boardUpdateAction.do" method="post">
		<input type="hidden" name="board_type" value="${board.board_type}">
		<input type="hidden" name="board_num" value="${board.board_num}">
		<table align="center">
			<tr>
				<td>
					<table border="1">
						<tr>
							<td width="120" align="center">Title</td>
							<td width="400">
								<input type="text" name="board_title" value="${board.board_title}" id="bd_tit">
							</td>
						</tr>
						<tr>
							<td height="300" align="center">Comment</td>
							<td>
								<textarea cols="60" rows="20" name="board_comment" id="bd_cont">${board.board_comment}</textarea>
							</td>
						</tr>
						<tr>
							<td align="center">Writer</td>
							<td><input type="text" value="${board.creator}" readonly="readonly"></td>
						</tr>
					</table>
				</td>
			</tr>
			<tr>
				<td align="right">
					<a href="/board/boardList.do">List</a> 
					<a href="#" id="chkUpdate">Update</a>
				</td>
			</tr>
		</table>
	</form>
</body>
<script type="text/javascript">
	$('#chkUpdate').on("click", function() {
		var board_title = $('#bd_tit').val();
		var board_cont = $('#bd_cont').val();
		
		if (board_title ==''){
			alert("Title을 작성해 주세요.")
			$('#bd_tit').val("");
			$('#bd_tit').focus();
			
			return false;
		}
		
		if(board_cont ==''){
			alert("Comment를 작성해 주세요.")
			$('#bd_cont').val("");
			$('#bd_cont').focus();
			
			return false;
		}
		
		$('#updateForm').submit();
	});
</script>
</html>