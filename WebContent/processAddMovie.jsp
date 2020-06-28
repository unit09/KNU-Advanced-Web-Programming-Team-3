<%@page import="java.sql.*"%>

<%

	request.setCharacterEncoding("euc-kr");
	String moviename = request.getParameter("moviename");
	String place = request.getParameter("place");
	String floor = request.getParameter("floor");
	String time = request.getParameter("time");
	String service = request.getParameter("service");
	String price = request.getParameter("price");
	
	
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

	//response.sendRedirect("addMovies.jsp");
%>


<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
<title>Insert title here</title>
</head>
<body>
	<script>
	swal({
		title: "추가 완료",
		icon: "success"
	}).then((result) => {
		if(result){
			location.href = 'addMovies.jsp';
		}
	});
	</script>
</body>
</html>