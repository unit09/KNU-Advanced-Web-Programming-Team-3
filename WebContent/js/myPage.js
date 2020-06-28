//현재 비밀번호 확인
function checkPw(inputVal, originalPw) {
	if(inputVal != originalPw) {
		$("#check-pw-feedback").addClass("show");
	} else {
		$("#check-pw-feedback").removeClass("show");
	}
}



//비밀번호 변경 가능한지 (유효성 검사)
//변경 불가능하면 false 반환, 가능하면 true
function changePw() {
	
	//기존 비밀번호를 틀리게 입력한 경우
	if($("#check-pw-feedback").hasClass("show")) {
		alert("비밀번호를 올바르게 입력하세요.");
		return false;
	}
	
	
	
	var newPw = $("#input-pw-new").val();
	
	if(!pwCheck(newPw)) {
		alert("비밀번호는 8~20자 사이의 영문과 숫자로 조합되어야합니다.");
		return false;
	} else {
		alert("성공적으로 비밀번호를 변경하였습니다.");
		return true;
	}
	
}


//비밀번호 유효성 검사 (영문 숫자 혼용하여 6~20자리)
function pwCheck(str) {
	var reg_pwd = /^.*(?=.{6,20})(?=.*[0-9])(?=.*[a-zA-Z]).*$/;
	
	if(reg_pwd.test(str)) { //유효성 검사 통과
		return true;
	} else { //유효성 검사 실패
		return false;
	}
}