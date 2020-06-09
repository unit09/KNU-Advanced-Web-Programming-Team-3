package cinema;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class MovieDataHandler {
	private Connection con;
    private ResultSet rs;
    private Statement stmt = null;
    
    public MovieDataHandler() {
    	String dbURL = "jdbc:mysql://localhost:3306/cinema_db?useUnicode=yes&characterEncoding=UTF-8&serverTimezone=UTC";                    
        String dbID = "test";
        String dbPassword = "test";
        
        try {
        	Class.forName("com.mysql.cj.jdbc.Driver");
            con = DriverManager.getConnection(dbURL,dbID,dbPassword);
        }
        catch(Exception e) {
        	System.out.println("find E" + e.getMessage());
        }
    }
    
    public Movie[] getMovies() {
    	String sql = "SELECT * FROM movie";
    	Movie[] movies = new Movie[20];
    	
    	try {
    		stmt = con.createStatement();
    		rs = stmt.executeQuery(sql);
    		
    		if(rs.next()) {
    			int i = 1;
    			
    			do {
    				Movie temp = new Movie(i, rs.getString("title"), rs.getString("genre"), 
    										rs.getDouble("rating"), rs.getInt("runtime"), 
    										rs.getString("director"), rs.getString("actors"), 
    										rs.getString("plot"), rs.getString("posterURL"));
    				movies[i - 1] = temp;
    				i++;
    			}while(rs.next());
    		}
    		else {
    			movies = null;
    		}
    	}
    	catch(Exception e) {
        	System.out.println(e.getMessage());
        }
    	
    	return movies;
    }
    
    public void sendMovies(Movie[] movies) {
    	String sql = "insert into movie values ";
    	
    	for(int i = 0; i < movies.length; i++) {
    		sql += "(" + movies[i].getId() + ",\"" + movies[i].getTitle() + "\",\"" + movies[i].getGenre() + "\"," 
    				+ movies[i].getRating() + "," + movies[i].getRunningTime() + ",\"" + movies[i].getDirector()
    				+ "\",\"" + movies[i].getActors() + "\",\"" + movies[i].getPlot() + "\",\""
    				+ movies[i].getPosterURL() + "\")";
    		
    		if(i != movies.length - 1) {
    			sql += ",";
    		}
    	}
    	
    	try {
    		int result = stmt.executeUpdate(sql);
        	System.out.println(result + " row inserted");
    	}
    	catch(Exception e) {
        	System.out.println(e.getMessage());
        }
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
