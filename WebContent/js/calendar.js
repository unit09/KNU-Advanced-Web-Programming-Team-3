const $calendar = document.getElementById("calendar");
const $today = document.querySelector(".date");
const today = new Date();
const LENGTH = 14;
const YOIL = [ "일", "월", "화", "수", "목", "금", "토" ];

$calendar.innerHTML = "";

for(let i = 0; i < LENGTH; i++){
    const date = new Date(today.getFullYear(), today.getMonth(), today.getDate() + i);
    const $baby = document.createElement("div");
    
    if(!i){ // i가 0일때(오늘)
        $baby.classList.add("selected");
    }
    $baby.innerHTML = `<button>${date.getDate()}</button><div>${i ? YOIL[date.getDay()] : "오늘"}</div>`;

    if(date.getDay() == 6){ // 토요일이면
        $baby.classList.add("Saturday");
    }

    if(date.getDay() == 0){ // 일요일이면
        $baby.classList.add("Sunday");
    }


    $baby.querySelector("button").onclick = () => {

        $calendar.querySelector(".selected").classList.remove("selected");
        $baby.classList.add("selected");
        updateDate(date);

        let select;
        if((select = document.querySelector(".select_movie"))){
            select.click();
        }
        
    };
    $calendar.append($baby);
}
updateDate(today);

function updateDate(date) {
    $today.innerHTML = date.toLocaleDateString() + (today.toLocaleDateString() != date.toLocaleDateString() ? `(${YOIL[date.getDay()]})` : "(오늘)");
}
