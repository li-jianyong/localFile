package model;

public class newsBEAN {
	private int id;
	private String content;
	private String savetime;
	private String filename;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSavetime() {
		return savetime;
	}
	public void setSavetime(String savetime) {
		this.savetime = savetime;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public newsBEAN(int id, String content, String savetime, String filename) {
		super();
		this.id = id;
		this.content = content;
		this.savetime = savetime;
		this.filename = filename;
	}
	
}
