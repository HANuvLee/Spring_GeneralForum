//전체 체크 박스 클릭 시 name이 chk인 체크박스 모두 checked로 활성화 
$("document").ready(function() {
	$("#allchk").click(function() {
		if ($("#allchk").is(":checked"))
			$("input[name=chk]").prop("checked", true);
		else
			$("input[name=chk]").prop("checked", false);
	})

	//체크박스의 전체 길이와 체크된 체크박스의 길이를 변수에 대입하여 체크 여부에 따른 전체체크 활성화 및 비활성화 
	$("input[name=chk]").click(function() {
		var total = $("input[name=chk]").length;
		var chked = $("input[name=chk]:checked").length;

		if (total != chked)
			$("#allchk").prop("checked", false);
		else
			$("#allchk").prop("checked", true);
	});
});