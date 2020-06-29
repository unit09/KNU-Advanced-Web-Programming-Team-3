

fetch("./make_json.jsp").then(res => res.json()).then(data => {
    // json을 받아옴

    const $movie = document.querySelector(".movie-list");
    const $menu = document.querySelector(".menu");

    $menu.innerHTML = data[0].title; // 첫 번째 영화 제목을 초기값으로 줌
    $menu.setAttribute("title", data[0].title);

    
    for(const movie of data){
        const $baby = document.createElement("li");

        $baby.classList.add(`age-${movie.age}`); // movie-age가 0이면 전체 이용가
        $baby.innerHTML = movie.title;
        $baby.setAttribute("title", movie.title);
        
        $baby.onclick = () => {

            let $select = document.querySelector(".select_movie");

            if($select){
                $select.classList.remove("select_movie");
            }

            $baby.classList.add("select_movie");

            $menu.innerHTML = $baby.innerHTML;
            $menu.setAttribute("title", $baby.innerHTML);

            $content = document.querySelector(".content");


            let date_data = movie.schedule.reduce((pv, v) => {
            if(!pv[v.date]) pv[v.date] = [];
            pv[v.date].push(v);
            return pv;
            }, {})
            
            const $date = document.querySelector(".selected");
            console.log(date_data);
            console.log($date.firstChild.innerHTML);
            
            let date_a = Object.keys(date_data);

            const $info_content = document.querySelector(".info_content")

            while($info_content.hasChildNodes()){           // 페이지 초기화
                $info_content.removeChild($info_content.firstChild);
            }
            

            for(date of date_a){
                let day = date.substring(8,10);
                if(Number($date.firstChild.innerHTML) === Number(day)){ // 01이랑 1랑 같게 보기 위해서 Number를 씀
                    let movie_data = date_data[date].reduce((pv, v) => {
                    if(!pv[v.place]) pv[v.place] = [];
                    pv[v.place].push(v);
                    return pv;
                    }, {})
                    
                    let movie_location_a = Object.keys(movie_data);
            
                    for(let movie_location of movie_location_a){
        
                        const $info = document.createElement("div");
                        const $location = document.createElement("div");
                        $location.innerHTML = movie_location;
                        $location.classList.add("location");
                        $info.classList.add("info");
                        $info_content.append($location);
                        $info_content.append($info);
        
                        for(let movie_place of Object.values(movie_data)){
                            for(let movie_place_detail of movie_place){
                                let $box = document.createElement("button");
                                $box.classList.add("info_box");
        
                                let $time = document.createElement("div");
                                $time.innerHTML = movie_place_detail.time;
                                $time.classList.add("time");
                                $box.append($time);
                                
                                let $audience = document.createElement("div");
                                $audience.innerHTML = `<strong>${movie_place_detail.audience[0]}</strong>/${movie_place_detail.audience[1]}`;
                                $audience.classList.add("audience");
                                $box.append($audience);
        
                                let $section = document.createElement("div");
                                $section.innerHTML = movie_place_detail.location + "층";
                                $section.classList.add("section");
                                $box.append($section);
        
                                if(movie_location == movie_place_detail.place)
                                    $info.append($box);
        
                            }
                        }
                    }
                }
            }
        }

        $movie.append($baby);

    }

});

