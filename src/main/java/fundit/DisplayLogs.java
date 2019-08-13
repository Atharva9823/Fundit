package fundit;

import java.io.IOException;
import java.sql.CallableStatement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class DisplayLogs
 */
public class DisplayLogs extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DisplayLogs() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/fundit","root","mysqlpassword");
			
			int c_id = Integer.parseInt(request.getParameter("C_id"));
			int aadhar = Integer.parseInt(request.getParameter("aadhar"));
			int aadhar_init = Integer.parseInt(request.getParameter("aadhar_init"));
			double stake = Double.parseDouble(request.getParameter("stake"));
			
			
			CallableStatement cs = con.prepareCall("{call check_needs(?,?,?,?)}");
			
			cs.setDouble(1, stake);
			cs.setNull(2, aadhar);
			cs.setInt(3, aadhar_init);
			cs.setInt(4, c_id);
			
			cs.execute();
			
			
			con.close();
			
			
			
			request.setAttribute("cid", c_id);
			request.getRequestDispatcher("companyDetails.jsp").forward(request,  response);
			
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
