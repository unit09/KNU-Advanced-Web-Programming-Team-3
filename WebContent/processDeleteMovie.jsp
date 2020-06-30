<%@page import="java.sql.*"%>
<%
	request.setCharacterEncoding("euc-kr");
	String target = request.getParameter("target"); // timeslot의 id값을 받아옴
	
	Connection conn = null;                                        // null로 초기화 한다.
	Statement stmt = null; // SQL구문을 실행
	
	try{
		String url = "jdbc:mysql://jjo.kr:33066/boram3jo";        // 사용하려는 데이터베이스명을 포함한 URL 기술
		String id = "boram3jo";                                                    // 사용자 계정
		String pw = "15881009";  // 사용자 계정의 패스워드
		
		String query = "delete from timeslot where id = " + target;
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
			swal({
				title: "삭제 완료",
				icon: "success"
			}).then((result)=>{
				if(result){
					location.href = './deleteMovies.jsp';
				}
			});
		</script>
	</body>
</html>

