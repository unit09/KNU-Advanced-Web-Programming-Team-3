<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.util.Arrays" %>
<%@ page import="cinema.TicketDataHandler" %>

<!DOCTYPE html>
<html>
	<%@ include file="header.jsp" %>
	<link type="text/css" rel="stylesheet" href="./css/seats.css?v=3"></link>
	<script src="./js/seats.js"></script>
	
	<body>
		<%
			String userId = (String)session.getAttribute("userId");
			int timeslotId = 7;	// 여기에는 필요없나?
		%>
	
		<nav class="navbar navbar-expand-lg navbar-light bg-light">
			<button
		    	class="navbar-toggler"
		      	type="button"
		      	data-toggle="collapse"
		      	data-target="#numberToggler"
		      	aria-controls="numberToggler"
		      	aria-expanded="false"
		      	aria-label="Toggle navigation"
		    >
		    	<span class="navbar-toggler-icon"></span>
		    </button>
		
			<div class="collapse navbar-collapse" id="numberToggler">
				<ul class="navbar-nav mr-auto">
		        	<li class="nav-item" style="margin-left : 50px">
		          		<select class="btn btn-secondary" id = "adult" onchange = "change('adult')">
							<% for(int i = 0; i <= 8; i++) { %>
								<option value = <%= i %>>성인 <%= i %>명</option>
							<% } %>
						</select>
		        	</li>
		        	<li class="nav-item" style="margin-left : 50px">
						<select class="btn btn-secondary" id = "teenager" onchange = "change('teenager')">
							<% for(int i = 0; i <= 8; i++) { %>
								<option value = <%= i %>>청소년 <%= i %>명</option>
							<% } %>
						</select>
		        	</li>
		      	</ul>
		      	
		      	<ul class="navbar-nav ml-auto">
		        	<li class="nav-item">
		        		<form name="ticketing" action="./processTicketing.jsp" method="post">
		        			<input type="button" class="btn btn-secondary" id="makeButton" style="width:auto;" onclick="check('<%= userId %>')" value="예매하기">
		        			<input type="hidden" name="arr" id="arr">
		        		</form>
		       		</li>
		    	</ul>
			</div>
		</nav>
		
		<%
			int[] reserved;
			TicketDataHandler handler = new TicketDataHandler();
			reserved = handler.getReserved(timeslotId);
			
			if(reserved == null){
				reserved = new int[51];
			}
			
			handler.closeCon();
		%>
	
	
		<div class = "page for-center">
			<div class = "screen" style = "font-size : 24px; text-align : center;"> Screen </div>
			<p style = "margin-bottom : 60px">
			
			<div class = "line" style = "width : 60px; margin-left : 30px; margin-right : 30px;">
				<% for(int i = 1; i <= 5; i++) { %>
					<div class = "seat" style = "background-color : ivory;"> <%= (char)(64 + i) %> </div>
				<% } %>
			</div>
	
			<div class = "line" style = "width : 180px">
				<% for(int i = 1, n = 1; i <= 15; i++, n++) { %>
					<% if(reserved[i] == 1) { %>
						<button class = "seat" id = "seat<%= i %>" style="background-color : #F78181;"> <%= n %> </button>
					<% } else { %>
						<button class = "seat" id = "seat<%= i %>" onclick = "setColor('seat<%= i %>', '<%= i %>')"> <%= n %> </button>
					<% } %>
					<% if(n == 3) { n = 0; } %>
				<% } %>
			</div>
				
			<div class = "line" style = "width : 240px;">
				<% for(int i = 16, n = 4; i <= 35; i++, n++) { %>
					<% if(reserved[i] == 1) { %>
						<button class = "seat" id = "seat<%= i %>" style="background-color : #F78181;"> <%= n %> </button>
					<% } else { %>
						<button class = "seat" id = "seat<%= i %>" onclick = "setColor('seat<%= i %>', '<%= i %>')"> <%= n %> </button>
					<% } %>
					<% if(n == 7) { n = 3; } %>
				<% } %>
			</div>
	
			<div class = "line" style = "width : 180px">
				<% for(int i = 36, n = 8; i <= 50; i++, n++) { %>
					<% if(reserved[i] == 1) { %>
						<button class = "seat" id = "seat<%= i %>" style="background-color : #F78181;"> <%= n %> </button>
					<% } else { %>
						<button class = "seat" id = "seat<%= i %>" onclick = "setColor('seat<%= i %>', '<%= i %>')"> <%= n %> </button>
					<% } %>
					<% if(n == 10) { n = 7; } %>
				<% } %>
			</div>
		</div>
			
		<div class="for-center" style = "width : 920px; height : 80px">
			<div class = "seat" style = "float : right; width : 30px; height : 30px; background-color : #F78181;"> </div>
			<div class = "seat" style = "float : right; width : 80px; line-height : 30px; background-color : white; font-size : 16px;"> 예매 불가 </div>
			<div class = "seat" style = "float : right; width : 30px; height : 30px; background-color : #A9D0F5;"> </div>
			<div class = "seat" style = "float : right; width : 80px; line-height : 30px; background-color : white; font-size : 16px;"> 좌석 선택 </div>
			<div class = "seat" style = "float : right; width : 30px; height : 30px;"> </div>
			<div class = "seat" style = "float : right; width : 80px; line-height : 30px; background-color : white; font-size : 16px;"> 예매 가능 </div>
		</div>

		<%@ include file="footer.jsp" %>		
	</body>
</html>