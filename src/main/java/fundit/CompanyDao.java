package fundit;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
public class CompanyDao {
	String url, username, password;
	Connection con;
	public CompanyDao()
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
	
	public int addCompany(Company c) throws SQLException
	{
		String query="insert into company values(?,?,?,?,?,?,?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);
		
		int number = c.getC_id();

		pst.setInt(1, number);
		pst.setString(2, c.getC_name());
		pst.setInt(3, 0);
		pst.setString(4, c.getDate());
		pst.setInt(5, 0);
		pst.setString(6, c.getCity());
		pst.setString(7, c.getPasswd());
		pst.setInt(8, 100);
		pst.setString(9, c.getCategory());
		pst.setString(10, c.getDescription());
		
		int ra = pst.executeUpdate();
		return number;
	}
	
	public int login(String c_id_temp, String pwd) throws SQLException
	{
		int c_id = Integer.parseInt(c_id_temp);
		String query = "select count(*) as cnt from company where c_id="+c_id+" and passwd='"+pwd+"'";
		Statement st = con.createStatement();
		ResultSet rs = st.executeQuery(query);
		
		rs.next();
		
		if(rs.getInt("cnt")==1)
		{
			return 1;
		}
		
		return 0;
		
	}
	
	public List<Holdings> getHoldings(String c_id_temp) throws SQLException
	{
		int aa = Integer.parseInt(c_id_temp);
		//System.out.println(aa);
		String query = "select * from holdings where c_id = " + aa;
		System.out.println(query);
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
			//System.out.println(h.getAadhar());
			hl.add(h);
			
		}	
		return hl;
	}
	
}
