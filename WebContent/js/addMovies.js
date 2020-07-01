function CheckAddMovies() {
	var moviename = document.querySelector("[name=moviename]"); //영화 이름
	var movietime = document.querySelector("[name=time]");
	var movieplace = document.querySelector("[name=place]");
	var moviefloor = document.querySelector("[name=floor]");
	var movieservice = document.querySelector("[name=service]");
	var movieprice = document.querySelector("[name=price]");
	
	if(moviename.value == ""){
		swal("정보부족!", "영상을 선택해주세요.", "error");
		return;
	}
	if(movieplace.value == ""){
		swal("정보부족!", "상영관을 선택해주세요.", "error");
		return;
	}
	if(movietime.validity.vaild == false){
		swal("정보부족!", "시간을 설정해주세요.", "error");
		return;
	}
	if(moviefloor.value == ""){
		swal("정보부족!", "층을 선택해주세요.", "error");
		return;
	}
	if(movieservice.value == ""){
		swal("정보부족!", "서비스를 선택해주세요.", "error");
		return;
	}
	if(movieprice.value < 0 || movieprice.value > 20000 || movieprice.value == ""){
		swal("정보부족!", "0원에서 2만원 사이의 값을 입력해주세요.", "error");
		return;
	}

	swal({
		title: "영화시간표 추가",
		text: "입력하신 정보로 영화시간표를 추가하시겠습니까?",
		icon: "info",
		buttons: true
	})
	.then((result) => {
		if(result){
			document.querySelector("form").submit();
		}
	});
}

