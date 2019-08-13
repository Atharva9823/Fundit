package fundit;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 * Servlet implementation class companyLoginServlet
 */
public class companyLoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public companyLoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//doGet(request, response);
		
		CompanyDao c = new CompanyDao();
		try {
			c.connect();
			int k = c.login(request.getParameter("c_id"), request.getParameter("psswrd"));
			
			if(k==1)
			{
				String e = request.getParameter("c_id");
				//List<Holdings> hl = new ArrayList<Holdings>();
				//hl = i.getHoldings(request.getParameter("EMAIL"));
				HttpSession se = request.getSession();
				se.setAttribute("login_status", e);
				//request.setAttribute("holdings", hl);
				request.setAttribute("eMail", e);
				request.getRequestDispatcher("companyAdmin.jsp").forward(request, response);
			}
			else
			{
				HttpSession se = request.getSession();
				se.setAttribute("login_status", "failed");
				request.getRequestDispatcher("clogin.jsp").forward(request, response);
				
			}
			c.disconnect();
		}catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
