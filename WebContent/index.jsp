<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="api.APIHandler"%>
<%@ page import="cinema.Movie"%>
<!DOCTYPE html>
<html>
	<%@ include file="header.jsp" %>
	<link type="text/css" rel="stylesheet" href="./css/index.css?v=3"></link>
	<script src="./js/index.js"></script>
	
	<body>
		<% Movie[] movies = APIHandler.getAPI(); %>
		
		<div class="container-fluid content" style="float: center">
	        <div class="row">
	            <div class="col-sm-6 col-md-6 col-lg-6">
	                <div class="row">
	                    <div class="col-sm-1 col-md-1 col-lg-1"></div>
	                    <div class="col-sm-11 col-md-11 col-lg-11">
	                        <ul class="list-group">
	                            <% for(int i = 0; i < movies.length; i++){ %>
		                            <% String title = movies[i].getTitle(); %>
		                            <% double vote_average = movies[i].getRating(); %>
		                            <a href='#myCarousel' data-slide-to=<%= i %> class='list-group-item list-group-item-action' id='list_<%= i %>'>  
		                                &starf;&nbsp;&nbsp;<%= vote_average %>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%= title %>&nbsp;
		                            </a>
	                            <% } %>
	                        </ul>
	                    </div>  <!-- row2 col5 -->
	                </div>  <!-- row2 -->
	            </div>  <!-- row1 col5-->

	            <div class="col-sm-6 col-md-6 col-lg-6">
	                <div id="myCarousel" class="carousel slide carousel-fade" data-ride="carousel" style="float: center">
	                    <div class="carousel-inner">
	                            <% for(int i = 0; i < movies.length; i++){ %>
		                            <% String imgurl = movies[i].getPosterURL(); %>
		                            <% String title = movies[i].getTitle(); %>
		                            <% String actors = movies[i].getActors(); %>
		                            <% String director = movies[i].getDirector(); %>
		                            <% String genres = movies[i].getGenre(); %>
		                            <% int runtime = movies[i].getRunningTime(); %>
		                            <% String overview = movies[i].getPlot(); %>
		                            <div class='carousel-item' id='cinner_<%= i %>'>
		                                <img class='img-responsive center-block' alt='Poster' src=<%= imgurl %> />
		                                <div class='carousel-caption d-none d-md-block'>
		                                    <!-- <h2><%= title %></h2> -->
		                                    <p style='visibility:hidden'>Actors: <%= actors %></p>
		                                    <p style='visibility:hidden'>Directors: <%= director %></p>
		                                    <p style='visibility:hidden'>Overview: <%= overview %></p>
		                                    <p style='visibility:hidden'>Genres: <%= genres %></p>
		                                </div>
		                            </div>
	                            <% } %>
	                    </div>  <!-- carousel-inner -->
	                    <a href="#myCarousel" class="left carousel-control-prev" role="button" data-slide="prev">
	                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
	                        <span class="sr-only">Previous</span>
	                    </a>
	                    <a href="#myCarousel" class="right carousel-control-next" role="button" data-slide="next">
	                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
	                        <span class="sr-only">Next</span>
	                    </a>
	                </div>  <!-- carousel -->
	            </div>  <!-- row1 col7 -->
	        </div>  <!-- row1 -->
	    </div> <!-- main container -->
		
		<%@ include file="footer.jsp" %>
	</body>
</html>