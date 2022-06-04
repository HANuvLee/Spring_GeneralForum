<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@include file="/WEB-INF/views/common/common.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<script type="text/javascript" src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<link href="/resources/css/boardView.css" rel="stylesheet">
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/js/bootstrap.min.js"></script>
<title>boardView</title>
</head>
<body>
	<div style="margin-left: 850px;">
		<a href="/board/boardList.do">List</a>
	</div>
	<table align="center" class="table">
		<tr>
			<td width="120" align="center">Title</td>
			<td width="400">${board.board_title}</td>
		</tr>
		<tr>
			<td height="300" align="center">Comment</td>
			<td><textarea class="boardComent" rows="15" cols="60">${board.board_comment}</textarea>
			</td>
		</tr>
		<tr>
			<td align="center">Writer</td>
			<td>${board.creator}</td>
		</tr>
	</table>
	<div style="margin-left: 850px;"> 
		<c:set var="creator" value="${board.creator}" /> 
		<c:set var="user_name" value="${user_name}" />
		<c:if test="${creator eq user_name}">
			<a href="/board/boardUpdate.do?board_type=${board.board_type}&board_num=${board.board_num}">Update</a>
		</c:if>
	</div>
	<form class="mb-4">
		<textarea class="form-control replyInsertForm" rows="1" placeholder="Join the discussion and leave a comment!"></textarea>
		<div class="replyBtn" style="display: none;">
			<span class="btn btn-dark replyBtnCancel">���</span>
			<span class="btn btn-link replyBtnInsert" onclick="replyInsert()">���</span>
		</div>
	</form>
	<div class="repWrapper">
		<!--�������� ��� ����Ʈ�� ����. -->
	</div>
</body>
<script type="text/javascript">
	$(function(){
		replyList(${board.board_num}, '${board.board_type}');
	});
	
	//��� ����Ʈ ��ȸ
	function replyList(board_num, board_type) {
		$.ajax({
			url : '/board/replyList.do',
			type : 'get',
			data : {
				board_num : board_num,
				board_type : board_type
			},
			success:function(res){
				let rephtml = "";
				for(let i in res){
					rephtml += "<hr class='repline'>";
					rephtml += "<div class= 'reptable'>";
					rephtml += "<div class='repheader'>"+res[i].creator+" "+res[i].wdate+"</div>";
					rephtml += "<div class='repbody'>"+res[i].cont+"</div>";
					rephtml += "<div class='repBtn'>";
					rephtml += "<div class='rerepCnt' reply_num="+res[i].reply_num+">���"+res[i].childCnt+"������</div>";	
					if("${user_name}" == res[i].creator ){ //�ڽ��� ��۸� ���� �� ���� ���� */
						rephtml += "<span class= 'btn btn-dark repDeleteBtn'>����</span>";
						rephtml += "<span class= 'btn btn-link repUpdateBtn' reply_num="+res[i].reply_num+">����</span>";
						rephtml += "<div class='repUpdateForm' repUpdatFormno="+res[i].reply_num+">";
						rephtml += "</div>";
					 }
					rephtml += "</div>";
					rephtml += "<div class='rerepWrapper' reply_num="+res[i].reply_num+">";
					rephtml += "</div>";
					rephtml += "</div>";
				}
				$('.repWrapper').html(rephtml);
				
				//��� ��ư Ŭ�� �� ��� ����Ʋ ��ȸ�ϴ� ajaxȣ��
				$('.rerepCnt').click(function() {
					let reply_num = ($(this).attr('reply_num'));
					$.ajax({
						url : '/board/rereplyList.do',
						type : 'get',
						data : {
							board_num : board_num, 
							board_type : board_type,
							reply_num : reply_num
						},
						success:function(res){
							rerephtml = "";
							for(let i in res){
								rerephtml += "<div class='rereptable'>";
								rerephtml += "<div class='rerepheader'>"+res[i].creator+" "+res[i].wdate+"</div>";
								rerephtml += "<div class='rerepbody'>"+res[i].cont+"</div>";
								rerephtml += "<div class='rerepBtn'>";
								/* if("${user_name}" == res[i].creator ){ //�ڽ��� ��۸� ���� �� ���� ���� */
								rerephtml += "<span class= 'btn btn-dark rerepDeleteBtn'>����</span>";
								rerephtml += "<span class= 'btn btn-link rerepUpdateBtn'>����</span>";
								/* } */
								rerephtml += "</div>";
								rerephtml += "</div>";
							}
							$('div[grs='+reply_num+']').html(rerephtml);
						},
						error : function(XMLHttpRequest, textStatus, errorThrown){ // �񵿱� ����� �����Ұ�� error �ݹ����� ���ɴϴ�.
			                alert("��� ����.");
			        	}
					});
				});
				
				//��� ���� ��ư Ŭ�� �� ������ �� ��ư ����
				$('.repUpdateBtn').click(function(){
					let reply_num = ($(this).attr('reply_num'));
					let repUpdateForm = "";
						repUpdateForm += "<textarea class='form-control replyUpdateForm' rows='1'></textarea>";
						repUpdateForm += "<div class='replyUpdateBtn'>";
						repUpdateForm += "<span class='btn btn-dark replyUpdateCancel'>���</span>"
						repUpdateForm += "<span class='btn btn-link replyUpdateBtn' onclick='replyUpdate("+reply_num+")'>����</span>";
						repUpdateForm += "</div>";
					$('div[repUpdatFormno='+reply_num+']').html(repUpdateForm);
				});
			},
			error : function(XMLHttpRequest, textStatus, errorThrown){ // �񵿱� ����� �����Ұ�� error �ݹ����� ���ɴϴ�.
                    alert("��� ����.");
            }
		});
	};
	//��� ����
	function replyUpdate(reply_num) {
		if($('.replyUpdateForm').val().trim() == ""){
			alert("�� ��۳����� ������ �Ұ��մϴ�.");
		}else{
			let cont = $('.replyUpdateForm').val();
			$.ajax({
				url : '/board/replyUpdate.do',
				type : 'post',
				data : {
					board_num : ${board.board_num}, 
					board_type :'${board.board_type}',
					reply_num : reply_num,
					cont : cont
				},
				success:function(){
					replyList(${board.board_num}, '${board.board_type}');
				},
				error : function(XMLHttpRequest, textStatus, errorThrown){ // �񵿱� ����� �����Ұ�� error �ݹ����� ���ɴϴ�.
                    alert("��� ����.");
            	}
			});
		};
	};
	
	//��� �Է� 
	function replyInsert() {	
		if($('.replyInsertForm').val().trim() == ""){
			alert("�� ��۳����� ������ �Ұ��մϴ�.");
		}else{
			let cont = $('.replyInsertForm').val();
			$.ajax({
				url : '/board/replyInsert.do',
				type : 'post',
				data : {
					board_num : ${board.board_num}, 
					board_type :'${board.board_type}',
					cont : cont
				},
				success:function(){
					replyList(${board.board_num}, '${board.board_type}');
				},
				error : function(XMLHttpRequest, textStatus, errorThrown){ // �񵿱� ����� �����Ұ�� error �ݹ����� ���ɴϴ�.
                    alert("��� ����.");
            	}
			});
		};
	};
	//��� �Է� �� ��ư �߰�
	$('.replyInsertForm').click(function() {
		if($('.replyBtn').css('display') == 'none') {
            $('.replyBtn').css('display', 'block');
        }
	});
	
	//��� �Է� �� ��� ��
	$('.replyBtnCancel').click(function() {
		$('.replyInsertForm').val("");
		$('.replyBtn').css('display', 'none');
	});
</script>
</html>