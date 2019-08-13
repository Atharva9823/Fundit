package fundit;

import java.util.*;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class LoginServlet
 */
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
//		doGet(request, response);
		
		InvestorDao i = new InvestorDao();
		try {
			i.connect();
			int k = i.login(request.getParameter("EMAIL"), request.getParameter("PASSWORD"));
			
			if(k==1)
			{
				String e = request.getParameter("EMAIL");
				//List<Holdings> hl = new ArrayList<Holdings>();
				//hl = i.getHoldings(request.getParameter("EMAIL"));
				HttpSession se = request.getSession();
				se.setAttribute("login_status", e);
				//request.setAttribute("holdings", hl);
				request.setAttribute("eMail", e);
				request.getRequestDispatcher("investor.jsp").forward(request, response);
			}
			else
			{
				HttpSession se = request.getSession();
				se.setAttribute("login_status", "failed");
				request.getRequestDispatcher("login.jsp").forward(request, response);
				
			}
			i.disconnect();
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}

}
