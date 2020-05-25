package api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import cinema.Movie;

public class APIHandler {
	private static final String key = "b451a27758c56f8e4861cde4c174919f";
	
	public static Movie[] getAPI() {
		String result = "";
		Movie[] movies = new Movie[20];
		
		try {
			URL pageUrl = new URL("https://api.themoviedb.org/3/discover/movie?api_key="
					+ key
					+ "&language=ko-KR&sort_by=popularity.desc&include_adult=false&include_video=false"
					+ "&page=1&primary_release_date.gte=2019-09-01");
			
			result = getJSON(pageUrl);
            
            JSONParser jsonParser = new JSONParser();
            JSONObject jsonObject = (JSONObject)jsonParser.parse(result);
            JSONArray jsonArray = (JSONArray)jsonObject.get("results");
            
            for(int i = 0; i < jsonArray.size(); i++) {
            	JSONObject tempObject = (JSONObject)jsonArray.get(i);
            	Movie tempMovie = new Movie(i + 1);
            	
            	tempMovie.setTitle((String)tempObject.get("title"));
            	if(tempObject.get("vote_average") instanceof Long) {
            		tempMovie.setRating(((Long)tempObject.get("vote_average")).doubleValue());
            	}
            	else {
            		tempMovie.setRating((double)tempObject.get("vote_average"));
            	}            	
            	tempMovie.setPlot((String)tempObject.get("overview"));
            	tempMovie.setPosterURL("https://image.tmdb.org/t/p/w500" + tempObject.get("poster_path"));
            	
            	URL detailUrl = new URL("https://api.themoviedb.org/3/movie/" + tempObject.get("id") 
            							+ "?language=ko-KR&api_key=" + key);

            	String temp1 = getJSON(detailUrl);
            	JSONObject detail = (JSONObject)jsonParser.parse(temp1);
            	
            	JSONArray genres = (JSONArray)detail.get("genres");
            	String gTemp = "";
            	for(int j = 0; j < genres.size(); j++) {
            		gTemp += (String)((JSONObject)genres.get(j)).get("name") + " ";
            	}
            	tempMovie.setGenre(gTemp);
            	tempMovie.setRunningTime(((Long)detail.get("runtime")).intValue());
            	
            	URL creditUrl = new URL("https://api.themoviedb.org/3/movie/" + tempObject.get("id")
            							+ "/credits?&api_key=" + key);
            	
            	String temp2 = getJSON(creditUrl);            	
            	JSONObject credit = (JSONObject)jsonParser.parse(temp2);
            	
            	JSONArray actors = (JSONArray)credit.get("cast");
            	String aTemp = "";
            	for(int j = 0; j < actors.size(); j++) {
            		if(j > 5) {
            			break;
            		}
            		
            		aTemp += (String)((JSONObject)actors.get(j)).get("name") + ", ";
            	}
            	tempMovie.setActors(aTemp);
            	
            	JSONArray crews = (JSONArray)credit.get("crew");
            	for(int j = 0; j < crews.size(); j++) {
            		if(((String)((JSONObject)crews.get(j)).get("job")).equals("Director")) {
            			tempMovie.setDirector((String)((JSONObject)crews.get(j)).get("name"));
            			break;
            		}
            	}
            	
            	movies[i] = tempMovie;
            }
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return movies;
	}
	
	private static String getJSON(URL url) {
		String result = "";
		BufferedReader br = null;
		
		try {
			HttpURLConnection con = (HttpURLConnection)url.openConnection();
			con.setRequestMethod("GET");
			
			br = new BufferedReader(new InputStreamReader(con.getInputStream(),"UTF-8"));
			
			String line;
	        while((line = br.readLine()) != null) {
	            result = result + line + "\n";
	        }
		}
		catch(Exception e) {
			System.out.println(e.getMessage());
		}
		
		return result;
	}
}
