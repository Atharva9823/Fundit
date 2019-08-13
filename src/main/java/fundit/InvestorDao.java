package fundit;
import java.sql.*;

import java.util.*;
public class InvestorDao {
	String url, username, password;
	Connection con;
	public InvestorDao()
	{
		url="jdbc:mysql://localhost:3306/fundit";
		username="root";
		password="mysqlpassword";
		
	}
	
	public void connect() throws ClassNotFoundException, SQLException
	{
		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection("jdbc:mysql://localhost:3306/fundit","root","mysqlpassword");
	}
	
	public void disconnect() throws SQLException
	{
		con.close();
	}
	
	public int addInvestor(Investor i) throws SQLException
	{
		String query="insert into investor values(?,?,?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);
		
		pst.setInt(1, i.getAadhar());
		pst.setString(2, i.getName());
		pst.setString(3, i.getDob());
		pst.setString(4, i.getEmail());
		pst.setString(5, i.getIpasswd());
		pst.setDouble(6, i.getIcapital());
		
		int ra = pst.executeUpdate();
		return ra;
	}
	
	public int login(String a, String pwd) throws SQLException
	{
		String query = "select count(*) as cnt from investor where aadhar=" + Integer.parseInt(a) + " and ipasswd='"+pwd+"'";
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		rs.next();
		
		if(rs.getInt("cnt")==1)
		{
			return 1;
		}
		return 0;
	}
	
	public int GetAadhar(String email) throws SQLException {
		String query = "select aadhar from investor where email = '" + email + "'";
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		rs.next();
		int aa = rs.getInt("aadhar");
		rs.close();
		return aa;
	}
	
	public List<Holdings> getHoldings(int aa) throws SQLException
	{
		//int aa = GetAadhar(email);
		String query = "select * from holdings where aadhar = " + aa;
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		List<Holdings> hl= new ArrayList<Holdings>();
		while(rs.next())
		{
			Holdings h = new Holdings();
			h.setAadhar(rs.getInt("aadhar"));
			h.setC_id(rs.getInt("c_id"));
			h.setDate(rs.getString("bond_date"));
			h.setStake(rs.getDouble("stake"));
			h.setBond_val(rs.getDouble("bond_val"));
			h.setOffer(rs.getDouble("offer"));
			hl.add(h);
			
		}	
		return hl;
	}
	
	
	
}
