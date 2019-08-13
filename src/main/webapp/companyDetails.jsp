<%@page import="java.lang.Math"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@page import="fundit.Investor"%>
<%@page import="fundit.InvestorDao"%>

<%@page import="fundit.Company"%>
<%@page import="fundit.Needs"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<meta charset="ISO-8859-1">
	<link rel="stylesheet" type="text/css" href="style.css">
    <link rel="stylesheet" type="text/css" href="companygrid.css">
    <title>
		mini project
	</title>
</head>
<body>


<%

int Cid= (Integer)request.getAttribute("cid");
int flag = 1;
String log_status = "";

Class.forName("com.mysql.jdbc.Driver");
Connection con=DriverManager.getConnection("jdbc:mysql://localhost:3306/fundit","root","mysqlpassword");

String query = "select * from company where c_id = "+ Cid;
String query2 = "select * from needs where c_id = "+ Cid;

//Company details
Statement st = con.createStatement();
ResultSet rs = st.executeQuery(query);
rs.next();

Company c = new Company();
c.setC_id(rs.getInt("c_id"));
c.setC_name(rs.getString("c_name"));
c.setCity(rs.getString("city"));
c.setValuation(rs.getDouble("valuation"));
c.setDate(rs.getString("founded"));
c.setStake(rs.getDouble("stake"));
c.setDescription(rs.getString("description"));
c.setCategory(rs.getString("category"));
rs.close();

//Needs details
Statement st2 = con.createStatement();
ResultSet rs2 = st2.executeQuery(query2);
List<Needs> nl = new ArrayList<Needs>();
while(rs2.next())
{
	Needs ne = new Needs();
	ne.setAadhar(rs2.getInt("aadhar"));
	ne.setC_id(rs2.getInt("c_id"));
	ne.setBuy(rs2.getBoolean("buy"));
	ne.setSell(rs2.getBoolean("sell"));
	ne.setOffer(rs2.getDouble("offer"));
	ne.setStake(rs2.getDouble("stake"));
	nl.add(ne);
}
rs2.close();


String login_status = new String();
login_status = "";
HttpSession se = request.getSession();
if(se.isNew())
	se.setAttribute("login_status", "");
else
	login_status = (String)se.getAttribute("login_status");

Investor inv = new Investor();

if(login_status.equals(""));
else if(login_status.length() == 5){}
else
{
	InvestorDao i = new InvestorDao();
	String sessionLogin = (String)se.getAttribute("login_status");
	
	String query3 = "select * from investor where aadhar = "+ Integer.parseInt(sessionLogin );
	
	Statement st3 = con.createStatement();
	ResultSet rs3 = st3.executeQuery(query3);
	rs3.next();
	
	log_status = rs3.getString("name");
	inv.setAadhar(rs3.getInt("aadhar"));
	rs3.close();
	
	flag = 2;
}



if(!login_status.equals("") && login_status.length() == 5) 
{
	int status = Integer.parseInt(login_status);
	String query4 = "select * from company where c_id = " + status;
	Statement st4 = con.createStatement();
	ResultSet rs4 = st.executeQuery(query4);

	rs4.next();
	log_status = rs4.getString("c_name");
	rs4.close();
	
	flag = 0;
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
	
	<div class="companyDetails">
	<div class="companyName">
		<img src="computeit.png">
	</div>
	<div class="companyInfo">
		<h1><%= c.getC_name() %></h1>
		<p>
			<%= c.getDescription() %>
		</p>
		<ul>
			<li>Founded on <%= c.getDate() %></li><br>
			<li>Located in <%= c.getCity() %></li><br>
			<li>Valuation : <%= c.getValuation() %></li><br>
			<li>Company Id : <%= c.getC_id() %> </li><br>
			<li>Stake : <%= c.getStake() %>%</li><br>
			<li>Category : <%= c.getCategory() %></li><br>
		</ul>
		<div class="companyfundedbar"><div style="width:<%= 100-c.getStake() %>%;"></div></div>
		<%= 100-c.getStake() %>% Owned.
		
		<br>
		<br><b><h3 style="margin-top: 30px">Needs Table</h3></b>
		<br>
		<table class="stakeTable">
			<tr> 
				<th>Stake Offered</th>
				<th>Offer</th>
				<th>Buy / Sell Quantity</th>
			</tr>
			
		<%
		int comp_present = 0;
		int comp_buy = 0;
		int comp_sell = 0;
		Needs ne;
		
		for(Needs n1 : nl) {
		if((n1.getAadhar()) == 0)
		{
			comp_present = 1;
			break;
		}
		}
		
		for(Needs n2 : nl) {
			if(n2.getAadhar() == 0  && n2.isBuy())
			{
				comp_buy = 1;
				break;
			}
			}
		
		for(Needs n3 : nl) {
			if(n3.getAadhar() == 0 && n3.isSell())
			{
				comp_sell = 1;
				break;
			}
			}

		for(Needs n4 : nl) {
			int aadhar_inv;
			if(login_status.equals("")) {
				aadhar_inv = 0;
				System.out.println("LOLOLOL");

			} else {
				aadhar_inv = inv.getAadhar();


			}

			
			

		%>
			<tr> 
				<td><%=n4.getStake() %></td>
				<td><%=n4.getOffer() %></td>
				<%
				
				double max = Math.min(n4.getStake(), 100-c.getStake());%>
				
				<td><form action="LogsInvestor" method="post">
					<input type="hidden" value=<%=n4.getC_id() %> name="C_id">
					<input type="hidden" value=<%=n4.getAadhar() %> name="aadhar">
					<input type="hidden" value=<%=aadhar_inv %> name="aadhar_init">
					<%if(n4.isBuy()) {%>
						<input type="number" name="stake" min="1" max="<%= max%>">
					<%}else {%>
						<input type="number" name="stake" min="1" max="<%= n4.getStake()%>">
					<% } %>		
					
					<% if(comp_present == 1 && n4.getAadhar() == 0 && flag == 0 ){ %>
						<input type="submit" value="<% if(n4.isBuy()) out.println("Sell"); else out.println("Buy");%>" disabled></form></td>
					<%} else if(comp_present == 1 && n4.getAadhar() == 0 && flag == 2 && n4.isBuy() && comp_sell == 1){ %>
						<input type="submit" value="<% if(n4.isBuy()) out.println("Sell"); else out.println("Buy");%>" disabled></form></td>
					<%} else if(comp_present == 1 && n4.getAadhar() != 0 && flag == 2 && n4.isSell() && comp_sell == 1){ %>
						<input type="submit" value="<% if(n4.isBuy()) out.println("Sell"); else out.println("Buy");%>" disabled></form></td>
					<%} else if(comp_present == 1 && n4.getAadhar() == 0 && flag == 2){ %>
						<input type="submit" value="<% if(n4.isBuy()) out.println("Sell"); else out.println("Buy");%>" ></form></td>
					<%} else if(comp_present == 1 && n4.getAadhar() != 0 && flag == 0){ %>
						<input type="submit" value="<% if(n4.isBuy()) out.println("Sell"); else out.println("Buy");%>" ></form></td>
					<%} else if(comp_present == 0 && aadhar_inv != n4.getAadhar() && flag == 2){ %>
						<input type="submit" value="<% if(n4.isBuy()) out.println("Sell"); else out.println("Buy");%>" ></form></td>
					<%} else if(comp_present == 0 && aadhar_inv == 0 && flag == 0){ %>
						<input type="submit" value="<% if(n4.isBuy()) out.println("Sell"); else out.println("Buy");%>" ></form></td>
					<%} else if(comp_present == 1 && aadhar_inv != n4.getAadhar() && flag == 2){ %>
						<input type="submit" value="<% if(n4.isBuy()) out.println("Sell"); else out.println("Buy");%>" ></form></td>
					<%} else{%>
						<input type="submit" value="<% if(n4.isBuy()) out.println("Sell"); else out.println("Buy");%>" disabled></form></td>
					<%} %>
					
			</tr>
		<%} %>
		
		</table>
		
	</div>
	
	</div>
	
</body>
</html>