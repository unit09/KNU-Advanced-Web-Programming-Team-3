<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.PreparedStatement" %>

<%
	String arr = request.getParameter("arr");
	String[] checked = arr.split(",");
	int userId = 1;	// 나중에 세션으로 받아오기
	int timeslotId = 1;	// 이거도 세션으로? 아님 딴걸로?
	
	String dbURL = "jdbc:mysql://localhost:3306/cinema_db?useUnicode=yes&characterEncoding=UTF-8&serverTimezone=UTC";                    
    String dbID = "test";
    String dbPassword = "test";
    Connection con = null;
    ResultSet rs;
    Statement stmt = null;
    PreparedStatement pstmt = null;
    
    try {
    	Class.forName("com.mysql.cj.jdbc.Driver");
        con = DriverManager.getConnection(dbURL,dbID,dbPassword);
    }
    catch(Exception e) {
    	System.out.println("find E" + e.getMessage());
    }
    
    stmt = con.createStatement();
    String insert = "INSERT INTO ticket(user_id, timeslot_id, seat_number, date) values(?,?,?,NOW())";
    pstmt = con.prepareStatement(insert);
    
    for(int i = 0; i < checked.length; i++){
    	String sql = "SELECT id, timeslot_id, seat_number FROM ticket WHERE timeslot_id='" + timeslotId + "'AND seat_number=" + checked[i];
    	
    	try {
    		rs = stmt.executeQuery(sql);
    		
    		if(rs.next()) {
    			response.sendRedirect("sorry.jsp");
    			return;
    		}
    		else {
    			pstmt.setInt(1, userId);
    			pstmt.setInt(2, timeslotId);
    			pstmt.setInt(3, Integer.parseInt(checked[i]));
    			
    			int r = pstmt.executeUpdate();
    			
    			System.out.println("변경된 row : " + r);
    		}
    		
    		rs.close();
    	}
    	catch(Exception e) {
        	System.out.println(e.getMessage());
        	response.sendRedirect("sorry.jsp");
			return;
        }
    }
    
    try{
		stmt.close();
		con.close();
	}
	catch(Exception e){
		System.out.println(e.getMessage());
	}
    
    
	response.sendRedirect("thanks.jsp");
%>