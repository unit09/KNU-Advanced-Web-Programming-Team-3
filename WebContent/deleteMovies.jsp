<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="EUC-KR"%>
<%@ page import="cinema.Timeslot" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Arrays" %>

<%
	if(session.getAttribute("userId") == null || !session.getAttribute("userId").equals("test")){
		response.sendRedirect("errors.jsp");
		return;
	}

	Connection conn = null;                                        // null로 초기화 한다.
	Statement stmt = null; // SQL구문을 실행
	ResultSet rs = null; // SQL구문의 실행결과를 저장
	
	ArrayList<Timeslot> ts = new ArrayList<Timeslot>();
	ArrayList<String> movieName = new ArrayList<String>();
	
	try{
		String url = "jdbc:mysql://jjo.kr:33066/boram3jo";        // 사용하려는 데이터베이스명을 포함한 URL 기술
		String id = "boram3jo";                                                    // 사용자 계정
		String pw = "15881009";                                                // 사용자 계정의 패스워드
		String query = "select ts.id, m.title, p.name, p.floor, ts.starttime from movie m, timeslot ts, place p where ts.movie = m.id and p.id = ts.place;";
		Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
		conn=DriverManager.getConnection(url,id,pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.
		//out.println("제대로 연결되었습니다.");      						// 커넥션이 제대로 연결되면 수행된다.
		stmt = conn.createStatement(); 								//statement 생성
		rs = stmt.executeQuery(query); 								//쿼리 생성
		
		while(rs.next()){
			ts.add(new Timeslot(rs.getInt("id"), rs.getString("title"), rs.getString("name"), rs.getInt("floor"), rs.getString("starttime")));
		}
		
		for(int i = 0; i < ts.size(); i++){
			if(!movieName.contains(ts.get(i).getTitle())){
				movieName.add(ts.get(i).getTitle());
			}
		}
	}
	catch(Exception e){		// 예외가 발생하면 예외 상황을 처리한다.
		e.printStackTrace();
	}
	
	String data1 = "", data2 = "", data3 = "", data4 = "", data5 = "";
	
	for(int i = 0; i < ts.size(); i++){
		if(i == 0){
			data1 = "" + ts.get(i).getId();
			data2 = ts.get(i).getTitle();
			data3 = ts.get(i).getPlaceName();
			data4 = "" + ts.get(i).getFloor();
			data5 = ts.get(i).getStartTime();
		}
		else{
			data1 += "," + ts.get(i).getId();
			data2 += "," + ts.get(i).getTitle();
			data3 += "," + ts.get(i).getPlaceName();
			data4 += "," + ts.get(i).getFloor();
			data5 += "," + ts.get(i).getStartTime();
		}
	}
%>

<!DOCTYPE html>
<html>
	<!-- header 부분  -->
	<%@ include file="header.jsp" %>
	<script src="./js/deleteMovies.js"></script>
		
	<!-- body 부분 -->
	<body>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">영상 시간표 삭제</h1>
			</div>
		</div>
		<div class="container">
			<form name="deleteMovie" action="./processDeleteMovie.jsp" class="form-horizontal" method="post">
				<input type="hidden" name="data1" id="data1" value="<%= data1 %>">
				<input type="hidden" name="data2" id="data2" value="<%= data2 %>">
				<input type="hidden" name="data3" id="data3" value="<%= data3 %>">
				<input type="hidden" name="data4" id="data4" value="<%= data4 %>">
				<input type="hidden" name="data5" id="data5" value="<%= data5 %>">
				<div class="form-group row">
					<label class="col-sm-2">영화 제목</label>
					<div class="col-sm-3">
						<select class="form-control" id="moviename" onchange="selectTitle()">
							<option value="">삭제할 영상을 선택하세요</option>
							<% for(int i = 0; i < movieName.size(); i++){ %>
								<option value ="<%= movieName.get(i) %>"><%= movieName.get(i) %></option>
							<% } %>
						</select>
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-sm-2">상영관 </label>
					<div class="col-sm-3">
						<select class="form-control" id="place" onchange="selectPlace()">
							<option value="">상영관을 선택해주세요</option>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">층 </label>
					<div class="col-sm-3">
						<select class="form-control" id="floor" onchange="selectFloor()">
							<option value="">층을 선택해주세요</option>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">시간</label>
					<div class="col-sm-3">
						<select class="form-control" id="starttime">
							<option value="">시간을 선택해주세요</option>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="button" class="btn btn-primary" value="삭제" onclick="checkDeleteMovies()">
						<input type="hidden" name="target" id="target">
					</div>
				</div>
			</form>
		</div>
		
		<%
			// 6. 사용한 Statement 종료
			if(rs != null) try { rs.close(); } catch(SQLException ex) {}
		    if(stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		    // 7. 커넥션 종료
		    if(conn != null) try { conn.close(); } catch(SQLException ex) {}
		%>
	<%@ include file="footer.jsp" %>
	</body>
</html>