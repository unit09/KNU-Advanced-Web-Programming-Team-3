

fetch("./make_json.jsp").then(res => res.json()).then(data => {
    // json을 받아옴
    console.log(data);
    
    const $movie = document.querySelector(".movie-list");
    const $menu = document.querySelector(".menu");

    $menu.innerHTML = data[0].title;

    
    for(const movie of data){
        const $baby = document.createElement("li");

        $baby.classList.add(`age-${movie.age}`); // movie-age가 0이면 전체 이용가
        $baby.innerHTML = movie.title;
        
        $baby.onclick = () => {

            let $select = document.querySelector(".select_movie");

            $baby.classList.add("select_movie");

            if($select){
                $select.classList.remove("select_movie");
            }

            $menu.innerHTML = $baby.innerHTML;

            $content = document.querySelector(".content");

            let movie_data = movie.schedule.reduce((pv, v) => {
            if(!pv[v.place]) pv[v.place] = [];
            pv[v.place].push(v);
            return pv;
            }, {})

            const $info_content = document.querySelector(".info_content")

            while($info_content.hasChildNodes()){
                $info_content.removeChild($info_content.firstChild);
            }

            
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

        $movie.append($baby);

    }

});

