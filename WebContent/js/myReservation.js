function deleteTicket(i, ts_id, seat_number){
	//alert(i + "/" + ts_id +"/" + seat_number);
	
	swal({
		title: "예매 취소",
		text: "정말로 예매를 취소하시겠습니까?",
		icon: "info",
		buttons: true
	})
	.then((result) => {
		if(result){
			document.getElementById("ts" + i).value = ts_id;
			document.getElementById("seatNum" + i).value = seat_number;
			document.getElementById("delres" + i).submit();
		}
	});
}