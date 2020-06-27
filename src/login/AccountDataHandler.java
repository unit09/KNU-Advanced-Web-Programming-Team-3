package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import com.mysql.cj.jdbc.DatabaseMetaData;
import com.mysql.cj.xdevapi.PreparableStatement;

import cinema.Movie;

public class AccountDataHandler {
	private static final String key = "b451a27758c56f8e4861cde4c174919f";
	
	private Connection con;
	private ResultSet rs;
	private Statement stmt;

	public AccountDataHandler() {
		String dbURL = "jdbc:mysql://jjo.kr:33066/boram3jo?useUnicode=yes&characterEncoding=UTF-8&serverTimezone=UTC";                    
		String dbID = "boram3jo";
		String dbPassword = "15881009";
		
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			con = DriverManager.getConnection(dbURL,dbID,dbPassword);
			stmt = con.createStatement();
		} catch(Exception e) {
			//db가 없는 경우 (최초 실행)
			System.out.println("[에러!] db가 없습니다. mysql을 실행하고 CREATE DATABASE cinema_db; 명령어로 db를 생성하세요.");
		}
	}

	public void signup(String name, String id, String pw, String email) { //회원가입 실패시 -1 반환
		try {
			java.sql.DatabaseMetaData meta = con.getMetaData();
			rs = meta.getTables(null, null, "account", null);
			
			if(!rs.next()) { //account 테이블 없으면 테이블 생성
				String sql = "CREATE TABLE account (NO INTEGER NOT NULL AUTO_INCREMENT, NAME VARCHAR(20), id VARCHAR(20), pw VARCHAR(20), email VARCHAR(20), PRIMARY KEY (NO))";
				stmt.executeUpdate(sql);
			}

			//account 테이블에 회원 정보 기입
			String sql = String.format("INSERT INTO account (name, id, pw, email) VALUES ('%s', '%s', '%s', '%s')", name, id, pw, email);
			stmt.executeUpdate(sql);
			System.out.println("회원 정보 기입 성공: " + sql);
		} catch (Exception e) {
			System.out.println("회원 정보 기입 실패: " + e);
		}
	}
	
	public boolean login(String id, String pw) {
		try {
			String sql = String.format("SELECT * FROM account WHERE id='%s' && pw='%s'", id, pw);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) { //id, pw 일치하는 계정 존재
				
				System.out.println(id + " 로그인에 성공하였습니다.");
				
				return true;
				
			} else { //계정 존재 하지 않음
				
				System.out.println(id + " 로그인 실패하였습니다.");
				
				return false;
				
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return false;
	}
	
	//id를 주면 사용자 본명을 반환 (없는 id면 null 반환)
	public String getUserName(String id) {
		try {
			String sql = String.format("SELECT * FROM account WHERE id='%s'", id);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) { //id 존재
				return rs.getString("name");
			} else { //id 미존재 (null 반환)
				return null;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return null;
	}
	
	public void close() {
		try {
			if(stmt != null) stmt.close();
			if(rs != null) rs.close();
			if(con != null) con.close();
		} catch (Exception e) {}
	}
	
	//id를 주면 email을 반환 (없는 id면 null 반환)
	public String getEmail(String id) {
		try {
			String sql = String.format("SELECT * FROM account WHERE id='%s'", id);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) { //id 존재
				return rs.getString("email");
			} else { //id 미존재 (null 반환)
				return null;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return null;
	}
	
	//예약된 영화가 없으면 빈 ArrayList<HashMap> 반환, 에러나면 null 반환 (userId는 session.getAttribute("userId")를 통해서 얻을 수 있음)
	public ArrayList<HashMap<String, String>> getAllReservations(String userId) {
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		
		try {
			String sql = String.format("select title, starttime, seat_number, date, posterURL from ticket t, timeslot ts, movie m where t.user_id=\"%s\" and m.id = ts.movie and ts.id = t.timeslot_id;", userId);
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) { //예약된 영화 존재
				
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("title", rs.getString("title"));
				map.put("starttime", rs.getString("starttime"));
				map.put("seat_number", rs.getString("seat_number"));
				map.put("date", rs.getString("date"));
				map.put("posterURL", rs.getString("posterURL"));
				
				list.add(map);
			}
		} catch(Exception e) {
			System.out.println("예약된 영화를 불러오는데 실패하였습니다.");
			return null;
		}
		
		return list;
	}
	
}
