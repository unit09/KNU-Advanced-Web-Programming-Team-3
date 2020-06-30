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
			//db�� ���� ��� (���� ����)
			System.out.println("[����!] db�� �����ϴ�. mysql�� �����ϰ� CREATE DATABASE cinema_db; ��ɾ�� db�� �����ϼ���.");
		}
	}

	public void signup(String name, String id, String pw, String email) { //ȸ������ ���н� -1 ��ȯ
		try {
			java.sql.DatabaseMetaData meta = con.getMetaData();
			rs = meta.getTables(null, null, "account", null);
			
			if(!rs.next()) { //account ���̺� ������ ���̺� ����
				String sql = "CREATE TABLE account (NO INTEGER NOT NULL AUTO_INCREMENT, NAME VARCHAR(20), id VARCHAR(20), pw VARCHAR(20), email VARCHAR(20), PRIMARY KEY (NO))";
				stmt.executeUpdate(sql);
			}

			//account ���̺� ȸ�� ���� ����
			String sql = String.format("INSERT INTO account (name, id, pw, email) VALUES ('%s', '%s', '%s', '%s')", name, id, pw, email);
			stmt.executeUpdate(sql);
			System.out.println("ȸ�� ���� ���� ����: " + sql);
		} catch (Exception e) {
			System.out.println("ȸ�� ���� ���� ����: " + e);
		}
	}
	
	public boolean login(String id, String pw) {
		try {
			String sql = String.format("SELECT * FROM account WHERE id='%s' && pw='%s'", id, pw);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) { //id, pw ��ġ�ϴ� ���� ����
				
				System.out.println(id + " �α��ο� �����Ͽ����ϴ�.");
				
				return true;
				
			} else { //���� ���� ���� ����
				
				System.out.println(id + " �α��� �����Ͽ����ϴ�.");
				
				return false;
				
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return false;
	}
	
	//id�� �ָ� ����� ������ ��ȯ (���� id�� null ��ȯ)
	public String getUserName(String id) {
		try {
			String sql = String.format("SELECT * FROM account WHERE id='%s'", id);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) { //id ����
				return rs.getString("name");
			} else { //id ������ (null ��ȯ)
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
	
	//id�� �ָ� email�� ��ȯ (���� id�� null ��ȯ)
	public String getEmail(String id) {
		try {
			String sql = String.format("SELECT * FROM account WHERE id='%s'", id);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) { //id ����
				return rs.getString("email");
			} else { //id ������ (null ��ȯ)
				return null;
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		
		return null;
	}
	
	//����� ��ȭ�� ������ �� ArrayList<HashMap> ��ȯ, �������� null ��ȯ (userId�� session.getAttribute("userId")�� ���ؼ� ���� �� ����)
	public ArrayList<HashMap<String, String>> getAllReservations(String userId) {
		ArrayList<HashMap<String, String>> list = new ArrayList<HashMap<String, String>>();
		
		try {
			String sql = String.format("select title, starttime, seat_number, date, posterURL, ts.id from ticket t, timeslot ts, movie m where t.user_id=\"%s\" and m.id = ts.movie and ts.id = t.timeslot_id;", userId);
			rs = stmt.executeQuery(sql);
			
			while(rs.next()) { //����� ��ȭ ����
				
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("title", rs.getString("title"));
				map.put("starttime", rs.getString("starttime"));
				map.put("seat_number", rs.getString("seat_number"));
				map.put("date", rs.getString("date"));
				map.put("posterURL", rs.getString("posterURL"));
				map.put("timeslotId", rs.getString("id"));
				
				list.add(map);
			}
		} catch(Exception e) {
			System.out.println("����� ��ȭ�� �ҷ����µ� �����Ͽ����ϴ�.");
			return null;
		}
		
		return list;
	}
	
	//���̵� �ߺ� üũ true�� �ߺ� ����, false�� �ߺ� ����
	public boolean idCheck(String id) {
		if(id == "" || id == null) {
			return false;
		}
		
		try {
			String sql = String.format("select * from account where id='%s'", id);
			rs = stmt.executeQuery(sql);
			
			if(rs.next()) { //�ߺ��Ǵ� ���̵� ����
				return false;
			}
		} catch (Exception e) {
			// TODO: handle exception
			return false;
		}
		
		
		return true;
	}
	
	//��й�ȣ ����
	public void setPw(String userId, String newPw) {
		try {
			String sql = String.format("UPDATE account SET pw=\"%s\" WHERE id=\"%s\";", newPw, userId);
			stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println(e);
		}
	}
	
}
