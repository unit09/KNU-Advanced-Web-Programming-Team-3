<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import = "org.json.simple.JSONObject" %>
<%@ page import = "org.json.simple.JSONArray" %>
<%@ page import="java.sql.*"%>

<%


	Connection conn = null;                                        // null로 초기화 한다.
	Statement stmt1 = null; // SQL구문을 실행
	Statement stmt2 = null;
	Statement stmt3 = null;
	ResultSet rs1 = null; // SQL구문의 실행결과를 저장
	ResultSet rs2 = null;
	ResultSet rs3 = null;
	
	try{
		String url = "jdbc:mysql://jjo.kr:33066/boram3jo";        // 사용하려는 데이터베이스명을 포함한 URL 기술
		String id = "boram3jo";                                                    // 사용자 계정
		String pw = "15881009";                                                // 사용자 계정의 패스워드
		String query1 = "select id, title, age from movie";
		Class.forName("com.mysql.jdbc.Driver");                       // 데이터베이스와 연동하기 위해 DriverManager에 등록한다.
		conn=DriverManager.getConnection(url,id,pw);              // DriverManager 객체로부터 Connection 객체를 얻어온다.
		//out.println("제대로 연결되었습니다.");      // 커넥션이 제대로 연결되면 수행된다.
		stmt1 = conn.createStatement(); //statement 생성

		rs1 = stmt1.executeQuery(query1); //쿼리 생성


		}catch(Exception e){// 예외가 발생하면 예외 상황을 처리한다.
		e.printStackTrace();
	}
	
	
	response.setContentType("application/json");

	JSONArray itemList = new JSONArray();


	while(rs1.next()){
		JSONArray scheduleList = new JSONArray();
		JSONObject movieJson = new JSONObject();
	
		movieJson.put("title", rs1.getString("title"));
		movieJson.put("age", rs1.getString("age"));
		
		String movie_id = rs1.getString("id");
		

		String query2 = "select * from movie join timeslot on movie.id = timeslot.movie and movie.id = " + movie_id + " join place on place.id = timeslot.place";
		stmt2 = conn.createStatement();
		rs2 = stmt2.executeQuery(query2);
		
		while(rs2.next()){		
			JSONObject tempJson = new JSONObject();
			
			String str = rs2.getString("starttime");
			String timeslot_id = rs2.getString("timeslot.id");

			
			String date = str.substring(0, 10); //      2020-06-26 까지만 짜름
			String start_time = str.substring(11,16);// 16:00 이렇게 짜름
			tempJson.put("date", date);
			tempJson.put("time", start_time);
			tempJson.put("place", rs2.getString("name"));
			tempJson.put("location", rs2.getString("floor"));
			
			String query3 = "select * from ticket, timeslot where timeslot_id = timeslot.id and timeslot_id = " + timeslot_id +" and movie = " + movie_id;
			stmt3 = conn.createStatement();
			rs3 = stmt3.executeQuery(query3);
			
			JSONArray audience = new JSONArray();
			int count = 0; // 예매 되어있는 좌석 세기
			
			while(rs3.next()){
				count++;
			}
			
			int capacity = Integer.parseInt(rs2.getString("capacity"));
			
			audience.add(count);
			audience.add(capacity);
			
			tempJson.put("audience", audience);
			scheduleList.add(tempJson);
		}
		
		movieJson.put("schedule", scheduleList);
		itemList.add(movieJson);
		
	}

	response.getWriter().write(itemList.toString());
%>
