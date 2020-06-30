<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="EUC-KR"%>

<%
	if(session.getAttribute("userId") == null || !session.getAttribute("userId").equals("test")){
		response.sendRedirect("errors.jsp");
		return;
	}

	Connection conn = null;                                        // null로 초기화 한다.
	Statement stmt = null; // SQL구문을 실행
	Statement stmt2 = null;
	ResultSet rs = null; // SQL구문의 실행결과를 저장
	ResultSet rs2 = null;
	
	try{
		String url = "jdbc:mysql://jjo.kr:33066/boram3jo";        // 사용하려는 데이터베이스명을 포함한 URL 기술
		String id = "boram3jo";                                                    // 사용자 계정
		String pw = "15881009";                                                // 사용자 계정의 패스워드
		String query = "select id,title from movie";
		String query2 = "select distinct id,name from place";
		Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
		conn=DriverManager.getConnection(url,id,pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.
		//out.println("제대로 연결되었습니다.");      // 커넥션이 제대로 연결되면 수행된다.
		stmt = conn.createStatement(); //statement 생성
		stmt2 = conn.createStatement();
		rs = stmt.executeQuery(query); //쿼리 생성
		rs2 = stmt2.executeQuery(query2);
		
		}catch(Exception e){// 예외가 발생하면 예외 상황을 처리한다.
		e.printStackTrace();
	}
%>

<!DOCTYPE html>
<html>
	<!-- header 부분  -->
	<%@ include file="header.jsp" %>
	<script src="./js/addMovies.js"></script>
		
	<!-- body 부분 -->
	<body>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">영상 시간표 추가</h1>
			</div>
		</div>
		<div class="container">
		<form name="newMovie" action="./processAddMovie.jsp" class="form-horizontal" method="post">
			<div class="form-group row">
				<label class="col-sm-2">영화 제목</label>
				<div class="col-sm-3">
					<select class="form-control" name = "moviename">
					<option value="">상영할 영상을 선택하세요</option>
					<% while(rs.next()) { %>
						<option value ="<%=rs.getString("id")%>"><%=rs.getString("title")%></option>
					<% } %>
					</select>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">상영관 </label>
				<div class="col-sm-3">
					<select class="form-control" name="place">
					<option value="">상영관을 선택해주세요</option>
					<% while(rs2.next()) { %>
						<option value ="<%=rs2.getString("id")%>"><%=rs2.getString("name")%></option>
					<% } %>
					</select>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">층 </label>
				<div class="col-sm-3">
					<select class="form-control" name="floor">
					<option>1층</option>
					</select>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">시작 시간</label>
				<div class="col-sm-3">
					<input type="datetime-local" class="form-control" name="time" >
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">서비스 </label>
				<div class="col-sm-3">
					<select class="form-control" name="service">
					<option>2D</option>
					</select>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">가격 </label>
				<div class="col-sm-3">
					<input type="number" class="form-control" name="price" >
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="button" class="btn btn-primary" 
					value="등록" onclick="CheckAddMovies()">
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