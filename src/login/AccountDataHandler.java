package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class AccountDataHandler {
	
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
				String sql = "CREATE TABLE ACCOUNT (NO INTEGER NOT NULL AUTO_INCREMENT, NAME VARCHAR(20), id VARCHAR(20), pw VARCHAR(20), email VARCHAR(20), PRIMARY KEY (NO))";
				stmt.executeUpdate(sql);
			}

			//account 테이블에 회원 정보 기입
			String sql = String.format("INSERT INTO account (name, id, pw, email) VALUES ('%s', '%s', '%s', '%s')", name, id, pw, email);
			System.out.println("회원 정보 기입 성공: " + sql);
			stmt.executeUpdate(sql);
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
			stmt.close();
			rs.close();
			con.close();
		} catch (SQLException e) {}
	}	
}