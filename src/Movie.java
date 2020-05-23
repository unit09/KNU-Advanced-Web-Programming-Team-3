
public class Movie {
	private int id;
	private String title;
	private String genre;
	private double rating;
	private int runningTime;
	private String director;
	private String actors;
	private String plot;
	private String posterURL;
	
	public Movie(int id, String title, String genre, double rating, int runningTime, 
					String director, String actors, String plot, String posterURL) {
		this.id = id;
		this.title = title;
		this.genre = genre;
		this.rating = rating;
		this.runningTime = runningTime;
		this.director = director;
		this.actors = actors;
		this.plot = plot;
		this.posterURL = posterURL;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public double getRating() {
		return rating;
	}

	public void setRating(double rating) {
		this.rating = rating;
	}

	public int getRunningTime() {
		return runningTime;
	}

	public void setRunningTime(int runningTime) {
		this.runningTime = runningTime;
	}

	public String getDirector() {
		return director;
	}

	public void setDirector(String director) {
		this.director = director;
	}

	public String getActors() {
		return actors;
	}

	public void setActors(String actors) {
		this.actors = actors;
	}

	public String getPlot() {
		return plot;
	}

	public void setPlot(String plot) {
		this.plot = plot;
	}

	public String getPosterURL() {
		return posterURL;
	}

	public void setPosterURL(String posterURL) {
		this.posterURL = posterURL;
	}
	
	
}
