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

	Connection conn = null;                                        // null�� �ʱ�ȭ �Ѵ�.
	Statement stmt = null; // SQL������ ����
	ResultSet rs = null; // SQL������ �������� ����
	
	ArrayList<Timeslot> ts = new ArrayList<Timeslot>();
	ArrayList<String> movieName = new ArrayList<String>();
	
	try{
		String url = "jdbc:mysql://jjo.kr:33066/boram3jo";        // ����Ϸ��� �����ͺ��̽����� ������ URL ���
		String id = "boram3jo";                                                    // ����� ����
		String pw = "15881009";                                                // ����� ������ �н�����
		String query = "select ts.id, m.title, p.name, p.floor, ts.starttime from movie m, timeslot ts, place p where ts.movie = m.id and p.id = ts.place;";
		Class.forName("com.mysql.jdbc.Driver");                       // �����ͺ��̽��� �����ϱ� ���� DriverManager�� ����Ѵ�.
		conn=DriverManager.getConnection(url,id,pw);              // DriverManager ��ü�κ��� Connection ��ü�� ���´�.
		//out.println("����� ����Ǿ����ϴ�.");      						// Ŀ�ؼ��� ����� ����Ǹ� ����ȴ�.
		stmt = conn.createStatement(); 								//statement ����
		rs = stmt.executeQuery(query); 								//���� ����
		
		while(rs.next()){
			ts.add(new Timeslot(rs.getInt("id"), rs.getString("title"), rs.getString("name"), rs.getInt("floor"), rs.getString("starttime")));
		}
		
		for(int i = 0; i < ts.size(); i++){
			if(!movieName.contains(ts.get(i).getTitle())){
				movieName.add(ts.get(i).getTitle());
			}
		}
	}
	catch(Exception e){		// ���ܰ� �߻��ϸ� ���� ��Ȳ�� ó���Ѵ�.
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
	<!-- header �κ�  -->
	<%@ include file="header.jsp" %>
	<script src="./js/deleteMovies.js"></script>
		
	<!-- body �κ� -->
	<body>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">���� �ð�ǥ ����</h1>
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
					<label class="col-sm-2">��ȭ ����</label>
					<div class="col-sm-3">
						<select class="form-control" id="moviename" onchange="selectTitle()">
							<option value="">������ ������ �����ϼ���</option>
							<% for(int i = 0; i < movieName.size(); i++){ %>
								<option value ="<%= movieName.get(i) %>"><%= movieName.get(i) %></option>
							<% } %>
						</select>
					</div>
				</div>
				
				<div class="form-group row">
					<label class="col-sm-2">�󿵰� </label>
					<div class="col-sm-3">
						<select class="form-control" id="place" onchange="selectPlace()">
							<option value="">�󿵰��� �������ּ���</option>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">�� </label>
					<div class="col-sm-3">
						<select class="form-control" id="floor" onchange="selectFloor()">
							<option value="">���� �������ּ���</option>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<label class="col-sm-2">�ð�</label>
					<div class="col-sm-3">
						<select class="form-control" id="starttime">
							<option value="">�ð��� �������ּ���</option>
						</select>
					</div>
				</div>
				<div class="form-group row">
					<div class="col-sm-offset-2 col-sm-10">
						<input type="button" class="btn btn-primary" value="����" onclick="checkDeleteMovies()">
						<input type="hidden" name="target" id="target">
					</div>
				</div>
			</form>
		</div>
		
		<%
			// 6. ����� Statement ����
			if(rs != null) try { rs.close(); } catch(SQLException ex) {}
		    if(stmt != null) try { stmt.close(); } catch(SQLException ex) {}
		    // 7. Ŀ�ؼ� ����
		    if(conn != null) try { conn.close(); } catch(SQLException ex) {}
		%>
	<%@ include file="footer.jsp" %>
	</body>
</html>