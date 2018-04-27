package model;

public class noticeBEAN {
	private int id;
	private String title;
	private String content;
	private String savetime;
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
	public noticeBEAN(int id, String title, String content, String savetime) {
		super();
		this.id = id;
		this.title = title;
		this.content = content;
		this.savetime = savetime;
	}
	
}
