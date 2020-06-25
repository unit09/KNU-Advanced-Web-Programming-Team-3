package cinema;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class TicketDataHandler {
	private Connection con;
    private ResultSet rs;
    private Statement stmt = null;
    
    public TicketDataHandler() {
    	String dbURL = "jdbc:mysql://jjo.kr:33066/boram3jo?useUnicode=yes&characterEncoding=UTF-8&serverTimezone=UTC";                    
        String dbID = "boram3jo";
        String dbPassword = "15881009";
        
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbURL,dbID,dbPassword);
        }
        catch(Exception e) {
        	System.out.println("find E" + e.getMessage());
        }
    }
    
    public int[] getReserved(int timeslotId) {
    	String sql = "SELECT seat_number FROM ticket WHERE timeslot_id=" + timeslotId;
    	int[] reserved = new int[51];
    	
    	try {
    		stmt = con.createStatement();
    		rs = stmt.executeQuery(sql);
    		
    		if(rs.next()) {    			
    			do {
    				reserved[rs.getInt("seat_number")] = 1;
    			}while(rs.next());
    		}
    		else {
    			reserved = null;
    		}
    	}
    	catch(Exception e) {
        	System.out.println(e.getMessage());
        }
    	
    	return reserved;
    }
    
    public void closeCon() {
    	try {
    		rs.close();
    		stmt.close();
    		con.close();
    	}
    	catch(Exception e) {
    		System.out.println(e.getMessage());
    	}
    }
}
