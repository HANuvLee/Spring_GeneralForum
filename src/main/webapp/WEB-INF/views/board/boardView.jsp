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
		<input type="hidden" name="board_num" value="${board.board_num}">
		<input type="hidden" name="board_type" value="${board.board_type}">
		<textarea class="form-control replyInsertForm" rows="1" placeholder="Join the discussion and leave a comment!"></textarea>
		<div class="replyBtn" style="display: none;">
			<span class="btn btn-dark replyBtnCancel">취소</span>
			<span class="btn btn-link replyBtnInsert" onclick="replyInsert()">댓글</span>
		</div>
	</form>
	<div class="repWrapper">
		 <hr class="repline">
		<div class="repheader">
			리오넬메시 22/05/30
		</div>
		<div class="repbody">
			jkdhsakjdhashdjkashkdhasjkdhjkashdjkashjkdhasjkhdjkashdjkhaskjhdjkashdjkhasjkdhasjkhdkjashjkdhsa
		</div>
		<div class="repBtn">
			<div class="rerepCnt">답글12개보기</div>
			<span class= "btn btn-dark repDeleteBtn">삭제</span>
			<span class= "btn btn-link repUpdateBtn">수정</span>
		</div>
	</div>
	<div class="rerepWrapper">
		<div class="repheader">
			리오넬메시 22/05/30
		</div>
		<div class="rerepbody">
			jkdhsakjdhashdjkashkdhasjkdhjkashdjkashjkdhasjkhdjkashdjkhaskjhdjkashdjkhasjkdhasjkhdkjashjkdhsa
		</div>
		<div class="rerepBtn">
			<span class= "btn btn-dark repDeleteBtn">삭제</span>
			<span class= "btn btn-link repUpdateBtn">수정</span>
		</div>
	</div>
</body>
<script type="text/javascript">
	$(function(){
		replyList(${board.board_num}, '${board.board_type}');
	});
	
	//댓글 리스트 조회
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
					rephtml += "<div class= 'reptable'>";
					rephtml += "<hr class='repline'>";
					rephtml += "<div class='repheader'>"+res[i].creator+" "+res[i].wdate+"</div>";
					rephtml += "<div class='repbody'>"+res[i].cont+"</div>";
					rephtml += "<div class='repBtn'>";
					rephtml += "<div class='rerepCnt' reply_num="+res[i].reply_num+">답글"+res[i].childCnt+"개보기</div>";	
					/* if("${user_name}" == res[i].creator ){ //자신의 댓글만 수정 및 삭제 가능 */
					rephtml += "<span class= 'btn btn-dark repDeleteBtn'>삭제</span>";
					rephtml += "<span class= 'btn btn-link repUpdateBtn'>수정</span>";
					/* } */
					rephtml += "<div class='rerepWrapper' grs="+res[i].reply_num+">";
					rephtml += "</div>";
					rephtml += "</div>";
				}
				$('.repWrapper').html(rephtml);
				
				//답글 버튼 클릭 시 답글 리스틀 조회하는 ajax호출
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
								/* if("${user_name}" == res[i].creator ){ //자신의 댓글만 수정 및 삭제 가능 */
								rerephtml += "<span class= 'btn btn-dark rerepDeleteBtn'>삭제</span>";
								rerephtml += "<span class= 'btn btn-link rerepUpdateBtn'>수정</span>";
								/* } */
								rerephtml += "</div>";
							}
							$('div[grs='+reply_num+']').html(rerephtml);
						},
						error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
			                alert("통신 실패.");
			        	}
					});
				});
			},
			error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    alert("통신 실패.");
            }
		});
	};
	//댓글 입력 
	function replyInsert() {	
		if($('.replyInsertForm').val().trim() == ""){
			alert("빈 댓글내용은 저장이 불가합니다.");
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
				error : function(XMLHttpRequest, textStatus, errorThrown){ // 비동기 통신이 실패할경우 error 콜백으로 들어옵니다.
                    alert("통신 실패.");
            	}
			});
		};
	};
	
	//답글 조회
	function rereplySelect(board_num, board_type, reply_num) {
	
	};
	
	//댓글 입력 시 버튼 추가
	$('.replyInsertForm').click(function() {
		if($('.replyBtn').css('display') == 'none') {
            $('.replyBtn').css('display', 'block');
        }
	});
	
	//댓글 입력 중 취소 시
	$('.replyBtnCancel').click(function() {
		$('.replyInsertForm').val("");
		$('.replyBtn').css('display', 'none');
	});
</script>
</html>