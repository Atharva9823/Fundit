package fundit;
import java.sql.*;
public class HoldingsDao {
	String url, username, password;
	Connection con;
	public HoldingsDao()
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

}
