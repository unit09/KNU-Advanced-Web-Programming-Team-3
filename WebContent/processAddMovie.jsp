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

Connection conn = null;                                        // null로 초기화 한다.
Statement stmt = null; // SQL구문을 실행

try{
	String url = "jdbc:mysql://jjo.kr:33066/boram3jo";        // 사용하려는 데이터베이스명을 포함한 URL 기술
	String id = "boram3jo";                                                    // 사용자 계정
	String pw = "15881009";  // 사용자 계정의 패스워드
	
	String query = "insert into timeslot(movie,place,starttime,endtime,price)values('" 
	+ moviename + "','" + place + "','" + time + "',(select cast('" + time 
		+ "' as datetime ) + interval (select runtime from movie where id = '" 
		+ moviename + "') minute ), '" + price + "')";
	Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
	conn=DriverManager.getConnection(url,id,pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.
	stmt = conn.createStatement();
	stmt.executeUpdate(query);
	
	
	}catch(Exception e){// 예외가 발생하면 예외 상황을 처리한다.
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