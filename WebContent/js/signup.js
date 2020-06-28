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



//인증코드 이메일 발송
function sendMail() {
	
	if($("#input-email").val() == "" || $("#input-email").val() == null) return;
	
	window.name = "parentForm"; //부모 창 이름
	window.open("./processSendMail.jsp?email=" + $("#input-email").val() + $("#input-email-kind").val(), "childForm", "width=1,height=1"); //childForm이란 이름의 자식창 팝업
	
}




//인증코드 일치 여부 검사
function checkCode() {
	
	if($("#input-email-code").val() == $("#code-check").val()) { //인증번호 일치
		$("#code-check").val("true");
		$("#input-email-code").attr("readonly", true); //더이상 인증번호 입력란 못 건드리게
		$("#input-email-code").addClass("border-success");
		$("#check-code-button").addClass("d-none");
		
		//성공 alert 띄우기
		$("#code-success-alert").removeClass("d-none");
		$("#code-success-alert").addClass("show");
	} else { //인증번호 미일치
		//실패 alert 띄우기
		$("#code-fail-alert").removeClass("d-none");
		$("#code-fail-alert").addClass("show");
	}
	
}



//정상적인 이메일로 인증코드 받아서 인증받고는 엉뚱한 이메일로 바꿔버려서 가입하는 현상 방지
function resetCode() {
	$("#code-check").val("false");
	$("#input-email-code").attr("readonly", false);
	$("#input-email-code").removeClass("border-success");
	$("#check-code-button").removeClass("d-none");
}




//회원가입 버튼을 눌렀을 때 id 중복검사는 했는지, 비밀번호는 올바른지, 인증코드는 유효한지 검사한 후 submit 
function checkAll() {
	
	//ID 중복검사
	if($("#id-check").val() != "true") {
		alert("ID 중복 검사를 해주세요.");
		return false;
	}
	
	//PW 유효성 검사
	if($("#pw-check-feedback").hasClass("show")) {
		alert("비밀번호는 6~20자 사이 영문과 숫자를 혼용하여 사용해야합니다.");
		return false;
	}
	
	//비밀번호 확인 일치 검사
	if($("#pw-double-check-feedback").hasClass("show")) {
		alert("비밀번호와 비밀번호 확인이 다릅니다.");
		return false;
	}
	
	//이메일 인증코드 검사
	if($("#code-check").val() != "true") {
		alert("이메일 인증을 해주세요. 인증코드 전송을 누른 후 새로 뜨는 팝업창이 자동으로 사라지기 전까지 직접 끄면 안 됩니다.");
		return false;
	}
	
	
	return true;
}