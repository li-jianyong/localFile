package model;

public class sysuserBEAN {
	private int id;
	private String uname;
	private String upass;
	private String utype;
	private String truename;
	private String phone;
	private String status;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUname() {
		return uname;
	}
	public void setUname(String uname) {
		this.uname = uname;
	}
	public String getUpass() {
		return upass;
	}
	public void setUpass(String upass) {
		this.upass = upass;
	}
	public String getUtype() {
		return utype;
	}
	public void setUtype(String utype) {
		this.utype = utype;
	}
	public String getTruename() {
		return truename;
	}
	public void setTruename(String truename) {
		this.truename = truename;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public sysuserBEAN(int id, String uname, String upass, String utype,
			String truename, String phone, String status) {
		super();
		this.id = id;
		this.uname = uname;
		this.upass = upass;
		this.utype = utype;
		this.truename = truename;
		this.phone = phone;
		this.status = status;
	}
	
}
