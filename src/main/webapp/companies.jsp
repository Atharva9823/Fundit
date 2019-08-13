<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>

<%@page import="fundit.Company"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="style.css">
    <link rel="stylesheet" type="text/css" href="companygrid.css">
    <title>
		mini project
	</title>
</head>
<body>



<%
int count = 0;
List<Company> cl = new ArrayList<Company>();
Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/fundit","root","mysqlpassword");
String query = "select * from company";
Statement st = con.createStatement();
ResultSet rs = st.executeQuery(query);
while(rs.next())
{
	Company c = new Company();
	c.setC_id(rs.getInt("c_id"));
	c.setC_name(rs.getString("c_name"));
	c.setCity(rs.getString("city"));
	c.setValuation(rs.getDouble("valuation"));
	c.setDate(rs.getString("founded"));
	c.setStake(rs.getDouble("stake"));
	c.setDescription(rs.getString("description"));
	cl.add(c);
	count++;
}
rs.close();


int i = 0;


String login_status = new String();
login_status = "";
HttpSession se = request.getSession();
if(se.isNew())
	se.setAttribute("login_status", "");
else
	login_status = (String)se.getAttribute("login_status");

String log_status = "";

if(!login_status.equals("") ) 
{
	if(login_status.length() == 5)
	{
	int status = Integer.parseInt(login_status);
	String query2 = "select * from company where c_id = " + status;
	Statement st2 = con.createStatement();
	ResultSet rs2 = st.executeQuery(query2);
	
	rs2.next();
	log_status = rs2.getString("c_name");
	rs2.close();
	}
	else
	{
		int status = Integer.parseInt(login_status);
		String query2 = "select * from investor where aadhar = " + status;
		Statement st2 = con.createStatement();
		ResultSet rs2 = st.executeQuery(query2);
		
		rs2.next();
		log_status = rs2.getString("name");
		rs2.close();
	}
}

con.close();

%>

	<table class="navbar">
		<tr>
			<td id="logo"><img src="it2.png">&nbsp;&nbsp;fund<b>IT</b></td>
			<td style="border-bottom: 3px solid transparent"><a href="index.jsp">Home</a></td>
			<td style="border-bottom: 3px solid #189AD3"><a href="companies.jsp">Startups</a></td>
			<td style="border-bottom: 3px solid transparent"><a>Support</a></td>
			<td style="border-bottom: 3px solid transparent"><a>About</a></td>
			<td style="border-bottom: 3px solid transparent">
			<a href="<% if(login_status.equals(""))
							out.println("login.jsp");
						else if(login_status.length() == 5)
							out.println("companyAdmin.jsp");
						else
							out.println("investor.jsp");
					 %>">
			<% if(!login_status.equals(""))
				{
					out.println(log_status); 			
				}
				else 
					out.println("Login");
			%>
			</a></td> 
		</tr>
    </table>
    <h1 style="margin: 20px;text-align:center;font-family:roboto;font-size:50px;">Startups</h1>
    
    	<table class="top_cmp">
	<%for(i=0;i<count;i++) { %>
	<%if(i%4 == 0) { %>
		<tr>
			<td>
				<div class="cmpname">
					<img src="computeit.png" class="cmplogo">
					<p><%= cl.get(i).getC_name() %></p>
				</div>
				<div class="cmpdet">
				<div class="prbar_cmp1"><div  style="width:<%= 100 - (cl.get(i).getStake())%>%;"></div></div>
				<em><%= 100 - cl.get(i).getStake() %> Owned</em><br><br>
				<%= cl.get(i).getDescription() %>
				<br>
				
				<form action="companyRedirect" method="post" >
				<input type="hidden" name="companyID" value="<%=cl.get(i).getC_id() %>">
				<button type="submit" class="knowmore">Invest</button>
				</form>
				</div>
			</td>
		
		<%} else if((i+1)%4 == 0) {%>
			<td>
				<div class="cmpname">
					<img src="computeit.png" class="cmplogo">
					<p><%= cl.get(i).getC_name() %></p>
				</div>
				<div class="cmpdet">
				<div class="prbar_cmp1"><div  style="width:<%= 100 - (cl.get(i).getStake())%>%;"></div></div>
				<em><%= 100 - cl.get(i).getStake() %> Owned</em><br><br>
				<%= cl.get(i).getDescription() %>
				<br>
				
				<form action="companyRedirect" method="post" >
				<input type="hidden" name="companyID" value="<%=cl.get(i).getC_id() %>">
				<button type="submit" class="knowmore">Invest</button>
				</form>
				
				</div>
			</td>
			</tr>
			
		<%} else { %>
			<td>
				<div class="cmpname">
					<img src="computeit.png" class="cmplogo">
					<p><%= cl.get(i).getC_name() %></p>
				</div>
				<div class="cmpdet">
				<div class="prbar_cmp1"><div  style="width:<%= 100 - (cl.get(i).getStake())%>%;"></div></div>
				<em><%= 100 - cl.get(i).getStake() %> Owned</em><br><br>
				<%= cl.get(i).getDescription() %>
				<br>
				
				<form action="companyRedirect" method="post" >
				<input type="hidden" name="companyID" value="<%=cl.get(i).getC_id() %>">
				<button type="submit" class="knowmore">Invest</button>
				</form>
												
				</div>
				
			</td>
		<%} }%>
		</table>
    
    <footer>
        <div class="foot">
            <ul>
                <li style="border: 2px solid transparent; border-bottom: 2px solid gray; ">ABOUT US</li>
                <br>
                <li><a href="#">Team</a></li>
                <li><a href="#">Project infinite</a></li>
            </ul>
    
            <ul>
                <li style="border: 2px solid transparent; border-bottom: 2px solid gray; ">CONTRIBUTIONS</li>
                <br>		
                <li>Contributer 1</li>
                <li>Other</li>
            </ul>
            
            <ul class="social_links">
                <li style="border: 2px solid transparent; border-bottom: 2px solid gray; ">FOLLOW US</li>
                <br>
                <li>
                    <img style="width: 32px;" src="facebook.png">
                    <img style="width: 32px;" src="twitter.png">
                    <img style="width: 32px;" src="insta.png">
                </li>
                
            </ul>
            
        </div>
    </footer>
</body>

</html>