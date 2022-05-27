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
	 <!-- Comments section-->
    <section class="mb-5">
        <div class="card bg-light">
            <div class="card-body">
                <!-- 댓글 입력폼 => 로그인 상태만 가능-->
                <c:if test="${not empty user_name}">
	                <form class="mb-4">
	                	<textarea class="form-control" id="content" rows="1" placeholder="댓글을 작성하고 대화에 참여하세요!"></textarea>
	                </form>
	                <div class="replyWriteForm">
		              
	                </div>
                </c:if>
                <!--댓글 목록-->
                <div class="d-flex mb-4">
                    <!-- <div class="flex-shrink-0"><img class="rounded-circle" src="https://dummyimage.com/50x50/ced4da/6c757d.jpg" alt="..." /></div> -->
                    <div class="ms-3">
                        <div class="fw-bold parent">Commenter Name</div>
                        If you're going to lead a space frontier, it has to be government; it'll never be private enterprise. Because the space frontier is dangerous, and it's expensive, and it has unquantified risks.
                        Child comment 1
                        <div class="d-flex mt-4">
                            <div class="ms-3">
                                <div class="fw-bold">Commenter Name</div>
                                And under those conditions, you cannot establish a capital-market evaluation of that enterprise. You can't get investors.
                            </div>
                        </div>
                    </div>
                </div> 
                <!-- Single comment-->
            </div>
        </div>
    </section>
</body>
<script type="text/javascript">
	$(function(){
		let board_num = ${board.board_num};
		let board_type = '${board.board_type}'; 
		replyList(board_num, board_type);
	})
	 //댓글리스트를 가져와 삽입하는 메소드
	 function replyList(board_num, board_type) {

		$.ajax({
			url : '/board/replyList.do',
			type : 'get',
			data : {
				board_num : board_num,
				board_type : board_type
			},
			success	: function(data){
				console.log(data);
				// 정상적으로 응답 받았을 경우에는 success 콜백이 호출되게 됩니다.
				// 이 콜백 함수의 파라미터에서는 응답 바디, 응답 코드 그리고 XHR 헤더를 확인할 수 있습니다.
				let rplisthtml ="";
				for(const i in data){
					let reply_num = data[i].reply_num;
					let board_num = data[i].board_num;
					let board_type = data[i].board_type;
					let grp = data[i].grp;
					let grps = data[i].grps;
					let grpl = data[i].grpl;
					let creator = data[i].creator;
					let content = data[i].content;
					let wdate = data[i].wdate;
					
					rplisthtml += "<div class='ms-3'>";
					
					if(grpl == 0){ //모댓글일 시
						rplisthtml += " <div class='fw-bold parent'>"+creator+"";
						rplisthtml += "</div>";
						rplisthtml += ""+content+"";
						rplisthtml += "</div>";

					}
				}
				
				//댓글리스트 출력 부분에 받아온 댓글 리스트 넣기.
				$('.d-flex').html(rplisthtml);
				
				$('.form-control').on('click', function(){
					let replyWriteFormhtml ="";
					replyWriteFormhtml += "<button type='button' class='btn btn-dark' id='btnrep-submit'>댓글</button>";
					/* replyWriteFormhtml += "<input class='btn btn-dark' type='submit' value='취소'>"; */
					$('.replyWriteForm').html(replyWriteFormhtml);
					
					$('#btnrep-submit').on('click', function() {
						if($('.form-control').val() == ''){
							alert("댓글내용을 입력해주세요.");
							$('.form-control').focus();
							return false;
						}else if((($('.form-control').val()).trim()) == ''){
							alert("공백은 입력불가입니다.");
							$('.form-control').focus();
							return false;
						}else{
							content = $('.form-control').val();
 							replyInsert(board_num, board_type, content);
 						}
					});
				});
			
			},
			error	: function(xhr, status, error){
				// 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없기 때문에 error 콜백이 호출될 수 있습니다.
				// 예를 들어, dataType을 지정해서 응답 받을 데이터 형식을 지정하였지만, 서버에서는 다른 데이터형식으로 응답하면  error 콜백이 호출되게 됩니다.
			},
			complete : function(xhr, status){
				// success와 error 콜백이 호출된 후에 반드시 호출됩니다.
				// try - catch - finally의 finally 구문과 동일합니다.
			}
		}); 
	};
	function replyInsert(board_num, board_type, content) {
		$.ajax({
			url : '/board/replyInsert.do',
			type : 'post',
			data : {
				board_num : board_num,
				board_type : board_type,
				content : content,
			},
			success	: function(){
				replyList(board_num, board_type);
			},
			error	: function(xhr, status, error){
				// 응답을 받지 못하였다거나 정상적인 응답이지만 데이터 형식을 확인할 수 없기 때문에 error 콜백이 호출될 수 있습니다.
				// 예를 들어, dataType을 지정해서 응답 받을 데이터 형식을 지정하였지만, 서버에서는 다른 데이터형식으로 응답하면  error 콜백이 호출되게 됩니다.
			},
			complete : function(xhr, status){
				// success와 error 콜백이 호출된 후에 반드시 호출됩니다.
				// try - catch - finally의 finally 구문과 동일합니다.
			}
		});
	};
</script>
</html>