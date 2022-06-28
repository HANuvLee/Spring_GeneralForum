<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>boardWrite</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link href="/resources/css/boardWrite.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>boardWrite</title>
</head>
<body>
<form action="/board/boardWriteAction.do" method="post">
	<div style="margin: 10px 0 5px 840px;">
		<a href="/board/boardList.do">List</a>
	</div>
	<table align="center" class="table">
		<tr>
			<td width="120" align="center">
				Type							
			</td>
			<td width="400">
			<select name="board_type">
				<option value="a01" selected>일반</option>
				<option value="a02">Q&A</option>
				<option value="a03">익명</option>
				<option value="a04">자유</option>
			</select>
			</td>
		</tr>
		<tr>
			<td width="120" align="center">
				Title
			</td>
			<td width="400">
			<input name="board_title" type="text" size="53"> 
			</td>
		</tr>
		<tr>
			<td height="200" align="center">
				Comment
			</td>
			<td valign="top">
			<textarea name="board_comment"  rows="15" cols="55"></textarea>
			</td>
		</tr>
		<tr>
			<td align="center">
				Writer
			</td>
			<td>
				<input type="text" name="creator" id="creator" value="${user_name}" readonly="readonly" size="53">
			</td>
		</tr>
	</table>
	<div style="margin: 10px 0 10px 840px;">
		<input type="submit" value="작성" class="btn btn-dark">
	</div>
</form>	
</body>
<script type="text/javascript" src="/resources/js/boardWrite.js"></script>
</html>