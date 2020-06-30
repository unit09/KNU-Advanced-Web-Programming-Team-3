<%@ page contentType="text/html; charset=utf-8" %>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1" />
	<title>CINE KNU</title>
	
	<link rel="stylesheet" href="./css/common.css">
	<link rel="stylesheet" href="//unpkg.com/bootstrap@4/dist/css/bootstrap.min.css">
	<script src='//unpkg.com/jquery@3/dist/jquery.min.js'></script>
	<script src='//unpkg.com/popper.js@1/dist/umd/popper.min.js'></script>
	<script src='//unpkg.com/bootstrap@4/dist/js/bootstrap.min.js'></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	
	<script src="./js/common.js"></script>
</head>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
	<a class="navbar-brand" href="./index.jsp">CINE KNU</a>
	
    <button
    	class="navbar-toggler"
      	type="button"
      	data-toggle="collapse"
      	data-target="#navbarToggler"
      	aria-controls="navbarToggler"
      	aria-expanded="false"
      	aria-label="Toggle navigation"
    >
    	<span class="navbar-toggler-icon"></span>
    </button>
    
    <div class="collapse navbar-collapse" id="navbarToggler">
    	<ul class="navbar-nav mr-auto">
        	<li class="nav-item">
          		<a class="nav-link" href="./index.jsp">Movie Info</a>
        	</li>
        	<li class="nav-item">
          		<a class="nav-link" href="./timetable.jsp">Movie Reservation</a>
        	</li>
        	<% if(session.getAttribute("userId") != null && session.getAttribute("userId").equals("test")){ %>
        		<li class="nav-item">
          			<a class="nav-link" href="./addMovies.jsp">Timetable Addition</a>
        		</li>
        		<li class="nav-item">
          			<a class="nav-link" href="./deleteMovies.jsp">Timetable Deletion</a>
        		</li>
        	<% } %>
        	<% if(session.getAttribute("userId") != null) { %>
        		<li class="nav-item">
          			<a class="nav-link" href="./myPage.jsp">My Page</a>
        		</li>
        	<% } %>
      	</ul>

      	<ul class="navbar-nav ml-auto">
      		<% if(session.getAttribute("userId") == null){ %>
        		<li class="nav-item">
	          		<a href="./login.jsp" class="btn btn-success" id="loginButton" style="width:auto;" role="button">Login</a>
	          	</li>
          	<% } else { %>
          		<li class="nav-item">
          			<img src="./img/icon.png" width="40" height="40">
          		</li>
          		<li class="nav-item">
          			<a class="nav-link">어서오세요. <%= session.getAttribute("userName") %> 님</a>
          		</li>
          		<li class="nav-item">
          			<button class="btn btn-success" id="logoutButton" style="width:auto;" onclick="logout()">logout</button>
          		</li>
          	<% } %>
    	</ul>
	</div>
</nav>
