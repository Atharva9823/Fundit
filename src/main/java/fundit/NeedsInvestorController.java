package fundit;

import java.sql.*;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class NeedsInvestorController
 */
public class NeedsInvestorController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NeedsInvestorController() {
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
			double offer = Double.parseDouble(request.getParameter("Offer"));
			double stake = Double.parseDouble(request.getParameter("stake"));
			
			CallableStatement cs = con.prepareCall("{call insert_needs(?,?,?,?,?,?)}");
			
			
			cs.setInt(1, c_id);
			cs.setInt(2, aadhar);
			cs.setInt(3, 0);
			cs.setInt(4, 1);
			cs.setDouble(5, stake);
			cs.setDouble(6, offer);
			
			cs.execute();
			
			con.close();
			
			request.getRequestDispatcher("investor.jsp").forward(request,  response);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
