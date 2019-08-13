package fundit;

public class Investor {
	private String name, email, ipasswd, dob;
	private int aadhar;
	private double icapital;
	
	public Investor()
	{
		name="";
		email="";
		ipasswd="";
		dob="";
		aadhar=0;
		icapital=0;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getIpasswd() {
		return ipasswd;
	}
	public void setIpasswd(String ipasswd) {
		this.ipasswd = ipasswd;
	}
	public String getDob() {
		return dob;
	}
	public void setDob(String dob) {
		this.dob = dob;
	}
	public int getAadhar() {
		return aadhar;
	}
	public void setAadhar(int aadhar) {
		this.aadhar = aadhar;
	}
	public double getIcapital() {
		return icapital;
	}
	public void setIcapital(double icapital) {
		this.icapital = icapital;
	}
	
	
}
