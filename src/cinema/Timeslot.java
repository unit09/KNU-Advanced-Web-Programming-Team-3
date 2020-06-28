package cinema;

public class Timeslot {
	private int id;
	private String title;
	private String placeName;
	private int floor;
	private String startTime;
	
	public Timeslot(int id, String title, String placeName, int floor, String startTime) {
		this.id = id;
		this.title = title;
		this.placeName = placeName;
		this.floor = floor;
		this.startTime = startTime;
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
	public String getPlaceName() {
		return placeName;
	}
	public void setPlaceName(String placeName) {
		this.placeName = placeName;
	}
	public int getFloor() {
		return floor;
	}
	public void setFloor(int floor) {
		this.floor = floor;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}	
}
