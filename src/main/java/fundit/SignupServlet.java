package fundit;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class SignupServlet
 */
public class SignupServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SignupServlet() {
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
		InvestorDao m = new InvestorDao();
		Investor i = new Investor();
		i.setAadhar(Integer.parseInt(request.getParameter("AADHAR")));
		i.setEmail(request.getParameter("EMAIL"));
		i.setIcapital(Integer.parseInt(request.getParameter("ICAPITAL")));
		i.setIpasswd(request.getParameter("PASSWORD"));
		i.setName(request.getParameter("FIRSTNAME"));
		i.setDob(request.getParameter("DOB"));
		
		String cp = request.getParameter("CPASSWORD");
		
		try {
			if(i.getIpasswd().equals(cp))
			{
				m.connect();
				m.addInvestor(i);
				m.disconnect();
				
			}
		}	 		catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		request.getRequestDispatcher("login.jsp").forward(request,  response);

	}

}
