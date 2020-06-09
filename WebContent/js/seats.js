var selected = 0;	// 현재 선택 인원
var adult_select = 0;	// 성인 선택 인원
var teenager_select = 0;	// 청소년 선택 인원

var seats = new Array();

for(var i = 1; i <= 50; i++){
	seats[i] = 0;
}

function setColor(id, index) {
	var property = document.getElementById(id);
	if (seats[index] == 0) {
		if(selected == adult_select + teenager_select){
    		swal("인원초과!", "선택하신 인원을 초과하였습니다.", "warning");
		}
		else{
			property.style.backgroundColor = "#A9D0F5";
			seats[index] = 1;
			selected++;
		}     
	}
	else if(seats[index] == 1) {
		property.style.backgroundColor = "#D8D8D8";
		seats[index] = 0;
		selected--;
	}
}

function change(now){
    var now_id = document.getElementById(now);
    var num = now_id.options[now_id.selectedIndex].value;

    num = Number(num);

    for(var i = 1; i <= 50; i++){
        if(seats[i] == 1){
            setColor('seat' + i, i);
        }
    }

    if(now == 'adult'){
        if(teenager_select + num > 8){
        	swal("최대인원초과!", "최대 8명까지 가능합니다.", "warning");
            $(now_id).val(0).prop("selected", true);
            adult_select = 0
        }
        else{
            adult_select = num;
        }	
    }
    else{
        if(adult_select + num > 8){
        	swal("최대인원초과!", "최대 8명까지 가능합니다.", "warning");
            $(now_id).val(0).prop("selected", true);
            teenager_select = 0;
        }
        else{
            teenager_select = num;
        }
    }
}	

function check(user_id, ts_id){
	var checked = new Array();
	
	for(var i = 1; i <= 50; i++){
		if(seats[i] == 1){
			checked.push(i);
		}
    }

    if(user_id == ''){
    	swal("로그인 필요!", "좌석을 예매하시려면 로그인이 필요합니다.", "error");
    }
    else{
        if(checked.length == 0){
        	swal("좌석 선택 필요!", "선택한 좌석이 없습니다.", "warning");
        }
        else{        
        	swal({
      		  title: "좌석 예매",
      		  text: "선택하신 좌석으로 예매를 완료하시겠습니까?",
      		  icon: "info",
      		  buttons: true
      		})
      		.then((result) => {
      			if(result){
      				document.getElementById("arr").value = checked;
      	        	document.ticketing.submit();
      			}
      		});
        }
    }
	
}