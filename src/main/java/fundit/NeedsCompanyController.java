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
 * Servlet implementation class NeedsCompanyController
 */
public class NeedsCompanyController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public NeedsCompanyController() {
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
			 
			System.out.println("cid : " + (String)request.getParameter("c_id") + " Offer : " + (String)request.getParameter("offer") + "Stake : " + (String)request.getParameter("stake") );
			
			int c_id = Integer.parseInt(request.getParameter("c_id"));
			double offer = Double.parseDouble(request.getParameter("offer"));
			double stake;
			String buysell = (String)request.getParameter("buysell");
			
			System.out.println("string is :"+buysell);
			
			int buy, sell;
			
			if(buysell.equals("buy"))
			{
				buy = 1;
				sell = 0;
				stake = Double.parseDouble(request.getParameter("bstake"));
			}
			else
			{
				buy = 0;
				sell = 1;
				stake = Double.parseDouble(request.getParameter("sstake"));
			}
			
			CallableStatement cs = con.prepareCall("{call insert_needs(?,?,?,?,?,?)}");
			
			cs.setInt(1, c_id);
			cs.setNull(2, 0);
			cs.setInt(3, buy);
			cs.setInt(4, sell);
			cs.setDouble(5, stake);
			cs.setDouble(6, offer);
			
			cs.execute();
			
			con.close();
			
			request.getRequestDispatcher("companyAdmin.jsp").forward(request,  response);
			
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
