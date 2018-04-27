package model;

public class msgBEAN {
	private int id;
	private String content;
	private String savetime;
	private String oper;
	private String infoid;
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
	public String getOper() {
		return oper;
	}
	public void setOper(String oper) {
		this.oper = oper;
	}
	public String getInfoid() {
		return infoid;
	}
	public void setInfoid(String infoid) {
		this.infoid = infoid;
	}
	public msgBEAN(int id, String content, String savetime, String oper,
			String infoid) {
		super();
		this.id = id;
		this.content = content;
		this.savetime = savetime;
		this.oper = oper;
		this.infoid = infoid;
	}
	
}
