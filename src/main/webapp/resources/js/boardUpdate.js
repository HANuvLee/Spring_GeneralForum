$('#chkUpdate').on("click", function() {
	var board_title = $('#bd_tit').val();
	var board_cont = $('#bd_cont').val();

	if (board_title == '') {
		alert("Title을 작성해 주세요.")
		$('#bd_tit').val("");
		$('#bd_tit').focus();

		return false;
	}

	if (board_cont == '') {
		alert("Comment를 작성해 주세요.")
		$('#bd_cont').val("");
		$('#bd_cont').focus();

		return false;
	}

	$('#updateForm').submit();
});