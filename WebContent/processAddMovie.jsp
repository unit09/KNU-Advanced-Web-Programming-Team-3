<%@page import="java.sql.*"%>
<%

request.setCharacterEncoding("euc-kr");
String moviename = request.getParameter("moviename");
String place = request.getParameter("place");
String floor = request.getParameter("floor");
String time = request.getParameter("time");
String service = request.getParameter("service");
String price = request.getParameter("price");

out.println(moviename);
out.println(place);
out.println(floor);
out.println(time);
out.println(service);

Connection conn = null;                                        // null�� �ʱ�ȭ �Ѵ�.
Statement stmt = null; // SQL������ ����

try{
	String url = "jdbc:mysql://jjo.kr:33066/boram3jo";        // ����Ϸ��� �����ͺ��̽����� ������ URL ���
	String id = "boram3jo";                                                    // ����� ����
	String pw = "15881009";  // ����� ������ �н�����
	
	String query = "insert into timeslot(movie,place,starttime,endtime,price)values('" 
	+ moviename + "','" + place + "','" + time + "',(select cast('" + time 
		+ "' as datetime ) + interval (select runtime from movie where id = '" 
		+ moviename + "') minute ), '" + price + "')";
	Class.forName("com.mysql.jdbc.Driver");                       // �����ͺ��̽��� �����ϱ� ���� DriverManager�� ����Ѵ�.
	conn=DriverManager.getConnection(url,id,pw);              // DriverManager ��ü�κ��� Connection ��ü�� ���´�.
	stmt = conn.createStatement();
	stmt.executeUpdate(query);
	
	
	}catch(Exception e){// ���ܰ� �߻��ϸ� ���� ��Ȳ�� ó���Ѵ�.
	e.printStackTrace();
}


%>

<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>
</head>
<body>

</body>
</html>