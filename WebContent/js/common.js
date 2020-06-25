function logout(){
	swal({
		title: "로그아웃",
		text: "정말로 로그아웃하시겠습니까?",
		icon: "info",
		buttons: true
	})
	.then((result) => {
		if(result){
			location.href = "./processLogout.jsp";
		}
	});
}