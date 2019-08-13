package fundit;

import java.util.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class LogsDao {
	String url, username, password;
	Connection con;
	public LogsDao()
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
	
	public List<Logs> addLogs(int aadhar) throws SQLException
	{
		String query= "select * from logs where aadhar_buy = ? OR aadhar_sell = ?";
		PreparedStatement pst = con.prepareStatement(query);
		
		pst.setInt(1, aadhar);
		pst.setInt(2, aadhar);
		
		ResultSet rs = pst.executeQuery();
		
		List<Logs> ll= new ArrayList<Logs>();
		while(rs.next())
		{
			Logs l = new Logs();
			l.setC_id(rs.getInt("c_id"));
			l.setAadhar_buy(rs.getInt("aadhar_buy"));
			l.setAadhar_sell(rs.getInt("aadhar_sell"));
			l.setStake(rs.getDouble("stake"));
			l.setOffer(rs.getDouble("offer"));
			l.setT_date(rs.getString("t_date"));
			l.setT_time(rs.getString("t_time"));
			ll.add(l);
		}	
		
		return ll;
	}
	
}