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
		<div class="content container text-center p-3">
			<div class="row">
				<%
					AccountDataHandler adh = new AccountDataHandler();
					
					String userId = session.getAttribute("userId").toString();
					ArrayList<HashMap<String, String>> list = adh.getAllReservations(userId);
					
					for(HashMap<String, String> map : list) {
						String title = map.get("title").toString();
						String starttime = map.get("starttime").toString(); //"2020-06-25 16:00:00" 형태로 넘어옴
						String date = map.get("date").toString(); //"2020-06-25" 형태로 넘어옴
						String seatNumber = map.get("seat_number").toString();
						String posterURL = map.get("posterURL").toString();
						
						//2020-06-25를 2020년 6월 25일 목요일 string으로 변경
						SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
						Date dt = sdf.parse(date);
						sdf = new SimpleDateFormat("yyyy년 M월 d일");
						date = sdf.format(dt);
						
						//2020-06-25 16:00:00를 16시 00분으로 변경
						sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
						dt = sdf.parse(starttime);
						sdf = new SimpleDateFormat("a h시 m분");
						starttime = sdf.format(dt);
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
				                  <button type="button" class="btn btn-sm btn-danger">예약취소</button>
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