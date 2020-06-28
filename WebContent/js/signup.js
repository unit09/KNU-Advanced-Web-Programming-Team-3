$(document).ready(function() {
	
	
	
	
	
	
	
});




function idCheck() {
	
	window.name = "parentForm"; //부모 창 이름
	window.open("./processIdCheck.jsp?id=" + $("#input-id").val(), "childForm", "width=1,height=1"); //childForm이란 이름의 자식창 팝업
	
}



function idCheckReset() {
	
	$("#id-check").val("false");
	
}



function alertClose(clickedId) {
	
	var parent = $("#" + clickedId).closest("button").closest("div");
	parent.addClass("d-none");
	parent.removeClass("show");
	
}



//비밀번호 유효성 검사 (영문 숫자 혼용하여 6~20자리)
function pwCheck(str) {
	var reg_pwd = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	
	if(reg_pwd.test(str)) { //유효성 검사 통과
		$("#pw-check-feedback").removeClass("show");
	} else { //유효성 검사 실패
		$("#pw-check-feedback").addClass("show");
	}
}


//비밀번호와 비밀번호 확인이 일치하는지
function pwDoubleCheck() {
	
	var pwInput = $("#input-pw");
	var pwDoubleCheckInput = $("#input-pw-double-check");
	
	console.log(pwInput.val() +" "+ pwDoubleCheckInput.val());
	
	if(pwInput.val() != pwDoubleCheckInput.val()) { //비밀번호 일치하지 않음
		$("#pw-double-check-feedback").addClass("show");
	} else {
		$("#pw-double-check-feedback").removeClass("show");
	}
	
}