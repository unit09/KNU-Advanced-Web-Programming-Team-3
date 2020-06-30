<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="utf-8"%>

<%@page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
	String i = request.getParameter("sel");
	String seatNum = request.getParameter("seatNum" + i);
	String timeslot_id = request.getParameter("ts" + i); // timeslot의 id값을 받아옴
	String userId = (String)session.getAttribute("userId");
	
	Connection conn = null;                                        // null로 초기화 한다.
	Statement stmt = null; // SQL구문을 실행
	
	try{
		String url = "jdbc:mysql://jjo.kr:33066/boram3jo";        // 사용하려는 데이터베이스명을 포함한 URL 기술
		String id = "boram3jo";                                                    // 사용자 계정
		String pw = "15881009";  // 사용자 계정의 패스워드
		
		String query = "delete from ticket where user_id='" + userId + "' and timeslot_id=" + timeslot_id + " and seat_number=" + seatNum;
		Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
		conn = DriverManager.getConnection(url,id,pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.
		stmt = conn.createStatement();
		stmt.executeUpdate(query);
		
		
		}catch(Exception e){// 예외가 발생하면 예외 상황을 처리한다.
		e.printStackTrace();
		System.out.println("에러에러");
	}
	
	// 6. 사용한 Statement 종료
    if(stmt != null) try { stmt.close(); } catch(SQLException ex) {}
    // 7. 커넥션 종료
    if(conn != null) try { conn.close(); } catch(SQLException ex) {}
    
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="EUC-KR">
		<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
		<title>CINE KNU</title>
	</head>
	<body>
		<script>
			swal({
				title: "예약을 취소하였습니다",
				icon: "success"
			}).then((result)=>{
				if(result){
					location.href = './myReservation.jsp';
				}
			});
		</script>
	</body>
</html>

