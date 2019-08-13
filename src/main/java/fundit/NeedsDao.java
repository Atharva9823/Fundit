package fundit;
import java.sql.*;
public class NeedsDao {
	String url, username, password;
	Connection con;
	public NeedsDao()
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
	
	public int addNeeds(Needs n) throws SQLException
	{
		String query="insert into needs values(?,?,?,?,?,?)";
		PreparedStatement pst = con.prepareStatement(query);
		
		pst.setInt(1, n.getC_id());
		pst.setInt(2, n.getAadhar());
		pst.setBoolean(3, n.isBuy());
		pst.setBoolean(4, n.isSell());
		pst.setDouble(5, n.getStake());
		pst.setDouble(6, n.getOffer());
		
		int ra = pst.executeUpdate();
		System.out.println(ra);
		return ra;
	}
	
}
