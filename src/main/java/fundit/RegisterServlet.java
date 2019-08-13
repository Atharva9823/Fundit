package fundit;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class RegisterServlet
 */
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
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
		CompanyDao cm = new CompanyDao();
		Company c = new Company();
		c.setC_id(Integer.parseInt(request.getParameter("pan")));
		c.setC_name(request.getParameter("cname"));
		c.setCity(request.getParameter("city"));
		c.setDate(request.getParameter("founding"));
		c.setCategory(request.getParameter("categ"));
		c.setDescription(request.getParameter("desc"));
		c.setPasswd(request.getParameter("psswrd"));
		
		String cp = request.getParameter("cpsswrd");
		
		try {
			if(c.getPasswd().equals(cp))
			{
				cm.connect();
				int cid= cm.addCompany(c);
				cm.disconnect();
				
				request.setAttribute("c_id", cid);
				request.getRequestDispatcher("success.jsp").forward(request,  response);
				
			}
			
			else
			{
				request.getRequestDispatcher("register.jsp").forward(request,  response);
			}
		}	 		catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
	}

}
