<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="EUC-KR"%>

<%
	if(session.getAttribute("userId") == null || !session.getAttribute("userId").equals("test")){
		response.sendRedirect("errors.jsp");
		return;
	}

	Connection conn = null;                                        // null�� �ʱ�ȭ �Ѵ�.
	Statement stmt = null; // SQL������ ����
	Statement stmt2 = null;
	ResultSet rs = null; // SQL������ �������� ����
	ResultSet rs2 = null;
	
	try{
		String url = "jdbc:mysql://jjo.kr:33066/boram3jo";        // ����Ϸ��� �����ͺ��̽����� ������ URL ���
		String id = "boram3jo";                                                    // ����� ����
		String pw = "15881009";                                                // ����� ������ �н�����
		String query = "select id,title from movie";
		String query2 = "select distinct id,name from place";
		Class.forName("com.mysql.jdbc.Driver");                       // �����ͺ��̽��� �����ϱ� ���� DriverManager�� ����Ѵ�.
		conn=DriverManager.getConnection(url,id,pw);              // DriverManager ��ü�κ��� Connection ��ü�� ���´�.
		//out.println("����� ����Ǿ����ϴ�.");      // Ŀ�ؼ��� ����� ����Ǹ� ����ȴ�.
		stmt = conn.createStatement(); //statement ����
		stmt2 = conn.createStatement();
		rs = stmt.executeQuery(query); //���� ����
		rs2 = stmt2.executeQuery(query2);
		
		}catch(Exception e){// ���ܰ� �߻��ϸ� ���� ��Ȳ�� ó���Ѵ�.
		e.printStackTrace();
	}
%>

<!DOCTYPE html>
<html>
	<!-- header �κ�  -->
	<%@ include file="header.jsp" %>
	<script src="./js/addMovies.js"></script>
		
	<!-- body �κ� -->
	<body>
		<div class="jumbotron">
			<div class="container">
				<h1 class="display-3">���� �ð�ǥ �߰�</h1>
			</div>
		</div>
		<div class="container">
		<form name="newMovie" action="./processAddMovie.jsp" class="form-horizontal" method="post">
			<div class="form-group row">
				<label class="col-sm-2">��ȭ ����</label>
				<div class="col-sm-3">
					<select class="form-control" name = "moviename">
					<option value="">���� ������ �����ϼ���</option>
					<% while(rs.next()) { %>
						<option value ="<%=rs.getString("id")%>"><%=rs.getString("title")%></option>
					<% } %>
					</select>
				</div>
			</div>
			
			<div class="form-group row">
				<label class="col-sm-2">�󿵰� </label>
				<div class="col-sm-3">
					<select class="form-control" name="place">
					<option value="">�󿵰��� �������ּ���</option>
					<% while(rs2.next()) { %>
						<option value ="<%=rs2.getString("id")%>"><%=rs2.getString("name")%></option>
					<% } %>
					</select>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">�� </label>
				<div class="col-sm-3">
					<select class="form-control" name="floor">
					<option>1��</option>
					</select>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">���� �ð�</label>
				<div class="col-sm-3">
					<input type="datetime-local" class="form-control" name="time" >
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">���� </label>
				<div class="col-sm-3">
					<select class="form-control" name="service">
					<option>2D</option>
					</select>
				</div>
			</div>
			<div class="form-group row">
				<label class="col-sm-2">���� </label>
				<div class="col-sm-3">
					<input type="number" class="form-control" name="price" >
				</div>
			</div>
			<div class="form-group row">
				<div class="col-sm-offset-2 col-sm-10">
					<input type="button" class="btn btn-primary" 
					value="���" onclick="CheckAddMovies()">
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