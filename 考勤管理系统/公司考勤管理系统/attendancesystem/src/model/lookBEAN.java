package model;

public class lookBEAN {
	private int id;
	private String uid;
	private String infoid;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUid() {
		return uid;
	}
	public void setUid(String uid) {
		this.uid = uid;
	}
	public String getInfoid() {
		return infoid;
	}
	public void setInfoid(String infoid) {
		this.infoid = infoid;
	}
	public lookBEAN(int id, String uid, String infoid) {
		super();
		this.id = id;
		this.uid = uid;
		this.infoid = infoid;
	}
	
}
