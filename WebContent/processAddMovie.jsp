<%@page import="java.sql.*"%>

<%
	request.setCharacterEncoding("euc-kr");
	String moviename = request.getParameter("moviename");
	String place = request.getParameter("place");
	String floor = request.getParameter("floor");
	String time = request.getParameter("time");
	String service = request.getParameter("service");
	String price = request.getParameter("price");
	
	
	Connection conn = null;
	Statement stmt = null;
	ResultSet rs;
	boolean flag = true;
	
	try{
		String url = "jdbc:mysql://jjo.kr:33066/boram3jo";
		String id = "boram3jo"; 
		String pw = "15881009";
		
		String checkQuery = "select * from timeslot t, movie m where t.place = " + place + " and m.id = " + moviename +
							" and (((date_format(t.endtime, '%Y-%m-%d %H:%i:%s') >= date_format('" + time + "', '%Y-%m-%d %H:%i:%s'))" +
									" and (date_format(t.starttime, '%Y-%m-%d %H:%i:%s') <= date_format('" + time + "', '%Y-%m-%d %H:%i:%s')))" +
							" or ((date_format(t.starttime, '%Y-%m-%d %H:%i:%s') <= date_format(date_add('" + time + "', INTERVAL m.runtime MINUTE), '%Y-%m-%d %H:%i:%s'))" +
									"and (date_format(t.starttime, '%Y-%m-%d %H:%i:%s') >= date_format('" + time +"', '%Y-%m-%d %H:%i:%s'))))";
		
		String query = "insert into timeslot(movie,place,starttime,endtime,price)values('" 
		+ moviename + "','" + place + "','" + time + "',(select cast('" + time 
			+ "' as datetime ) + interval (select runtime from movie where id = '" 
			+ moviename + "') minute ), '" + price + "')";
		Class.forName("com.mysql.jdbc.Driver");
		conn = DriverManager.getConnection(url,id,pw);
		stmt = conn.createStatement();
		
		rs = stmt.executeQuery(checkQuery);
		if(rs.next()) {
			flag = false;
		}
		else {
			stmt.executeUpdate(query);
		}
		rs.close();
		
		}catch(Exception e){
		e.printStackTrace();
	}

	//response.sendRedirect("addMovies.jsp");
%>

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<title>CINE KNU</title>
	</head>
	<body>
		<script>
			<% if(!flag){ %>
			swal({
				title: "시간 겹침!",
				icon: "error"
			}).then((result)=>{
				if(result){
					location.href = './addMovies.jsp';
				}
			});
			<% }else{ %>
			swal({
				title: "추가 완료",
				icon: "success"
			}).then((result)=>{
				if(result){
					location.href = './addMovies.jsp';
				}
			});
			<% } %>
		</script>
	</body>
</html>