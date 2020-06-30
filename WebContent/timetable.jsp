<%@ page contentType="text/html; charset=utf-8" %>

<!DOCTYPE html>
<html>
    <head>
    	<meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="./css/timetable.css">
    </head>

    <body>
        <div class = "main">
        	<div class="header">
        		<%@ include file="header.jsp" %>
        	</div>
        
            <div class = "menu">  </div>
            <div class = "date"></div>
            <div class = "back"></div>
            <div class = "vack"></div>
            <ul class="movie-list">
            </ul>
            <div id="calendar">
            </div>
            <div class="content">
                <div class = "info_content">
                </div>
            </div>
            
            <div class="footer">
            	 <%@ include file="footer.jsp" %>
            </div>
        </div>
               
        <script type="text/javascript" src="./js/calendar.js"></script>
        <script type="text/javascript" src="./js/movie.js"></script>
    </body>
</html>