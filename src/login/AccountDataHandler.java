package login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import com.mysql.cj.jdbc.DatabaseMetaData;
import com.mysql.cj.xdevapi.PreparableStatement;

import cinema.Movie;

public class AccountDataHandler {
	private static final String key = "b451a27758c56f8e4861cde4c174919f";
	
	private Connection con;
	private ResultSet rs;
	private Statement stmt;

	public AccountDataHandler() {
		String dbURL = "jdbc:mysql://localhost:3306/cinema_db?useUnicode=yes&characterEncoding=UTF-8&serverTimezone=UTC";                    
		String dbID = "test";
		String dbPassword = "test";
		
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
    
//    public MovieDataHandler() {
//    	String dbURL = "jdbc:mysql://localhost:3306/cinema_db?useUnicode=yes&characterEncoding=UTF-8&serverTimezone=UTC";                    
//        String dbID = "test";
//        String dbPassword = "test";
//        
//        try {
//        	Class.forName("com.mysql.cj.jdbc.Driver");
//            con = DriverManager.getConnection(dbURL,dbID,dbPassword);
//        }
//        catch(Exception e) {
//        	System.out.println("find E" + e.getMessage());
//        }
//    }
//    
//    public Movie[] getMovies() {
//    	String sql = "SELECT * FROM movie";
//    	Movie[] movies = new Movie[20];
//    	
//    	try {
//    		stmt = con.createStatement();
//    		rs = stmt.executeQuery(sql);
//    		
//    		if(rs.next()) {
//    			int i = 1;
//    			
//    			do {
//    				Movie temp = new Movie(i, rs.getString("title"), rs.getString("genre"), 
//    										rs.getDouble("rating"), rs.getInt("runtime"), 
//    										rs.getString("director"), rs.getString("actors"), 
//    										rs.getString("plot"), rs.getString("posterURL"));
//    				movies[i - 1] = temp;
//    				i++;
//    			}while(rs.next());
//    		}
//    		else {
//    			movies = null;
//    		}
//    	}
//    	catch(Exception e) {
//        	System.out.println(e.getMessage());
//        }
//    	
//    	return movies;
//    }
//    
//    public void sendMovies(Movie[] movies) {
//    	String sql = "insert into movie values ";
//    	
//    	for(int i = 0; i < movies.length; i++) {
//    		sql += "(" + movies[i].getId() + ",\"" + movies[i].getTitle() + "\",\"" + movies[i].getGenre() + "\"," 
//    				+ movies[i].getRating() + "," + movies[i].getRunningTime() + ",\"" + movies[i].getDirector()
//    				+ "\",\"" + movies[i].getActors() + "\",\"" + movies[i].getPlot() + "\",\""
//    				+ movies[i].getPosterURL() + "\")";
//    		
//    		if(i != movies.length - 1) {
//    			sql += ",";
//    		}
//    	}
//    	
//    	try {
//    		int result = stmt.executeUpdate(sql);
//        	System.out.println(result + " row inserted");
//    	}
//    	catch(Exception e) {
//        	System.out.println(e.getMessage());
//        }
//    }
//    
//    public void closeCon() {
//    	
//    }
	
}
