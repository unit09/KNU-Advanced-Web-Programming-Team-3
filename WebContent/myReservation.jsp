<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.ArrayList"%>
<%@ page contentType="text/html; charset=utf-8"%>
<%@ page import="login.AccountDataHandler"%>

<!DOCTYPE html>
<html>
<head>
<link type="text/css" rel="stylesheet" href="./css/myPage.css"></link>
<script src="./js/myReservation.js"></script>
<title>마이 페이지</title>
</head>
<body>
<%@ include file="header.jsp" %>
	<div class="wrapper">
		<nav class="sidebar">
			<div class="">
				<ul class="nav flex-column">
					<%@ include file="myPageSidebar.jsp" %>
				</ul>
			</div>
		</nav>
		<div class="content container text-center p-3" style="min-height:500px">
			<div class="row" style="height: 100%;">
				<%
					AccountDataHandler adh = new AccountDataHandler();
					
					String userId = session.getAttribute("userId").toString();
					ArrayList<HashMap<String, String>> list = adh.getAllReservations(userId);
					
					if(list.size() == 0) {
						%>
						<div class="text-center jumbotron" style="margin:auto;">
							<h3>예약된 영화가 없습니다.</h3>
						</div>
						<%
					}
					
					int i = 0;
					
					for(HashMap<String, String> map : list) {
						String title = map.get("title").toString();
						String starttime = map.get("starttime").toString(); //"2020-06-25 16:00:00" 형태로 넘어옴
						String date = map.get("date").toString(); //"2020-06-25" 형태로 넘어옴
						String seatNumber = map.get("seat_number").toString();
						String posterURL = map.get("posterURL").toString();
						String timeslotId = map.get("timeslotId").toString();
						
						//2020-06-25를 2020년 6월 25일 목요일 string으로 변경
						/*
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						Date dt = sdf.parse(date);
						sdf = new SimpleDateFormat("yyyy년 M월 d일");
						date = sdf.format(dt);
						*/
						
						//2020-06-25 16:00:00를 16시 00분으로 변경
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
						Date dt = sdf.parse(starttime);
						sdf = new SimpleDateFormat("yyyy년 M월 d일");
						date = sdf.format(dt);
						sdf = new SimpleDateFormat("a h시 m분");
						starttime = sdf.format(dt);
						
						i++;
						
						boolean isPast = false; //현재 시간보다 과거의 예매인 경우 true
						Date now = new Date(); //현재 시간
						if(now.compareTo(dt) > 0) { //now > dt
							isPast = true;
						}
						System.out.println(now.toString() + " " + dt.toString() + " " + now.compareTo(dt));
						%>
				        <div class="col-md-4">
				          <div class="card mb-4 shadow-sm">
				          	<div class="img-cropper">
				          		<img class="movie-poster" src="<%=posterURL%>">
				          	</div>
				            <div class="card-body">
			              	<h5 class="text-primary"><%=title%></h5>
				              <p class="card-text">
				              	상영일: <%=date%> <br>
				              	상영시간: <%=starttime%> <br>
				              </p>
				              <div class="d-flex justify-content-between align-items-center">
				                <div class="btn-group">
				                	<form name="delres<%= i %>" id="delres<%= i %>" action="./processDeleteReservation.jsp?sel=<%= i %>" class="form-horizontal" method="post">
				                		<input type="button" class="btn btn-sm btn-danger" value="예약취소" onclick="deleteTicket('<%= i %>','<%= timeslotId %>','<%= seatNumber %>')" <% if(isPast) out.println("hidden"); %>>
				                		<input type="hidden" name="ts<%= i %>" id="ts<%= i %>">
				                		<input type="hidden" name="seatNum<%= i %>" id="seatNum<%= i %>">				                		
				                	</form>
				                </div>
				                <small class="text-success"><%=seatNumber%>번 좌석</small>
				              </div>
				            </div>
				          </div>
				        </div>
						<%
					}
				
					adh.close();
				%>
			</div>
		</div>
	</div>

<%@ include file="footer.jsp" %>
</body>
</html>