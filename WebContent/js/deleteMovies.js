class Timeslot{
	constructor(id, title, place, floor, starttime) {
        this.id = id;
        this.title = title;
        this.place = place;
        this.floor = floor;
        this.starttime = starttime;
    }
}

var ts = new Array();

$(document).ready(function(){
	var arr1 = $(data1).val().split(',');
	var arr2 = $(data2).val().split(',');
	var arr3 = $(data3).val().split(',');
	var arr4 = $(data4).val().split(',');
	var arr5 = $(data5).val().split(',');
	
	for(var i = 0; i < arr1.length; i++){
		ts.push(new Timeslot(arr1[i], arr2[i], arr3[i], arr4[i], arr5[i]));
	}
});

function selectTitle() {
	var sel = document.getElementById("moviename");
	var num = sel.selectedIndex;
	
    document.getElementById("place").options[0].selected = true;
    document.getElementById("place").options.length = 1;
    document.getElementById("floor").options[0].selected = true;
    document.getElementById("floor").options.length = 1;
    document.getElementById("starttime").options[0].selected = true;
    document.getElementById("starttime").options.length = 1;
    
    if(num != 0){
    	var movie_val = sel.options[num].value;
    	var place_sel = document.getElementById("place");
    	var arr = new Array();
    	
    	for(var i = 0; i < ts.length; i++){
    		if(ts[i].title == movie_val && arr.indexOf(ts[i].place) == -1){
    			arr.push(ts[i].place);
    		}
    	}
    	
    	for(var i = 0; i < arr.length; i++){
    		var op = new Option();
    	    op.value = arr[i];
    	    op.text = arr[i];
    	 
    	    // select 태그에 생성 된 option을 넣는다.
    	    place_sel.add(op);
    	}
    }
}

function selectPlace() {
	var place_sel = document.getElementById("place");
	var num = place_sel.selectedIndex;
	
    document.getElementById("floor").options[0].selected = true;    
    document.getElementById("floor").options.length = 1;
    document.getElementById("starttime").options[0].selected = true;
    document.getElementById("starttime").options.length = 1;
    
    if(num != 0){
    	var movie_val = document.getElementById("moviename").options[document.getElementById("moviename").selectedIndex].value;
    	var place_val = place_sel.options[num].value;
    	
    	var floor_sel = document.getElementById("floor");
    	var arr = new Array();
    	
    	for(var i = 0; i < ts.length; i++){
    		if(ts[i].title == movie_val && ts[i].place == place_val && arr.indexOf(ts[i].floor) == -1){
    			arr.push(ts[i].floor);
    		}
    	}
    	
    	for(var i = 0; i < arr.length; i++){
    		var op = new Option();
    	    op.value = arr[i];
    	    op.text = arr[i];
    	 
    	    // select 태그에 생성 된 option을 넣는다.
    	    floor_sel.add(op);
    	}
    }
}

function selectFloor() {
	var floor_sel = document.getElementById("floor");
	var num = floor_sel.selectedIndex;
	
    document.getElementById("starttime").options[0].selected = true;
    document.getElementById("starttime").options.length = 1;
    
    if(num != 0){
    	var movie_val = document.getElementById("moviename").options[document.getElementById("moviename").selectedIndex].value;
    	var place_val = document.getElementById("place").options[document.getElementById("place").selectedIndex].value;
    	var floor_val = floor_sel.options[num].value;
    	
    	var time_sel = document.getElementById("starttime");
    	var arr = new Array();
    	
    	for(var i = 0; i < ts.length; i++){
    		if(ts[i].title == movie_val && ts[i].place == place_val && ts[i].floor == floor_val){
    			arr.push(ts[i].starttime);
    		}
    	}
    	
    	for(var i = 0; i < arr.length; i++){
    		var op = new Option();
    	    op.value = arr[i];
    	    op.text = arr[i];
    	 
    	    // select 태그에 생성 된 option을 넣는다.
    	    time_sel.add(op);
    	}
    }
}
	
function checkDeleteMovies() {
	swal({
		title: "시간표 삭제",
		text: "정말 시간표를 삭제하시겠습니까?",
		icon: "info",
		buttons: true
	})
	.then((result) => {
		if(result){
			var movie_val = document.getElementById("moviename").options[document.getElementById("moviename").selectedIndex].value;
			var place_val = document.getElementById("place").options[document.getElementById("place").selectedIndex].value;
			var floor_val = document.getElementById("floor").options[document.getElementById("floor").selectedIndex].value;
			var time_val = document.getElementById("starttime").options[document.getElementById("starttime").selectedIndex].value;
			
			for(var i = 0; i < ts.length; i++){
				if(ts[i].title == movie_val && ts[i].place == place_val && ts[i].floor == floor_val && ts[i].starttime == time_val){
					document.getElementById("target").value = ts[i].id;
					break;
				}
			}
			
	        document.deleteMovie.submit();
		}
	});
}